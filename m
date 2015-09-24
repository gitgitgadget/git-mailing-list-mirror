From: Jeff King <peff@peff.net>
Subject: [PATCH 41/68] init: use strbufs to store paths
Date: Thu, 24 Sep 2015 17:07:36 -0400
Message-ID: <20150924210736.GL30946@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:09:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDls-0003uA-Ms
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754175AbbIXVJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:09:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:35995 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753768AbbIXVHi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:07:38 -0400
Received: (qmail 12067 invoked by uid 102); 24 Sep 2015 21:07:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:07:38 -0500
Received: (qmail 29348 invoked by uid 107); 24 Sep 2015 21:07:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:07:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:07:36 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278621>

The init code predates strbufs, and uses PATH_MAX-sized
buffers along with many manual checks on intermediate sizes
(some of which make magic assumptions, such as that init
will not create a path inside .git longer than 50
characters).

We can simplify this greatly by using strbufs, which drops
some hard-to-verify strcpy calls.  Note that we need to
update probe_utf8_pathname_composition, too, as it assumes
we are passing a buffer large enough to append its probe
filenames (it now just takes a strbuf, which also gets rid
of the confusing "len" parameter, which was not the length of
"path" but rather the offset to start writing).

Some of the conversion makes new calls to git_path_buf.
While we're in the area, let's also convert existing calls
to git_path to the safer git_path_buf (our existing calls
were passed to pretty tame functions, and so were not a
problem, but it's easy to be consistent and safe here).

Note that we had an explicit test that "git init" rejects
long template directories. This comes from 32d1776 (init: Do
not segfault on big GIT_TEMPLATE_DIR environment variable,
2009-04-18). We can drop the test_must_fail here, as we now
accept this and need only confirm that we don't segfault,
which was the original point of the test.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/init-db.c        | 174 ++++++++++++++++++++---------------------------
 compat/precompose_utf8.c |  12 ++--
 compat/precompose_utf8.h |   2 +-
 git-compat-util.h        |   2 +-
 t/t0001-init.sh          |   4 +-
 5 files changed, 87 insertions(+), 107 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index e7d0e31..cf6a3c8 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -36,10 +36,11 @@ static void safe_create_dir(const char *dir, int share)
 		die(_("Could not make %s writable by group"), dir);
 }
 
