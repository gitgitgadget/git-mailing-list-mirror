From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 07/11] handle_missing_loose_ref(): inline function
Date: Wed, 15 Oct 2014 17:06:19 +0200
Message-ID: <1413385583-4872-8-git-send-email-mhagger@alum.mit.edu>
References: <1413385583-4872-1-git-send-email-mhagger@alum.mit.edu>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 17:07:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeQAX-0002gO-Bl
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 17:07:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861AbaJOPHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 11:07:10 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:52145 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751679AbaJOPGm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2014 11:06:42 -0400
X-AuditID: 12074413-f79bb6d000001e81-71-543e8d8185a6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 05.DF.07809.18D8E345; Wed, 15 Oct 2014 11:06:41 -0400 (EDT)
Received: from michael.fritz.box (p4FC96250.dip0.t-ipconnect.de [79.201.98.80])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s9FF6SNZ020034
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 15 Oct 2014 11:06:40 -0400
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413385583-4872-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsUixO6iqNvYaxdicPmBkEXXlW4mi4beK8wW
	t1fMZ7bonvKW0eLfhBqLM28aGR3YPP6+/8DksXPWXXaPBZtKPS5eUvZY/MDL4/MmuQC2KG6b
	pMSSsuDM9Dx9uwTujL6rk1gK1opW7N96h72B8Qd/FyMnh4SAicT+U49YIWwxiQv31rN1MXJx
	CAlcZpSY/rGVCcI5ziSx4uc3RpAqNgFdiUU9zWAJEYEGRolDrxaCtTALLGKUaF91hRmkSljA
	VeJm2yMwm0VAVeJz/y8wm1fAWWLV4ncsEPvkJPZOXg1mcwq4SPx6uQ1sgxBQzYKlk1kmMPIu
	YGRYxSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrrpebWaKXmlK6iRESZsI7GHedlDvEKMDBqMTD
	u2GvbYgQa2JZcWXuIUZJDiYlUd6kHrsQIb6k/JTKjMTijPii0pzU4kOMEhzMSiK88xOAcrwp
	iZVVqUX5MClpDhYlcV61Jep+QgLpiSWp2ampBalFMFkZDg4lCV57kKGCRanpqRVpmTklCGkm
	Dk6Q4VxSIsWpeSmpRYmlJRnxoPiILwZGCEiKB2ivJ0g7b3FBYi5QFKL1FKOilDjvu26ghABI
	IqM0D24sLHm8YhQH+lKYNwyknQeYeOC6XwENZgIaPDHUFmRwSSJCSqqBUWHPLetVHFUetyTT
	z+nfzN21KeGndvzzPe9+L8hRNF79/c7x3IvbdIJfv46brrn4p1t1oKKeeNxs1uDcnstCX24t
	ltmxPbkpKL5B9KJmgupU0a9SrVualJirnnnuOjlLqt1ebs2Zhbtf+fG/13zWfYnt 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It only had one remaining caller.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 70 ++++++++++++++++++++++++++++--------------------------------------
 1 file changed, 30 insertions(+), 40 deletions(-)

diff --git a/refs.c b/refs.c
index 3acd83e..9f2a0f8 100644
--- a/refs.c
+++ b/refs.c
@@ -1366,37 +1366,6 @@ static struct ref_entry *get_packed_ref(const char *refname)
 	return find_ref(get_packed_refs(&ref_cache), refname);
 }
 
-/*
- * A loose ref file doesn't exist; check for a packed ref.  The
- * options are forwarded from resolve_safe_unsafe().
- */
-static int handle_missing_loose_ref(const char *refname,
-				    unsigned char *sha1,
-				    int reading,
-				    int *flag)
-{
-	struct ref_entry *entry;
-
-	/*
-	 * The loose reference file does not exist; check for a packed
-	 * reference.
-	 */
-	entry = get_packed_ref(refname);
-	if (entry) {
-		hashcpy(sha1, entry->u.value.sha1);
-		if (flag)
-			*flag |= REF_ISPACKED;
-		return 0;
-	}
-	/* The reference is not a packed reference, either. */
-	if (reading) {
-		return -1;
-	} else {
-		hashclr(sha1);
-		return 0;
-	}
-}
-
 int parse_ref(const char *path, struct strbuf *refname,
 	      unsigned char *sha1, int *flag)
 {
@@ -1505,7 +1474,7 @@ int resolve_ref(const char *refname, struct strbuf *result,
 		unsigned char *sha1, int reading, int *flag)
 {
 	int depth = MAXDEPTH;
-	int ret = 0;
+	int ret;
 
 	if (flag)
 		*flag = 0;
@@ -1518,24 +1487,45 @@ int resolve_ref(const char *refname, struct strbuf *result,
 	strbuf_reset(result);
 	strbuf_addstr(result, refname);
 
-	while (!ret) {
+	do {
 		char path[PATH_MAX];
 
 		if (--depth < 0) {
 			errno = ELOOP;
-			ret = -1;
-			break;
+			return -1;
 		}
 
 		git_snpath(path, sizeof(path), "%s", result->buf);
 		ret = parse_ref(path, result, sha1, flag);
-		if (ret == -2) {
-			ret = handle_missing_loose_ref(result->buf, sha1,
-						       reading, flag);
-			ret = ret ? -1 : 1;
+	} while (!ret);
+
+	if (ret == 1) {
+		return 0;
+	} else if (ret == -2) {
+		/*
+		 * The loose reference file does not exist; check for a packed
+		 * reference.
+		 */
+		struct ref_entry *entry;
+
+		entry = get_packed_ref(result->buf);
+		if (entry) {
+			hashcpy(sha1, entry->u.value.sha1);
+			if (flag)
+				*flag |= REF_ISPACKED;
+			return 0;
+		}
+
+		/* The reference is not a packed reference, either. */
+		if (reading) {
+			return -1;
+		} else {
+			hashclr(sha1);
+			return 0;
 		}
+	} else {
+		return -1;
 	}
-	return ret > 0 ? 0 : -1;
 }
 
 const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int reading, int *flag)
-- 
2.1.1
