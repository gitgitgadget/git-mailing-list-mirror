Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C60B31F453
	for <e@80x24.org>; Wed, 24 Apr 2019 00:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbfDXAyc (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 20:54:32 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35614 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728730AbfDXAyb (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 23 Apr 2019 20:54:31 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:ace5:84c6:6a15:3d32])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3422761005;
        Wed, 24 Apr 2019 00:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1556067266;
        bh=rQ4sKic+lenaKvOpJCK5TG1KV2P/o2iyGzmytgngEBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=R+xZ9b+sNHUaVFO+a3eeUhY+qTC7vO79MFw62KuYVlKRF/BW0jS07o4qJznOufdp+
         lch3KFuuQwWlPM8J2BuM9OWNlnDFH9dDxBdsvU6EwrQYyhOlHTvVFNqqCDyDVpzRI1
         +tOT20A1AvdrSOU8NSaJcnxj5l5swri4aA+gREjA7/tN3h2jy4M2fiziRkGbtSjC8d
         cbfmB3lSe6PT5BzMsklkZleeB10qkXNLr9PchgWdDpotp/kIwkkOWq5JBVucrOsrPk
         BYz9eZ9rdYecOwYQWklewKBCK8wBrFlOd6AqFjgL1wGPzRTTd4HFSfi9p3jkeaCxPZ
         iqRX8s6EEhZwJJO0GNhW4YiNei3kQi5NlxTB58L26lVUum/I2OECHm6RgWbCVpEZXL
         yfo8vXGbB7AGwtlQTDR4kK2qw+mEjROZC6iop/2DAn1QzR92yI+sMzYD6obH8jpneu
         C9XOm6LbDoBKOY17cwZyq3960bSJX4I1/KDo+GBs9Y9jhstZxPz
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/5] sequencer: add support for multiple hooks
Date:   Wed, 24 Apr 2019 00:49:46 +0000
Message-Id: <20190424004948.728326-4-sandals@crustytoothpaste.net>
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

Add support for multiple post-rewrite hooks, both for "git commit
--amend" and "git rebase".

Additionally add support for multiple prepare-commit-msg hooks.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/am.c                       | 28 ++++++---
 sequencer.c                        | 96 +++++++++++++++++++-----------
 t/t5407-post-rewrite-hook.sh       | 15 +++++
 t/t7505-prepare-commit-msg-hook.sh |  9 +++
 4 files changed, 105 insertions(+), 43 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 4fb107a9d1..303abc98c2 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -442,22 +442,32 @@ static int run_applypatch_msg_hook(struct am_state *state)
 static int run_post_rewrite_hook(const struct am_state *state)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
-	const char *hook = find_hook("post-rewrite");
+	struct child_process proc;
+	struct string_list *hooks;
+	struct string_list_item *p;
 	int ret;
 
-	if (!hook)
+	hooks = find_hooks("post-rewrite");
+	if (!hooks)
 		return 0;
 
-	argv_array_push(&cp.args, hook);
-	argv_array_push(&cp.args, "rebase");
+	for_each_string_list_item(p, hooks) {
+		child_process_init(&proc);
 
-	cp.in = xopen(am_path(state, "rewritten"), O_RDONLY);
-	cp.stdout_to_stderr = 1;
-	cp.trace2_hook_name = "post-rewrite";
+		argv_array_push(&cp.args, p->string);
+		argv_array_push(&cp.args, "rebase");
 
-	ret = run_command(&cp);
+		cp.in = xopen(am_path(state, "rewritten"), O_RDONLY);
+		cp.stdout_to_stderr = 1;
+		cp.trace2_hook_name = "post-rewrite";
 
-	close(cp.in);
+		ret = run_command(&cp);
+
+		close(cp.in);
+		if (ret)
+			break;
+	}
+	free_hooks(hooks);
 	return ret;
 }
 
