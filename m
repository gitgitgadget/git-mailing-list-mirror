Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BF9B1F461
	for <e@80x24.org>; Tue, 14 May 2019 00:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfENAYK (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 20:24:10 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36446 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726623AbfENAYJ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 May 2019 20:24:09 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:89af:9dea:d4e0:996c])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0AEE960821;
        Tue, 14 May 2019 00:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1557793447;
        bh=TzUG9jK8dfwV5fOCpym/nZrYIHq63IOSoVFbdb5CNVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=m67kzRFKetJpVoFHyN44jH02SAWrjj7BQkBfPoYlXjJgiq9a7VxN7XNfbo/SxULYJ
         y9eAvA7soAqFCeImuhndLsdN5Uw3aIVXpOKN6RNMdUCkY1wZJXYd+y51RnkOOlRc+O
         GBxrlIGUWmBcRvaIJiQSctwcZliQ7nN3EJ5MLyKjO5lbj4LcHMCKKtqKx9w9hqp7dK
         kU5c/R/taPlGsUIpIgP/jQPhDB/u0Pyihj5VRxG5CoPcZ0GGJv/yE+BeXhNQF+C681
         DbJOlL20qANoejJEUVch9R5nBEL1eo1Z+ntsLM7tUnhrCS6yN2FCiswlPqOvGdRXlm
         D8cL3yYzDslIkLlxkMVzuRKLe0dSryUHWmGYz6lhFGiX2H2+XtUmpKr2gkhleln30c
         7B4jGkzYM1mC9RkivKWyFWIhY+N9NJbrUzW+d7xlT0DuY8xt7ffYmSjwFqM3HLdsSn
         7w5io0wBCh3GKFphs1Rq3vj9RmH8tg+j7KUe1SjUlgLQ10xHa9f
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 4/7] builtin/worktree: add support for multiple post-checkout hooks
Date:   Tue, 14 May 2019 00:23:29 +0000
Message-Id: <20190514002332.121089-6-sandals@crustytoothpaste.net>
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

Add support for multiple post-checkout hooks. We test only one possible
path in the multiple hook case because the same code path is used for
all checkouts and we know the hooks work from earlier assertions.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/worktree.c            | 44 ++++++++++++++++++++++-------------
 t/t5403-post-checkout-hook.sh |  8 +++++++
 2 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index d2a7e2f3f1..1edcde8c84 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -262,6 +262,32 @@ static void validate_worktree_add(const char *path, const struct add_opts *opts)
 	free_worktrees(worktrees);
 }
 
+struct hook_data {
+	struct commit *commit;
+	const char *dir;
+};
+
+static int run_post_checkout_hook(const char *name, const char *path, void *p)
+{
+	struct hook_data *data = p;
+	struct commit *commit = data->commit;
+	const char *env[] = { "GIT_DIR", "GIT_WORK_TREE", NULL };
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	cp.git_cmd = 0;
+	cp.no_stdin = 1;
+	cp.stdout_to_stderr = 1;
+	cp.dir = data->dir;
+	cp.env = env;
+	cp.argv = NULL;
+	cp.trace2_hook_name = "post-checkout";
+	argv_array_pushl(&cp.args, absolute_path(path),
+			 oid_to_hex(&null_oid),
+			 oid_to_hex(&commit->object.oid),
+			 "1", NULL);
+	return run_command(&cp);
+}
+
 static int add_worktree(const char *path, const char *refname,
 			const struct add_opts *opts)
 {
@@ -395,22 +421,8 @@ static int add_worktree(const char *path, const char *refname,
 	 * is_junk is cleared, but do return appropriate code when hook fails.
 	 */
 	if (!ret && opts->checkout) {
-		const char *hook = find_hook("post-checkout");
-		if (hook) {
-			const char *env[] = { "GIT_DIR", "GIT_WORK_TREE", NULL };
-			cp.git_cmd = 0;
-			cp.no_stdin = 1;
-			cp.stdout_to_stderr = 1;
-			cp.dir = path;
-			cp.env = env;
-			cp.argv = NULL;
-			cp.trace2_hook_name = "post-checkout";
-			argv_array_pushl(&cp.args, absolute_path(hook),
-					 oid_to_hex(&null_oid),
-					 oid_to_hex(&commit->object.oid),
-					 "1", NULL);
-			ret = run_command(&cp);
-		}
+		struct hook_data data = { commit, path };
+		ret = for_each_hook("post-checkout", run_post_checkout_hook, &data);
 	}
 
 	argv_array_clear(&child_env);
diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
index a39b3b5c78..aa265ce610 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -5,6 +5,7 @@
 
 test_description='Test the post-checkout hook.'
 . ./test-lib.sh
+. "$TEST_DIRECTORY/lib-hooks.sh"
 
 test_expect_success setup '
 	mkdir -p .git/hooks &&
@@ -73,4 +74,11 @@ test_expect_success 'post-checkout hook is triggered by clone' '
 	test -f clone3/.git/post-checkout.args
 '
 
+cmd_rebase () {
+	git checkout -B hook-test rebase-on-me^ &&
+	git rebase rebase-on-me
+}
+
+test_multiple_hooks post-checkout cmd_rebase
+
 test_done
