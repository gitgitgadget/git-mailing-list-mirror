Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D0391F461
	for <e@80x24.org>; Tue, 14 May 2019 00:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfENAYI (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 20:24:08 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36428 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726623AbfENAYI (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 May 2019 20:24:08 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:89af:9dea:d4e0:996c])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9948F60822;
        Tue, 14 May 2019 00:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1557793435;
        bh=O/i/bBJQ1LZyXtJefOxLL/P80jm5PpP5ZX95G/EckUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=bJrqrur3aySY9vCjuZu60z+9PtKYUCgcWlSVKJRJJNlQrmy1VzQT1yfk/643H+cq0
         MpQwk7T9AEEmkTEJ+a8r0ulIqhzWqzXDNDYrgecZli4oWlGu2yUZKBAOms+2hw5TQM
         W8M87POy8vKSeGwpbxKn7uVehc6Tg63xhiPnUSGJ26NQHxzM091FOd4DixnAhFNWIg
         KXn/zj5fw9EklOhcK7E75QVkGPJjzkUEXovVY38MJi4AG5eJ9JztrxLCGntI+rnz2h
         k5M4+cdKob+CZg7NlJ380GUuFJOwxVd3cZxXP4la7eWF7tKA2E8Rrt9xa6af0oeuyg
         cUTShT3M1t+AbGzqPgvTD6NSKRawtCzp3D3sIovyQrwE7v02n3c7a6lkgumrkipYIZ
         SMt5ZEJXSaAXjjXVZEtnKCC1io9Ah/EXlJvJ/yKIzdYBDZEtLG2eFZ68BLMBw78aC3
         Cb43XZh1iNnMy/mYwzalxMYlVbh0eaYckyUrgwLk0O+LmdXLncs
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 3/7] sequencer: add support for multiple hooks
Date:   Tue, 14 May 2019 00:23:28 +0000
Message-Id: <20190514002332.121089-5-sandals@crustytoothpaste.net>
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

Add support for multiple post-rewrite hooks, both for "git commit
--amend" and "git rebase".

Additionally add support for multiple prepare-commit-msg hooks.

Note that the prepare-commit-msg hook is not passed a set of hooks
directly because these are discovered later when the code calls
run_hooks_le.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/am.c                       | 20 +++++-----
 sequencer.c                        | 59 ++++++++++++++++++------------
 t/t5407-post-rewrite-hook.sh       | 15 ++++++++
 t/t7505-prepare-commit-msg-hook.sh |  9 +++++
 4 files changed, 70 insertions(+), 33 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 912d9821b1..55a5b74da3 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -436,19 +436,13 @@ static int run_applypatch_msg_hook(struct am_state *state)
 	return ret;
 }
 
-/**
- * Runs post-rewrite hook. Returns it exit code.
- */
-static int run_post_rewrite_hook(const struct am_state *state)
+static int do_run_post_rewrite_hook(const char *name, const char *path, void *p)
 {
+	const struct am_state *state = p;
 	struct child_process cp = CHILD_PROCESS_INIT;
-	const char *hook = find_hook("post-rewrite");
 	int ret;
 
-	if (!hook)
-		return 0;
-
-	argv_array_push(&cp.args, hook);
+	argv_array_push(&cp.args, path);
 	argv_array_push(&cp.args, "rebase");
 
 	cp.in = xopen(am_path(state, "rewritten"), O_RDONLY);
@@ -461,6 +455,14 @@ static int run_post_rewrite_hook(const struct am_state *state)
 	return ret;
 }
 
