From: Jeff King <peff@peff.net>
Subject: Re: Running commands in wrong environment
Date: Sun, 6 Dec 2009 09:38:33 -0500
Message-ID: <20091206143833.GA26440@coredump.intra.peff.net>
References: <D6F784B72498304C93A8A4691967698E8EE2C44FE5@REX2.intranet.epfl.ch>
 <20091204104441.GD27495@coredump.intra.peff.net>
 <7vr5raslqa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Marinescu Paul dan <pauldan.marinescu@epfl.ch>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 06 15:38:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHIG4-00086C-IH
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 15:38:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754993AbZLFOib (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 09:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754804AbZLFOia
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 09:38:30 -0500
Received: from peff.net ([208.65.91.99]:37976 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754310AbZLFOi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 09:38:28 -0500
Received: (qmail 30278 invoked by uid 107); 6 Dec 2009 14:43:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 06 Dec 2009 09:43:04 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Dec 2009 09:38:33 -0500
Content-Disposition: inline
In-Reply-To: <7vr5raslqa.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134662>

On Fri, Dec 04, 2009 at 09:16:45AM -0800, Junio C Hamano wrote:

> My gut feeling is xsetenv/xputenv would be sufficient.  I do not think we
> make any setenv/putenv that we do not care about failing, perhaps other
> than the "if LESS is not there set it to this default value, as it would
> give users nicer experience if they use 'less'."

Here is a patch. I still feel a little silly writing this. The chances
that you will run out of memory doing setenv but _not_ doing any of the
other git operations seems very low. But it's not too invasive a patch.

-- >8 --
Subject: [PATCH] wrap setenv and putenv with error-checking

The setenv and putenv calls can fail if they run out of
memory. We would generally ignore such an error and continue
running, meaning in such an instance we could generate
incorrect results (e.g., if GIT_INDEX_FILE was not set
before running a hook, the hook would operate on the wrong
index).

This patch introduces xsetenv and xputenv wrappers which die
upon failure. The conversion to use these wrappers is almost
a purely mechanical s/\t(set|put)env/\tx\1env/, with two
exceptions:

  1. set_git_dir actually checked the return value of setenv
     and returned an error to its caller. However, most
     callsites simply ignored the error; the only one that
     did check immediately called die(). So set_git_dir has
     had its return value removed, and just calls xsetenv.

  2. The gitsetenv wrapper uses putenv. However, it properly
     passes on the return value, so calling code using
     xsetenv does the right thing.

Finally, there is one final callsite to note: in daemon.c,
we now call xsetenv to set REMOTE_ADDR. It is OK to die
here, though, as we only execute this function after we have
forked, so we are killing only a single connection, not the
whole daemon.

Signed-off-by: Jeff King <peff@peff.net>
---
I didn't do unsetenv. Should we bother? POSIX says it can return an
error, but only for feeding it a bogus name argument.

 builtin-clone.c   |    2 +-
 builtin-commit.c  |    2 +-
 builtin-grep.c    |    4 ++--
 builtin-help.c    |    4 ++--
 builtin-init-db.c |    2 +-
 builtin-merge.c   |    4 ++--
 builtin-reset.c   |    2 +-
 builtin-revert.c  |    8 ++++----
 cache.h           |    2 +-
 daemon.c          |    2 +-
 environment.c     |    6 ++----
 exec_cmd.c        |    4 ++--
 git-compat-util.h |    2 ++
 git.c             |   14 +++++++-------
 path.c            |    2 +-
 run-command.c     |    2 +-
 setup.c           |    7 +++----
 wrapper.c         |   11 +++++++++++
 18 files changed, 45 insertions(+), 35 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index caf3025..e901e2c 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -452,7 +452,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	atexit(remove_junk);
 	sigchain_push_common(remove_junk_on_signal);
 
-	setenv(CONFIG_ENVIRONMENT, mkpath("%s/config", git_dir), 1);
+	xsetenv(CONFIG_ENVIRONMENT, mkpath("%s/config", git_dir), 1);
 
 	if (safe_create_leading_directories_const(git_dir) < 0)
 		die("could not create leading directories of '%s'", git_dir);
diff --git a/builtin-commit.c b/builtin-commit.c
index e93a647..f65df2b 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -756,7 +756,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (edit_flag)
 		use_editor = 1;
 	if (!use_editor)
-		setenv("GIT_EDITOR", ":", 1);
+		xsetenv("GIT_EDITOR", ":", 1);
 
 	if (get_sha1("HEAD", head_sha1))
 		initial_commit = 1;
diff --git a/builtin-grep.c b/builtin-grep.c
index a5b6719..cb3845a 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -421,13 +421,13 @@ static int external_grep(struct grep_opt *opt, const char **paths, int cached)
 		struct strbuf sb = STRBUF_INIT;
 
 		grep_add_color(&sb, opt->color_match);
-		setenv("GREP_COLOR", sb.buf, 1);
+		xsetenv("GREP_COLOR", sb.buf, 1);
 
 		strbuf_reset(&sb);
 		strbuf_addstr(&sb, "mt=");
 		grep_add_color(&sb, opt->color_match);
 		strbuf_addstr(&sb, ":sl=:cx=:fn=:ln=:bn=:se=");
-		setenv("GREP_COLORS", sb.buf, 1);
+		xsetenv("GREP_COLORS", sb.buf, 1);
 
 		strbuf_release(&sb);
 
diff --git a/builtin-help.c b/builtin-help.c
index 09ad4b0..886190c 100644
--- a/builtin-help.c
+++ b/builtin-help.c
@@ -329,7 +329,7 @@ static void setup_man_path(void)
 	if (old_path)
 		strbuf_addstr(&new_path, old_path);
 
-	setenv("MANPATH", new_path.buf, 1);
+	xsetenv("MANPATH", new_path.buf, 1);
 
 	strbuf_release(&new_path);
 }
@@ -370,7 +370,7 @@ static void show_man_page(const char *git_cmd)
 static void show_info_page(const char *git_cmd)
 {
 	const char *page = cmd_to_page(git_cmd);
-	setenv("INFOPATH", system_path(GIT_INFO_PATH), 1);
+	xsetenv("INFOPATH", system_path(GIT_INFO_PATH), 1);
 	execlp("info", "info", "gitman", page, NULL);
 	die("no info viewer handled the request");
 }
diff --git a/builtin-init-db.c b/builtin-init-db.c
index dd84cae..67fd947 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -445,7 +445,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	if (is_bare_repository_cfg == 1) {
 		static char git_dir[PATH_MAX+1];
 
-		setenv(GIT_DIR_ENVIRONMENT,
+		xsetenv(GIT_DIR_ENVIRONMENT,
 			getcwd(git_dir, sizeof(git_dir)), 0);
 	}
 
diff --git a/builtin-merge.c b/builtin-merge.c
index 56a1bb6..8e645eb 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -959,7 +959,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	strbuf_addstr(&buf, "merge");
 	for (i = 0; i < argc; i++)
 		strbuf_addf(&buf, " %s", argv[i]);
-	setenv("GIT_REFLOG_ACTION", buf.buf, 0);
+	xsetenv("GIT_REFLOG_ACTION", buf.buf, 0);
 	strbuf_reset(&buf);
 
 	for (i = 0; i < argc; i++) {
@@ -974,7 +974,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		remotes = &commit_list_insert(commit, remotes)->next;
 
 		strbuf_addf(&buf, "GITHEAD_%s", sha1_to_hex(o->sha1));
-		setenv(buf.buf, argv[i], 1);
+		xsetenv(buf.buf, argv[i], 1);
 		strbuf_reset(&buf);
 	}
 
diff --git a/builtin-reset.c b/builtin-reset.c
index 73e6022..ce54934 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -220,7 +220,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, git_reset_usage,
 						PARSE_OPT_KEEP_DASHDASH);
 	reflog_action = args_to_str(argv);
-	setenv("GIT_REFLOG_ACTION", reflog_action, 0);
+	xsetenv("GIT_REFLOG_ACTION", reflog_action, 0);
 
 	/*
 	 * Possible arguments are:
diff --git a/builtin-revert.c b/builtin-revert.c
index 151aa6a..7d26a9f 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -188,9 +188,9 @@ static void set_author_ident_env(const char *message)
 			for (timestamp++; *timestamp && isspace(*timestamp);
 					timestamp++)
 				; /* do nothing */
-			setenv("GIT_AUTHOR_NAME", line, 1);
-			setenv("GIT_AUTHOR_EMAIL", email, 1);
-			setenv("GIT_AUTHOR_DATE", timestamp, 1);
+			xsetenv("GIT_AUTHOR_NAME", line, 1);
+			xsetenv("GIT_AUTHOR_EMAIL", email, 1);
+			xsetenv("GIT_AUTHOR_DATE", timestamp, 1);
 			free(line);
 			return;
 		}
