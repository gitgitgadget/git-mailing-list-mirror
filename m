From: Dmitry Kakurin <dmitry.kakurin@gmail.com>
Subject: [MinGW PATCH] git clone was failing with 'invalid object name HEAD' if ran from cmd.exe directly
Date: Mon, 6 Aug 2007 02:44:49 -0700
Message-ID: <BD28FA320B7749FFBE3135FE92380BCE@ntdev.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="koi8-r";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 06 11:45:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHz9B-0003bH-UD
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 11:45:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760409AbXHFJoy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 05:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755273AbXHFJoy
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 05:44:54 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:55975 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755478AbXHFJow (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 05:44:52 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1726876wah
        for <git@vger.kernel.org>; Mon, 06 Aug 2007 02:44:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        b=Xcs4N365li2WHaAx6Uy2mYLE6gsaOo9SgkblyxAOgIYCMKG5Bo128fQXNEsgl5iAbTV1/CyX9HFSJJR6DCA4ubDXctVxt8o/eWh8SKwCqr9uAliypnFHqnZlSzKv2SLt2g74JLA2AjlHUh9w7vkmil8x7Ueh0KsSGPH2ik0uod0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        b=cKfM9g+1ZbLkfJJGRWgVZy+8fd4x+1zUhHJH8IZXl6V80yGmLYlOervf3B0crlLVPLQ2NjEtR0ohJsyWLNRiCli9UR78NTKNscPSbTQ3YvqX82TxG5BWIHtAzqWyEjn0sBVqA4P6rOUS91ZNOTus16i8+TgTCwuNvDOLU6UJY4s=
Received: by 10.114.77.1 with SMTP id z1mr5472963waa.1186393491789;
        Mon, 06 Aug 2007 02:44:51 -0700 (PDT)
Received: from dmitrykl2 ( [71.112.20.227])
        by mx.google.com with ESMTPS id j15sm6206047waf.2007.08.06.02.44.51
        (version=SSLv3 cipher=OTHER);
        Mon, 06 Aug 2007 02:44:51 -0700 (PDT)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Windows Mail 6.0.6000.16480
X-MimeOLE: Produced By Microsoft MimeOLE V6.0.6000.16480
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55131>

environment.c caches results of many getenv calls.
Under MinGW setenv(X) invalidates all previous values returned by getenv(X)
so cached values become dangling pointers.

Added cache-aware function set_git_dir to complement get_git_dir

Signed-off-by: Dmitry Kakurin <Dmitry.Kakurin@gmail.com>
---
 builtin-init-db.c |    4 +---
 cache.h           |    1 +
 environment.c     |    6 ++++++
 git.c             |    6 +++---
 path.c            |    2 +-
 setup.c           |    6 +++---
 7 files changed, 21 insertions(+), 10 deletions(-)
 create mode 100644 config.mak

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 5c0feba..62e579d 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -344,9 +344,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
  /*
   * Set up the default .git directory contents
   */
- git_dir = getenv(GIT_DIR_ENVIRONMENT);
- if (!git_dir)
-  git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;
+ git_dir = get_git_dir();
  safe_create_dir(git_dir, 0);
 
  /* Check to see if the repository version is right.
diff --git a/cache.h b/cache.h
index 91e9f71..bc2916e 100644
--- a/cache.h
+++ b/cache.h
@@ -210,6 +210,7 @@ extern int is_bare_repository(void);
 extern int is_inside_git_dir(void);
 extern int is_inside_work_tree(void);
 extern const char *get_git_dir(void);
+extern void set_git_dir(const char *newDir);
 extern char *get_object_directory(void);
 extern char *get_refs_directory(void);
 extern char *get_index_file(void);
diff --git a/environment.c b/environment.c
index f83fb9e..6ea7088 100644
--- a/environment.c
+++ b/environment.c
@@ -80,6 +80,12 @@ const char *get_git_dir(void)
  return git_dir;
 }
 
+void set_git_dir(const char *newDir)
+{
+    setenv(GIT_DIR_ENVIRONMENT, newDir, 1);
+    git_dir = NULL; // reset cache
+}
+
 char *get_object_directory(void)
 {
  if (!git_object_dir)
diff --git a/git.c b/git.c
index 210a763..53dfa05 100644
--- a/git.c
+++ b/git.c
@@ -67,14 +67,14 @@ static int handle_options(const char*** argv, int* argc, int* envchanged)
     fprintf(stderr, "No directory given for --git-dir.\n" );
     usage(git_usage_string);
    }
-   setenv(GIT_DIR_ENVIRONMENT, (*argv)[1], 1);
+   set_git_dir( (*argv)[1] );
    if (envchanged)
     *envchanged = 1;
    (*argv)++;
    (*argc)--;
    handled++;
   } else if (!prefixcmp(cmd, "--git-dir=")) {
-   setenv(GIT_DIR_ENVIRONMENT, cmd + 10, 1);
+   set_git_dir(cmd + 10);
    if (envchanged)
     *envchanged = 1;
   } else if (!strcmp(cmd, "--work-tree")) {
@@ -93,7 +93,7 @@ static int handle_options(const char*** argv, int* argc, int* envchanged)
     *envchanged = 1;
   } else if (!strcmp(cmd, "--bare")) {
    static char git_dir[PATH_MAX+1];
-   setenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir, sizeof(git_dir)), 1);
+   set_git_dir(getcwd(git_dir, sizeof(git_dir)));
    if (envchanged)
     *envchanged = 1;
   } else {
diff --git a/path.c b/path.c
index 8a06cf7..14af033 100644
--- a/path.c
+++ b/path.c
@@ -266,7 +266,7 @@ char *enter_repo(char *path, int strict)
 
  if (access("objects", X_OK) == 0 && access("refs", X_OK) == 0 &&
      validate_headref("HEAD") == 0) {
-  setenv(GIT_DIR_ENVIRONMENT, ".", 1);
+  set_git_dir(".");
   check_repository_format();
   return path;
  }
diff --git a/setup.c b/setup.c
index 47cd790..c5cf3ea 100644
--- a/setup.c
+++ b/setup.c
@@ -292,7 +292,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
    }
    die("Not a git repository");
   }
-  setenv(GIT_DIR_ENVIRONMENT, cwd, 1);
+  set_git_dir(cwd);
   gitdirenv = getenv(GIT_DIR_ENVIRONMENT);
   if (!gitdirenv)
    die("getenv after setenv failed");
@@ -332,8 +332,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
   * In case there is a work tree we may change the directory,
   * therefore make GIT_DIR an absolute path.
   */
- if ( !is_absolute_path( gitdirenv ) ) {
-  setenv(GIT_DIR_ENVIRONMENT, gitdir, 1);
+ if (!is_absolute_path(gitdirenv)) {
+  set_git_dir(gitdir);
   gitdirenv = getenv(GIT_DIR_ENVIRONMENT);
   if (!gitdirenv)
    die("getenv after setenv failed");
-- 
1.5.3.GIT

- Dmitry
