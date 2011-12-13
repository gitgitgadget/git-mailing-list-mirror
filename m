From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH/RFC 2/2] change all unchecked calls to setenv to xsetenv
Date: Tue, 13 Dec 2011 13:10:27 +0100
Message-ID: <1323778227-1664-2-git-send-email-kusmabite@gmail.com>
References: <1323778227-1664-1-git-send-email-kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 13:10:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaRCD-0002Wc-R2
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 13:10:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753742Ab1LMMKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 07:10:49 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:57068 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751029Ab1LMMKs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Dec 2011 07:10:48 -0500
Received: by mail-lpp01m010-f46.google.com with SMTP id p5so2318290lag.19
        for <git@vger.kernel.org>; Tue, 13 Dec 2011 04:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=jSwKCf59BY5PKGgz/FE5fyW3BEhLjcRLM2RyhCvQyxo=;
        b=ez8nKyoSlPKX3XAEpvVYtGnHQf6cu6VQ9p6+rGqtpcfgU20mJ50Oi3orn0yk1LTEJR
         tZQVvK7FnyQ954w3wy4/xcM4mc7bx9rmteJLApPWE2Jw3S1Xtihb/vJ4fs5mh/t7T+aE
         dKTMh4ItR/5PSdE5h/dW7k/6G/55MluOFRsAk=
Received: by 10.152.110.6 with SMTP id hw6mr7719699lab.37.1323778247615;
        Tue, 13 Dec 2011 04:10:47 -0800 (PST)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id pc8sm19773401lab.8.2011.12.13.04.10.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Dec 2011 04:10:46 -0800 (PST)
X-Mailer: git-send-email 1.7.7.1.msysgit.0.272.g9e47e
In-Reply-To: <1323778227-1664-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187014>

This avoids us from accidentally dropping state, possibly leading
to unexpected behaviour.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---

While reviewing some patches for Git for Windows, I realized that
we almost never check the return-value from setenv. This can lead
to quite surprising errors in unusual sitations. Mostly, an error
would probably be preferred. So here we go.

However, I'm not at all convinced myself that all of these make
sense; in particular settings like GIT_EDITOR and GIT_PAGER could
perhaps benefit from having a warning printed rather than a hard
error.

Thoughts?

 builtin/clone.c      |    2 +-
 builtin/commit.c     |    6 +++---
 builtin/help.c       |    4 ++--
 builtin/init-db.c    |    2 +-
 builtin/merge.c      |    4 ++--
 builtin/notes.c      |    2 +-
 builtin/remote-ext.c |    4 ++--
 builtin/revert.c     |    2 +-
 config.c             |    2 +-
 exec_cmd.c           |    4 ++--
 git.c                |   18 +++++++++---------
 pager.c              |    2 +-
 setup.c              |    6 +++---
 13 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index efe8b6c..8d81c29 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -566,7 +566,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	atexit(remove_junk);
 	sigchain_push_common(remove_junk_on_signal);
 
-	setenv(CONFIG_ENVIRONMENT, mkpath("%s/config", git_dir), 1);
+	xsetenv(CONFIG_ENVIRONMENT, mkpath("%s/config", git_dir), 1);
 
 	if (safe_create_leading_directories_const(git_dir) < 0)
 		die(_("could not create leading directories of '%s'"), git_dir);
diff --git a/builtin/commit.c b/builtin/commit.c
index e36e9ad..2b87da9 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -361,13 +361,13 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
 			die(_("unable to create temporary index"));
 
 		old_index_env = getenv(INDEX_ENVIRONMENT);
-		setenv(INDEX_ENVIRONMENT, index_lock.filename, 1);
+		xsetenv(INDEX_ENVIRONMENT, index_lock.filename, 1);
 
 		if (interactive_add(argc, argv, prefix, patch_interactive) != 0)
 			die(_("interactive add failed"));
 
 		if (old_index_env && *old_index_env)
-			setenv(INDEX_ENVIRONMENT, old_index_env, 1);
+			xsetenv(INDEX_ENVIRONMENT, old_index_env, 1);
 		else
 			unsetenv(INDEX_ENVIRONMENT);
 
@@ -1023,7 +1023,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (edit_flag)
 		use_editor = 1;
 	if (!use_editor)
-		setenv("GIT_EDITOR", ":", 1);
+		xsetenv("GIT_EDITOR", ":", 1);
 
 	/* Sanity check options */
 	if (amend && !current_head)
diff --git a/builtin/help.c b/builtin/help.c
index 61ff798..e7dc15b 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -330,7 +330,7 @@ static void setup_man_path(void)
 	if (old_path)
 		strbuf_addstr(&new_path, old_path);
 
