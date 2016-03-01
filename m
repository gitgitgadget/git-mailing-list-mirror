From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 30/33] refs: break out resolve_ref_unsafe_submodule
Date: Mon, 29 Feb 2016 19:53:03 -0500
Message-ID: <1456793586-22082-31-git-send-email-dturner@twopensource.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 01 01:54:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaYa7-0007RW-TI
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 01:54:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753894AbcCAAyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 19:54:15 -0500
Received: from mail-qg0-f48.google.com ([209.85.192.48]:36342 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753601AbcCAAyC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 19:54:02 -0500
Received: by mail-qg0-f48.google.com with SMTP id u110so1417624qge.3
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 16:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ikIgKjRNn0/tHS+UOcwl0hc95AmsM8JH62nOV2P8n9I=;
        b=zsQODM0IXtYRBT3zJaaFaVLPk9SdXt6KE/XilCZE0mgePkZXYl3WzQDCG8Ik/YoRB7
         YoMdJENIiXLLNuroc3/VJdEMXgNyBcK0h5vu4IDEAufFt/WkTCdlqfe4XW0gIJmmecsJ
         ng5q6lz+tE4FQKhkeC7kUFA61U10a+d4wZWay60C+JjytZoCeWB1ptMvY4YsDiYupg6d
         AKkEbjasL+dI0oK+jB4KmMNhMng5efPSO9R/Tv/F3/hWbbdivTIzR2/OMCTJb3ZA+ujI
         D23YDOUygEMpOOpFhfekcu4tKGKFwT+jCq1zMzaZpPg8tx01ZEXMHVbSTZ6iLC9ScLO8
         Cmyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ikIgKjRNn0/tHS+UOcwl0hc95AmsM8JH62nOV2P8n9I=;
        b=LO5CyafR9EuDkPRco/nD1CxHjNGGpy6LQICWJSz+kjc8/BdYJcPvGccoCtZE88dOpQ
         FMbW2tlwK/sXFVbUdQ3ruZI3LkJIeI/s+Qu4NKDu+6O3V8HOv+kj2MZTrc30YMtkVrNW
         IdQ4b7n2aKjwUmjpB2n+Gv4FRHIlRbGwtqRKZBXNkW1N+WMhe/lHIp8dZ+yJxhvxOpVL
         u5doRZLc6Y12YluZaDGE6sYhPKFLXfMCzitTTVHL2WczCORGkjt5pclC4xqlOe+P6M1W
         npa8w8OATTm1k2HlCsdtSZRxtBAaVOwyTjRRUu8M0PybP941Fc2t1LAtlcArV9bnh4tS
         cDlQ==
X-Gm-Message-State: AD7BkJKJFP40YD3PuHRk1KblKTxbybTBB4fdLSm6VxISA8wF+j+C4fupTJJfxHDpOF7h8Q==
X-Received: by 10.140.221.17 with SMTP id r17mr1305396qhb.61.1456793641855;
        Mon, 29 Feb 2016 16:54:01 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z62sm12094715qka.26.2016.02.29.16.54.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 16:54:00 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287967>

It will soon be useful for resolve_ref_unsafe to support submodules.
But since it is called from so many places, changing it would have
been painful.  Fortunately, it's just a thin wrapper around (the
former) resolve_ref_1.  So now resolve_ref_1 becomes
resolve_ref_unsafe_submodule, and it passes its submodule argument
through to read_raw_ref.

The files backend doesn't need this functionality, but it doesn't
hurt.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c               | 41 +++++++++++++++++++++++++----------------
 refs/files-backend.c |  8 ++++++--
 refs/refs-internal.h | 19 ++++++++++++++++---
 3 files changed, 47 insertions(+), 21 deletions(-)

diff --git a/refs.c b/refs.c
index 5fe0bac..d1cf707 100644
--- a/refs.c
+++ b/refs.c
@@ -60,6 +60,9 @@ void register_ref_storage_backends(void)
 	 * entries below when you add a new backend.
 	 */
 	register_ref_storage_backend(&refs_be_files);
+#ifdef USE_LIBLMDB
+	register_ref_storage_backend(&refs_be_lmdb);
+#endif
 }
 
 /*
@@ -320,8 +323,10 @@ static int submodule_backend(const char *key, const char *value, void *data)
 	const char **path = data;
 	char **old_path = data;
 	if (!strcmp(key, "extensions.refstorage") &&
-	    !git_config_string(path, key, "extensions.refstorage"))
-			free(*old_path);
+	    !git_config_string(path, key, "extensions.refstorage")) {
+		free(*old_path);
+		*path = xstrdup(value);
+	}
 
 	return 0;
 }
@@ -1313,21 +1318,22 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
 
-static int read_raw_ref(const char *refname, unsigned char *sha1,
-			struct strbuf *symref, struct strbuf *sb_path,
-			unsigned int *flags)
+static int read_raw_ref(const char *submodule, const char *refname,
+			unsigned char *sha1, struct strbuf *symref,
+			struct strbuf *sb_path, unsigned int *flags)
 {
-	return the_refs_backend->read_raw_ref(refname, sha1, symref, sb_path,
-					      flags);
+	return the_refs_backend->read_raw_ref(submodule, refname, sha1,
+					      symref, sb_path, flags);
 }
 
 /* This function needs to return a meaningful errno on failure */
