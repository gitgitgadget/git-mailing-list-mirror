Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 699301F453
	for <e@80x24.org>; Wed, 24 Apr 2019 00:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbfDXAy2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 20:54:28 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35604 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728730AbfDXAy1 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 23 Apr 2019 20:54:27 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:ace5:84c6:6a15:3d32])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8C06161004;
        Wed, 24 Apr 2019 00:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1556067264;
        bh=9pmGmZkH3SLKDzryngARcBqea9FlDm5LdsXGcmd50V4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=1Z5Tm+CUUcoAYs7xpPuAArTF1NyIWi55DrpXS8VLQKtnapw+Ylq9YZ+JHIxtvVW/V
         f9jefCGVF7b8KnO8tgTIgiwqTHBRggxHChlyjE6duaCOIKVnNiu6R8Bbq9+/9AJCl+
         CsX4N0KHLV4oUFYMPb3T8vNCcsldVhy2Hp8tKYvSdzJ1zQbj5vSeZo9LkbppyqxGEx
         0jvN0MEVNuNIjRgVTeBVNvjqtrybRumZfXB0LswQ3CHWxoWAdyPckcXKiDI3WyoDk8
         s6dmjm7JNkjHDDGCkYKzZF/2ilKmQKyIC8+QUBfVbqwzgSd8qnNhv4BaZuGcUfCp8/
         fMv1MbIdStcMv0R5+/8DpWmbHXoXlIKgOQiTCD5F2Bf5/Qetmsb9qzmnckIY/OTMAT
         vlOQUS129ysOLsbrlhWsYMc4Q8awgbpqGfPZ/chRjDbBA47K7LtcMGUU26zvOB1aJ6
         yCE0sacEiQtR66kqsIuqZFMXyJ+nd6ahCPZikIVb8GRwfghuafc
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/5] builtin/receive-pack: add support for multiple hooks
Date:   Wed, 24 Apr 2019 00:49:45 +0000
Message-Id: <20190424004948.728326-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18
In-Reply-To: <20190424004948.728326-1-sandals@crustytoothpaste.net>
References: <20190424004948.728326-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add support for multiple hooks for the pre-receive, post-receive,
update, post-update, and push-to-checkout hooks. Add tests for these
hooks using the multiple hook test framework.

