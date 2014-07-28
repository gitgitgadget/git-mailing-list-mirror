From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH v3 03/10] setup: convert setup_git_directory_gently_1 et al.
 to strbuf
Date: Mon, 28 Jul 2014 20:26:40 +0200
Message-ID: <53D695E0.2050209@web.de>
References: <53D694A2.8030007@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 28 20:26:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBpdR-0002iX-4O
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 20:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbaG1S0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 14:26:53 -0400
Received: from mout.web.de ([212.227.17.11]:52458 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750926AbaG1S0w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 14:26:52 -0400
Received: from [192.168.178.27] ([79.253.140.83]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MF3nL-1XIBQ101HP-00GLnd; Mon, 28 Jul 2014 20:26:42
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <53D694A2.8030007@web.de>
X-Provags-ID: V03:K0:F8S+eMZ9yx2G8yN6vbR47Uc8/9c9vQ+jHK+O0hL85diLvrsa8rc
 uOyF1ZcLao6gveVqrfAzjEUYhQvZ35CrAjSC1638wgcX1IKMzBRPseAN25zap1N9P5BuRj0
 pQUnRuLnvRp34NY0ML6MKubkvu6ua52gb5Q966BSPooLxA0zeld0gnuIfTkhP0ZhSVUOGO9
 DbbTayjjIjrQIhEG7XE4w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254336>

Convert setup_git_directory_gently_1() and its helper functions
setup_explicit_git_dir(), setup_discovered_git_dir() and
setup_bare_git_dir() to use a struct strbuf to hold the current working
directory.  Replacing the PATH_MAX-sized buffer used before removes a
path length limition on some file systems.  The functions are converted
all in one go because they all read and write the variable cwd.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 setup.c | 85 +++++++++++++++++++++++++++++++++--------------------------------
 1 file changed, 43 insertions(+), 42 deletions(-)

diff --git a/setup.c b/setup.c
index 0a22f8b..c8b8a97 100644
--- a/setup.c
+++ b/setup.c
@@ -387,7 +387,7 @@ const char *read_gitfile(const char *path)
 }
 
 static const char *setup_explicit_git_dir(const char *gitdirenv,
-					  char *cwd, int len,
+					  struct strbuf *cwd,
 					  int *nongit_ok)
 {
 	const char *work_tree_env = getenv(GIT_WORK_TREE_ENVIRONMENT);
@@ -441,7 +441,7 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
 				die_errno("Could not chdir to '%s'", git_work_tree_cfg);
 			if (!getcwd(core_worktree, PATH_MAX))
 				die_errno("Could not get directory '%s'", git_work_tree_cfg);
-			if (chdir(cwd))
+			if (chdir(cwd->buf))
 				die_errno("Could not come back to cwd");
 			set_git_work_tree(core_worktree);
 		}
@@ -459,21 +459,20 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
 	worktree = get_git_work_tree();
 
 	/* both get_git_work_tree() and cwd are already normalized */
-	if (!strcmp(cwd, worktree)) { /* cwd == worktree */
+	if (!strcmp(cwd->buf, worktree)) { /* cwd == worktree */
 		set_git_dir(gitdirenv);
 		free(gitfile);
 		return NULL;
 	}
 
-	offset = dir_inside_of(cwd, worktree);
+	offset = dir_inside_of(cwd->buf, worktree);
 	if (offset >= 0) {	/* cwd inside worktree? */
 		set_git_dir(real_path(gitdirenv));
 		if (chdir(worktree))
 			die_errno("Could not chdir to '%s'", worktree);
-		cwd[len++] = '/';
-		cwd[len] = '\0';
+		strbuf_addch(cwd, '/');
 		free(gitfile);
-		return cwd + offset;
+		return cwd->buf + offset;
 	}
 
 	/* cwd outside worktree */
@@ -483,7 +482,7 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
 }
 
 static const char *setup_discovered_git_dir(const char *gitdir,
-					    char *cwd, int offset, int len,
+					    struct strbuf *cwd, int offset,
 					    int *nongit_ok)
 {
 	if (check_repository_format_gently(gitdir, nongit_ok))
@@ -491,17 +490,17 @@ static const char *setup_discovered_git_dir(const char *gitdir,
 
 	/* --work-tree is set without --git-dir; use discovered one */
 	if (getenv(GIT_WORK_TREE_ENVIRONMENT) || git_work_tree_cfg) {
-		if (offset != len && !is_absolute_path(gitdir))
+		if (offset != cwd->len && !is_absolute_path(gitdir))
 			gitdir = xstrdup(real_path(gitdir));
-		if (chdir(cwd))
+		if (chdir(cwd->buf))
 			die_errno("Could not come back to cwd");
-		return setup_explicit_git_dir(gitdir, cwd, len, nongit_ok);
+		return setup_explicit_git_dir(gitdir, cwd, nongit_ok);
 	}
 
 	/* #16.2, #17.2, #20.2, #21.2, #24, #25, #28, #29 (see t1510) */
 	if (is_bare_repository_cfg > 0) {
-		set_git_dir(offset == len ? gitdir : real_path(gitdir));
-		if (chdir(cwd))
+		set_git_dir(offset == cwd->len ? gitdir : real_path(gitdir));
+		if (chdir(cwd->buf))
 			die_errno("Could not come back to cwd");
 		return NULL;
 	}
@@ -512,18 +511,18 @@ static const char *setup_discovered_git_dir(const char *gitdir,
 		set_git_dir(gitdir);
 	inside_git_dir = 0;
 	inside_work_tree = 1;
-	if (offset == len)
+	if (offset == cwd->len)
 		return NULL;
 
 	/* Make "offset" point to past the '/', and add a '/' at the end */
 	offset++;
-	cwd[len++] = '/';
-	cwd[len] = 0;
-	return cwd + offset;
+	strbuf_addch(cwd, '/');
+	return cwd->buf + offset;
 }
 
 /* #16.1, #17.1, #20.1, #21.1, #22.1 (see t1510) */
-static const char *setup_bare_git_dir(char *cwd, int offset, int len, int *nongit_ok)
+static const char *setup_bare_git_dir(struct strbuf *cwd, int offset,
+				      int *nongit_ok)
 {
 	int root_len;
 
@@ -536,20 +535,20 @@ static const char *setup_bare_git_dir(char *cwd, int offset, int len, int *nongi
 	if (getenv(GIT_WORK_TREE_ENVIRONMENT) || git_work_tree_cfg) {
 		const char *gitdir;
 
-		gitdir = offset == len ? "." : xmemdupz(cwd, offset);
-		if (chdir(cwd))
+		gitdir = offset == cwd->len ? "." : xmemdupz(cwd->buf, offset);
+		if (chdir(cwd->buf))
 			die_errno("Could not come back to cwd");
-		return setup_explicit_git_dir(gitdir, cwd, len, nongit_ok);
+		return setup_explicit_git_dir(gitdir, cwd, nongit_ok);
 	}
 
 	inside_git_dir = 1;
 	inside_work_tree = 0;
-	if (offset != len) {
-		if (chdir(cwd))
+	if (offset != cwd->len) {
+		if (chdir(cwd->buf))
 			die_errno("Cannot come back to cwd");
-		root_len = offset_1st_component(cwd);
-		cwd[offset > root_len ? offset : root_len] = '\0';
-		set_git_dir(cwd);
+		root_len = offset_1st_component(cwd->buf);
+		strbuf_setlen(cwd, offset > root_len ? offset : root_len);
+		set_git_dir(cwd->buf);
 	}
 	else
 		set_git_dir(".");
@@ -617,10 +616,10 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
 {
 	const char *env_ceiling_dirs = getenv(CEILING_DIRECTORIES_ENVIRONMENT);
 	struct string_list ceiling_dirs = STRING_LIST_INIT_DUP;
-	static char cwd[PATH_MAX + 1];
+	static struct strbuf cwd = STRBUF_INIT;
 	const char *gitdirenv, *ret;
 	char *gitfile;
-	int len, offset, offset_parent, ceil_offset = -1;
+	int offset, offset_parent, ceil_offset = -1;
 	dev_t current_device = 0;
 	int one_filesystem = 1;
 
@@ -632,9 +631,9 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
 	if (nongit_ok)
 		*nongit_ok = 0;
 
-	if (!getcwd(cwd, sizeof(cwd) - 1))
+	if (strbuf_getcwd(&cwd))
 		die_errno("Unable to read current working directory");
-	offset = len = strlen(cwd);
+	offset = cwd.len;
 
 	/*
 	 * If GIT_DIR is set explicitly, we're not going
@@ -643,7 +642,7 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
 	 */
 	gitdirenv = getenv(GIT_DIR_ENVIRONMENT);
 	if (gitdirenv)
-		return setup_explicit_git_dir(gitdirenv, cwd, len, nongit_ok);
+		return setup_explicit_git_dir(gitdirenv, &cwd, nongit_ok);
 
 	if (env_ceiling_dirs) {
 		int empty_entry_found = 0;
@@ -651,7 +650,7 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
 		string_list_split(&ceiling_dirs, env_ceiling_dirs, PATH_SEP, -1);
 		filter_string_list(&ceiling_dirs, 0,
 				   canonicalize_ceiling_entry, &empty_entry_found);
-		ceil_offset = longest_ancestor_length(cwd, &ceiling_dirs);
+		ceil_offset = longest_ancestor_length(cwd.buf, &ceiling_dirs);
 		string_list_clear(&ceiling_dirs, 0);
 	}
 
@@ -683,7 +682,7 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
 
 		if (gitdirenv) {
 			ret = setup_discovered_git_dir(gitdirenv,
-						       cwd, offset, len,
+						       &cwd, offset,
 						       nongit_ok);
 			free(gitfile);
 			return ret;
@@ -691,29 +690,31 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
 		free(gitfile);
 
 		if (is_git_directory("."))
-			return setup_bare_git_dir(cwd, offset, len, nongit_ok);
+			return setup_bare_git_dir(&cwd, offset, nongit_ok);
 
 		offset_parent = offset;
-		while (--offset_parent > ceil_offset && cwd[offset_parent] != '/');
+		while (--offset_parent > ceil_offset && cwd.buf[offset_parent] != '/');
 		if (offset_parent <= ceil_offset)
-			return setup_nongit(cwd, nongit_ok);
+			return setup_nongit(cwd.buf, nongit_ok);
 		if (one_filesystem) {
-			dev_t parent_device = get_device_or_die("..", cwd, offset);
+			dev_t parent_device = get_device_or_die("..", cwd.buf,
+								offset);
 			if (parent_device != current_device) {
 				if (nongit_ok) {
-					if (chdir(cwd))
+					if (chdir(cwd.buf))
 						die_errno("Cannot come back to cwd");
 					*nongit_ok = 1;
 					return NULL;
 				}
-				cwd[offset] = '\0';
+				strbuf_setlen(&cwd, offset);
 				die("Not a git repository (or any parent up to mount point %s)\n"
-				"Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set).", cwd);
+				"Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set).",
+				    cwd.buf);
 			}
 		}
 		if (chdir("..")) {
-			cwd[offset] = '\0';
-			die_errno("Cannot change to '%s/..'", cwd);
+			strbuf_setlen(&cwd, offset);
+			die_errno("Cannot change to '%s/..'", cwd.buf);
 		}
 		offset = offset_parent;
 	}
-- 
2.0.2
