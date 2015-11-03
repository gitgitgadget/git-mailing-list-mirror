From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 25/25] refs: break out ref conflict checks
Date: Tue,  3 Nov 2015 08:40:09 +0100
Message-ID: <3060e6410e8798064ef84cd31645021d1b84fbb9.1446534991.git.mhagger@alum.mit.edu>
References: <cover.1446534991.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 08:40:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtWD8-0007c0-5F
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 08:40:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082AbbKCHkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 02:40:49 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:48283 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751431AbbKCHkp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2015 02:40:45 -0500
X-AuditID: 12074411-f797e6d000007df3-16-563864fdb375
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 10.C5.32243.DF468365; Tue,  3 Nov 2015 02:40:45 -0500 (EST)
Received: from michael.fritz.box (p5DDB0E27.dip0.t-ipconnect.de [93.219.14.39])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA37eDdM016391
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 3 Nov 2015 02:40:44 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1446534991.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsUixO6iqPs3xSLMYONUZov5m04wWnRd6Way
	aOi9wmxxe8V8ZgcWj7/vPzB5XLyk7LHg+X12j8+b5AJYorhtkhJLyoIz0/P07RK4M6bMbGcu
	uKFVcWzXPfYGxnVKXYycHBICJhL3l95lh7DFJC7cW8/WxcjFISRwmVHidvc3JgjnGJPEmzUv
	2UCq2AR0JRb1NDOB2CICahIT2w6xdDFycDALFEnc6dcBCQsL2Eq0tswBK2cRUJV4O/MRWDmv
	QJTE7iWLoZbJSUy53w4W5xSwkHhw9w9YXEjAXGLTvWVsExh5FzAyrGKUS8wpzdXNTczMKU5N
	1i1OTszLSy3SNdXLzSzRS00p3cQICR/BHYwzTsodYhTgYFTi4V2wxDxMiDWxrLgy9xCjJAeT
	kijvuhiLMCG+pPyUyozE4oz4otKc1OJDjBIczEoivAWBQDnelMTKqtSifJiUNAeLkjgv3xJ1
	PyGB9MSS1OzU1ILUIpisDAeHkgTvRGCcCAkWpaanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaW
	ZMSDIiO+GBgbICkeoL0rk0H2Fhck5gJFIVpPMSpKifNOBkkIgCQySvPgxsKSwitGcaAvhXkv
	gFTxABMKXPcroMFMQIPDt5mCDC5JREhJNTBOWtVzLT9IebtikdTt7oo+d67sP0nnOmL+PdTr
	C/N3NRCVYgw+Z7u1pNp46hHfDxzb7DTtg6sUZCZ+2HHv1OrLwUZRc0+X10yJPXX5196jDJ0e
	7YrT3ju2z3vQcZ4tY27yR1fR+zGnp3zxfuJxt7L8owPbmnVXLrJcSd4SdDFT6/SB 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280764>

From: David Turner <dturner@twopensource.com>

Create new function verify_no_descendants, to hold one of the ref
conflict checks used in verify_refname_available. Multiple backends
will need this function, so move it to the common code.

Also move rename_ref_available to the common code, because alternate
backends might need it and it has no files-backend-specific code.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 49 +++++++------------------------------------------
 refs/refs-internal.h | 16 ++++++++++++++++
 refs/refs.c          | 44 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 42 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index e0ae769..baa13bb 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -729,6 +729,7 @@ static int verify_refname_available_dir(const char *refname,
 					struct strbuf *err)
 {
 	const char *slash;
+	const char *extra_refname;
 	int pos;
 	struct strbuf dirname = STRBUF_INIT;
 	int ret = -1;
@@ -834,32 +835,12 @@ static int verify_refname_available_dir(const char *refname,
 		}
 	}
 
