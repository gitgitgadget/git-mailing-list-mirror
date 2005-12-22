From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Introduce core.sharedrepository
Date: Thu, 22 Dec 2005 23:13:56 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512222313070.12044@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Dec 22 23:14:13 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpYhG-00015S-Mb
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 23:14:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030346AbVLVWN6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 17:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030348AbVLVWN6
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 17:13:58 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:32443 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1030346AbVLVWN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 17:13:57 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7231613F976; Thu, 22 Dec 2005 23:13:56 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 57ED79E3E1; Thu, 22 Dec 2005 23:13:56 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 41E149E3A1; Thu, 22 Dec 2005 23:13:56 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3082113F976; Thu, 22 Dec 2005 23:13:56 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13973>


This is the second attempt, after Junio convinced me that my simple approach
to set umask was misguided.

If the config variable 'core.sharedrepository' is set, the directories

	$GIT_DIR/objects/
	$GIT_DIR/objects/??
	$GIT_DIR/objects/pack
	$GIT_DIR/refs
	$GIT_DIR/refs/heads
	$GIT_DIR/refs/heads/tags

are set group writable (and g+s, since the git group may be not the primary
group of all users).

Since all files are written as lock files first,
and then moved to their destination, they do not have to be group writable.
Indeed, if this leads to problems you found a bug.

Note that -- as in my first attempt -- the config variable is set in the
function which checks the repository format. If this were done in
git_default_config instead, a lot of programs would need to be modified
to call git_config(git_default_config) first.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 cache.h     |    1 +
 setup.c     |    4 ++++
 sha1_file.c |   21 +++++++++++++++++++++
 3 files changed, 26 insertions(+), 0 deletions(-)

1a164f16e90378ba66e70e6082266645d3b45c57
diff --git a/cache.h b/cache.h
index cb87bec..0f875dd 100644
--- a/cache.h
+++ b/cache.h
@@ -159,6 +159,7 @@ extern void rollback_index_file(struct c
 extern int trust_executable_bit;
 extern int only_use_symrefs;
 extern int diff_rename_limit_default;
+extern int shared_repository;
 
 #define GIT_REPO_VERSION 0
 extern int repository_format_version;
diff --git a/setup.c b/setup.c
index d3556ed..3de372e 100644
--- a/setup.c
+++ b/setup.c
@@ -1,5 +1,7 @@
 #include "cache.h"
 
+int shared_repository = 0;
+
 const char *prefix_path(const char *prefix, int len, const char *path)
 {
 	const char *orig = path;
@@ -180,6 +182,8 @@ int check_repository_format_version(cons
 {
        if (strcmp(var, "core.repositoryformatversion") == 0)
                repository_format_version = git_config_int(var, value);
+	else if (strcmp(var, "core.sharedrepository") == 0)
+		shared_repository = git_config_bool(var, value);
        return 0;
 }
 
diff --git a/sha1_file.c b/sha1_file.c
index d451a94..e109a07 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -48,6 +48,21 @@ int get_sha1_hex(const char *hex, unsign
 	return 0;
 }
 
+static int make_group_writable(const char *path)
+{
+	struct stat st;
+
+	if (lstat(path, &st) < 0)
+		return -1;
+	if (st.st_mode & S_IWUSR)
+		st.st_mode |= S_IWGRP;
+	if (S_ISDIR(st.st_mode))
+		st.st_mode |= S_ISGID;
+	if (chmod(path, st.st_mode) < 0)
+		return -2;
+	return 0;
+}
+
 int safe_create_leading_directories(char *path)
 {
 	char *pos = path;
@@ -64,6 +79,10 @@ int safe_create_leading_directories(char
 				*pos = '/';
 				return -1;
 			}
+		if (shared_repository && make_group_writable(path)) {
+			*pos = '/';
+			return -2;
+		}
 		*pos++ = '/';
 	}
 	return 0;
@@ -1241,6 +1260,8 @@ static int link_temp_to_file(const char 
 		if (dir) {
 			*dir = 0;
 			mkdir(filename, 0777);
+			if (shared_repository && make_group_writable(filename))
+				return -2;
 			*dir = '/';
 			if (!link(tmpfile, filename))
 				return 0;
-- 
1.0.GIT
