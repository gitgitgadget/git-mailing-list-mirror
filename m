Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E92C433FE
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 16:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240089AbhKVQHb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 11:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhKVQHa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 11:07:30 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02300C061748
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 08:04:18 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id a9so33627137wrr.8
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 08:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iqdqImQHIlME5Amy2ooarkXIhrjMOTd9uMi+q6eAbLA=;
        b=FI6OcvPcmx1KQqB38w+uuWQExBhx80j3J20adg9GLwfKBCRHh+ZNqHusGsyPeWkH6n
         YSPTSar0a7wOHkAqNKfECgSX0T3DQhqWJ560+USIt1dh6k9KTlE38E5aLg17I72N8+/W
         ZSP1ze9CmgPcl8jFzcSSHpoJ62kgIlq+JcH3IQ03Z5mm0a25lPwqc82Gg6nNHyH5CGXK
         8uESrvDM+KtrYw1xePQTLn3cgeGkLiQ6U3zmtFvuuwP1ESVpNTv6vPpSdiEvsejzTzA5
         6gbVysrTXAzxcBaUsCL1PSKWcf4km93W3pqdOqQKR+iQHG+/FFzm+f661yXZmXV3lb8Y
         vNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iqdqImQHIlME5Amy2ooarkXIhrjMOTd9uMi+q6eAbLA=;
        b=T5vyF/b86GhIEZBqI51W4sv2EtGAbDkHjjc/izwexBBgP5soS/HeMesmXU5jdwtswJ
         yiFXnHzgu20t2EUZyimwssCsmn40S/7PD6MlPZJRMk9vcUMDWnoMXUzobBOI+Fn/zQ3s
         xYiQY1OKk7q5m5oC9ZNes28Rnkr29GHscF0VmJ+RCKL3JP3suatLSzsB2i39umMAjGVc
         9Q4kjdmtscfzp10by3fcREA2ZEqs+3Gwc3ARHI8ZxViL5Wg6j8xOCh/SIWi1ROxKuHBl
         pdpS7lXMqX8ssROCpE1Zngnt/VXnlFmdAmiir4JlydiA0Fq4j8BnQjTk1AC70Jz0iibc
         lOiw==
X-Gm-Message-State: AOAM531GD6w8R/FIhHBLWDloNK2bTkWNDlehb1eI6r75v8HyUv47i2aZ
        pZCtL1zPPNWCg6IjzigxePlqtXoVgv8Qyw==
X-Google-Smtp-Source: ABdhPJxce0Gvd/gMdwaX491sv7CMF21ALKsAmmBPxYjB6t5fucNId+8DLcx/m9XyFofev1eoEjjfLQ==
X-Received: by 2002:a5d:6da5:: with SMTP id u5mr40567090wrs.374.1637597056997;
        Mon, 22 Nov 2021 08:04:16 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h27sm24005953wmc.43.2021.11.22.08.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 08:04:16 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/5] run-command API users: use strvec_pushv(), not argv assignment
Date:   Mon, 22 Nov 2021 17:04:05 +0100
Message-Id: <patch-3.5-fd6c4c960ba-20211122T153605Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.822.gf3f912c366d
In-Reply-To: <cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com>
References: <YZseJ4jOVIK3+bUD@coredump.intra.peff.net> <cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Migrate those run-command API users that assign directly to the "argv"
member to use a strvec_pushv() of "args" instead, but exclude those
cases where we can't easily get rid of the construction of the "argv"
variable being given to the resulting "strvec_pushv()".

This is in preparation for getting rid of the "argv" member from the
run-command API itself.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 add-patch.c                |  4 ++--
 builtin/notes.c            |  2 +-
 builtin/receive-pack.c     | 16 ++++++++--------
 daemon.c                   |  2 +-
 editor.c                   |  2 +-
 http-backend.c             |  2 +-
 http.c                     |  5 +++--
 remote-curl.c              |  2 +-
 run-command.c              |  2 +-
 sequencer.c                |  2 +-
 t/helper/test-subprocess.c |  2 +-
 transport.c                |  2 +-
 12 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 8c41cdfe39b..573eef0cc4a 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -413,7 +413,7 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 		strvec_push(&args, ps->items[i].original);
 
 	setup_child_process(s, &cp, NULL);
