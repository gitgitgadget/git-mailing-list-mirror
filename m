Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BFC21F461
	for <e@80x24.org>; Tue, 14 May 2019 00:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfENAXy (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 20:23:54 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36410 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726623AbfENAXx (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 May 2019 20:23:53 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:89af:9dea:d4e0:996c])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 14E326081E;
        Tue, 14 May 2019 00:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1557793430;
        bh=7DlsO1mFZm0RqwF6/9Pqs4pYRp8J2urx1klf493ot6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=zEfmKZaeI61VukC3Y+9Bj3Jmp4Nw4aSFR7+xqxAsEpAVALpLRh6zpydvnErFH1W37
         rpDWXz5LtTniBETcfN8tsaj9U7vmzQOGkBlmaCPMv5wXm2MPjqKuaFq+82kFQPC93D
         8+HDwO+ukwLLfHRwyL5sScv+GveOdbykbkZBcI03gT4etPXz2SOaYV2Qm/hXWCr2ND
         hcZP9SWQE0lceVRvqHPj4jr59VCPbgvJGVzqkAjM8ponelnTaX0o6wx+t7ulwFqH5N
         aM0uMF6gubq/ERf1NyOX3nQ9mdV3OCXRr5ekVrWhZXn5vwucjgZ0YWnZNjkjgXbxRu
         76+rxVLeHStxUhsZ2md+CHoedr6R+01KSTsvdxzyZ2l595KMgFR2OFau3LJz8icWa8
         QPRFUoRrRI2hwlFKmjs5Wxz71SZ1CDf3zyOjOJz1u+hJU1l+CnAP1FaZRVXelwcUVG
         JtMN882QvhwMXe6JrdHNhsSyLyS8kdKbTkCAwr2e7EE1L43Os78
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 2/7] builtin/receive-pack: add support for multiple hooks
Date:   Tue, 14 May 2019 00:23:26 +0000
Message-Id: <20190514002332.121089-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a
In-Reply-To: <20190514002332.121089-1-sandals@crustytoothpaste.net>
References: <20190514002332.121089-1-sandals@crustytoothpaste.net>
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
 builtin/receive-pack.c | 78 ++++++++++++++++++++++++++----------------
 t/t5516-fetch-push.sh  | 30 ++++++++++++++++
 2 files changed, 78 insertions(+), 30 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 29f165d8bd..5940f6969a 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -669,6 +669,8 @@ static void prepare_push_cert_sha1(struct child_process *proc)
 	}
 }
 
