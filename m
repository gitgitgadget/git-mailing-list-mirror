Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2254AC433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 12:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236886AbhKWML3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 07:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236990AbhKWMLX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 07:11:23 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22688C06175C
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 04:08:10 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso2015920wms.3
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 04:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v/6E2Bj5WTSF4T2he388WxOB/k0yfrVSmMBTk9rRscU=;
        b=Mqzl+1z1mreZLcPFclYwWdVL6BouZnss69SyHQmNbGZuCMBcpbWThukiHxS0OqrpIP
         LcyBGOMfeDs3RfFRCLV7PRfA8u94jlvvSj0+dOM4sI52Xu8WqDxETzBGDjQ/DR1l6ru7
         6vetHPXiKMFhqQcwzOXjjz3fxEGBVgDDkwBvy8Q+z9U73zFsAFxLNaqCApruZBsGTM4E
         jMu9PdKsf1yw+/eD8WP3YLXz7WoDobf0WKFqCG+Dz2L1QNSUjg82/xl7jq1AmBm9gzGk
         ZTFEdGGYlxlybCNBqUZ1uAdM+/bUalutdMDvtlJAM/v+D7P0SLhirRatg7YU53ExO3AT
         C5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v/6E2Bj5WTSF4T2he388WxOB/k0yfrVSmMBTk9rRscU=;
        b=ipdBQDkQCOs6qurAGNdArqyQD3glNQyyf8cwylTGawgxye5ToydkESuUOKBUIbw+YG
         65mIJW1JNexXNUYu2NF64WOGyIK8eY94+nmQ4a0Fgewyy2Ml5E4FHnUvzeue58CCi2CP
         7jAZ2an35HHq9JD+swRozZJK+NO+c/3mNeo4thH9HHW6F0qjqt/9c0or275A+xEH4YHA
         1fRdRo+NPjEE8dd038aW+G1d5EkanfHvCI4mU1ydr0NYgGVWVH59PrmjQM3IiwU0Hu6h
         +mYPBYuy8KfjKx9t6N1FenvfMTfE1sak0F5fLTaNdExwyITPeGlHtaMkbp+2gbGFylFR
         qdKw==
X-Gm-Message-State: AOAM532dYJFgBt6M0zc6zaYyF3wXT+rCAQhGp6N/2ueYAdXRnHcYaniy
        EFTQqjg3cYOwvdjoVq0EVPz3+p85FWLXaw==
X-Google-Smtp-Source: ABdhPJykshZRV7tfyDrVrvHx6RdCAXWqg2lZJXleWMIErAhknVWau54B8Y88NCT6DS0JyFhChMMQhw==
X-Received: by 2002:a05:600c:4113:: with SMTP id j19mr2587708wmi.48.1637669288167;
        Tue, 23 Nov 2021 04:08:08 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m9sm1220299wmq.1.2021.11.23.04.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 04:08:07 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 9/9] run-command API: remove "env" member, always use "env_array"
Date:   Tue, 23 Nov 2021 13:06:36 +0100
Message-Id: <patch-v2-9.9-6bd9f508a3d-20211123T115551Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.831.gd33babec0d1
In-Reply-To: <cover-v2-0.9-00000000000-20211123T115551Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20211123T115551Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the "env" member from "struct child_process" in favor of always
using the "env_array". As with the preceding removal of "argv" in
favor of "args" this gets rid of current and future oddities around
memory management at the API boundary (see the amended API docs).

For some of the conversions we can replace patterns like:

    child.env = env->v;

With:

    strvec_pushv(&child.env_array, env->v);

But for others we need to guard the strvec_pushv() with a NULL check,
since we're not passing in the "v" member of a "struct strvec",
e.g. in the case of tmp_objdir_env()'s return value.

Ideally we'd rename the "env_array" member to simply "env" as a
follow-up, since it and "args" are now inconsistent in not having an
"_array" suffix, and seemingly without any good reason, unless we look
at the history of how they came to be.

