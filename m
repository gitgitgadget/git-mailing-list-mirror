Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4200C433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 12:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236954AbhKWMLR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 07:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236845AbhKWMLO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 07:11:14 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B88C06173E
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 04:08:04 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id s13so38619696wrb.3
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 04:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ap/JLxskfILLwb37sHg/+vhYBR1wOoOJZb+jcylUE4k=;
        b=VEHlE/66I6OZdxuU5PAHxJ+MWUsOzoRoF3s5bPBcICbKyuTdcULUL8mL+iKzC6LK+e
         gMNXQjG0hh7QxYBnAOzgEj0zl8ILif+JehvkCqicg57YoSLlwic0thm1u19euO3R2cbD
         WJWmAy6kUP6wS0tdR2mMfoaK7YgcfZvebLa9qBYFK+nKUaTmQIPd4zWP6kIozGFtlBZm
         ilCLPS18pdmQnrjIHDCoqOtsy7kHekMugA8jrOnNiAhkeWFUU6JtCEYd9eRAWlUXk/9g
         wyRDfHGiHJQoDqLIrrgI9zWQzoPS/Z+X/JepmoB3W0E/6W2WLpKU+VUVURoQ2QQDOp59
         R9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ap/JLxskfILLwb37sHg/+vhYBR1wOoOJZb+jcylUE4k=;
        b=dCQrtRLQnH3n90p3w8G/4/lTuRJdLgKhnwUD13h/5IWPrTwQAiS/18rK3gkxDb5FbP
         HPGkfByEieQr8V+maCAGw7TsFrEEJ1BA3H5D5YdpFjz5CqfI6g82/IBNxQUeI/xfCltX
         ehX43eAkUaogctjPqYtnzW2VcqdjIrkD+DgkUOMhhX8pkRQZl9WME5LhivrbyKKSRSGK
         O7fapT1egOQoG2zPSb4Re39oy0xEU/MmHUlryov3rK6vo+GknWXuKOxYsfN58cJhy4Kf
         m503FQ40L9SXCVpxTtlILa1eWnf3ggSaAiNSoVmPn6Ck905iChYoir6UVTXC+CaaufdW
         nD/w==
X-Gm-Message-State: AOAM532jFLQtIrKKQiQCXoDmyDZcpCVFAkbqWCkjglbqT0+AbrpCxE4T
        cdqqtWR0ggYthDhvoqMZUrKCZT7gfRpzoQ==
X-Google-Smtp-Source: ABdhPJzm/LbDharC1pG0z5C+JhXsrluTmWNg1kRVcOihXfJs5BG3ySjm3ziFbOGnFjvhEo1PHHGYjQ==
X-Received: by 2002:a5d:64e7:: with SMTP id g7mr6839592wri.350.1637669282830;
        Tue, 23 Nov 2021 04:08:02 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m9sm1220299wmq.1.2021.11.23.04.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 04:08:02 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/9] run-command API users: use strvec_pushl(), not argv construction
Date:   Tue, 23 Nov 2021 13:06:32 +0100
Message-Id: <patch-v2-5.9-2b446606eb9-20211123T115551Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.831.gd33babec0d1
In-Reply-To: <cover-v2-0.9-00000000000-20211123T115551Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20211123T115551Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a pattern of hardcoding an "argv" array size, populating it and
assigning to the "argv" member of "struct child_process" to instead
use "strvec_pushl()" to add data to the "args" member.

This implements the same behavior as before in fewer lines of code,
and moves us further towards being able to remove the "argv" member in
a subsequent commit.