+typedef int (*feed_fn)(void *, const char **, size_t *);
+
 struct receive_hook_feed_state {
 	struct command *cmd;
 	int skip_broken;
@@ -676,34 +678,36 @@ struct receive_hook_feed_state {
 	const struct string_list *push_options;
 };
 
-typedef int (*feed_fn)(void *, const char **, size_t *);
-static int run_and_feed_hook(const char *hook_name, feed_fn feed,
-			     struct receive_hook_feed_state *feed_state)
+struct receive_hook_data {
+	feed_fn fn;
+	struct receive_hook_feed_state *state;
+};
+
+static int do_run_and_feed_hook(const char *name, const char *path, void *cbp)
 {
-	struct child_process proc = CHILD_PROCESS_INIT;
+	struct receive_hook_data *data = cbp;
+	struct child_process proc;
 	struct async muxer;
 	const char *argv[2];
-	int code;
-
-	argv[0] = find_hook(hook_name);
-	if (!argv[0])
-		return 0;
+	int code = 0;
 
+	argv[0] = path;
 	argv[1] = NULL;
 
+	child_process_init(&proc);
 	proc.argv = argv;
 	proc.in = -1;
 	proc.stdout_to_stderr = 1;
-	proc.trace2_hook_name = hook_name;
+	proc.trace2_hook_name = name;
 
-	if (feed_state->push_options) {
+	if (data->state->push_options) {
 		int i;
-		for (i = 0; i < feed_state->push_options->nr; i++)
+		for (i = 0; i < data->state->push_options->nr; i++)
 			argv_array_pushf(&proc.env_array,
 				"GIT_PUSH_OPTION_%d=%s", i,
-				feed_state->push_options->items[i].string);
+				data->state->push_options->items[i].string);
 		argv_array_pushf(&proc.env_array, "GIT_PUSH_OPTION_COUNT=%d",
-				 feed_state->push_options->nr);
+				 data->state->push_options->nr);
 	} else
 		argv_array_pushf(&proc.env_array, "GIT_PUSH_OPTION_COUNT");
 
@@ -734,7 +738,7 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed,
 	while (1) {
 		const char *buf;
 		size_t n;
-		if (feed(feed_state, &buf, &n))
+		if (data->fn(data->state, &buf, &n))
 			break;
 		if (write_in_full(proc.in, buf, n) < 0)
 			break;
@@ -748,6 +752,13 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed,
 	return finish_command(&proc);
 }
 
+static int run_and_feed_hook(const char *hook_name, feed_fn feed,
+			     struct receive_hook_feed_state *feed_state)
+{
+	struct receive_hook_data data = { feed, feed_state };
+	return for_each_hook(hook_name, do_run_and_feed_hook, &data);
+}
+
 static int feed_receive_hook(void *state_, const char **bufp, size_t *sizep)
 {
 	struct receive_hook_feed_state *state = state_;
@@ -790,16 +801,14 @@ static int run_receive_hook(struct command *commands,
 	return status;
 }
 
-static int run_update_hook(struct command *cmd)
+static int do_run_update_hook(const char *name, const char *path, void *data)
 {
-	const char *argv[5];
+	struct command *cmd = data;
 	struct child_process proc = CHILD_PROCESS_INIT;
+	const char *argv[5];
 	int code;
 
-	argv[0] = find_hook("update");
-	if (!argv[0])
-		return 0;
-
+	argv[0] = path;
 	argv[1] = cmd->ref_name;
 	argv[2] = oid_to_hex(&cmd->old_oid);
 	argv[3] = oid_to_hex(&cmd->new_oid);
@@ -819,6 +828,11 @@ static int run_update_hook(struct command *cmd)
 	return finish_command(&proc);
 }
 
+static int run_update_hook(struct command *cmd)
+{
+	return for_each_hook("update", do_run_update_hook, cmd);
+}
+
 static int is_ref_checked_out(const char *ref)
 {
 	if (is_bare_repository())
@@ -1011,7 +1025,7 @@ static const char *update_worktree(unsigned char *sha1)
 
 	argv_array_pushf(&env, "GIT_DIR=%s", absolute_path(get_git_dir()));
 
-	if (!find_hook(push_to_checkout_hook))
+	if (!find_hooks(push_to_checkout_hook, NULL))
 		retval = push_to_deploy(sha1, &env, work_tree);
 	else
 		retval = push_to_checkout(sha1, &env, work_tree);
@@ -1170,25 +1184,23 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 	}
 }
 
-static void run_update_post_hook(struct command *commands)
+static int do_run_update_post_hook(const char *name, const char *path, void *data)
 {
+	struct command *commands = data;
 	struct command *cmd;
 	struct child_process proc = CHILD_PROCESS_INIT;
-	const char *hook;
 
-	hook = find_hook("post-update");
-	if (!hook)
-		return;
+	child_process_init(&proc);
 
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (cmd->error_string || cmd->did_not_exist)
 			continue;
 		if (!proc.args.argc)
-			argv_array_push(&proc.args, hook);
+			argv_array_push(&proc.args, path);
 		argv_array_push(&proc.args, cmd->ref_name);
 	}
 	if (!proc.args.argc)
-		return;
+		return 0;
 
 	proc.no_stdin = 1;
 	proc.stdout_to_stderr = 1;
@@ -1198,8 +1210,14 @@ static void run_update_post_hook(struct command *commands)
 	if (!start_command(&proc)) {
 		if (use_sideband)
 			copy_to_sideband(proc.err, -1, NULL);
-		finish_command(&proc);
+		return finish_command(&proc);
 	}
+	return -1;
+}
+
+static void run_update_post_hook(struct command *commands)
+{
+	for_each_hook("post-update", do_run_update_post_hook, commands);
 }
 
 static void check_aliased_update_internal(struct command *cmd,
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index c81ca360ac..697c3ab074 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -15,6 +15,7 @@ This test checks the following functionality:
 '
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY/lib-hooks.sh"
 
 D=$(pwd)
 
@@ -1712,4 +1713,33 @@ test_expect_success 'updateInstead with push-to-checkout hook' '
 	)
 '
 
+test_expect_success 'setup' '
+	mk_test_with_hooks hooktest heads/master
+'
+
+cmd_receive () {
+	git reset --hard &&
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
