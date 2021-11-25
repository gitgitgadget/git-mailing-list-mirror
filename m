Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1961BC4332F
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 22:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346414AbhKYW7t (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 17:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237543AbhKYW5n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 17:57:43 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05B4C06175A
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 14:52:37 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id r8so14561598wra.7
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 14:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=an4921mEsiUx4HsKaUVGgTkVKenK01kI8nyRI400NTc=;
        b=m0x6H0/HtUSQAXAV2d0Y913GhXCrdL09Frn/j9q243pTVV0nuabM04FCmekQnltiNX
         dvPFlIHEBRINmFGG5v1XSQR3nYiCJFSbM8e62bII4zHfpcKJ0M9+6rQQIXK0dRpNdCzy
         65P2ofdvgqapOWuTJbALenIVdz9dEuFBSa3fi2BmBrx2QVvjeclCUk1spTylKDIyRm5w
         1rr3gZo55mi2p/WG1d5Xfjz0H8Qe0nwgo9alOxPjaWR2g3szG7yGU//2pQwvJ/CcpwdM
         k5Fk8Z1D/W+l2+t9ZHWQdNu2MIIvO02m3su/GvdPjRLMqPmy/OpD/OyUF1BTRZox/903
         Kllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=an4921mEsiUx4HsKaUVGgTkVKenK01kI8nyRI400NTc=;
        b=h4Q15O6TNO06eQNkj1JnJ5+g0zaYFdwilSXVuhJchCrKdCs5HX4LzCoBExC/tYezne
         sBvEtfIa3czR07u0+4O0Fackx4i6Y4hv0225690xRdkSvybf0dAX2ERLnwYbv3MjKhBO
         Ub3WlRes5iYMte1JA9U4s20uJMKxZEnhKuZheX8X3lCKvPe3GvwydRCgfQu+kZnKIta7
         MfieVsZnwVBcBHoFWgOcRLIKahiyDwmI4zuB2fFJusbCc68RLYUH2wp2IKicR1u3SrBA
         Kp8MymKY6ivcjd/bPVlHSwkbe5IBWpOm/yL6PO1fSad4JTXiwDGhwd6hXdAxIzJY1dLl
         qDkw==
X-Gm-Message-State: AOAM532DbrnCqKgLNTMmrwWDwX6upNo+bHNatC2B5GfXEvEUkLyE0EH0
        /82/vFKN48XrXvGCiTkOtnTu+MUxj9jMIw==
X-Google-Smtp-Source: ABdhPJwks1RGZlL3GCc51wSyjiBt8dWE6wCpuSR3f+RYo1uXtpwRn7K+XgcVi8h1vidxxHlPHeUvmg==
X-Received: by 2002:a05:6000:1aca:: with SMTP id i10mr10586526wry.407.1637880756152;
        Thu, 25 Nov 2021 14:52:36 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h22sm5001257wmq.14.2021.11.25.14.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 14:52:35 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 9/9] run-command API: remove "env" member, always use "env_array"
Date:   Thu, 25 Nov 2021 23:52:24 +0100
Message-Id: <patch-v3-9.9-4e4db79ea53-20211125T224833Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.838.g779e9098efb
In-Reply-To: <cover-v3-0.9-00000000000-20211125T224833Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20211123T115551Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20211125T224833Z-avarab@gmail.com>
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
index 9edd3e2829b..962d71cf987 100644
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
@@ -360,7 +360,7 @@ static int add_worktree(const char *path, const char *refname,
 		strvec_pushl(&cp.args, "reset", "--hard", "--no-recurse-submodules", NULL);
 		if (opts->quiet)
 			strvec_push(&cp.args, "--quiet");
-		cp.env = child_env.v;
+		strvec_pushv(&cp.env_array, child_env.v);
 		ret = run_command(&cp);
 		if (ret)
 			goto done;
@@ -389,7 +389,7 @@ static int add_worktree(const char *path, const char *refname,
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
index d92a8d9ab5b..8b9648281d7 100644
--- a/editor.c
+++ b/editor.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "config.h"
 #include "strbuf.h"
+#include "strvec.h"
 #include "run-command.h"
 #include "sigchain.h"
 
@@ -78,7 +79,8 @@ static int launch_specified_editor(const char *editor, const char *path,
 		strbuf_realpath(&realpath, path, 1);
 
 		strvec_pushl(&p.args, editor, realpath.buf, NULL);
-		p.env = env;
+		if (env)
+			strvec_pushv(&p.env_array, (const char **)env);
 		p.use_shell = 1;
 		p.trace2_child_class = "editor";
 		if (start_command(&p) < 0) {
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
2.34.1.838.g779e9098efb

