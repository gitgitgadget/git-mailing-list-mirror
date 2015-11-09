From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 11/11] refs: break out ref conflict checks
Date: Mon,  9 Nov 2015 18:03:48 +0100
Message-ID: <4dfc6ad3effed7afb511e3356eefa0ef48dd8b8e.1447085798.git.mhagger@alum.mit.edu>
References: <cover.1447085798.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, David Turner <dturner@twopensource.com>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 18:04:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zvpry-0007tx-4P
	for gcvg-git-2@plane.gmane.org; Mon, 09 Nov 2015 18:04:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752354AbbKIREa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 12:04:30 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:54988 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752264AbbKIREY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2015 12:04:24 -0500
X-AuditID: 1207440f-f79df6d000007c0f-d4-5640d217bb4f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 7A.EF.31759.712D0465; Mon,  9 Nov 2015 12:04:23 -0500 (EST)
Received: from michael.fritz.box (p4FC97689.dip0.t-ipconnect.de [79.201.118.137])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA9H41Z0026059
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 9 Nov 2015 12:04:22 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1447085798.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqCt+ySHMYPk2E4v5m04wWnRd6Way
	aOi9wmwxacpNJovbK+YzW/xo6WG26O37xOrA7vH3/Qcmj52z7rJ7nD2Y6fGsdw+jx8VLyh4L
	nt9n9/i8SS6APYrbJimxpCw4Mz1P3y6BO+PWlD1MBWu1Kp53tbA2MLYpdTFyckgImEisWDGT
	EcIWk7hwbz1bFyMXh5DAZUaJxQ07GCGcE0wST3+tYgapYhPQlVjU08wEYosIqElMbDvEAlLE
	LPCRUWLuj4VgCWEBW4muh1uAGjg4WARUJTa+4gEJ8wpESaw60MwCsU1OYsr9drByTgELiR0n
	/oFdISRgLjFx1RqmCYy8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmujlZpbopaaUbmKE
	hB4/0KnrZQ4xCnAwKvHwRsy0DxNiTSwrrsw9xCjJwaQkyht9wiFMiC8pP6UyI7E4I76oNCe1
	+BCjBAezkghvwS6gHG9KYmVValE+TEqag0VJnFd9ibqfkEB6YklqdmpqQWoRTFaGg0NJgjf8
	IlCjYFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPCg24ouB0QGS4gHau+MCyN7igsRc
	oChE6ylGRSlx3kUgCQGQREZpHtxYWEJ5xSgO9KUw73KQ7TzAZATX/QpoMBPQ4KX+YINLEhFS
	Ug2MKSf/rpz0dEfmW4aiK5Vv2F53zU9juTLjO6/w1wV/D+QyXtzcmFC4P+yxFNufiif9IUEX
	Xm0NLdr+11Vb3Z5ni7zCuwtHr7xLO3OHT/X7dOXL/0xrEg9d+sm0ozM//acQV1V7 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281062>

From: David Turner <dturner@twopensource.com>

Create new function find_descendant_ref, to hold one of the ref
conflict checks used in verify_refname_available. Multiple backends
will need this function, so move it to the common code.

Also move rename_ref_available to the common code, because alternate
backends might need it and it has no files-backend-specific code.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               | 44 ++++++++++++++++++++++++++++++++++++++++++++
 refs/files-backend.c | 49 +++++++------------------------------------------
 refs/refs-internal.h | 16 ++++++++++++++++
 3 files changed, 67 insertions(+), 42 deletions(-)

diff --git a/refs.c b/refs.c
index 175b3e9..0e2eaf8 100644
--- a/refs.c
+++ b/refs.c
@@ -1027,3 +1027,47 @@ int ref_is_hidden(const char *refname)
 	}
 	return 0;
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
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1094348..8bb3728 100644
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
@@ -2474,22 +2455,6 @@ int verify_refname_available(const char *newname,
 	return 0;
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
index 88a5be0..6c29f45 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -183,4 +183,20 @@ int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
 			const unsigned char *new_sha1, const char *msg,
 			int flags, struct strbuf *err);
 
+/*
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
 #endif /* REFS_REFS_INTERNAL_H */
-- 
2.6.2