Since we've entirely removed the "argv" variable(s) we can be sure
that no potential logic errors of the type discussed in a preceding
commit are being introduced here, i.e. ones where the local "argv" was
being modified after the assignment to "struct child_process"'s
"argv".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/add.c          |  7 ++-----
 builtin/fsck.c         | 12 ++++--------
 builtin/help.c         |  3 +--
 builtin/merge.c        |  3 +--
 builtin/notes.c        |  5 ++---
 builtin/receive-pack.c | 38 +++++++++++++-------------------------
 builtin/replace.c      |  3 +--
 editor.c               |  4 +---
 sequencer.c            | 10 +++-------
 upload-pack.c          |  5 +----
 10 files changed, 29 insertions(+), 61 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index ef6b619c45e..a010b2c325f 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -302,15 +302,11 @@ int interactive_add(const char **argv, const char *prefix, int patch)
 static int edit_patch(int argc, const char **argv, const char *prefix)
 {
 	char *file = git_pathdup("ADD_EDIT.patch");
-	const char *apply_argv[] = { "apply", "--recount", "--cached",
-		NULL, NULL };
 	struct child_process child = CHILD_PROCESS_INIT;
 	struct rev_info rev;
 	int out;
 	struct stat st;
 
-	apply_argv[3] = file;
-
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 
 	if (read_cache() < 0)
@@ -338,7 +334,8 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 		die(_("Empty patch. Aborted."));
 
 	child.git_cmd = 1;
-	child.argv = apply_argv;
+	strvec_pushl(&child.args, "apply", "--recount", "--cached", file,
+		     NULL);
 	if (run_command(&child))
 		die(_("Could not apply '%s'"), file);
 
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 27b9e78094d..9e54892311d 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -944,15 +944,13 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 	if (the_repository->settings.core_commit_graph) {
 		struct child_process commit_graph_verify = CHILD_PROCESS_INIT;
-		const char *verify_argv[] = { "commit-graph", "verify", NULL, NULL, NULL };
 
 		prepare_alt_odb(the_repository);
 		for (odb = the_repository->objects->odb; odb; odb = odb->next) {
 			child_process_init(&commit_graph_verify);
-			commit_graph_verify.argv = verify_argv;
 			commit_graph_verify.git_cmd = 1;
-			verify_argv[2] = "--object-dir";
-			verify_argv[3] = odb->path;
+			strvec_pushl(&commit_graph_verify.args, "commit-graph",
+				     "verify", "--object-dir", odb->path, NULL);
 			if (run_command(&commit_graph_verify))
 				errors_found |= ERROR_COMMIT_GRAPH;
 		}
@@ -960,15 +958,13 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 	if (the_repository->settings.core_multi_pack_index) {
 		struct child_process midx_verify = CHILD_PROCESS_INIT;
-		const char *midx_argv[] = { "multi-pack-index", "verify", NULL, NULL, NULL };
 
 		prepare_alt_odb(the_repository);
 		for (odb = the_repository->objects->odb; odb; odb = odb->next) {
 			child_process_init(&midx_verify);
-			midx_verify.argv = midx_argv;
 			midx_verify.git_cmd = 1;
-			midx_argv[2] = "--object-dir";
-			midx_argv[3] = odb->path;
+			strvec_pushl(&midx_verify.args, "multi-pack-index",
+				     "verify", "--object-dir", odb->path, NULL);
 			if (run_command(&midx_verify))
 				errors_found |= ERROR_MULTI_PACK_INDEX;
 		}
diff --git a/builtin/help.c b/builtin/help.c
index 75cd2fb407f..d387131dd83 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -212,11 +212,10 @@ static int check_emacsclient_version(void)
 {
 	struct strbuf buffer = STRBUF_INIT;
 	struct child_process ec_process = CHILD_PROCESS_INIT;
-	const char *argv_ec[] = { "emacsclient", "--version", NULL };
 	int version;
 
 	/* emacsclient prints its version number on stderr */
-	ec_process.argv = argv_ec;
+	strvec_pushl(&ec_process.args, "emacsclient", "--version", NULL);
 	ec_process.err = -1;
 	ec_process.stdout_to_stderr = 1;
 	if (start_command(&ec_process))
diff --git a/builtin/merge.c b/builtin/merge.c
index ea3112e0c0b..5f0476b0b76 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -310,10 +310,9 @@ static int save_state(struct object_id *stash)
 	int len;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf buffer = STRBUF_INIT;
-	const char *argv[] = {"stash", "create", NULL};
 	int rc = -1;
 
-	cp.argv = argv;
+	strvec_pushl(&cp.args, "stash", "create", NULL);
 	cp.out = -1;
 	cp.git_cmd = 1;
 
diff --git a/builtin/notes.c b/builtin/notes.c
index 71c59583a17..85d1abad884 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -134,14 +134,13 @@ static void copy_obj_to_fd(int fd, const struct object_id *oid)
 
 static void write_commented_object(int fd, const struct object_id *object)
 {
-	const char *show_args[5] =
-		{"show", "--stat", "--no-notes", oid_to_hex(object), NULL};
 	struct child_process show = CHILD_PROCESS_INIT;
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf cbuf = STRBUF_INIT;
 
 	/* Invoke "git show --stat --no-notes $object" */
-	show.argv = show_args;
+	strvec_pushl(&show.args, "show", "--stat", "--no-notes",
+		     oid_to_hex(object), NULL);
 	show.no_stdin = 1;
 	show.out = -1;
 	show.err = 0;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 49b846d9605..6149d507965 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1370,22 +1370,10 @@ static const char *push_to_deploy(unsigned char *sha1,
 				  struct strvec *env,
 				  const char *work_tree)
 {
-	const char *update_refresh[] = {
-		"update-index", "-q", "--ignore-submodules", "--refresh", NULL
-	};
-	const char *diff_files[] = {
-		"diff-files", "--quiet", "--ignore-submodules", "--", NULL
-	};
-	const char *diff_index[] = {
-		"diff-index", "--quiet", "--cached", "--ignore-submodules",
-		NULL, "--", NULL
-	};
-	const char *read_tree[] = {
-		"read-tree", "-u", "-m", NULL, NULL
-	};
 	struct child_process child = CHILD_PROCESS_INIT;
 
-	child.argv = update_refresh;
+	strvec_pushl(&child.args, "update-index", "-q", "--ignore-submodules",
+		     "--refresh", NULL);
 	child.env = env->v;
 	child.dir = work_tree;
 	child.no_stdin = 1;
@@ -1396,7 +1384,8 @@ static const char *push_to_deploy(unsigned char *sha1,
 
 	/* run_command() does not clean up completely; reinitialize */
 	child_process_init(&child);
-	child.argv = diff_files;
+	strvec_pushl(&child.args, "diff-files", "--quiet",
+		     "--ignore-submodules", "--", NULL);
 	child.env = env->v;
 	child.dir = work_tree;
 	child.no_stdin = 1;
@@ -1405,11 +1394,12 @@ static const char *push_to_deploy(unsigned char *sha1,
 	if (run_command(&child))
 		return "Working directory has unstaged changes";
 
-	/* diff-index with either HEAD or an empty tree */
-	diff_index[4] = head_has_history() ? "HEAD" : empty_tree_oid_hex();
-
 	child_process_init(&child);
-	child.argv = diff_index;
+	strvec_pushl(&child.args, "diff-index", "--quiet", "--cached",
+		     "--ignore-submodules",
+		     /* diff-index with either HEAD or an empty tree */
+		     head_has_history() ? "HEAD" : empty_tree_oid_hex(),
+		     "--", NULL);
 	child.env = env->v;
 	child.no_stdin = 1;
 	child.no_stdout = 1;
@@ -1418,9 +1408,9 @@ static const char *push_to_deploy(unsigned char *sha1,
 	if (run_command(&child))
 		return "Working directory has staged changes";
 
-	read_tree[3] = hash_to_hex(sha1);
 	child_process_init(&child);
-	child.argv = read_tree;
+	strvec_pushl(&child.args, "read-tree", "-u", "-m", hash_to_hex(sha1),
+		     NULL);
 	child.env = env->v;
 	child.dir = work_tree;
 	child.no_stdin = 1;
@@ -2575,16 +2565,14 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		run_update_post_hook(commands);
 		string_list_clear(&push_options, 0);
 		if (auto_gc) {
-			const char *argv_gc_auto[] = {
-				"gc", "--auto", "--quiet", NULL,
-			};
 			struct child_process proc = CHILD_PROCESS_INIT;
 
 			proc.no_stdin = 1;
 			proc.stdout_to_stderr = 1;
 			proc.err = use_sideband ? -1 : 0;
 			proc.git_cmd = proc.close_object_store = 1;
-			proc.argv = argv_gc_auto;
+			strvec_pushl(&proc.args, "gc", "--auto", "--quiet",
+				     NULL);
 
 			if (!start_command(&proc)) {
 				if (use_sideband)
diff --git a/builtin/replace.c b/builtin/replace.c
index 946938d011e..6ff1734d587 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -258,11 +258,10 @@ static int import_object(struct object_id *oid, enum object_type type,
 		return error_errno(_("unable to open %s for reading"), filename);
 
 	if (!raw && type == OBJ_TREE) {
-		const char *argv[] = { "mktree", NULL };
 		struct child_process cmd = CHILD_PROCESS_INIT;
 		struct strbuf result = STRBUF_INIT;
 
-		cmd.argv = argv;
+		strvec_push(&cmd.args, "mktree");
 		cmd.git_cmd = 1;
 		cmd.in = fd;
 		cmd.out = -1;
diff --git a/editor.c b/editor.c
index 674309eed8b..b7d2a9b73c3 100644
--- a/editor.c
+++ b/editor.c
@@ -58,7 +58,6 @@ static int launch_specified_editor(const char *editor, const char *path,
 
 	if (strcmp(editor, ":")) {
 		struct strbuf realpath = STRBUF_INIT;
-		const char *args[] = { editor, NULL, NULL };
 		struct child_process p = CHILD_PROCESS_INIT;
 		int ret, sig;
 		int print_waiting_for_editor = advice_enabled(ADVICE_WAITING_FOR_EDITOR) && isatty(2);
@@ -80,9 +79,8 @@ static int launch_specified_editor(const char *editor, const char *path,
 		}
 
 		strbuf_realpath(&realpath, path, 1);
-		args[1] = realpath.buf;
 
-		p.argv = args;
+		strvec_pushl(&p.args, editor, realpath.buf, NULL);
 		p.env = env;
 		p.use_shell = 1;
 		p.trace2_child_class = "editor";
diff --git a/sequencer.c b/sequencer.c
index ea96837cde3..6e02210db7a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1164,18 +1164,14 @@ static int run_rewrite_hook(const struct object_id *oldoid,
 			    const struct object_id *newoid)
 {
 	struct child_process proc = CHILD_PROCESS_INIT;
-	const char *argv[3];
 	int code;
 	struct strbuf sb = STRBUF_INIT;
+	const char *hook_path = find_hook("post-rewrite");
 
-	argv[0] = find_hook("post-rewrite");
-	if (!argv[0])
+	if (!hook_path)
 		return 0;
 
-	argv[1] = "amend";
-	argv[2] = NULL;
-
-	proc.argv = argv;
+	strvec_pushl(&proc.args, hook_path, "amend", NULL);
 	proc.in = -1;
 	proc.stdout_to_stderr = 1;
 	proc.trace2_hook_name = "post-rewrite";
diff --git a/upload-pack.c b/upload-pack.c
index c78d55bc674..9b5db32623f 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -596,14 +596,11 @@ static int do_reachable_revlist(struct child_process *cmd,
 				struct object_array *reachable,
 				enum allow_uor allow_uor)
 {
-	static const char *argv[] = {
-		"rev-list", "--stdin", NULL,
-	};
 	struct object *o;
 	FILE *cmd_in = NULL;
 	int i;
 
-	cmd->argv = argv;
+	strvec_pushl(&cmd->args, "rev-list", "--stdin", NULL);
 	cmd->git_cmd = 1;
 	cmd->no_stderr = 1;
 	cmd->in = -1;
-- 
2.34.0.831.gd33babec0d1

