From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 1/3] resolve_ref_unsafe(): extract function handle_missing_loose_ref()
Date: Wed, 19 Jun 2013 08:36:26 +0200
Message-ID: <1371623788-7227-2-git-send-email-mhagger@alum.mit.edu>
References: <1371623788-7227-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 08:36:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpC0m-0005JS-Ds
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 08:36:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756512Ab3FSGgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 02:36:48 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:54719 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756393Ab3FSGgq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Jun 2013 02:36:46 -0400
X-AuditID: 12074413-b7f136d000006de1-30-51c1517d6626
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 49.3D.28129.D7151C15; Wed, 19 Jun 2013 02:36:45 -0400 (EDT)
Received: from michael.berlin.jpk.com (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5J6aXcT032032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 19 Jun 2013 02:36:44 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1371623788-7227-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqFsbeDDQYMd9A4uuK91MFg29V5gt
	5t3dxWRxe8V8ZosfLT3MFncvr2J3YPP4+/4Dk8ell9/ZPG6/ns/s8ax3D6PHxUvKHp83yQWw
	RXHbJCWWlAVnpufp2yVwZ/RvfsBccEOwYkZzG2MD40beLkZODgkBE4mbXceYIWwxiQv31rN1
	MXJxCAlcZpS4tW0dE4Rzm0niwPXZjCBVbAK6Eot6mplAbBEBNYmJbYdYQIqYBTYyShy/ug+s
	SFggUqLj0BqwIhYBVYnbiyaAreAVcJbYv+8K1DoFiSkP34PZnAIuEvf+PgdazQ60zVnigscE
	Rt4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3TN9XIzS/RSU0o3MULCTHgH466TcocYBTgY
	lXh4G1YeCBRiTSwrrsw9xCjJwaQkyhsacDBQiC8pP6UyI7E4I76oNCe1+BCjBAezkgivngNQ
	jjclsbIqtSgfJiXNwaIkzqu2RN1PSCA9sSQ1OzW1ILUIJivDwaEkwVsGMlSwKDU9tSItM6cE
	Ic3EwQkiuEA28ABtSAMp5C0uSMwtzkyHKDrFqCglzusCkhAASWSU5sENgCWEV4ziQP8I81qC
	VPEAkwlc9yugwUxAg4W+7wMZXJKIkJJqYBRnWzqJUyxVdP588avztJSaF31YbcLkNadH0ePV
	7FK9O8ZLH3HaMJf5uAiXvDC7Ok1yXmG7qd2zRZvfcC2+bWG8bKXOqZeSSrxvFpruuP26ySLE
	flrOFU71Om/b+qxdc1etTnNcsWdBJvfkzctWcyx+V3K9JWO5a+PDHQZN4bWa379a 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228352>

The nesting was getting a bit out of hand, and it's about to get
worse.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 56 +++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 21 deletions(-)

diff --git a/refs.c b/refs.c
index 42a7e17..ab1f99e 100644
--- a/refs.c
+++ b/refs.c
@@ -1197,6 +1197,37 @@ static struct ref_entry *get_packed_ref(const char *refname)
 	return find_ref(get_packed_refs(&ref_cache), refname);
 }
 
+/*
+ * A loose ref file doesn't exist; check for a packed ref.  The
+ * options are forwarded from resolve_safe_unsafe().
+ */
+static const char *handle_missing_loose_ref(const char *refname,
+					    unsigned char *sha1,
+					    int reading,
+					    int *flag)
+{
+	struct ref_entry *entry;
+
+	/*
+	 * The loose reference file does not exist; check for a packed
+	 * reference.
+	 */
+	entry = get_packed_ref(refname);
+	if (entry) {
+		hashcpy(sha1, entry->u.value.sha1);
+		if (flag)
+			*flag |= REF_ISPACKED;
+		return refname;
+	}
+	/* The reference is not a packed reference, either. */
+	if (reading) {
+		return NULL;
+	} else {
+		hashclr(sha1);
+		return refname;
+	}
+}
+
 const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int reading, int *flag)
 {
 	int depth = MAXDEPTH;
@@ -1222,28 +1253,11 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 		git_snpath(path, sizeof(path), "%s", refname);
 
 		if (lstat(path, &st) < 0) {
-			struct ref_entry *entry;
-
-			if (errno != ENOENT)
+			if (errno == ENOENT)
+				return handle_missing_loose_ref(refname, sha1,
+								reading, flag);
+			else
 				return NULL;
-			/*
-			 * The loose reference file does not exist;
-			 * check for a packed reference.
-			 */
-			entry = get_packed_ref(refname);
-			if (entry) {
-				hashcpy(sha1, entry->u.value.sha1);
-				if (flag)
-					*flag |= REF_ISPACKED;
-				return refname;
-			}
-			/* The reference is not a packed reference, either. */
-			if (reading) {
-				return NULL;
-			} else {
-				hashclr(sha1);
-				return refname;
-			}
 		}
 
 		/* Follow "normalized" - ie "refs/.." symlinks by hand */
-- 
1.8.3.1
