From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 12/18] verify_refname_available(): report errors via a "struct strbuf *err"
Date: Mon, 11 May 2015 17:25:14 +0200
Message-ID: <1431357920-25090-13-git-send-email-mhagger@alum.mit.edu>
References: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 11 17:26:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yrpay-0002iU-86
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 17:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754492AbbEKP0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 11:26:11 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:50705 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751295AbbEKP0B (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2015 11:26:01 -0400
X-AuditID: 12074413-f79f26d0000030e7-1b-5550c9fed7a7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 8A.19.12519.EF9C0555; Mon, 11 May 2015 11:25:50 -0400 (EDT)
Received: from michael.fritz.box (p5DDB195E.dip0.t-ipconnect.de [93.219.25.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4BFPNnO002156
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 11 May 2015 11:25:49 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsUixO6iqPvvZECowcS1uhZdV7qZLBp6rzBb
	3F4xn9niR0sPs8Xmze0sFmfeNDI6sHn8ff+ByWPBplKPZ717GD0uXlL2WPzAy+PzJrkAtihu
	m6TEkrLgzPQ8fbsE7oxN55cwFqzUrVh3bzFbA+Na5S5GTg4JAROJs9vamSFsMYkL99azdTFy
	cQgJXGaU2Pe8mwXCOc4k0XvxCSNIFZuArsSinmYmEFtEQE1iYtshsCJmgV2MEveWTmUBSQgL
	xEmcWXCEFcRmEVCVaL9+BqyBV8BVYunys1Dr5CTOH/8JZnOCxK9eBusVEnCRaHp8j2UCI+8C
	RoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbrmermZJXqpKaWbGCFhJryDcddJuUOMAhyMSjy8
	Bhf8Q4VYE8uKK3MPMUpyMCmJ8v7aGxAqxJeUn1KZkVicEV9UmpNafIhRgoNZSYRXeQ1Qjjcl
	sbIqtSgfJiXNwaIkzqu2RN1PSCA9sSQ1OzW1ILUIJivDwaEkwdt4AqhRsCg1PbUiLTOnBCHN
	xMEJMpxLSqQ4NS8ltSixtCQjHhQd8cXA+ABJ8QDt3Q3SzltckJgLFIVoPcWoKCXOew8kIQCS
	yCjNgxsLSx6vGMWBvhTm/QhSxQNMPHDdr4AGMwENdowDG1ySiJCSamDk8l745dbnf4rXP3ya
	d3flmXW9272dOJ+fLk3dazubU3CeR2vQqlLNRM4s+amOOzJufN2omDBnYvGiiISDnqW51uzL
	oli2Tdpp+TlvAaeAyYLvYqLM9hsVnXwm/tsS+ft/2i5TYyG5vgI7DrbSzSY/f0wq 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268790>

It shouldn't be spewing errors directly to stderr.

For now, change its callers to spew the errors to stderr.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 50 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/refs.c b/refs.c
index 703e93d..43e7bdd 100644
--- a/refs.c
+++ b/refs.c
@@ -860,12 +860,12 @@ static int nonmatching_ref_fn(struct ref_entry *entry, void *vdata)
 /*
  * Return 0 if a reference named refname could be created without
  * conflicting with the name of an existing reference in dir.
- * Otherwise, return a negative value. If extras is non-NULL, it is a
- * list of additional refnames with which refname is not allowed to
- * conflict. If skip is non-NULL, ignore potential conflicts with refs
- * in skip (e.g., because they are scheduled for deletion in the same
- * operation). Behavior is undefined if the same name is listed in
- * both extras and skip.
+ * Otherwise, return a negative value and write an explanation to err.
+ * If extras is non-NULL, it is a list of additional refnames with
+ * which refname is not allowed to conflict. If skip is non-NULL,
+ * ignore potential conflicts with refs in skip (e.g., because they
+ * are scheduled for deletion in the same operation). Behavior is
+ * undefined if the same name is listed in both extras and skip.
  *
  * Two reference names conflict if one of them exactly matches the
  * leading components of the other; e.g., "refs/foo/bar" conflicts
@@ -877,7 +877,8 @@ static int nonmatching_ref_fn(struct ref_entry *entry, void *vdata)
 static int verify_refname_available(const char *refname,
 				    const struct string_list *extras,
 				    const struct string_list *skip,
-				    struct ref_dir *dir)
+				    struct ref_dir *dir,
+				    struct strbuf *err)
 {
 	const char *slash;
 	int pos;
@@ -889,6 +890,8 @@ static int verify_refname_available(const char *refname,
 	 * refname is "refs/foo/bar".
 	 */
 
+	assert(err);
+
 	strbuf_grow(&dirname, strlen(refname) + 1);
 	for (slash = strchr(refname, '/'); slash; slash = strchr(slash + 1, '/')) {
 		/* Expand dirname to the new prefix, not including the trailing slash: */
@@ -908,16 +911,16 @@ static int verify_refname_available(const char *refname,
 				 * a proper prefix of refname; e.g.,
 				 * "refs/foo", and is not in skip.
 				 */
-				error("'%s' exists; cannot create '%s'",
-				      dirname.buf, refname);
+				strbuf_addf(err, "'%s' exists; cannot create '%s'",
+					    dirname.buf, refname);
 				goto cleanup;
 			}
 		}
 
 		if (extras && string_list_has_string(extras, dirname.buf) &&
 		    (!skip || !string_list_has_string(skip, dirname.buf))) {
-			error("cannot process '%s' and '%s' at the same time",
-			      refname, dirname.buf);
+			strbuf_addf(err, "cannot process '%s' and '%s' at the same time",
+				    refname, dirname.buf);
 			goto cleanup;
 		}
 
@@ -976,8 +979,8 @@ static int verify_refname_available(const char *refname,
 			dir = get_ref_dir(dir->entries[pos]);
 			sort_ref_dir(dir);
 			if (do_for_each_entry_in_dir(dir, 0, nonmatching_ref_fn, &data)) {
-				error("'%s' exists; cannot create '%s'",
-				      data.conflicting_refname, refname);
+				strbuf_addf(err, "'%s' exists; cannot create '%s'",
+					    data.conflicting_refname, refname);
 				goto cleanup;
 			}
 		}
@@ -1000,8 +1003,8 @@ static int verify_refname_available(const char *refname,
 				break;
 
 			if (!skip || !string_list_has_string(skip, extra_refname)) {
-				error("cannot process '%s' and '%s' at the same time",
-				      refname, extra_refname);
+				strbuf_addf(err, "cannot process '%s' and '%s' at the same time",
+					    refname, extra_refname);
 				goto cleanup;
 			}
 		}
@@ -2340,6 +2343,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	int mustexist = (old_sha1 && !is_null_sha1(old_sha1));
 	int resolve_flags = 0;
 	int attempts_remaining = 3;
+	struct strbuf err = STRBUF_INIT;
 
 	lock = xcalloc(1, sizeof(struct ref_lock));
 	lock->lock_fd = -1;
@@ -2384,7 +2388,9 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	 * our refname.
 	 */
 	if (is_null_sha1(lock->old_sha1) &&
-	    verify_refname_available(refname, extras, skip, get_packed_refs(&ref_cache))) {
+	    verify_refname_available(refname, extras, skip,
+				     get_packed_refs(&ref_cache), &err)) {
+		error("%s", err.buf);
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -2425,10 +2431,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 			 */
 			goto retry;
 		else {
-			struct strbuf err = STRBUF_INIT;
 			unable_to_lock_message(ref_file, errno, &err);
 			error("%s", err.buf);
-			strbuf_release(&err);
 			goto error_return;
 		}
 	}
@@ -2436,6 +2440,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 
  error_return:
 	unlock_ref(lock);
+	strbuf_release(&err);
 	errno = last_errno;
 	return NULL;
 }
@@ -2822,14 +2827,19 @@ static int rename_tmp_log(const char *newrefname)
 static int rename_ref_available(const char *oldname, const char *newname)
 {
 	struct string_list skip = STRING_LIST_INIT_NODUP;
+	struct strbuf err = STRBUF_INIT;
 	int ret;
 
 	string_list_insert(&skip, oldname);
 	ret = !verify_refname_available(newname, NULL, &skip,
-					get_packed_refs(&ref_cache))
+					get_packed_refs(&ref_cache), &err)
 		&& !verify_refname_available(newname, NULL, &skip,
-					     get_loose_refs(&ref_cache));
+					     get_loose_refs(&ref_cache), &err);
+	if (!ret)
+		error("%s", err.buf);
+
 	string_list_clear(&skip, 0);
+	strbuf_release(&err);
 	return ret;
 }
 
-- 
2.1.4
