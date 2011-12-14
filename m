From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v2 4/4] use wrapper for unchecked setenv/putenv calls
Date: Wed, 14 Dec 2011 15:07:11 +0100
Message-ID: <1323871631-2872-5-git-send-email-kusmabite@gmail.com>
References: <1323871631-2872-1-git-send-email-kusmabite@gmail.com>
Cc: peff@peff.net, gitster@pobox.com, schwab@linux-m68k.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 14 15:07:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RapUn-0001jv-4m
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 15:07:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757332Ab1LNOHf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 09:07:35 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:65260 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757328Ab1LNOHc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2011 09:07:32 -0500
Received: by mail-lpp01m010-f46.google.com with SMTP id p5so326737lag.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 06:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=KugiqsQ5Iq1o9rOSXaP9UkUVXCVze+yCn4Vi69/nSH0=;
        b=eGlN2f+0TkmX+gkc9pX/OzpgH5o+IqOttZBdarW5alB+KP/g7yXgIidw5iTneh8Mmh
         Uj2GZOC1NRDnQtGUObvCEwvFBqJbAPRnvjpp7nW8Wga66br7AuUUTQ4UnuPbyVa8WW2E
         dUnUV6poa4LxMhVJ11zItSLdMM4cdd4NieF2M=
Received: by 10.152.105.84 with SMTP id gk20mr2472662lab.10.1323871651534;
        Wed, 14 Dec 2011 06:07:31 -0800 (PST)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id mq11sm2319038lab.11.2011.12.14.06.07.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 06:07:30 -0800 (PST)
X-Mailer: git-send-email 1.7.7.1.msysgit.0.272.g9e47e
In-Reply-To: <1323871631-2872-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187115>

This avoids us from accidentally dropping state, possibly leading
to unexpected behaviour.

This is especially important on Windows, where the maximum size of
the environment is 32 kB.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
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
 run-command.c        |    2 +-
 setup.c              |    6 +++---
 14 files changed, 30 insertions(+), 30 deletions(-)

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
diff --git a/run-command.c b/run-command.c
index 1c51043..37abbde 100644
--- a/run-command.c
+++ b/run-command.c
@@ -258,7 +258,7 @@ fail_pipe:
 		if (cmd->env) {
 			for (; *cmd->env; cmd->env++) {
 				if (strchr(*cmd->env, '='))
-					putenv((char *)*cmd->env);
+					xputenv((char *)*cmd->env);
 				else
 					unsetenv(*cmd->env);
 			}
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
