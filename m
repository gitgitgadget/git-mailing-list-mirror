From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] environment.c: introduce DECLARE_GIT_GETTER helper macro
Date: Sun, 28 Feb 2016 01:35:44 +0600
Message-ID: <1456601744-18404-1-git-send-email-kuleshovmail@gmail.com>
Cc: Git <git@vger.kernel.org>,
	Alexander Kuleshov <kuleshovmail@gmail.com>
To: JunioCHamanogitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 27 20:40:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZkis-00026q-VW
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 20:40:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992517AbcB0TkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 14:40:09 -0500
Received: from mail-lb0-f182.google.com ([209.85.217.182]:36852 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389AbcB0TkH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 14:40:07 -0500
Received: by mail-lb0-f182.google.com with SMTP id x1so61947193lbj.3
        for <git@vger.kernel.org>; Sat, 27 Feb 2016 11:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=5M6Mf7Nxoo+8QDBNFnbWGSMZ2ot9g/OZV5XYA1QLa4Q=;
        b=t0/1MYaDLIOR6JLJ7kQz77MRnwEcQ90H/FU8DECgOpXjktf7bXwUZTnFBbPyMV+wWM
         7JNm3XAYsYSEADLG8XFN7ik8Vp+YkLdj4oXngdPdAkHqg84TbDVBKdZNOoh5IosHdIor
         2U/cc1AURNFEZAuLE/J34a7vI1jNKcYQUFJP6pNXgkV4zpu65jz2f4Z7XUWJ+8sRz/zn
         +/zNtrc6/+6nBdvC8ih34PsLt201qRy5/WEt+RiJPAgRDIyOh1oIS+uF3md1kBWr7DgJ
         So/DaJStEvC30arirviKKfTlarPQKjQtgosENa0wYp8YPC9fdW/PGikX2aPcwRFzfroc
         fbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5M6Mf7Nxoo+8QDBNFnbWGSMZ2ot9g/OZV5XYA1QLa4Q=;
        b=ZUE8GSZ16gqS8yMNe3+3UkdVgONa6yfqmLnuZ7asEhxrTdMzQC0mrLBbV0QcEFNoU7
         imq07J0zG/OMHOgkVhDIZt0XUMm8hUfJsJHCELUkVFOuHkICG7U6EGS5MmHjDtGwYJSN
         lyNqNo4GJLV34owZcOUZgBoD2RCbkcDqsKZ4VUPitmWc6a6tPz9VcE/4anyyO8gSLvzL
         sdvxJHa249DKSp/Bl2lVQ7ekDX9heVezX6uiIjz4jgrrswJ5ARgmK0nHXJwSGVr9cbNn
         SS3hVn9iPr7nsPHJ/HcBPngCh6S+DcgcHynRTgRD0LBj6LTHxUIN5ugTSf/g1gzlAF+V
         5tiA==
X-Gm-Message-State: AD7BkJJpA8jasp87ULNGhRkT7BCuFlsvx9eZVe4llixDYkdYwMmS0IT29iV+/IriFDv6Jw==
X-Received: by 10.112.172.233 with SMTP id bf9mr2759689lbc.121.1456602005993;
        Sat, 27 Feb 2016 11:40:05 -0800 (PST)
Received: from localhost.localhost ([2.134.234.130])
        by smtp.gmail.com with ESMTPSA id ay2sm2662040lbc.39.2016.02.27.11.40.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Feb 2016 11:40:05 -0800 (PST)
X-Mailer: git-send-email 2.8.0.rc0.142.g64f2103.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287728>

The environment.c contans a couple of functions which are
consist from the following pattern:

        if (!env)
                setup_git_env();
        return env;

Let's move declaration of these functions to the DECLARE_GIT_GETTER
helper macro to prevent code duplication.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 environment.c | 49 ++++++++++++++-----------------------------------
 1 file changed, 14 insertions(+), 35 deletions(-)

diff --git a/environment.c b/environment.c
index 6dec9d0..f10fc7a 100644
--- a/environment.c
+++ b/environment.c
@@ -126,6 +126,14 @@ const char * const local_repo_env[] = {
 	NULL
 };
 
+#define DECLARE_GIT_GETTER(type, name, env)	\
+	type name(void)				\
+	{					\
+		if (!env)			\
+			setup_git_env();	\
+		return env;			\
+	}
+
 static char *expand_namespace(const char *raw_namespace)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -197,25 +205,11 @@ int is_bare_repository(void)
 	return is_bare_repository_cfg && !get_git_work_tree();
 }
 
-const char *get_git_dir(void)
-{
-	if (!git_dir)
-		setup_git_env();
-	return git_dir;
-}
-
 const char *get_git_common_dir(void)
 {
 	return git_common_dir;
 }
 
-const char *get_git_namespace(void)
-{
-	if (!namespace)
-		setup_git_env();
-	return namespace;
-}
-
 const char *strip_namespace(const char *namespaced_ref)
 {
 	if (!starts_with(namespaced_ref, get_git_namespace()))
@@ -249,13 +243,6 @@ const char *get_git_work_tree(void)
 	return work_tree;
 }
 
-char *get_object_directory(void)
-{
-	if (!git_object_dir)
-		setup_git_env();
-	return git_object_dir;
-}
-
 int odb_mkstemp(char *template, size_t limit, const char *pattern)
 {
 	int fd;
@@ -293,20 +280,6 @@ int odb_pack_keep(char *name, size_t namesz, const unsigned char *sha1)
 	return open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
 }
 
-char *get_index_file(void)
-{
-	if (!git_index_file)
-		setup_git_env();
-	return git_index_file;
-}
-
-char *get_graft_file(void)
-{
-	if (!git_graft_file)
-		setup_git_env();
-	return git_graft_file;
-}
-
 int set_git_dir(const char *path)
 {
 	if (setenv(GIT_DIR_ENVIRONMENT, path, 1))
@@ -325,3 +298,9 @@ const char *get_commit_output_encoding(void)
 {
 	return git_commit_encoding ? git_commit_encoding : "UTF-8";
 }
+
+DECLARE_GIT_GETTER(const char *, get_git_dir, git_dir)
+DECLARE_GIT_GETTER(const char *, get_git_namespace, namespace)
+DECLARE_GIT_GETTER(char *, get_object_directory, git_object_dir)
+DECLARE_GIT_GETTER(char *, get_index_file, git_index_file)
+DECLARE_GIT_GETTER(char *, get_graft_file, git_graft_file)
-- 
2.8.0.rc0.142.g64f2103.dirty