@@ -247,7 +247,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 
 	git_config(git_default_config, NULL);
 	me = action == REVERT ? "revert" : "cherry-pick";
-	setenv(GIT_REFLOG_ACTION, me, 0);
+	xsetenv(GIT_REFLOG_ACTION, me, 0);
 	parse_args(argc, argv);
 
 	/* this is copied from the shell script, but it's never triggered... */
diff --git a/cache.h b/cache.h
index bf468e5..be954f9 100644
--- a/cache.h
+++ b/cache.h
@@ -386,7 +386,7 @@ extern const char *get_git_dir(void);
 extern char *get_object_directory(void);
 extern char *get_index_file(void);
 extern char *get_graft_file(void);
-extern int set_git_dir(const char *path);
+extern void set_git_dir(const char *path);
 extern const char *get_git_work_tree(void);
 extern const char *read_gitfile_gently(const char *path);
 extern void set_git_work_tree(const char *tree);
diff --git a/daemon.c b/daemon.c
index 5783e24..9649a25 100644
--- a/daemon.c
+++ b/daemon.c
@@ -515,7 +515,7 @@ static int execute(struct sockaddr *addr)
 #endif
 		}
 		loginfo("Connection from %s:%d", addrbuf, port);
-		setenv("REMOTE_ADDR", addrbuf, 1);
+		xsetenv("REMOTE_ADDR", addrbuf, 1);
 	}
 	else {
 		unsetenv("REMOTE_ADDR");
diff --git a/environment.c b/environment.c
index 5171d9f..c750520 100644
--- a/environment.c
+++ b/environment.c
@@ -163,10 +163,8 @@ char *get_graft_file(void)
 	return git_graft_file;
 }
 