-	setenv("MANPATH", new_path.buf, 1);
+	xsetenv("MANPATH", new_path.buf, 1);
 
 	strbuf_release(&new_path);
 }
@@ -371,7 +371,7 @@ static void show_man_page(const char *git_cmd)
 static void show_info_page(const char *git_cmd)
 {
 	const char *page = cmd_to_page(git_cmd);
-	setenv("INFOPATH", system_path(GIT_INFO_PATH), 1);
+	xsetenv("INFOPATH", system_path(GIT_INFO_PATH), 1);
 	execlp("info", "info", "gitman", page, (char *)NULL);
 	die("no info viewer handled the request");
 }
diff --git a/builtin/init-db.c b/builtin/init-db.c
index d07554c..21ff09e 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -537,7 +537,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	if (is_bare_repository_cfg == 1) {
 		static char git_dir[PATH_MAX+1];
 
-		setenv(GIT_DIR_ENVIRONMENT,
+		xsetenv(GIT_DIR_ENVIRONMENT,
 			getcwd(git_dir, sizeof(git_dir)), argc > 0);
 	}
 
diff --git a/builtin/merge.c b/builtin/merge.c
index a1c8534..a4ae473 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1257,7 +1257,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	strbuf_addstr(&buf, "merge");
 	for (i = 0; i < argc; i++)
 		strbuf_addf(&buf, " %s", argv[i]);
-	setenv("GIT_REFLOG_ACTION", buf.buf, 0);
+	xsetenv("GIT_REFLOG_ACTION", buf.buf, 0);
 	strbuf_reset(&buf);
 
 	for (i = 0; i < argc; i++) {
@@ -1267,7 +1267,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		remotes = &commit_list_insert(commit, remotes)->next;
 		strbuf_addf(&buf, "GITHEAD_%s",
 			    sha1_to_hex(commit->object.sha1));
-		setenv(buf.buf, argv[i], 1);
+		xsetenv(buf.buf, argv[i], 1);
 		strbuf_reset(&buf);
 		if (merge_remote_util(commit) &&
 		    merge_remote_util(commit)->obj &&
diff --git a/builtin/notes.c b/builtin/notes.c
index 10b8bc7..7b53c69 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -1076,7 +1076,7 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		struct strbuf sb = STRBUF_INIT;
 		strbuf_addstr(&sb, override_notes_ref);
 		expand_notes_ref(&sb);
-		setenv("GIT_NOTES_REF", sb.buf, 1);
+		xsetenv("GIT_NOTES_REF", sb.buf, 1);
 		strbuf_release(&sb);
 	}
 
diff --git a/builtin/remote-ext.c b/builtin/remote-ext.c
index 692c834..0b2169a 100644
--- a/builtin/remote-ext.c
+++ b/builtin/remote-ext.c
@@ -38,8 +38,8 @@ static char *strip_escapes(const char *str, const char *service,
 		psoff = 4;
 
 	/* Pass the service to command. */
-	setenv("GIT_EXT_SERVICE", service, 1);
-	setenv("GIT_EXT_SERVICE_NOPREFIX", service + psoff, 1);
+	xsetenv("GIT_EXT_SERVICE", service, 1);
+	xsetenv("GIT_EXT_SERVICE_NOPREFIX", service + psoff, 1);
 
 	/* Scan the length of argument. */
 	while (str[rpos] && (escape || str[rpos] != ' ')) {
diff --git a/builtin/revert.c b/builtin/revert.c
index 1ea525c..955a99f 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -1007,7 +1007,7 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 	struct commit_list *cur;
 	int res;
 
-	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
+	xsetenv(GIT_REFLOG_ACTION, action_name(opts), 0);
 	if (opts->allow_ff)
 		assert(!(opts->signoff || opts->no_commit ||
 				opts->record_origin || opts->edit));
diff --git a/config.c b/config.c
index 5ea101f..f461a62 100644
--- a/config.c
+++ b/config.c
@@ -43,7 +43,7 @@ void git_config_push_parameter(const char *text)
 		strbuf_addch(&env, ' ');
 	}
 	sq_quote_buf(&env, text);
-	setenv(CONFIG_DATA_ENVIRONMENT, env.buf, 1);
+	xsetenv(CONFIG_DATA_ENVIRONMENT, env.buf, 1);
 	strbuf_release(&env);
 }
 
diff --git a/exec_cmd.c b/exec_cmd.c
index 171e841..a5a92dd 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -63,7 +63,7 @@ void git_set_argv_exec_path(const char *exec_path)
 	/*
 	 * Propagate this setting to external programs.
 	 */
-	setenv(EXEC_PATH_ENVIRONMENT, exec_path, 1);
+	xsetenv(EXEC_PATH_ENVIRONMENT, exec_path, 1);
 }
 
 
@@ -108,7 +108,7 @@ void setup_path(void)
 	else
 		strbuf_addstr(&new_path, _PATH_DEFPATH);
 
-	setenv("PATH", new_path.buf, 1);
+	xsetenv("PATH", new_path.buf, 1);
 
 	strbuf_release(&new_path);
 }
