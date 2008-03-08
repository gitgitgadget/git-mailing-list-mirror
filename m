From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 11/11] Support bundles in builtin-clone
Date: Sat, 8 Mar 2008 18:04:29 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0803081804280.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 09 00:11:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY8Cj-0001vn-VL
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 00:11:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019AbYCHXLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 18:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752016AbYCHXLL
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 18:11:11 -0500
Received: from iabervon.org ([66.92.72.58]:48094 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751421AbYCHXLL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 18:11:11 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sat, 08 Mar 2008 18:11:10 EST
Received: (qmail 18624 invoked by uid 1000); 8 Mar 2008 23:04:29 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Mar 2008 23:04:29 -0000
X-X-Sender: barkalow@iabervon.org
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76611>

This forward-ports c6fef0bb(clone: support cloning full bundles) to the
builtin clone.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-clone.c        |   63 ++++++++++++++++++++++++++++-------------------
 t/t5701-clone-local.sh |    6 ++--
 2 files changed, 40 insertions(+), 29 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 1b83062..e4047ed 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -64,42 +64,52 @@ static struct option builtin_clone_options[] = {
 	OPT_END()
 };
 
-static char *get_repo_path(const char *repo)
+static char *get_repo_path(const char *repo, int *is_bundle)
 {
-	const char *path;
-	struct stat buf;
-
-	path = mkpath("%s/.git", repo);
-	if (!stat(path, &buf) && S_ISDIR(buf.st_mode))
-		return xstrdup(make_absolute_path(path));
-
-	path = mkpath("%s.git", repo);
-	if (!stat(path, &buf) && S_ISDIR(buf.st_mode))
-		return xstrdup(make_absolute_path(path));
+	static char *suffix[] = { "/.git", ".git", "" };
+	static char *bundle_suffix[] = { ".bundle", "" };
+	struct stat st;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(suffix); i++) {
+		const char *path;
+		path = mkpath("%s%s", repo, suffix[i]);
+		if (!stat(path, &st) && S_ISDIR(st.st_mode)) {
+			*is_bundle = 0;
+			return xstrdup(make_absolute_path(path));
+		}
+	}
 
-	if (!stat(repo, &buf) && S_ISDIR(buf.st_mode))
-		return xstrdup(make_absolute_path(repo));
+	for (i = 0; i < ARRAY_SIZE(bundle_suffix); i++) {
+		const char *path;
+		path = mkpath("%s%s", repo, bundle_suffix[i]);
+		if (!stat(path, &st) && S_ISREG(st.st_mode)) {
+			*is_bundle = 1;
+			return xstrdup(make_absolute_path(path));
+		}
+	}
 
 	return NULL;
 }
 
-static char *guess_dir_name(const char *repo)
+static char *guess_dir_name(const char *repo, int is_bundle)
 {
 	const char *p, *start, *end, *limit;
 	int after_slash_or_colon;
 
 	/* Guess dir name from repository: strip trailing '/',
-	 * strip trailing '[:/]*git', strip leading '.*[/:]'. */
+	 * strip trailing '[:/]*.{git,bundle}', strip leading '.*[/:]'. */
 
 	after_slash_or_colon = 1;
 	limit = repo + strlen(repo);
 	start = repo;
 	end = limit;
 	for (p = repo; p < limit; p++) {
-		if (!prefixcmp(p, ".git")) {
+		const char *prefix = is_bundle ? ".bundle" : ".git";
+		if (!prefixcmp(p, prefix)) {
 			if (!after_slash_or_colon)
 				end = p;
-			p += 3;
+			p += strlen(prefix) - 1;
 		} else if (!prefixcmp(p, ".bundle")) {
 			if (!after_slash_or_colon)
 				end = p;
@@ -312,6 +322,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 {
 	int use_local_hardlinks = 1;
 	int use_separate_remote = 1;
+	int is_bundle = 0;
 	struct stat buf;
 	const char *repo_name, *repo, *work_tree, *git_dir;
 	char *path, *dir;
@@ -345,14 +356,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	repo_name = argv[0];
 
-	if (argc == 2) {
-		dir = xstrdup(argv[1]);
-	} else {
-		dir = guess_dir_name(repo_name);
-	}
-	fprintf(stderr, "dir is %s\n", dir);
-
-	path = get_repo_path(repo_name);
+	path = get_repo_path(repo_name, &is_bundle);
 	if (path != NULL)
 		repo = xstrdup(make_absolute_path(path));
 	else if (!strchr(repo_name, ':'))
@@ -361,6 +365,13 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		repo = repo_name;
 	fprintf(stderr, "repo is %s\n", repo);
 
+	if (argc == 2) {
+		dir = xstrdup(argv[1]);
+	} else {
+		dir = guess_dir_name(repo_name, is_bundle);
+	}
+	fprintf(stderr, "dir is %s\n", dir);
+
 	if (!stat(dir, &buf))
 		die("destination directory '%s' already exists.", dir);
 
@@ -426,7 +437,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	refspec.src = "refs/heads/";
 	refspec.dst = branch_top;
 
-	if (path != NULL)
+	if (path != NULL && !is_bundle)
 		refs = clone_local(path, git_dir);
 	else {
 		struct remote *remote = remote_get(argv[0]);
diff --git a/t/t5701-clone-local.sh b/t/t5701-clone-local.sh
index 7cfe716..8dfaaa4 100755
--- a/t/t5701-clone-local.sh
+++ b/t/t5701-clone-local.sh
@@ -83,14 +83,14 @@ test_expect_success 'bundle clone without .bundle suffix' '
 	git fetch
 '
 
-test_expect_failure 'bundle clone with .bundle suffix' '
+test_expect_success 'bundle clone with .bundle suffix' '
 	cd "$D" &&
 	git clone b1.bundle &&
 	cd b1 &&
 	git fetch
 '
 
-test_expect_failure 'bundle clone from b4' '
+test_expect_success 'bundle clone from b4' '
 	cd "$D" &&
 	git clone b4 bdl &&
 	cd bdl &&
@@ -108,7 +108,7 @@ test_expect_success 'bundle clone from b4.bundle that does not exist' '
 	fi
 '
 
-test_expect_failure 'bundle clone with nonexistent HEAD' '
+test_expect_success 'bundle clone with nonexistent HEAD' '
 	cd "$D" &&
 	git clone b2.bundle b2 &&
 	cd b2 &&
-- 
1.5.4.3.327.g614d7.dirty