Because the invocations of test_multiple_hooks contain multiple test
assertions, they (and the cd commands that surround them) must occur
outside of a subshell, or a failing test will not be noticed.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/receive-pack.c | 212 ++++++++++++++++++++++++-----------------
 t/t5516-fetch-push.sh  |  29 ++++++
 2 files changed, 152 insertions(+), 89 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 29f165d8bd..7454834d2a 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -680,72 +680,82 @@ typedef int (*feed_fn)(void *, const char **, size_t *);
 static int run_and_feed_hook(const char *hook_name, feed_fn feed,
 			     struct receive_hook_feed_state *feed_state)
 {
-	struct child_process proc = CHILD_PROCESS_INIT;
+	struct child_process proc;
+	struct string_list *hooks;
+	struct string_list_item *p;
 	struct async muxer;
 	const char *argv[2];
-	int code;
+	int code = 0;
 
-	argv[0] = find_hook(hook_name);
-	if (!argv[0])
+	hooks = find_hooks(hook_name);
+	if (!hooks)
 		return 0;
 
-	argv[1] = NULL;
+	for_each_string_list_item(p, hooks) {
+		argv[0] = p->string;
+		argv[1] = NULL;
 
-	proc.argv = argv;
-	proc.in = -1;
-	proc.stdout_to_stderr = 1;
-	proc.trace2_hook_name = hook_name;
+		child_process_init(&proc);
+		proc.argv = argv;
+		proc.in = -1;
+		proc.stdout_to_stderr = 1;
+		proc.trace2_hook_name = hook_name;
 
-	if (feed_state->push_options) {
-		int i;
-		for (i = 0; i < feed_state->push_options->nr; i++)
-			argv_array_pushf(&proc.env_array,
-				"GIT_PUSH_OPTION_%d=%s", i,
-				feed_state->push_options->items[i].string);
-		argv_array_pushf(&proc.env_array, "GIT_PUSH_OPTION_COUNT=%d",
-				 feed_state->push_options->nr);
-	} else
-		argv_array_pushf(&proc.env_array, "GIT_PUSH_OPTION_COUNT");
+		if (feed_state->push_options) {
+			int i;
+			for (i = 0; i < feed_state->push_options->nr; i++)
+				argv_array_pushf(&proc.env_array,
+					"GIT_PUSH_OPTION_%d=%s", i,
+					feed_state->push_options->items[i].string);
+			argv_array_pushf(&proc.env_array, "GIT_PUSH_OPTION_COUNT=%d",
+					 feed_state->push_options->nr);
+		} else
+			argv_array_pushf(&proc.env_array, "GIT_PUSH_OPTION_COUNT");
 
-	if (tmp_objdir)
-		argv_array_pushv(&proc.env_array, tmp_objdir_env(tmp_objdir));
+		if (tmp_objdir)
+			argv_array_pushv(&proc.env_array, tmp_objdir_env(tmp_objdir));
 
-	if (use_sideband) {
-		memset(&muxer, 0, sizeof(muxer));
-		muxer.proc = copy_to_sideband;
-		muxer.in = -1;
-		code = start_async(&muxer);
-		if (code)
-			return code;
-		proc.err = muxer.in;
-	}
+		if (use_sideband) {
+			memset(&muxer, 0, sizeof(muxer));
+			muxer.proc = copy_to_sideband;
+			muxer.in = -1;
+			code = start_async(&muxer);
+			if (code)
+				break;
+			proc.err = muxer.in;
+		}
 
-	prepare_push_cert_sha1(&proc);
+		prepare_push_cert_sha1(&proc);
 
-	code = start_command(&proc);
-	if (code) {
+		code = start_command(&proc);
+		if (code) {
+			if (use_sideband)
+				finish_async(&muxer);
+			break;
+		}
+
+		sigchain_push(SIGPIPE, SIG_IGN);
+
+		while (1) {
+			const char *buf;
+			size_t n;
+			if (feed(feed_state, &buf, &n))
+				break;
+			if (write_in_full(proc.in, buf, n) < 0)
+				break;
+		}
+		close(proc.in);
 		if (use_sideband)
 			finish_async(&muxer);
-		return code;
-	}
 
-	sigchain_push(SIGPIPE, SIG_IGN);
+		sigchain_pop(SIGPIPE);
 
-	while (1) {
-		const char *buf;
-		size_t n;
-		if (feed(feed_state, &buf, &n))
-			break;
-		if (write_in_full(proc.in, buf, n) < 0)
+		code = finish_command(&proc);
+		if (code)
 			break;
 	}
-	close(proc.in);
-	if (use_sideband)
-		finish_async(&muxer);
-
-	sigchain_pop(SIGPIPE);
-
-	return finish_command(&proc);
+        free_hooks(hooks);
+	return code;
 }
 
 static int feed_receive_hook(void *state_, const char **bufp, size_t *sizep)
@@ -793,30 +803,41 @@ static int run_receive_hook(struct command *commands,
 static int run_update_hook(struct command *cmd)
 {
 	const char *argv[5];
-	struct child_process proc = CHILD_PROCESS_INIT;
+	struct child_process proc;
+	struct string_list *hooks;
+	struct string_list_item *p;
 	int code;
 
-	argv[0] = find_hook("update");
-	if (!argv[0])
+	hooks = find_hooks("update");
+	if (!hooks)
 		return 0;
 
-	argv[1] = cmd->ref_name;
-	argv[2] = oid_to_hex(&cmd->old_oid);
-	argv[3] = oid_to_hex(&cmd->new_oid);
-	argv[4] = NULL;
+	for_each_string_list_item(p, hooks) {
+		child_process_init(&proc);
 
-	proc.no_stdin = 1;
-	proc.stdout_to_stderr = 1;
-	proc.err = use_sideband ? -1 : 0;
-	proc.argv = argv;
-	proc.trace2_hook_name = "update";
+		argv[0] = p->string;
+		argv[1] = cmd->ref_name;
+		argv[2] = oid_to_hex(&cmd->old_oid);
+		argv[3] = oid_to_hex(&cmd->new_oid);
+		argv[4] = NULL;
 
-	code = start_command(&proc);
-	if (code)
-		return code;
-	if (use_sideband)
-		copy_to_sideband(proc.err, -1, NULL);
-	return finish_command(&proc);
+		proc.no_stdin = 1;
+		proc.stdout_to_stderr = 1;
+		proc.err = use_sideband ? -1 : 0;
+		proc.argv = argv;
+		proc.trace2_hook_name = "update";
+
+		code = start_command(&proc);
+		if (code)
+			return code;
+		if (use_sideband)
+			copy_to_sideband(proc.err, -1, NULL);
+		code = finish_command(&proc);
+		if (code)
+			break;
+	}
+        free_hooks(hooks);
+	return code;
 }
 
 static int is_ref_checked_out(const char *ref)
@@ -1005,16 +1026,20 @@ static const char *update_worktree(unsigned char *sha1)
 	const char *retval;
 	const char *work_tree = git_work_tree_cfg ? git_work_tree_cfg : "..";
 	struct argv_array env = ARGV_ARRAY_INIT;
+	struct string_list *hooks;
 
 	if (is_bare_repository())
 		return "denyCurrentBranch = updateInstead needs a worktree";
 
 	argv_array_pushf(&env, "GIT_DIR=%s", absolute_path(get_git_dir()));
 
-	if (!find_hook(push_to_checkout_hook))
+	hooks = find_hooks(push_to_checkout_hook);
+	if (!hooks)
 		retval = push_to_deploy(sha1, &env, work_tree);
-	else
+	else {
+		free_hooks(hooks);
 		retval = push_to_checkout(sha1, &env, work_tree);
+	}
 
 	argv_array_clear(&env);
 	return retval;
@@ -1173,33 +1198,42 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 static void run_update_post_hook(struct command *commands)
 {
 	struct command *cmd;
-	struct child_process proc = CHILD_PROCESS_INIT;
-	const char *hook;
+	struct child_process proc;
+	struct string_list *hooks;
+	struct string_list_item *p;
 
-	hook = find_hook("post-update");
-	if (!hook)
+	hooks = find_hooks("post-update");
+	if (!hooks)
 		return;
 
-	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (cmd->error_string || cmd->did_not_exist)
-			continue;
+	for_each_string_list_item(p, hooks) {
+		child_process_init(&proc);
+
+		for (cmd = commands; cmd; cmd = cmd->next) {
+			if (cmd->error_string || cmd->did_not_exist)
+				continue;
+			if (!proc.args.argc)
+				argv_array_push(&proc.args, p->string);
+			argv_array_push(&proc.args, cmd->ref_name);
+		}
 		if (!proc.args.argc)
-			argv_array_push(&proc.args, hook);
-		argv_array_push(&proc.args, cmd->ref_name);
-	}
-	if (!proc.args.argc)
-		return;
+			return;
 
-	proc.no_stdin = 1;
-	proc.stdout_to_stderr = 1;
-	proc.err = use_sideband ? -1 : 0;
-	proc.trace2_hook_name = "post-update";
+		proc.no_stdin = 1;
+		proc.stdout_to_stderr = 1;
+		proc.err = use_sideband ? -1 : 0;
+		proc.trace2_hook_name = "post-update";
 
-	if (!start_command(&proc)) {
-		if (use_sideband)
-			copy_to_sideband(proc.err, -1, NULL);
-		finish_command(&proc);
+		if (!start_command(&proc)) {
+			int ret;
+			if (use_sideband)
+				copy_to_sideband(proc.err, -1, NULL);
+			ret = finish_command(&proc);
+			if (ret)
+				break;
+		}
 	}
+        free_hooks(hooks);
 }
 
 static void check_aliased_update_internal(struct command *cmd,
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 49bf4280e8..3143422344 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -15,6 +15,7 @@ This test checks the following functionality:
 '
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY/lib-hooks.sh"
 
 D=$(pwd)
 
@@ -1700,4 +1701,32 @@ test_expect_success 'updateInstead with push-to-checkout hook' '
 	)
 '
 
+test_expect_success 'setup' '
+	mk_test_with_hooks hooktest heads/master
+'
+
+cmd_receive () {
+	echo "$1" >>../file &&
+	git -C .. add file &&
+	git -C .. commit -m "$1" &&
+	git -C .. push hooktest refs/heads/master:refs/heads/master
+}
+
+cd hooktest
+test_multiple_hooks pre-receive cmd_receive
+test_multiple_hooks --ignore-exit-status post-receive cmd_receive
+test_multiple_hooks update cmd_receive
+test_multiple_hooks --ignore-exit-status post-update cmd_receive
+cd ..
+
+test_expect_success 'setup' '
+	rm -fr hooktest &&
+	git init hooktest &&
+	git -C hooktest config receive.denyCurrentBranch updateInstead
+'
+
+cd hooktest
+test_multiple_hooks push-to-checkout cmd_receive
+cd ..
+
 test_done