-	cp.argv = args.v;
+	strvec_pushv(&cp.args, args.v);
 	res = capture_command(&cp, plain, 0);
 	if (res) {
 		strvec_clear(&args);
@@ -431,7 +431,7 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 
 		setup_child_process(s, &colored_cp, NULL);
 		xsnprintf((char *)args.v[color_arg_index], 8, "--color");
-		colored_cp.argv = args.v;
+		strvec_pushv(&colored_cp.args, args.v);
 		colored = &s->colored;
 		res = capture_command(&colored_cp, colored, 0);
 		strvec_clear(&args);
diff --git a/builtin/notes.c b/builtin/notes.c
index 71c59583a17..2b2bac43f31 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -141,7 +141,7 @@ static void write_commented_object(int fd, const struct object_id *object)
 	struct strbuf cbuf = STRBUF_INIT;
 
 	/* Invoke "git show --stat --no-notes $object" */
-	show.argv = show_args;
+	strvec_pushv(&show.args, show_args);
 	show.no_stdin = 1;
 	show.out = -1;
 	show.err = 0;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 49b846d9605..33815631010 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -821,7 +821,7 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed,
 
 	argv[1] = NULL;
 
-	proc.argv = argv;
+	strvec_pushv(&proc.args, argv);
 	proc.in = -1;
 	proc.stdout_to_stderr = 1;
 	proc.trace2_hook_name = hook_name;
@@ -959,7 +959,7 @@ static int run_update_hook(struct command *cmd)
 	proc.no_stdin = 1;
 	proc.stdout_to_stderr = 1;
 	proc.err = use_sideband ? -1 : 0;
-	proc.argv = argv;
+	strvec_pushv(&proc.args, argv);
 	proc.trace2_hook_name = "update";
 
 	code = start_command(&proc);
@@ -1132,7 +1132,7 @@ static int run_proc_receive_hook(struct command *commands,
 	}
 	argv[1] = NULL;
 
-	proc.argv = argv;
+	strvec_pushv(&proc.args, argv);
 	proc.in = -1;
 	proc.out = -1;
 	proc.trace2_hook_name = "proc-receive";
@@ -1385,7 +1385,7 @@ static const char *push_to_deploy(unsigned char *sha1,
 	};
 	struct child_process child = CHILD_PROCESS_INIT;
 
-	child.argv = update_refresh;
+	strvec_pushv(&child.args, update_refresh);
 	child.env = env->v;
 	child.dir = work_tree;
 	child.no_stdin = 1;
@@ -1396,7 +1396,7 @@ static const char *push_to_deploy(unsigned char *sha1,
 
 	/* run_command() does not clean up completely; reinitialize */
 	child_process_init(&child);
-	child.argv = diff_files;
+	strvec_pushv(&child.args, diff_files);
 	child.env = env->v;
 	child.dir = work_tree;
 	child.no_stdin = 1;
@@ -1409,7 +1409,7 @@ static const char *push_to_deploy(unsigned char *sha1,
 	diff_index[4] = head_has_history() ? "HEAD" : empty_tree_oid_hex();
 
 	child_process_init(&child);
-	child.argv = diff_index;
+	strvec_pushv(&child.args, diff_index);
 	child.env = env->v;
 	child.no_stdin = 1;
 	child.no_stdout = 1;
@@ -1420,7 +1420,7 @@ static const char *push_to_deploy(unsigned char *sha1,
 
 	read_tree[3] = hash_to_hex(sha1);
 	child_process_init(&child);
-	child.argv = read_tree;
+	strvec_pushv(&child.args, read_tree);
 	child.env = env->v;
 	child.dir = work_tree;
 	child.no_stdin = 1;
@@ -2584,7 +2584,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 			proc.stdout_to_stderr = 1;
 			proc.err = use_sideband ? -1 : 0;
 			proc.git_cmd = proc.close_object_store = 1;
-			proc.argv = argv_gc_auto;
+			strvec_pushv(&proc.args, argv_gc_auto);
 
 			if (!start_command(&proc)) {
 				if (use_sideband)
diff --git a/daemon.c b/daemon.c
index b1fcbe0d6fa..8df21f2130c 100644
--- a/daemon.c
+++ b/daemon.c
@@ -922,7 +922,7 @@ static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 #endif
 	}
 
-	cld.argv = cld_argv.v;
+	strvec_pushv(&cld.args, cld_argv.v);
 	cld.in = incoming;
 	cld.out = dup(incoming);
 
diff --git a/editor.c b/editor.c
index 674309eed8b..90f3379285c 100644
--- a/editor.c
+++ b/editor.c
@@ -82,7 +82,7 @@ static int launch_specified_editor(const char *editor, const char *path,
 		strbuf_realpath(&realpath, path, 1);
 		args[1] = realpath.buf;
 
-		p.argv = args;
+		strvec_pushv(&p.args, args);
 		p.env = env;
 		p.use_shell = 1;
 		p.trace2_child_class = "editor";
diff --git a/http-backend.c b/http-backend.c
index 3d6e2ff17f8..4dd4d939f8a 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -480,7 +480,7 @@ static void run_service(const char **argv, int buffer_input)
 		strvec_pushf(&cld.env_array,
 			     "GIT_COMMITTER_EMAIL=%s@http.%s", user, host);
 
-	cld.argv = argv;
+	strvec_pushv(&cld.args, argv);
 	if (buffer_input || gzipped_request || req_len >= 0)
 		cld.in = -1;
 	cld.git_cmd = 1;
diff --git a/http.c b/http.c
index f92859f43fa..229da4d1488 100644
--- a/http.c
+++ b/http.c
@@ -2126,8 +2126,9 @@ int finish_http_pack_request(struct http_pack_request *preq)
 
 	ip.git_cmd = 1;
 	ip.in = tmpfile_fd;
-	ip.argv = preq->index_pack_args ? preq->index_pack_args
-					: default_index_pack_args;
+	strvec_pushv(&ip.args, preq->index_pack_args ?
+		     preq->index_pack_args :
+		     default_index_pack_args);
 
 	if (preq->preserve_index_pack_stdout)
 		ip.out = 0;
diff --git a/remote-curl.c b/remote-curl.c
index d69156312bd..0dabef2dd7c 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1061,7 +1061,7 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads,
 	client.in = -1;
 	client.out = -1;
 	client.git_cmd = 1;
-	client.argv = client_argv;
+	strvec_pushv(&client.args, client_argv);
 	if (start_command(&client))
 		exit(1);
 	write_or_die(client.in, preamble->buf, preamble->len);
diff --git a/run-command.c b/run-command.c
index f40df01c772..620a06ca2f5 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1039,7 +1039,7 @@ int run_command_v_opt_cd_env_tr2(const char **argv, int opt, const char *dir,
 				 const char *const *env, const char *tr2_class)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
-	cmd.argv = argv;
+	strvec_pushv(&cmd.args, argv);
 	cmd.no_stdin = opt & RUN_COMMAND_NO_STDIN ? 1 : 0;
 	cmd.git_cmd = opt & RUN_GIT_CMD ? 1 : 0;
 	cmd.stdout_to_stderr = opt & RUN_COMMAND_STDOUT_TO_STDERR ? 1 : 0;
diff --git a/sequencer.c b/sequencer.c
index ea96837cde3..60ede96461c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1175,7 +1175,7 @@ static int run_rewrite_hook(const struct object_id *oldoid,
 	argv[1] = "amend";
 	argv[2] = NULL;
 
-	proc.argv = argv;
+	strvec_pushv(&proc.args, argv);
 	proc.in = -1;
 	proc.stdout_to_stderr = 1;
 	proc.trace2_hook_name = "post-rewrite";
diff --git a/t/helper/test-subprocess.c b/t/helper/test-subprocess.c
index 92b69de6352..ff22f2fa2c5 100644
--- a/t/helper/test-subprocess.c
+++ b/t/helper/test-subprocess.c
@@ -15,6 +15,6 @@ int cmd__subprocess(int argc, const char **argv)
 		argv++;
 	}
 	cp.git_cmd = 1;
-	cp.argv = (const char **)argv + 1;
+	strvec_pushv(&cp.args, (const char **)argv + 1);
 	return run_command(&cp);
 }
diff --git a/transport.c b/transport.c
index e4f1decae20..2361f54bd48 100644
--- a/transport.c
+++ b/transport.c
@@ -1213,7 +1213,7 @@ static int run_pre_push_hook(struct transport *transport,
 	argv[2] = transport->url;
 	argv[3] = NULL;
 
-	proc.argv = argv;
+	strvec_pushv(&proc.args, argv);
 	proc.in = -1;
 	proc.trace2_hook_name = "pre-push";
 
-- 
2.34.0.822.gb876f875f1b