But as we've currently got 122 in-tree hits for a "git grep env_array"
let's leave that for now (and possibly forever). Doing that rename
would be too disruptive.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/receive-pack.c | 11 ++++++-----
 builtin/worktree.c     |  6 +++---
 connected.c            |  3 ++-
 editor.c               |  4 +++-
 object-file.c          |  2 +-
 run-command.c          | 20 +++++++-------------
 run-command.h          | 34 +++++++++++++++++-----------------
 trailer.c              |  2 +-
 8 files changed, 40 insertions(+), 42 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 48c99c8ee45..3979752ceca 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1367,7 +1367,7 @@ static const char *push_to_deploy(unsigned char *sha1,
 
 	strvec_pushl(&child.args, "update-index", "-q", "--ignore-submodules",
 		     "--refresh", NULL);
-	child.env = env->v;
+	strvec_pushv(&child.env_array, env->v);
 	child.dir = work_tree;
 	child.no_stdin = 1;
 	child.stdout_to_stderr = 1;
@@ -1379,7 +1379,7 @@ static const char *push_to_deploy(unsigned char *sha1,
 	child_process_init(&child);
 	strvec_pushl(&child.args, "diff-files", "--quiet",
 		     "--ignore-submodules", "--", NULL);
-	child.env = env->v;
+	strvec_pushv(&child.env_array, env->v);
 	child.dir = work_tree;
 	child.no_stdin = 1;
 	child.stdout_to_stderr = 1;
@@ -1393,7 +1393,7 @@ static const char *push_to_deploy(unsigned char *sha1,
 		     /* diff-index with either HEAD or an empty tree */
 		     head_has_history() ? "HEAD" : empty_tree_oid_hex(),
 		     "--", NULL);
-	child.env = env->v;
+	strvec_pushv(&child.env_array, env->v);
 	child.no_stdin = 1;
 	child.no_stdout = 1;
 	child.stdout_to_stderr = 0;
@@ -1404,7 +1404,7 @@ static const char *push_to_deploy(unsigned char *sha1,
 	child_process_init(&child);
 	strvec_pushl(&child.args, "read-tree", "-u", "-m", hash_to_hex(sha1),
 		     NULL);
-	child.env = env->v;
+	strvec_pushv(&child.env_array, env->v);
 	child.dir = work_tree;
 	child.no_stdin = 1;
 	child.no_stdout = 1;
@@ -2202,7 +2202,8 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 			close(err_fd);
 		return "unable to create temporary object directory";
 	}
-	child.env = tmp_objdir_env(tmp_objdir);
+	if (tmp_objdir)
+		strvec_pushv(&child.env_array, tmp_objdir_env(tmp_objdir));
 
 	/*
 	 * Normally we just pass the tmp_objdir environment to the child
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 7264a5b5de0..36b3d6c40da 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -349,7 +349,7 @@ static int add_worktree(const char *path, const char *refname,
 			strvec_push(&cp.args, "--quiet");
 	}
 
-	cp.env = child_env.v;
+	strvec_pushv(&cp.env_array, child_env.v);
 	ret = run_command(&cp);
 	if (ret)
 		goto done;
@@ -359,7 +359,7 @@ static int add_worktree(const char *path, const char *refname,
 		strvec_pushl(&cp.args, "reset", "--hard", "--no-recurse-submodules", NULL);
 		if (opts->quiet)
 			strvec_push(&cp.args, "--quiet");
-		cp.env = child_env.v;
+		strvec_pushv(&cp.env_array, child_env.v);
 		ret = run_command(&cp);
 		if (ret)
 			goto done;
@@ -388,7 +388,7 @@ static int add_worktree(const char *path, const char *refname,
 			cp.no_stdin = 1;
 			cp.stdout_to_stderr = 1;
 			cp.dir = path;
-			cp.env = env;
+			strvec_pushv(&cp.env_array, env);
 			cp.trace2_hook_name = "post-checkout";
 			strvec_pushl(&cp.args, absolute_path(hook),
 				     oid_to_hex(null_oid()),
diff --git a/connected.c b/connected.c
index 35bd4a26382..ed3025e7a2a 100644
--- a/connected.c
+++ b/connected.c
@@ -109,7 +109,8 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 			     _("Checking connectivity"));
 
 	rev_list.git_cmd = 1;
-	rev_list.env = opt->env;
+	if (opt->env)
+		strvec_pushv(&rev_list.env_array, opt->env);
 	rev_list.in = -1;
 	rev_list.no_stdout = 1;
 	if (opt->err_fd)
diff --git a/editor.c b/editor.c
index b7d2a9b73c3..7044ad5f72e 100644
--- a/editor.c
+++ b/editor.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "config.h"
 #include "strbuf.h"
+#include "strvec.h"
 #include "run-command.h"
 #include "sigchain.h"
 #include "compat/terminal.h"
@@ -81,7 +82,8 @@ static int launch_specified_editor(const char *editor, const char *path,
 		strbuf_realpath(&realpath, path, 1);
 
 		strvec_pushl(&p.args, editor, realpath.buf, NULL);
-		p.env = env;
+		if (env)
+			strvec_pushv(&p.env_array, (const char **)env);
 		p.use_shell = 1;
 		p.trace2_child_class = "editor";
 		term_fail = save_term(1);
diff --git a/object-file.c b/object-file.c
index c3d866a287e..2fc1bed417c 100644
--- a/object-file.c
+++ b/object-file.c
@@ -797,7 +797,7 @@ static void fill_alternate_refs_command(struct child_process *cmd,
 		}
 	}
 
-	cmd->env = local_repo_env;
+	strvec_pushv(&cmd->env_array, (const char **)local_repo_env);
 	cmd->out = -1;
 }
 
diff --git a/run-command.c b/run-command.c
index 99dc93e7300..ebade086700 100644
--- a/run-command.c
+++ b/run-command.c
@@ -655,12 +655,7 @@ static void trace_run_command(const struct child_process *cp)
 		sq_quote_buf_pretty(&buf, cp->dir);
 		strbuf_addch(&buf, ';');
 	}
-	/*
-	 * The caller is responsible for initializing cp->env from
-	 * cp->env_array if needed. We only check one place.
-	 */
-	if (cp->env)
-		trace_add_env(&buf, cp->env);
+	trace_add_env(&buf, cp->env_array.v);
 	if (cp->git_cmd)
 		strbuf_addstr(&buf, " git");
 	sq_quote_argv_pretty(&buf, cp->args.v);
@@ -676,9 +671,6 @@ int start_command(struct child_process *cmd)
 	int failed_errno;
 	char *str;
 
-	if (!cmd->env)
-		cmd->env = cmd->env_array.v;
-
 	/*
 	 * In case of errors we must keep the promise to close FDs
 	 * that have been passed in via ->in and ->out.
@@ -768,7 +760,7 @@ int start_command(struct child_process *cmd)
 		set_cloexec(null_fd);
 	}
 
-	childenv = prep_childenv(cmd->env);
+	childenv = prep_childenv(cmd->env_array.v);
 	atfork_prepare(&as);
 
 	/*
@@ -931,7 +923,7 @@ int start_command(struct child_process *cmd)
 	else if (cmd->use_shell)
 		cmd->args.v = prepare_shell_cmd(&nargv, sargv);
 
-	cmd->pid = mingw_spawnvpe(cmd->args.v[0], cmd->args.v, (char**) cmd->env,
+	cmd->pid = mingw_spawnvpe(cmd->args.v[0], cmd->args.v, (char**) cmd->env_array.v,
 			cmd->dir, fhin, fhout, fherr);
 	failed_errno = errno;
 	if (cmd->pid < 0 && (!cmd->silent_exec_failure || errno != ENOENT))
@@ -1047,7 +1039,8 @@ int run_command_v_opt_cd_env_tr2(const char **argv, int opt, const char *dir,
 	cmd.wait_after_clean = opt & RUN_WAIT_AFTER_CLEAN ? 1 : 0;
 	cmd.close_object_store = opt & RUN_CLOSE_OBJECT_STORE ? 1 : 0;
 	cmd.dir = dir;
-	cmd.env = env;
+	if (env)
+		strvec_pushv(&cmd.env_array, (const char **)env);
 	cmd.trace2_child_class = tr2_class;
 	return run_command(&cmd);
 }
@@ -1333,7 +1326,8 @@ int run_hook_ve(const char *const *env, const char *name, va_list args)
 	strvec_push(&hook.args, p);
 	while ((p = va_arg(args, const char *)))
 		strvec_push(&hook.args, p);
-	hook.env = env;
+	if (env)
+		strvec_pushv(&hook.env_array, (const char **)env);
 	hook.no_stdin = 1;
 	hook.stdout_to_stderr = 1;
 	hook.trace2_hook_name = name;
diff --git a/run-command.h b/run-command.h
index c0d1210cc63..2be5f5d6422 100644
--- a/run-command.h
+++ b/run-command.h
@@ -56,6 +56,23 @@ struct child_process {
 	 * `finish_command` (or during `start_command` when it is unsuccessful).
 	 */
 	struct strvec args;
+
+	/**
+	 * Like .args the .env_array is a `struct strvec'.
+	 *
+	 * To modify the environment of the sub-process, specify an array of
+	 * environment settings. Each string in the array manipulates the
+	 * environment.
+	 *
+	 * - If the string is of the form "VAR=value", i.e. it contains '='
+	 *   the variable is added to the child process's environment.
+	 *
+	 * - If the string does not contain '=', it names an environment
+	 *   variable that will be removed from the child process's environment.
+	 *
+	 * The memory in .env_array will be cleaned up automatically during
+	 * `finish_command` (or during `start_command` when it is unsuccessful).
+	 */
 	struct strvec env_array;
 	pid_t pid;
 
@@ -92,23 +109,6 @@ struct child_process {
 	 */
 	const char *dir;
 
-	/**
-	 * To modify the environment of the sub-process, specify an array of
-	 * string pointers (NULL terminated) in .env:
-	 *
-	 * - If the string is of the form "VAR=value", i.e. it contains '='
-	 *   the variable is added to the child process's environment.
-	 *
-	 * - If the string does not contain '=', it names an environment
-	 *   variable that will be removed from the child process's environment.
-	 *
-	 * If the .env member is NULL, `start_command` will point it at the
-	 * .env_array `strvec` (so you may use one or the other, but not both).
-	 * The memory in .env_array will be cleaned up automatically during
-	 * `finish_command` (or during `start_command` when it is unsuccessful).
-	 */
-	const char *const *env;
-
 	unsigned no_stdin:1;
 	unsigned no_stdout:1;
 	unsigned no_stderr:1;
diff --git a/trailer.c b/trailer.c
index 7c7cb61a945..1b12f77d945 100644
--- a/trailer.c
+++ b/trailer.c
@@ -236,7 +236,7 @@ static char *apply_command(struct conf_info *conf, const char *arg)
 			strbuf_replace(&cmd, TRAILER_ARG_STRING, arg);
 		strvec_push(&cp.args, cmd.buf);
 	}
-	cp.env = local_repo_env;
+	strvec_pushv(&cp.env_array, (const char **)local_repo_env);
 	cp.no_stdin = 1;
 	cp.use_shell = 1;
 
-- 
2.34.0.831.gd33babec0d1

