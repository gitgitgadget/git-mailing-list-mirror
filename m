From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 07/33] get_packed_ref(): return a ref_entry
Date: Mon, 22 Apr 2013 21:52:15 +0200
Message-ID: <1366660361-21831-8-git-send-email-mhagger@alum.mit.edu>
References: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 21:53:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUMo9-0004ng-VY
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 21:53:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755105Ab3DVTxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 15:53:39 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:53458 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754823Ab3DVTxi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Apr 2013 15:53:38 -0400
X-AuditID: 1207440f-b7f0e6d000000957-8b-5175954159ff
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 18.0D.02391.14595715; Mon, 22 Apr 2013 15:53:37 -0400 (EDT)
Received: from michael.fritz.box (p57A2598E.dip0.t-ipconnect.de [87.162.89.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3MJrEOK008578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Apr 2013 15:53:36 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsUixO6iqOs4tTTQ4EiLvkXXlW4mi4beK8wW
	t1fMZ3Zg9vj7/gOTx8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGcc+H+RraCFv+LvjSssDYyf
	uLsYOTgkBEwk5t6P6GLkBDLFJC7cW8/WxcjFISRwmVHiXPs1ZgjnApNEY8d7FpAqNgFdiUU9
	zUwgtoiAmsTEtkNgcWYBB4nNnxsZQWxhATuJfZN+gtksAqoSq9pmsILYvAIuEhdenmOE2KYg
	cXz7NjCbU8BV4nTHCbA5QkA1Kw5OZZnAyLuAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6J
	Xm5miV5qSukmRkio8O9g7Fovc4hRgINRiYc3w7M0UIg1say4MvcQoyQHk5IoL8cUoBBfUn5K
	ZUZicUZ8UWlOavEhRgkOZiURXtF8oBxvSmJlVWpRPkxKmoNFSZxXfYm6n5BAemJJanZqakFq
	EUxWhoNDSYI3A2SoYFFqempFWmZOCUKaiYMTRHCBbOAB2hAJUshbXJCYW5yZDlF0ilFRSpzX
	bRJQQgAkkVGaBzcAFtWvGMWB/hHm9QBp5wEmBLjuV0CDmYAGZyaUgAwuSURISTUw2gjuDWAP
	MFxatLy1d1/msY9NzgHBV/qb7S2lHD2PPNrbVy/RaKhWsr6tTepHiHD0wdW26oceCWgurPs2
	/WrykjuKj5ffeTTz3Vqx3gm8KzSe7ct/o6e0dfmf6RZ6yeWPkndMKwzlkW9ZK74pO7BvhrqL
	ItdXDw8vSdmuoI490WeOszq9nMKjxFKckWioxVxUnAgASlsdGsUCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222055>

Instead of copying the reference's SHA1 into a caller-supplied
variable, just return the ref_entry itself (or NULL if there is no
such entry).  This change will allow the function to be used from
elsewhere.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/refs.c b/refs.c
index 7260768..91a2940 100644
--- a/refs.c
+++ b/refs.c
@@ -1100,18 +1100,12 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sh
 }
 
 /*
- * Try to read ref from the packed references.  On success, set sha1
- * and return 0; otherwise, return -1.
+ * Return the ref_entry for the given refname from the packed
+ * references.  If it does not exist, return NULL.
  */
-static int get_packed_ref(const char *refname, unsigned char *sha1)
+static struct ref_entry *get_packed_ref(const char *refname)
 {
-	struct ref_dir *packed = get_packed_refs(get_ref_cache(NULL));
-	struct ref_entry *entry = find_ref(packed, refname);
-	if (entry) {
-		hashcpy(sha1, entry->u.value.sha1);
-		return 0;
-	}
-	return -1;
+	return find_ref(get_packed_refs(get_ref_cache(NULL)), refname);
 }
 
 const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int reading, int *flag)
@@ -1139,13 +1133,17 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 		git_snpath(path, sizeof(path), "%s", refname);
 
 		if (lstat(path, &st) < 0) {
+			struct ref_entry *entry;
+
 			if (errno != ENOENT)
 				return NULL;
 			/*
 			 * The loose reference file does not exist;
 			 * check for a packed reference.
 			 */
-			if (!get_packed_ref(refname, sha1)) {
+			entry = get_packed_ref(refname);
+			if (entry) {
+				hashcpy(sha1, entry->u.value.sha1);
 				if (flag)
 					*flag |= REF_ISPACKED;
 				return refname;
-- 
1.8.2.1
