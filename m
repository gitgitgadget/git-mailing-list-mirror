From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 12/18] verify_refname_available(): report errors via a "struct strbuf *err"
Date: Fri,  1 May 2015 14:25:52 +0200
Message-ID: <1430483158-14349-13-git-send-email-mhagger@alum.mit.edu>
References: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 01 14:27:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoA25-0001MH-NQ
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 14:27:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753549AbbEAM0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 08:26:54 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:59385 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753764AbbEAM00 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 May 2015 08:26:26 -0400
X-AuditID: 1207440d-f79976d000005643-b2-554370f1e2d0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 68.5E.22083.1F073455; Fri,  1 May 2015 08:26:25 -0400 (EDT)
Received: from michael.fritz.box (p4FC97D7E.dip0.t-ipconnect.de [79.201.125.126])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t41CQ3Zp004310
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 1 May 2015 08:26:24 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqPuxwDnU4HGDiEXXlW4mi4beK8wW
	t1fMZ7b40dLDbLF5czuLA6vH3/cfmDwWbCr1eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M+6t2sRU0K1bsbspq4FxtnIXIyeHhICJxO9NS9ghbDGJC/fWs3UxcnEICVxmlGha3MAI
	4ZxgknjTe4ANpIpNQFdiUU8zE4gtIqAmMbHtEAtIEbNAB6PEheXbwEYJC0RLXOp7ygxiswio
	Sty+u48FxOYVcJWYuvcIC8Q6OYnzx38C1XBwcALFv0xNBAkLCbhI3P/+lW0CI+8CRoZVjHKJ
	OaW5urmJmTnFqcm6xcmJeXmpRbpGermZJXqpKaWbGCEBxbuD8f86mUOMAhyMSjy8HCedQoVY
	E8uKK3MPMUpyMCmJ8tomOIcK8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuG9pw6U401JrKxKLcqH
	SUlzsCiJ86otUfcTEkhPLEnNTk0tSC2CycpwcChJ8CbmAzUKFqWmp1akZeaUIKSZODhBhnNJ
	iRSn5qWkFiWWlmTEgyIjvhgYGyApHqC9y0DaeYsLEnOBohCtpxgVpcR5e0ASAiCJjNI8uLGw
	NPGKURzoS2FeVmDSEOIBphi47ldAg5mABp+/5QAyuCQRISXVwJhzccUrnf1hbQtm/Ziy4O0d
	nRy2iIibC7ZdmrksR0c4/cpKO818pv+prBITfGdGfNcuOZ4hdPHfDve4u6be99IbbpR/XXTP
	esL7GTc9NwjzlN2+sL/wT6D45lXeJXY/ZTOlrjVUGQpJ1py7Vi1VnnH2F8POpinX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268131>

It shouldn't be spewing errors directly to stderr.

For now, change its callers to spew the errors to stderr.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 50 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/refs.c b/refs.c
index cd8aeed..730e248 100644
--- a/refs.c
+++ b/refs.c
@@ -865,12 +865,12 @@ static int nonmatching_ref_fn(struct ref_entry *entry, void *vdata)
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
  * leading components of the other; e.g., "foo/bar" conflicts with
@@ -882,13 +882,16 @@ static int nonmatching_ref_fn(struct ref_entry *entry, void *vdata)
 static int verify_refname_available(const char *refname,
 				    const struct string_list *extras,
 				    const struct string_list *skip,
-				    struct ref_dir *dir)
+				    struct ref_dir *dir,
+				    struct strbuf *err)
 {
 	const char *slash;
 	int pos;
 	struct strbuf dirname = STRBUF_INIT;
 	int ret = -1;
 
+	assert(err);
+
 	strbuf_grow(&dirname, strlen(refname) + 1);
 	for (slash = strchr(refname, '/'); slash; slash = strchr(slash + 1, '/')) {
 		/* Expand dirname to the new prefix, not including the trailing slash: */
@@ -905,16 +908,16 @@ static int verify_refname_available(const char *refname,
 			pos = search_ref_dir(dir, dirname.buf, dirname.len);
 			if (pos >= 0 &&
 			    (!skip || !string_list_has_string(skip, dirname.buf))) {
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
 
@@ -958,8 +961,8 @@ static int verify_refname_available(const char *refname,
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
@@ -982,8 +985,8 @@ static int verify_refname_available(const char *refname,
 				break;
 
 			if (!skip || !string_list_has_string(skip, extra_refname)) {
-				error("cannot process '%s' and '%s' at the same time",
-				      refname, extra_refname);
+				strbuf_addf(err, "cannot process '%s' and '%s' at the same time",
+					    refname, extra_refname);
 				goto cleanup;
 			}
 		}
@@ -2322,6 +2325,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	int mustexist = (old_sha1 && !is_null_sha1(old_sha1));
 	int resolve_flags = 0;
 	int attempts_remaining = 3;
+	struct strbuf err = STRBUF_INIT;
 
 	lock = xcalloc(1, sizeof(struct ref_lock));
 
@@ -2365,7 +2369,9 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
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
@@ -2405,10 +2411,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
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
@@ -2416,6 +2420,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 
  error_return:
 	unlock_ref(lock);
+	strbuf_release(&err);
 	errno = last_errno;
 	return NULL;
 }
@@ -2802,14 +2807,19 @@ static int rename_tmp_log(const char *newrefname)
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