-static void copy_templates_1(char *path, int baselen,
-			     char *template, int template_baselen,
+static void copy_templates_1(struct strbuf *path, struct strbuf *template,
 			     DIR *dir)
 {
+	size_t path_baselen = path->len;
+	size_t template_baselen = template->len;
 	struct dirent *de;
 
 	/* Note: if ".git/hooks" file exists in the repository being
@@ -49,77 +50,64 @@ static void copy_templates_1(char *path, int baselen,
 	 * with the way the namespace under .git/ is organized, should
 	 * be really carefully chosen.
 	 */
-	safe_create_dir(path, 1);
+	safe_create_dir(path->buf, 1);
 	while ((de = readdir(dir)) != NULL) {
 		struct stat st_git, st_template;
-		int namelen;
 		int exists = 0;
 
+		strbuf_setlen(path, path_baselen);
+		strbuf_setlen(template, template_baselen);
+
 		if (de->d_name[0] == '.')
 			continue;
-		namelen = strlen(de->d_name);
-		if ((PATH_MAX <= baselen + namelen) ||
-		    (PATH_MAX <= template_baselen + namelen))
-			die(_("insanely long template name %s"), de->d_name);
-		memcpy(path + baselen, de->d_name, namelen+1);
-		memcpy(template + template_baselen, de->d_name, namelen+1);
-		if (lstat(path, &st_git)) {
+		strbuf_addstr(path, de->d_name);
+		strbuf_addstr(template, de->d_name);
+		if (lstat(path->buf, &st_git)) {
 			if (errno != ENOENT)
-				die_errno(_("cannot stat '%s'"), path);
+				die_errno(_("cannot stat '%s'"), path->buf);
 		}
 		else
 			exists = 1;
 
-		if (lstat(template, &st_template))
-			die_errno(_("cannot stat template '%s'"), template);
+		if (lstat(template->buf, &st_template))
+			die_errno(_("cannot stat template '%s'"), template->buf);
 
 		if (S_ISDIR(st_template.st_mode)) {
-			DIR *subdir = opendir(template);
-			int baselen_sub = baselen + namelen;
-			int template_baselen_sub = template_baselen + namelen;
+			DIR *subdir = opendir(template->buf);
 			if (!subdir)
-				die_errno(_("cannot opendir '%s'"), template);
-			path[baselen_sub++] =
-				template[template_baselen_sub++] = '/';
-			path[baselen_sub] =
-				template[template_baselen_sub] = 0;
-			copy_templates_1(path, baselen_sub,
-					 template, template_baselen_sub,
-					 subdir);
+				die_errno(_("cannot opendir '%s'"), template->buf);
+			strbuf_addch(path, '/');
+			strbuf_addch(template, '/');
+			copy_templates_1(path, template, subdir);
 			closedir(subdir);
 		}
 		else if (exists)
 			continue;
 		else if (S_ISLNK(st_template.st_mode)) {
-			char lnk[256];
-			int len;
-			len = readlink(template, lnk, sizeof(lnk));
-			if (len < 0)
-				die_errno(_("cannot readlink '%s'"), template);
-			if (sizeof(lnk) <= len)
-				die(_("insanely long symlink %s"), template);
-			lnk[len] = 0;
-			if (symlink(lnk, path))
-				die_errno(_("cannot symlink '%s' '%s'"), lnk, path);
+			struct strbuf lnk = STRBUF_INIT;
+			if (strbuf_readlink(&lnk, template->buf, 0) < 0)
+				die_errno(_("cannot readlink '%s'"), template->buf);
+			if (symlink(lnk.buf, path->buf))
+				die_errno(_("cannot symlink '%s' '%s'"),
+					  lnk.buf, path->buf);
+			strbuf_release(&lnk);
 		}
 		else if (S_ISREG(st_template.st_mode)) {
-			if (copy_file(path, template, st_template.st_mode))
-				die_errno(_("cannot copy '%s' to '%s'"), template,
-					  path);
+			if (copy_file(path->buf, template->buf, st_template.st_mode))
+				die_errno(_("cannot copy '%s' to '%s'"),
+					  template->buf, path->buf);
 		}
 		else
-			error(_("ignoring template %s"), template);
+			error(_("ignoring template %s"), template->buf);
 	}
 }
 
 static void copy_templates(const char *template_dir)
 {
-	char path[PATH_MAX];
-	char template_path[PATH_MAX];
-	int template_len;
+	struct strbuf path = STRBUF_INIT;
+	struct strbuf template_path = STRBUF_INIT;
+	size_t template_len;
 	DIR *dir;
-	const char *git_dir = get_git_dir();
-	int len = strlen(git_dir);
 	char *to_free = NULL;
 
 	if (!template_dir)
@@ -132,26 +120,23 @@ static void copy_templates(const char *template_dir)
 		free(to_free);
 		return;
 	}
-	template_len = strlen(template_dir);
-	if (PATH_MAX <= (template_len+strlen("/config")))
-		die(_("insanely long template path %s"), template_dir);
-	strcpy(template_path, template_dir);
-	if (template_path[template_len-1] != '/') {
-		template_path[template_len++] = '/';
-		template_path[template_len] = 0;
-	}
-	dir = opendir(template_path);
+
+	strbuf_addstr(&template_path, template_dir);
+	strbuf_complete(&template_path, '/');
+	template_len = template_path.len;
+
+	dir = opendir(template_path.buf);
 	if (!dir) {
 		warning(_("templates not found %s"), template_dir);
 		goto free_return;
 	}
 
 	/* Make sure that template is from the correct vintage */
-	strcpy(template_path + template_len, "config");
+	strbuf_addstr(&template_path, "config");
 	repository_format_version = 0;
 	git_config_from_file(check_repository_format_version,
-			     template_path, NULL);
-	template_path[template_len] = 0;
+			     template_path.buf, NULL);
+	strbuf_setlen(&template_path, template_len);
 
 	if (repository_format_version &&
 	    repository_format_version != GIT_REPO_VERSION) {
@@ -162,17 +147,15 @@ static void copy_templates(const char *template_dir)
 		goto close_free_return;
 	}
 
-	memcpy(path, git_dir, len);
-	if (len && path[len - 1] != '/')
-		path[len++] = '/';
-	path[len] = 0;
-	copy_templates_1(path, len,
-			 template_path, template_len,
-			 dir);
+	strbuf_addstr(&path, get_git_dir());
+	strbuf_complete(&path, '/');
+	copy_templates_1(&path, &template_path, dir);
 close_free_return:
 	closedir(dir);
 free_return:
 	free(to_free);
+	strbuf_release(&path);
+	strbuf_release(&template_path);
 }
 
 static int git_init_db_config(const char *k, const char *v, void *cb)