-int set_git_dir(const char *path)
+void set_git_dir(const char *path)
 {
-	if (setenv(GIT_DIR_ENVIRONMENT, path, 1))
-		return error("Could not set GIT_DIR to '%s'", path);
+	xsetenv(GIT_DIR_ENVIRONMENT, path, 1);
 	setup_git_env();
-	return 0;
 }
diff --git a/exec_cmd.c b/exec_cmd.c
index 408e4e5..132cc58 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -64,7 +64,7 @@ void git_set_argv_exec_path(const char *exec_path)
 	/*
 	 * Propagate this setting to external programs.
 	 */
-	setenv(EXEC_PATH_ENVIRONMENT, exec_path, 1);
+	xsetenv(EXEC_PATH_ENVIRONMENT, exec_path, 1);
 }
 
 
@@ -109,7 +109,7 @@ void setup_path(void)
 	else
 		strbuf_addstr(&new_path, "/usr/local/bin:/usr/bin:/bin");
 
-	setenv("PATH", new_path.buf, 1);
+	xsetenv("PATH", new_path.buf, 1);
 
 	strbuf_release(&new_path);
 }
diff --git a/git-compat-util.h b/git-compat-util.h
index 5c59687..ba4b13d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -351,6 +351,8 @@ extern void *xcalloc(size_t nmemb, size_t size);
 extern void *xmmap(void *start, size_t length, int prot, int flags, int fd, off_t offset);
 extern ssize_t xread(int fd, void *buf, size_t len);
 extern ssize_t xwrite(int fd, const void *buf, size_t len);
+extern void xsetenv(const char *name, const char *value, int overwrite);
+extern void xputenv(char *string);
 extern int xdup(int fd);
 extern FILE *xfdopen(int fd, const char *mode);
 extern int xmkstemp(char *template);