diff --git a/git.c b/git.c
index 8e34903..cb80de2 100644
--- a/git.c
+++ b/git.c
@@ -54,7 +54,7 @@ int check_pager_config(const char *cmd)
 static void commit_pager_choice(void) {
 	switch (use_pager) {
 	case 0:
-		setenv("GIT_PAGER", "cat", 1);
+		xsetenv("GIT_PAGER", "cat", 1);
 		break;
 	case 1:
 		setup_pager();
@@ -109,7 +109,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--no-replace-objects")) {
 			read_replace_refs = 0;
-			setenv(NO_REPLACE_OBJECTS_ENVIRONMENT, "1", 1);
+			xsetenv(NO_REPLACE_OBJECTS_ENVIRONMENT, "1", 1);
 			if (envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--git-dir")) {
@@ -117,13 +117,13 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				fprintf(stderr, "No directory given for --git-dir.\n" );
 				usage(git_usage_string);
 			}
-			setenv(GIT_DIR_ENVIRONMENT, (*argv)[1], 1);
+			xsetenv(GIT_DIR_ENVIRONMENT, (*argv)[1], 1);
 			if (envchanged)
 				*envchanged = 1;
 			(*argv)++;
 			(*argc)--;
 		} else if (!prefixcmp(cmd, "--git-dir=")) {
-			setenv(GIT_DIR_ENVIRONMENT, cmd + 10, 1);
+			xsetenv(GIT_DIR_ENVIRONMENT, cmd + 10, 1);
 			if (envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--namespace")) {
@@ -131,13 +131,13 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				fprintf(stderr, "No namespace given for --namespace.\n" );
 				usage(git_usage_string);
 			}
-			setenv(GIT_NAMESPACE_ENVIRONMENT, (*argv)[1], 1);
+			xsetenv(GIT_NAMESPACE_ENVIRONMENT, (*argv)[1], 1);
 			if (envchanged)
 				*envchanged = 1;
 			(*argv)++;
 			(*argc)--;
 		} else if (!prefixcmp(cmd, "--namespace=")) {
-			setenv(GIT_NAMESPACE_ENVIRONMENT, cmd + 12, 1);
+			xsetenv(GIT_NAMESPACE_ENVIRONMENT, cmd + 12, 1);
 			if (envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--work-tree")) {
@@ -145,19 +145,19 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
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
 		} else if (!strcmp(cmd, "-c")) {
diff --git a/pager.c b/pager.c
index 975955b..d3a1299 100644
--- a/pager.c
+++ b/pager.c
@@ -76,7 +76,7 @@ void setup_pager(void)
 	if (!pager)
 		return;
 
-	setenv("GIT_PAGER_IN_USE", "true", 1);
+	xsetenv("GIT_PAGER_IN_USE", "true", 1);
 
 	/* spawn the pager */
 	pager_argv[0] = pager;
diff --git a/setup.c b/setup.c
index 61c22e6..06f38d0 100644
--- a/setup.c
+++ b/setup.c
@@ -309,7 +309,7 @@ void setup_work_tree(void)
 	 * if $GIT_WORK_TREE is set relative
 	 */
 	if (getenv(GIT_WORK_TREE_ENVIRONMENT))
-		setenv(GIT_WORK_TREE_ENVIRONMENT, ".", 1);
+		xsetenv(GIT_WORK_TREE_ENVIRONMENT, ".", 1);
 
 	set_git_dir(relative_path(git_dir, work_tree));
 	initialized = 1;
@@ -683,9 +683,9 @@ const char *setup_git_directory_gently(int *nongit_ok)
 
 	prefix = setup_git_directory_gently_1(nongit_ok);
 	if (prefix)
-		setenv("GIT_PREFIX", prefix, 1);
+		xsetenv("GIT_PREFIX", prefix, 1);
 	else
-		setenv("GIT_PREFIX", "", 1);
+		xsetenv("GIT_PREFIX", "", 1);
 
 	if (startup_info) {
 		startup_info->have_repository = !nongit_ok || !*nongit_ok;
-- 
1.7.7.1.msysgit.0.272.g9e47e