@@ -199,28 +182,20 @@ static int needs_work_tree_config(const char *git_dir, const char *work_tree)
 
 static int create_default_files(const char *template_path)
 {
-	const char *git_dir = get_git_dir();
-	unsigned len = strlen(git_dir);
-	static char path[PATH_MAX];
 	struct stat st1;
+	struct strbuf buf = STRBUF_INIT;
+	char *path;
 	char repo_version_string[10];
 	char junk[2];
 	int reinit;
 	int filemode;
 
-	if (len > sizeof(path)-50)
-		die(_("insane git directory %s"), git_dir);
-	memcpy(path, git_dir, len);
-
-	if (len && path[len-1] != '/')
-		path[len++] = '/';
-
 	/*
 	 * Create .git/refs/{heads,tags}
 	 */
-	safe_create_dir(git_path("refs"), 1);
-	safe_create_dir(git_path("refs/heads"), 1);
-	safe_create_dir(git_path("refs/tags"), 1);
+	safe_create_dir(git_path_buf(&buf, "refs"), 1);
+	safe_create_dir(git_path_buf(&buf, "refs/heads"), 1);
+	safe_create_dir(git_path_buf(&buf, "refs/tags"), 1);
 
 	/* Just look for `init.templatedir` */
 	git_config(git_init_db_config, NULL);
@@ -244,16 +219,16 @@ static int create_default_files(const char *template_path)
 	 */
 	if (shared_repository) {
 		adjust_shared_perm(get_git_dir());
-		adjust_shared_perm(git_path("refs"));
-		adjust_shared_perm(git_path("refs/heads"));
-		adjust_shared_perm(git_path("refs/tags"));
+		adjust_shared_perm(git_path_buf(&buf, "refs"));
+		adjust_shared_perm(git_path_buf(&buf, "refs/heads"));
+		adjust_shared_perm(git_path_buf(&buf, "refs/tags"));
 	}
 
 	/*
 	 * Create the default symlink from ".git/HEAD" to the "master"
 	 * branch, if it does not exist yet.
 	 */
-	strcpy(path + len, "HEAD");
+	path = git_path_buf(&buf, "HEAD");
 	reinit = (!access(path, R_OK)
 		  || readlink(path, junk, sizeof(junk)-1) != -1);
 	if (!reinit) {
@@ -266,10 +241,8 @@ static int create_default_files(const char *template_path)
 		  "%d", GIT_REPO_VERSION);
 	git_config_set("core.repositoryformatversion", repo_version_string);
 
-	path[len] = 0;
-	strcpy(path + len, "config");
-
 	/* Check filemode trustability */
+	path = git_path_buf(&buf, "config");
 	filemode = TEST_FILEMODE;
 	if (TEST_FILEMODE && !lstat(path, &st1)) {
 		struct stat st2;
@@ -290,14 +263,13 @@ static int create_default_files(const char *template_path)
 		/* allow template config file to override the default */
 		if (log_all_ref_updates == -1)
 		    git_config_set("core.logallrefupdates", "true");
-		if (needs_work_tree_config(git_dir, work_tree))
+		if (needs_work_tree_config(get_git_dir(), work_tree))
 			git_config_set("core.worktree", work_tree);
 	}
 
 	if (!reinit) {
 		/* Check if symlink is supported in the work tree */
-		path[len] = 0;
-		strcpy(path + len, "tXXXXXX");
+		path = git_path_buf(&buf, "tXXXXXX");
 		if (!close(xmkstemp(path)) &&
 		    !unlink(path) &&
 		    !symlink("testing", path) &&
@@ -308,31 +280,35 @@ static int create_default_files(const char *template_path)
 			git_config_set("core.symlinks", "false");
 
 		/* Check if the filesystem is case-insensitive */
-		path[len] = 0;
-		strcpy(path + len, "CoNfIg");
+		path = git_path_buf(&buf, "CoNfIg");
 		if (!access(path, F_OK))
 			git_config_set("core.ignorecase", "true");
-		probe_utf8_pathname_composition(path, len);
+		probe_utf8_pathname_composition(path);
 	}
 
+	strbuf_release(&buf);
 	return reinit;
 }
 
 static void create_object_directory(void)
 {
-	const char *object_directory = get_object_directory();
-	int len = strlen(object_directory);
-	char *path = xmalloc(len + 40);
+	struct strbuf path = STRBUF_INIT;
+	size_t baselen;
+
+	strbuf_addstr(&path, get_object_directory());
+	baselen = path.len;
+
+	safe_create_dir(path.buf, 1);
 
-	memcpy(path, object_directory, len);
+	strbuf_setlen(&path, baselen);
+	strbuf_addstr(&path, "/pack");
+	safe_create_dir(path.buf, 1);
 
-	safe_create_dir(object_directory, 1);
-	strcpy(path+len, "/pack");
-	safe_create_dir(path, 1);
-	strcpy(path+len, "/info");
-	safe_create_dir(path, 1);
+	strbuf_setlen(&path, baselen);
+	strbuf_addstr(&path, "/info");
+	safe_create_dir(path.buf, 1);
 
-	free(path);
+	strbuf_release(&path);
 }
 
 int set_git_dir_init(const char *git_dir, const char *real_git_dir,
diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index 95fe849..b4dd3c7 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -36,24 +36,28 @@ static size_t has_non_ascii(const char *s, size_t maxlen, size_t *strlen_c)
 }
 
 
-void probe_utf8_pathname_composition(char *path, int len)
+void probe_utf8_pathname_composition(struct strbuf *path)
 {
 	static const char *auml_nfc = "\xc3\xa4";
 	static const char *auml_nfd = "\x61\xcc\x88";
+	size_t baselen = path->len;
 	int output_fd;
 	if (precomposed_unicode != -1)
 		return; /* We found it defined in the global config, respect it */
-	strcpy(path + len, auml_nfc);
+	strbuf_addstr(path, auml_nfc);
 	output_fd = open(path, O_CREAT|O_EXCL|O_RDWR, 0600);
 	if (output_fd >= 0) {
 		close(output_fd);
-		strcpy(path + len, auml_nfd);
+		strbuf_setlen(path, baselen);
+		strbuf_addstr(path, auml_nfd);
 		precomposed_unicode = access(path, R_OK) ? 0 : 1;
 		git_config_set("core.precomposeunicode", precomposed_unicode ? "true" : "false");
-		strcpy(path + len, auml_nfc);
+		strbuf_setlen(path, baselen);
+		strbuf_addstr(path, auml_nfc);
 		if (unlink(path))
 			die_errno(_("failed to unlink '%s'"), path);
 	}
+	strbuf_setlen(path, baselen);
 }
 
 
diff --git a/compat/precompose_utf8.h b/compat/precompose_utf8.h
index 3b73585..7fc7be5 100644
--- a/compat/precompose_utf8.h
+++ b/compat/precompose_utf8.h
@@ -27,7 +27,7 @@ typedef struct {
 } PREC_DIR;
 
 void precompose_argv(int argc, const char **argv);
-void probe_utf8_pathname_composition(char *, int);
+void probe_utf8_pathname_composition(struct strbuf *path);
 
 PREC_DIR *precompose_utf8_opendir(const char *dirname);
 struct dirent_prec_psx *precompose_utf8_readdir(PREC_DIR *dirp);
diff --git a/git-compat-util.h b/git-compat-util.h
index 348b9dc..712de7f 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -229,7 +229,7 @@ typedef unsigned long uintptr_t;
 #else
 #define precompose_str(in,i_nfd2nfc)
 #define precompose_argv(c,v)
-#define probe_utf8_pathname_composition(a,b)
+#define probe_utf8_pathname_composition(p)
 #endif
 
 #ifdef MKDIR_WO_TRAILING_SLASH
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 7de8d85..f91bbcf 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -202,8 +202,8 @@ test_expect_success 'init honors global core.sharedRepository' '
 	x$(git config -f shared-honor-global/.git/config core.sharedRepository)
 '
 
-test_expect_success 'init rejects insanely long --template' '
-	test_must_fail git init --template=$(printf "x%09999dx" 1) test
+test_expect_success 'init allows insanely long --template' '
+	git init --template=$(printf "x%09999dx" 1) test
 '
 
 test_expect_success 'init creates a new directory' '
-- 
2.6.0.rc3.454.g204ad51