-static const char *resolve_ref_1(const char *refname,
-				 int resolve_flags,
-				 unsigned char *sha1,
-				 int *flags,
-				 struct strbuf *sb_refname,
-				 struct strbuf *sb_path)
+const char *resolve_ref_unsafe_submodule(const char *submodule,
+					 const char *refname,
+					 int resolve_flags,
+					 unsigned char *sha1,
+					 int *flags,
+					 struct strbuf *sb_refname,
+					 struct strbuf *sb_path)
 {
 	int bad_name = 0;
 	int symref_count;
@@ -1358,7 +1364,8 @@ static const char *resolve_ref_1(const char *refname,
 	for (symref_count = 0; symref_count < SYMREF_MAXDEPTH; symref_count++) {
 		unsigned int read_flags = 0;
 
-		if (read_raw_ref(refname, sha1, sb_refname, sb_path, &read_flags)) {
+		if (read_raw_ref(submodule, refname, sha1, sb_refname, sb_path,
+				 &read_flags)) {
 			int saved_errno = errno;
 			if (flags)
 				*flags |= read_flags;
@@ -1419,8 +1426,8 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 	struct strbuf sb_path = STRBUF_INIT;
 	const char *ret;
 
-	ret = resolve_ref_1(refname, resolve_flags, sha1, flags,
-			    &sb_refname, &sb_path);
+	ret = resolve_ref_unsafe_submodule(NULL, refname, resolve_flags, sha1,
+					   flags, &sb_refname, &sb_path);
 
 	strbuf_release(&sb_path);
 	return ret;
@@ -1663,6 +1670,8 @@ int safe_create_reflog(const char *refname, int force_create,
 
 int delete_reflog(const char *refname)
 {
+	if (ref_type(refname) != REF_TYPE_NORMAL)
+		return refs_be_files.delete_reflog(refname);
 	return the_refs_backend->delete_reflog(refname);
 }
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index a13d419..87c02f8 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1413,7 +1413,8 @@ static int resolve_missing_loose_ref(const char *refname,
  *
  * sb_path is workspace: the caller should allocate and free it.
  */
-static int files_read_raw_ref(const char *refname, unsigned char *sha1,
+static int files_read_raw_ref(const char *submodule,
+			      const char *refname, unsigned char *sha1,
 			      struct strbuf *symref, struct strbuf *sb_path,
 			      unsigned int *flags)
 {
@@ -1423,7 +1424,10 @@ static int files_read_raw_ref(const char *refname, unsigned char *sha1,
 	const char *buf;
 
 	strbuf_reset(sb_path);
-	strbuf_git_path(sb_path, "%s", refname);
+	if (submodule)
+		strbuf_git_path_submodule(sb_path, submodule, "%s", refname);
+	else
+		strbuf_git_path(sb_path, "%s", refname);
 	path = sb_path->buf;
 
 	for (;;) {
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 0d3f9e7..9736959 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -230,6 +230,15 @@ int do_for_each_per_worktree_ref(const char *submodule, const char *base,
 				 each_ref_fn fn, int trim, int flags,
 				 void *cb_data);
 
+
+const char *resolve_ref_unsafe_submodule(const char *submodule,
+					 const char *refname,
+					 int resolve_flags,
+					 unsigned char *sha1,
+					 int *flags,
+					 struct strbuf *sb_refname,
+					 struct strbuf *sb_path);
+
 /* refs backends */
 typedef int ref_init_db_fn(int shared, struct strbuf *err);
 typedef int ref_transaction_commit_fn(struct ref_transaction *transaction,
@@ -266,9 +275,9 @@ typedef int rename_ref_fn(const char *oldref, const char *newref,
 			  const char *logmsg);
 
 /* resolution methods */
-typedef int read_raw_ref_fn(const char *refname, unsigned char *sha1,
-			    struct strbuf *symref, struct strbuf *sb_path,
-			    unsigned int *flags);
+typedef int read_raw_ref_fn(const char *submodule, const char *refname,
+			    unsigned char *sha1, struct strbuf *symref,
+			    struct strbuf *sb_path, unsigned int *flags);
 typedef int verify_refname_available_fn(const char *refname, struct string_list *extra, struct string_list *skip, struct strbuf *err);
 typedef int resolve_gitlink_ref_fn(const char *path, const char *refname,
 				   unsigned char *sha1);
@@ -305,4 +314,8 @@ struct ref_storage_be {
 };
 
 extern struct ref_storage_be refs_be_files;
+
+#ifdef USE_LIBLMDB
+extern struct ref_storage_be refs_be_lmdb;
+#endif
 #endif /* REFS_REFS_INTERNAL_H */
-- 
2.4.2.767.g62658d5-twtrsrc