+/**
+ * Runs post-rewrite hook. Returns it exit code.
+ */
+static int run_post_rewrite_hook(const struct am_state *state)
+{
+	return for_each_hook("post-rewrite", do_run_post_rewrite_hook, (void *)state);
+}
+
 /**
  * Reads the state directory's "rewritten" file, and copies notes from the old
  * commits listed in the file to their rewritten commits.
diff --git a/sequencer.c b/sequencer.c
index 546f281898..f7703bc7a5 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1084,30 +1084,32 @@ int update_head_with_reflog(const struct commit *old_head,
 	return ret;
 }
 
-static int run_rewrite_hook(const struct object_id *oldoid,
-			    const struct object_id *newoid)
+struct rewrite_hook_data {
+	const struct object_id *oldoid;
+	const struct object_id *newoid;
+};
+
+static int do_run_rewrite_hook(const char *name, const char *path, void *p)
 {
+	struct rewrite_hook_data *data = p;
 	struct child_process proc = CHILD_PROCESS_INIT;
+	struct strbuf sb = STRBUF_INIT;
 	const char *argv[3];
 	int code;
-	struct strbuf sb = STRBUF_INIT;
-
-	argv[0] = find_hook("post-rewrite");
-	if (!argv[0])
-		return 0;
 
+	argv[0] = path;
 	argv[1] = "amend";
 	argv[2] = NULL;
 
 	proc.argv = argv;
 	proc.in = -1;
 	proc.stdout_to_stderr = 1;
-	proc.trace2_hook_name = "post-rewrite";
+	proc.trace2_hook_name = name;
 
 	code = start_command(&proc);
 	if (code)
 		return code;
-	strbuf_addf(&sb, "%s %s\n", oid_to_hex(oldoid), oid_to_hex(newoid));
+	strbuf_addf(&sb, "%s %s\n", oid_to_hex(data->oldoid), oid_to_hex(data->newoid));
 	sigchain_push(SIGPIPE, SIG_IGN);
 	write_in_full(proc.in, sb.buf, sb.len);
 	close(proc.in);
@@ -1116,6 +1118,26 @@ static int run_rewrite_hook(const struct object_id *oldoid,
 	return finish_command(&proc);
 }
 
+static int run_rewrite_hook(const struct object_id *oldoid,
+			    const struct object_id *newoid)
+{
+	struct rewrite_hook_data data = { oldoid, newoid };
+	return for_each_hook("post-rewrite", do_run_rewrite_hook, &data);
+}
+
+static int interactive_rewrite_hook_handler(const char *name, const char *path, void *data)
+{
+	struct child_process child = CHILD_PROCESS_INIT;
+
+	child.in = open(rebase_path_rewritten_list(),
+		O_RDONLY);
+	child.stdout_to_stderr = 1;
+	child.trace2_hook_name = "post-rewrite";
+	argv_array_push(&child.args, path);
+	argv_array_push(&child.args, "rebase");
+	return run_command(&child);
+}
+
 void commit_post_rewrite(struct repository *r,
 			 const struct commit *old_head,
 			 const struct object_id *new_head)
@@ -1368,7 +1390,7 @@ static int try_to_commit(struct repository *r,
 		goto out;
 	}
 
-	if (find_hook("prepare-commit-msg")) {
+	if (find_hooks("prepare-commit-msg", NULL)) {
 		res = run_prepare_commit_msg_hook(r, msg, hook_commit);
 		if (res)
 			goto out;
@@ -3763,8 +3785,6 @@ static int pick_commits(struct repository *r,
 		if (!stat(rebase_path_rewritten_list(), &st) &&
 				st.st_size > 0) {
 			struct child_process child = CHILD_PROCESS_INIT;
-			const char *post_rewrite_hook =
-				find_hook("post-rewrite");
 
 			child.in = open(rebase_path_rewritten_list(), O_RDONLY);
 			child.git_cmd = 1;
@@ -3774,18 +3794,9 @@ static int pick_commits(struct repository *r,
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
+			for_each_hook("post-rewrite",
+				      interactive_rewrite_hook_handler, NULL);
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
index ba8bd1b514..287e13e29d 100755
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
 
+cherry_pick_command () {
+	git checkout -f master &&
+	git checkout -B other b &&
+	git cherry-pick rebase-1
+}
+
+test_multiple_hooks prepare-commit-msg cherry_pick_command
+
 test_done
