From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/4] resolve_ref_unsafe(): extract function handle_missing_loose_ref()
Date: Tue, 11 Jun 2013 16:26:17 +0200
Message-ID: <1370960780-1055-2-git-send-email-mhagger@alum.mit.edu>
References: <20130507023802.GA22940@sigill.intra.peff.net>
 <1370960780-1055-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 16:27:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmPXP-0005vU-EJ
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 16:27:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525Ab3FKO0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 10:26:46 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:50745 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754140Ab3FKO0n (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jun 2013 10:26:43 -0400
X-AuditID: 1207440d-b7f006d000000adf-4c-51b733a276fb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 5C.2B.02783.2A337B15; Tue, 11 Jun 2013 10:26:42 -0400 (EDT)
Received: from michael.fritz.box (p57A251F0.dip0.t-ipconnect.de [87.162.81.240])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5BEQVIS026521
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 11 Jun 2013 10:26:41 -0400
X-Mailer: git-send-email 1.8.3
In-Reply-To: <1370960780-1055-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsUixO6iqLvIeHugwZ4PNhZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYHVg9/r7/wORx6eV3No9nvXsYPS5eUvb4vEkugDWK2yYpsaQsODM9
	T98ugTvj2Jw/zAWnBSt2Lp3M1sC4lreLkZNDQsBE4vuLSewQtpjEhXvr2boYuTiEBC4zSrw/
	sIUVwrnAJDHryxwWkCo2AV2JRT3NTCC2iICaxMS2QywgRcwC7YwS75r3MYMkhAXCJP7NuA1W
	xCKgKrHiyCqwZl4BZ4lJa78wQ6yTk3h/ZxdQnIODU8BF4nSjDEhYSKBEYsqqtywTGHkXMDKs
	YpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI10svNLNFLTSndxAgJKt4djP/XyRxiFOBgVOLhTWDc
	FijEmlhWXJl7iFGSg0lJlHeKwfZAIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8jXJAOd6UxMqq
	1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwMB4eSBO8+I6BGwaLU9NSKtMycEoQ0Ewcn
	iOAC2cADtOEzSCFvcUFibnFmOkTRKUZFKXHeuyAJAZBERmke3ABY/L9iFAf6R5j3B0gVDzB1
	wHW/AhrMBDR4ivoWkMEliQgpqQbGibPfb9K1nXLzR33M6y7bXeH208RyXyzq9lcr9/02v3yv
	v25Ko+7sXPZXT2ZWVqyVub2UrXGFQ0WfienhlUtP+gabR2813OLVstt7h3+FwP54IYYlfq/q
	Wk4Yc35+V/2LuymgQ/z9z9oda5jkzZcsDTLekHBY6vzbSi7ux1u57qvoq90+Jt2u 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227445>

The nesting was getting a bit out of hand, and it's about to get
worse.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 55 ++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/refs.c b/refs.c
index d17931a..1acce17 100644
--- a/refs.c
+++ b/refs.c
@@ -1193,6 +1193,37 @@ static struct ref_entry *get_packed_ref(const char *refname)
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
@@ -1218,28 +1249,10 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 		git_snpath(path, sizeof(path), "%s", refname);
 
 		if (lstat(path, &st) < 0) {
-			struct ref_entry *entry;
-
-			if (errno != ENOENT)
+			if (errno == ENOENT)
+				return handle_missing_loose_ref(refname, sha1, reading, flag);
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
1.8.3
