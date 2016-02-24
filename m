From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 29/32] refs: break out resolve_ref_unsafe_submodule
Date: Wed, 24 Feb 2016 17:59:01 -0500
Message-ID: <1456354744-8022-30-git-send-email-dturner@twopensource.com>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu Feb 25 00:00:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYiQO-0004YF-IJ
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 00:00:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759202AbcBXXAg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 18:00:36 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:35664 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759181AbcBXW7r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 17:59:47 -0500
Received: by mail-qk0-f171.google.com with SMTP id o6so13260117qkc.2
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 14:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e0mQUw0ICbISEoBT4jJ2U4sXafodcghYg5WnD62ns0Y=;
        b=AqlpUkqSE9XWjc7Zwwhl86L7i8yBLuSLpFyGpO/Xr5xlKuKw2rSPlIm2eZimdpnHWA
         lZnjMPrEfDeOWZY+RWKaB9XLo0mqMXrhJks1K7380hSaI3jRP+eKHGw3NhgcwbIDaUca
         +kNPOpf0LxMxl3deRUYVcI08YBsPl2GyDhru6FDJ9KT2nkd4nTOfgYOi1AIEuRA8Ls2D
         pdkvCyYCVNYa93RowpIcPneaVN9TJpe88z9Izj4CqPZiEiaKZm28QQ+waoal64bjwJyM
         myyOhowz8VUFl8VbHVLfiK17jExqm6XRkaC8bbXy79SFkOxzjHZizHcLehDH1atEMqth
         aFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e0mQUw0ICbISEoBT4jJ2U4sXafodcghYg5WnD62ns0Y=;
        b=E0VpCimf/Brmg61a7rNicwyzAtbmno3P+59zuHJ51fwMXGNLUpUgkfTLrRe+AYziE4
         kIXwhjJKMwD5tFUtZqY3wjsUcVbp1QHtk8EEQ686wGkmoYI1jrIPwNraz7bBMuZQf8FD
         XlaG8VKXZjv+hJYnB+nm6ErlP3s6hSA27PaZzMsqmH+E7tR3mPB1yY8vsU6avk504B3E
         6A8BEWYrz2VY7BjMabdvrBY3uXevZmLn9U0kFZunmCvND3kuTdT9X+y7Ue2g3ojmLodB
         yB6/tbWf9gQgp+/LTdOi2Mvfqi1crbyy44Lz15xv3cxEcChdOYuJRe25MIwBTfze99ex
         D+7Q==
X-Gm-Message-State: AG10YOTRdAzQrVlHKnG7KJVsofhCLISFvZ4XciK3ayCgZrcu/75iMniiVeqyuZ3r6xwsuw==
X-Received: by 10.55.71.143 with SMTP id u137mr52325314qka.1.1456354786651;
        Wed, 24 Feb 2016 14:59:46 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 66sm2154254qhp.4.2016.02.24.14.59.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Feb 2016 14:59:45 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287265>

It will soon be useful for resolve_ref_unsafe to support submodules.
But since it is called from so many places, changing it would have
been painful.  Fortunately, it's just a thin wrapper around (the
former) resolve_ref_1.  So now resolve_ref_1 becomes
resolve_ref_unsafe_submodule, and it passes its submodule argument
through to read_raw_ref.

The files backend doesn't need this functionality, but it doesn't
hurt.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c               | 41 +++++++++++++++++++++++++----------------
 refs/files-backend.c |  8 ++++++--
 refs/refs-internal.h | 19 ++++++++++++++++---
 3 files changed, 47 insertions(+), 21 deletions(-)

diff --git a/refs.c b/refs.c
index 90de086..9faeae9 100644
--- a/refs.c
+++ b/refs.c
@@ -61,6 +61,9 @@ void register_ref_storage_backends(void)
 	 * entries below when you add a new backend.
 	 */
 	register_ref_storage_backend(&refs_be_files);
+#ifdef USE_LIBLMDB
+	register_ref_storage_backend(&refs_be_lmdb);
+#endif
 }
 
 /*
@@ -321,8 +324,10 @@ static int submodule_backend(const char *key, const char *value, void *data)
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
@@ -1310,21 +1315,22 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
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
@@ -1355,7 +1361,8 @@ static const char *resolve_ref_1(const char *refname,
 	for (symref_count = 0; symref_count < SYMREF_MAXDEPTH; symref_count++) {
 		int read_flags = 0;
 
-		if (read_raw_ref(refname, sha1, sb_refname, sb_path, &read_flags)) {
+		if (read_raw_ref(submodule, refname, sha1, sb_refname, sb_path,
+				 &read_flags)) {
 			int saved_errno = errno;
 			if (flags)
 				*flags |= read_flags;
@@ -1416,8 +1423,8 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 	struct strbuf sb_path = STRBUF_INIT;
 	const char *ret;
 
-	ret = resolve_ref_1(refname, resolve_flags, sha1, flags,
-			    &sb_refname, &sb_path);
+	ret = resolve_ref_unsafe_submodule(NULL, refname, resolve_flags, sha1,
+					   flags, &sb_refname, &sb_path);
 
 	strbuf_release(&sb_path);
 	return ret;
@@ -1660,6 +1667,8 @@ int safe_create_reflog(const char *refname, int force_create,
 
 int delete_reflog(const char *refname)
 {
+	if (ref_type(refname) != REF_TYPE_NORMAL)
+	       return refs_be_files.delete_reflog(refname);
 	return the_refs_backend->delete_reflog(refname);
 }
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 6f13b70..c95cb91 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1421,7 +1421,8 @@ static int resolve_missing_loose_ref(const char *refname,
  *
  * sb_path is workspace: the caller should allocate and free it.
  */
-static int files_read_raw_ref(const char *refname, unsigned char *sha1,
+static int files_read_raw_ref(const char *submodule,
+			      const char *refname, unsigned char *sha1,
 			      struct strbuf *symref, struct strbuf *sb_path,
 			      unsigned int *flags)
 {
@@ -1431,7 +1432,10 @@ static int files_read_raw_ref(const char *refname, unsigned char *sha1,
 	const char *buf;
 
 	strbuf_reset(sb_path);
-	strbuf_git_path(sb_path, "%s", refname);
+	if (submodule)
+		strbuf_git_path_submodule(sb_path, submodule, "%s", refname);
+	else
+		strbuf_git_path(sb_path, "%s", refname);
 	path = sb_path->buf;
 
 	for(;;) {
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