diff --git a/git.c b/git.c
index 11544cd..e2c42cd 100644
--- a/git.c
+++ b/git.c
@@ -40,7 +40,7 @@ int check_pager_config(const char *cmd)
 static void commit_pager_choice(void) {
 	switch (use_pager) {
 	case 0:
-		setenv("GIT_PAGER", "cat", 1);
+		xsetenv("GIT_PAGER", "cat", 1);
 		break;
 	case 1:
 		setup_pager();
@@ -89,7 +89,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--no-replace-objects")) {
 			read_replace_refs = 0;
-			setenv(NO_REPLACE_OBJECTS_ENVIRONMENT, "1", 1);
+			xsetenv(NO_REPLACE_OBJECTS_ENVIRONMENT, "1", 1);
 			if (envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--git-dir")) {
@@ -97,14 +97,14 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				fprintf(stderr, "No directory given for --git-dir.\n" );
 				usage(git_usage_string);
 			}
-			setenv(GIT_DIR_ENVIRONMENT, (*argv)[1], 1);
+			xsetenv(GIT_DIR_ENVIRONMENT, (*argv)[1], 1);
 			if (envchanged)
 				*envchanged = 1;
 			(*argv)++;
 			(*argc)--;
 			handled++;
 		} else if (!prefixcmp(cmd, "--git-dir=")) {
-			setenv(GIT_DIR_ENVIRONMENT, cmd + 10, 1);
+			xsetenv(GIT_DIR_ENVIRONMENT, cmd + 10, 1);
 			if (envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--work-tree")) {
@@ -112,19 +112,19 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				fprintf(stderr, "No directory given for --work-tree.\n" );
 				usage(git_usage_string);
 			}
-			setenv(GIT_WORK_TREE_ENVIRONMENT, (*argv)[1], 1);
+			xsetenv(GIT_WORK_TREE_ENVIRONMENT, (*argv)[1], 1);
 			if (envchanged)
 				*envchanged = 1;
 			(*argv)++;
 			(*argc)--;
 		} else if (!prefixcmp(cmd, "--work-tree=")) {
-			setenv(GIT_WORK_TREE_ENVIRONMENT, cmd + 12, 1);
+			xsetenv(GIT_WORK_TREE_ENVIRONMENT, cmd + 12, 1);
 			if (envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--bare")) {
 			static char git_dir[PATH_MAX+1];
 			is_bare_repository_cfg = 1;
-			setenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir, sizeof(git_dir)), 0);
+			xsetenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir, sizeof(git_dir)), 0);
 			if (envchanged)
 				*envchanged = 1;
 		} else {
diff --git a/path.c b/path.c
index 2ec950b..575ba1d 100644
--- a/path.c
+++ b/path.c
@@ -336,7 +336,7 @@ char *enter_repo(char *path, int strict)
 
 	if (access("objects", X_OK) == 0 && access("refs", X_OK) == 0 &&
 	    validate_headref("HEAD") == 0) {
-		setenv(GIT_DIR_ENVIRONMENT, ".", 1);
+		xsetenv(GIT_DIR_ENVIRONMENT, ".", 1);
 		check_repository_format();
 		return path;
 	}
diff --git a/run-command.c b/run-command.c
index cf2d8f7..b9777e5 100644
--- a/run-command.c
+++ b/run-command.c
@@ -114,7 +114,7 @@ fail_pipe:
 		if (cmd->env) {
 			for (; *cmd->env; cmd->env++) {
 				if (strchr(*cmd->env, '='))
-					putenv((char *)*cmd->env);
+					xputenv((char *)*cmd->env);
 				else
 					unsetenv(*cmd->env);
 			}
diff --git a/setup.c b/setup.c
index f67250b..8d878bd 100644
--- a/setup.c
+++ b/setup.c
@@ -362,8 +362,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	for (;;) {
 		gitfile_dir = read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
 		if (gitfile_dir) {
-			if (set_git_dir(gitfile_dir))
-				die("Repository setup failed");
+			set_git_dir(gitfile_dir);
 			break;
 		}
 		if (is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT))
@@ -374,9 +373,9 @@ const char *setup_git_directory_gently(int *nongit_ok)
 				inside_work_tree = 0;
 			if (offset != len) {
 				cwd[offset] = '\0';
-				setenv(GIT_DIR_ENVIRONMENT, cwd, 1);
+				xsetenv(GIT_DIR_ENVIRONMENT, cwd, 1);
 			} else
-				setenv(GIT_DIR_ENVIRONMENT, ".", 1);
+				xsetenv(GIT_DIR_ENVIRONMENT, ".", 1);
 			check_repository_format_gently(nongit_ok);
 			return NULL;
 		}
diff --git a/wrapper.c b/wrapper.c
index c9be140..8fa3643 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -305,3 +305,14 @@ int unlink_or_warn(const char *file)
 	return rc;
 }
 
+void xsetenv(const char *name, const char *value, int overwrite)
+{
+	if (setenv(name, value, overwrite) != 0)
+		die_errno("unable to setenv %s", name);
+}
+
+void xputenv(char *string)
+{
+	if (putenv(string) != 0)
+		die_errno("unable to putenv %s", string);
+}
-- 
1.6.6.rc1.44.g4701a



> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