diff --git a/sequencer.c b/sequencer.c
index 79a046d748..3a616ceba6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1088,33 +1088,69 @@ int update_head_with_reflog(const struct commit *old_head,
 static int run_rewrite_hook(const struct object_id *oldoid,
 			    const struct object_id *newoid)
 {
-	struct child_process proc = CHILD_PROCESS_INIT;
+	struct child_process proc;
+	struct string_list *hooks;
+	struct string_list_item *p;
 	const char *argv[3];
 	int code;
 	struct strbuf sb = STRBUF_INIT;
 
-	argv[0] = find_hook("post-rewrite");
-	if (!argv[0])
+	hooks = find_hooks("post-rewrite");
+	if (!hooks)
 		return 0;
 
-	argv[1] = "amend";
-	argv[2] = NULL;
+	for_each_string_list_item(p, hooks) {
+		child_process_init(&proc);
 
-	proc.argv = argv;
-	proc.in = -1;
-	proc.stdout_to_stderr = 1;
-	proc.trace2_hook_name = "post-rewrite";
+		argv[0] = p->string;
+		argv[1] = "amend";
+		argv[2] = NULL;
 
-	code = start_command(&proc);
-	if (code)
-		return code;
-	strbuf_addf(&sb, "%s %s\n", oid_to_hex(oldoid), oid_to_hex(newoid));
-	sigchain_push(SIGPIPE, SIG_IGN);
-	write_in_full(proc.in, sb.buf, sb.len);
-	close(proc.in);
-	strbuf_release(&sb);
-	sigchain_pop(SIGPIPE);
-	return finish_command(&proc);
+		proc.argv = argv;
+		proc.in = -1;
+		proc.stdout_to_stderr = 1;
+		proc.trace2_hook_name = "post-rewrite";
+
+		code = start_command(&proc);
+		if (code)
+			return code;
+		strbuf_addf(&sb, "%s %s\n", oid_to_hex(oldoid), oid_to_hex(newoid));
+		sigchain_push(SIGPIPE, SIG_IGN);
+		write_in_full(proc.in, sb.buf, sb.len);
+		close(proc.in);
+		strbuf_release(&sb);
+		sigchain_pop(SIGPIPE);
+		code = finish_command(&proc);
+		if (code)
+			break;
+	}
+	free_hooks(hooks);
+	return code;
+}
+
+static void run_interactive_rewrite_hook(void)
+{
+	struct string_list *hooks;
+	struct string_list_item *p;
+	struct child_process child;
+
+	hooks = find_hooks("post-rewrite");
+	if (!hooks)
+		return;
+
+	for_each_string_list_item(p, hooks) {
+		child_process_init(&child);
+
+		child.in = open(rebase_path_rewritten_list(),
+			O_RDONLY);
+		child.stdout_to_stderr = 1;
+		child.trace2_hook_name = "post-rewrite";
+		argv_array_push(&child.args, p->string);
+		argv_array_push(&child.args, "rebase");
+		if (run_command(&child))
+			break;
+	}
+	free_hooks(hooks);
 }
 
 void commit_post_rewrite(struct repository *r,
@@ -1326,6 +1362,7 @@ static int try_to_commit(struct repository *r,
 	char *amend_author = NULL;
 	const char *hook_commit = NULL;
 	enum commit_msg_cleanup_mode cleanup;
+	struct string_list *hooks;
 	int res = 0;
 
 	if (parse_head(r, &current_head))
@@ -1369,7 +1406,10 @@ static int try_to_commit(struct repository *r,
 		goto out;
 	}
 
-	if (find_hook("prepare-commit-msg")) {
+	hooks = find_hooks("prepare-commit-msg");
+	if (hooks) {
+		free_hooks(hooks);
+
 		res = run_prepare_commit_msg_hook(r, msg, hook_commit);
 		if (res)
 			goto out;
@@ -3771,8 +3811,6 @@ static int pick_commits(struct repository *r,
 		if (!stat(rebase_path_rewritten_list(), &st) &&
 				st.st_size > 0) {
 			struct child_process child = CHILD_PROCESS_INIT;
-			const char *post_rewrite_hook =
-				find_hook("post-rewrite");
 
 			child.in = open(rebase_path_rewritten_list(), O_RDONLY);
 			child.git_cmd = 1;
@@ -3782,18 +3820,8 @@ static int pick_commits(struct repository *r,
 			/* we don't care if this copying failed */
 			run_command(&child);
 
-			if (post_rewrite_hook) {
-				struct child_process hook = CHILD_PROCESS_INIT;
-
-				hook.in = open(rebase_path_rewritten_list(),
-					O_RDONLY);
-				hook.stdout_to_stderr = 1;
-				hook.trace2_hook_name = "post-rewrite";
-				argv_array_push(&hook.args, post_rewrite_hook);
-				argv_array_push(&hook.args, "rebase");
-				/* we don't care if this hook failed */
-				run_command(&hook);
-			}
+			/* we don't care if this hook failed */
+			run_interactive_rewrite_hook();
 		}
 		apply_autostash(opts);
 
diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
index 7344253bfb..f8ce32fe3b 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -5,6 +5,7 @@
 
 test_description='Test the post-rewrite hook.'
 . ./test-lib.sh
+. "$TEST_DIRECTORY/lib-hooks.sh"
 
 test_expect_success 'setup' '
 	test_commit A foo A &&
@@ -263,4 +264,18 @@ test_expect_success 'git rebase -i (exec)' '
 	verify_hook_input
 '
 
+cmd_rebase () {
+	git reset --hard D &&
+	FAKE_LINES="1 fixup 2" git rebase -i B
+}
+
+cmd_amend () {
+	git reset --hard D &&
+	echo "D new message" > newmsg &&
+	git commit -Fnewmsg --amend
+}
+
+test_multiple_hooks --ignore-exit-status post-rewrite cmd_rebase
+test_multiple_hooks --ignore-exit-status post-rewrite cmd_amend
+
 test_done
diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
index ba8bd1b514..5b83f037b5 100755
--- a/t/t7505-prepare-commit-msg-hook.sh
+++ b/t/t7505-prepare-commit-msg-hook.sh
@@ -3,6 +3,7 @@
 test_description='prepare-commit-msg hook'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY/lib-hooks.sh"
 
 test_expect_success 'set up commits for rebasing' '
 	test_commit root &&
@@ -317,4 +318,12 @@ test_expect_success C_LOCALE_OUTPUT 'with failing hook (cherry-pick)' '
 	test $(grep -c prepare-commit-msg actual) = 1
 '
 
+commit_command () {
+	echo "$1" >>file &&
+	git add file &&
+	git commit -m "$1"
+}
+
+test_multiple_hooks prepare-commit-msg commit_command
+
 test_done
