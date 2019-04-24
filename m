Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 379951F453
	for <e@80x24.org>; Wed, 24 Apr 2019 00:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbfDXAye (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 20:54:34 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35618 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728985AbfDXAyc (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 23 Apr 2019 20:54:32 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:ace5:84c6:6a15:3d32])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CCC2F61002;
        Wed, 24 Apr 2019 00:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1556067269;
        bh=O1t0Oh4789kt9UwivGBZouF0W4VTRMivJax/eUp+gy4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=OqLCbh3jAfgbzvKqt3qRKD/fXmB0viQGMgrb74PNa2pfsFI4MIymqFbT7PiBcyVHU
         wU5CjlaiZiFmMXMWnEfeNyxfG3UZyuJyLnIBWYqwny/n0aBAA0jvRNDLfN/USojUoT
         GCgAj0ZaRlkl1kPQx3ga6is4oUrtEvsZkWZC8WTjPtKcWZmE/mpFGUyPD1Mc0WEr8r
         AmaJMk4MSK6HMhmbyCJLFn7zZnvCo/48D755n8W+B8JMhdJJsnLtEM9A3t5Ayng2+2
         ZxcBYilalyXJIYMCigyS6XTz55AzEp4qlTZbVG2y+3iF6ypCUe6txtw6d8x7d3nEgP
         +2DyznhYuusorH+aueDg+sKzG8c9Vpb6mn02tgv6pJNntypvIP4IXUHKtwkQoR0tQj
         EqPcdpi3zfAa/5PpkwykvGvHjGL2U5TT/FMYq87zt8Yhvgs/Mv36YRc87sI+uQXl3V
         tzSUFZMwU9fb0MQuLYiijpePwci+cAL3E1DedNxO/q7sSK7NDYJ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 4/5] builtin/worktree: add support for multiple post-checkout hooks
Date:   Wed, 24 Apr 2019 00:49:47 +0000
Message-Id: <20190424004948.728326-5-sandals@crustytoothpaste.net>
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

Add support for multiple post-checkout hooks. We test only one possible
path in the multiple hook case because the same code path is used for
all checkouts and we know the hooks work from earlier assertions.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/worktree.c            | 40 ++++++++++++++++++++++-------------
 t/t5403-post-checkout-hook.sh |  8 +++++++
 2 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index d2a7e2f3f1..3126fa3a82 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -395,21 +395,31 @@ static int add_worktree(const char *path, const char *refname,
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
+		struct string_list *hooks;
+		hooks = find_hooks("post-checkout");
+		if (hooks) {
+			struct string_list_item *p;
+			struct child_process cp;
+			for_each_string_list_item(p, hooks) {
+				const char *env[] = { "GIT_DIR", "GIT_WORK_TREE", NULL };
+				child_process_init(&cp);
+
+				cp.git_cmd = 0;
+				cp.no_stdin = 1;
+				cp.stdout_to_stderr = 1;
+				cp.dir = path;
+				cp.env = env;
+				cp.argv = NULL;
+				cp.trace2_hook_name = "post-checkout";
+				argv_array_pushl(&cp.args, absolute_path(p->string),
+						 oid_to_hex(&null_oid),
+						 oid_to_hex(&commit->object.oid),
+						 "1", NULL);
+				ret = run_command(&cp);
+				if (ret)
+					break;
+			}
+			free_hooks(hooks);
 		}
 	}
 
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