-	if (extras) {
-		/*
-		 * Check for entries in extras that start with
-		 * "$refname/". We do that by looking for the place
-		 * where "$refname/" would be inserted in extras. If
-		 * there is an entry at that position that starts with
-		 * "$refname/" and is not in skip, then we have a
-		 * conflict.
-		 */
-		for (pos = string_list_find_insert_index(extras, dirname.buf, 0);
-		     pos < extras->nr; pos++) {
-			const char *extra_refname = extras->items[pos].string;
-
-			if (!starts_with(extra_refname, dirname.buf))
-				break;
-
-			if (!skip || !string_list_has_string(skip, extra_refname)) {
-				strbuf_addf(err, "cannot process '%s' and '%s' at the same time",
-					    refname, extra_refname);
-				goto cleanup;
-			}
-		}
-	}
-
-	/* No conflicts were found */
-	ret = 0;
+	extra_refname = find_descendant_ref(dirname.buf, extras, skip);
+	if (extra_refname)
+		strbuf_addf(err, "cannot process '%s' and '%s' at the same time",
+			    refname, extra_refname);
+	else
+		ret = 0;
 
 cleanup:
 	strbuf_release(&dirname);
@@ -2461,22 +2442,6 @@ out:
 	return ret;
 }
 
-static int rename_ref_available(const char *oldname, const char *newname)
-{
-	struct string_list skip = STRING_LIST_INIT_NODUP;
-	struct strbuf err = STRBUF_INIT;
-	int ret;
-
-	string_list_insert(&skip, oldname);
-	ret = !verify_refname_available(newname, NULL, &skip, &err);
-	if (!ret)
-		error("%s", err.buf);
-
-	string_list_clear(&skip, 0);
-	strbuf_release(&err);
-	return ret;
-}
-
 static int write_ref_to_lockfile(struct ref_lock *lock,
 				 const unsigned char *sha1, struct strbuf *err);
 static int commit_ref_update(struct ref_lock *lock,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index f6a79b9..500b708 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -25,6 +25,22 @@
 int refname_is_safe(const char *refname);
 
 /*
+ * Check for entries in extras that are within the specified
+ * directory, where dirname is a reference directory name including
+ * the trailing slash (e.g., "refs/heads/foo/"). Ignore any
+ * conflicting references that are found in skip. If there is a
+ * conflicting reference, return its name.
+ *
+ * extras and skip must be sorted lists of reference names. Either one
+ * can be NULL, signifying the empty list.
+ */
+const char *find_descendant_ref(const char *dirname,
+				const struct string_list *extras,
+				const struct string_list *skip);
+
+int rename_ref_available(const char *oldname, const char *newname);
+
+/*
  * Flag passed to lock_ref_sha1_basic() telling it to tolerate broken
  * refs (i.e., because the reference is about to be deleted anyway).
  */
diff --git a/refs/refs.c b/refs/refs.c
index 25d4e22..1c1c6cb 100644
--- a/refs/refs.c
+++ b/refs/refs.c
@@ -1027,3 +1027,47 @@ enum peel_status peel_object(const unsigned char *name, unsigned char *sha1)
 	hashcpy(sha1, o->sha1);
 	return PEEL_PEELED;
 }
+
+const char *find_descendant_ref(const char *dirname,
+				const struct string_list *extras,
+				const struct string_list *skip)
+{
+	int pos;
+
+	if (!extras)
+		return NULL;
+
+	/*
+	 * Look at the place where dirname would be inserted into
+	 * extras. If there is an entry at that position that starts
+	 * with dirname (remember, dirname includes the trailing
+	 * slash) and is not in skip, then we have a conflict.
+	 */
+	for (pos = string_list_find_insert_index(extras, dirname, 0);
+	     pos < extras->nr; pos++) {
+		const char *extra_refname = extras->items[pos].string;
+
+		if (!starts_with(extra_refname, dirname))
+			break;
+
+		if (!skip || !string_list_has_string(skip, extra_refname))
+			return extra_refname;
+	}
+	return NULL;
+}
+
+int rename_ref_available(const char *oldname, const char *newname)
+{
+	struct string_list skip = STRING_LIST_INIT_NODUP;
+	struct strbuf err = STRBUF_INIT;
+	int ret;
+
+	string_list_insert(&skip, oldname);
+	ret = !verify_refname_available(newname, NULL, &skip, &err);
+	if (!ret)
+		error("%s", err.buf);
+
+	string_list_clear(&skip, 0);
+	strbuf_release(&err);
+	return ret;
+}
-- 
2.6.2
