Return-Path: <SRS0=iBdC=IG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9D2C433E0
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 13:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBD3E651CC
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 13:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhCHNSC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 08:18:02 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36452 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229505AbhCHNRc (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 8 Mar 2021 08:17:32 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 06B6660DF4;
        Mon,  8 Mar 2021 13:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1615209451;
        bh=477rPPPIrXVAWW3/7s04CBWAWD1rPS8GplMseRhE1OA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=m3MskxpYZUKQC2OAqyfy78NAJXON7rRs0bO5EylI4HhCCrFQK3eJl55VW/CAQpgTV
         V7Fg5msdfmYyXGKwTlL9qCjskf94lFh3OQ4VSGEfCESdaBDAEj+i6rh+VF7N7yAUTa
         aEnxgW4xwA/OvlIbkB62lNhdG0Ei14bYBSTy3zSXvw30iL97OGtrJ2s9yyk47QqiMT
         aRVliK11MycwLyzy/K+lACnSdxyJjSZFpT63bWi0rcWJIkBpOHQQdrRUW7Cy5ZMTWc
         ee/b3cMKS+frFkHKU7pToRwtKVrqE91RodAKSe/xVkLyLIPd7zSt8RnBg0RhFADu8O
         9UjDN55C+etiWlair7M6l0mw2n/IH3hygHYwA/V6kT5V25CZbIkC5U5QQRFujB4NaF
         UHauzdG93eSJdE0wtdZft1ryMw4qfRS6ZVf3Vj6pvvTqEx2rWjFz413qXJCEnxFwfg
         4AmDf8I07s++fGTj4nmV6H8HpsUsTMdRfM89+TqpIpjN7basLcW
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     jvusich@amazon.com
Subject: [PATCH] builtin/init-db: handle bare clones when core.bare set to false
Date:   Mon,  8 Mar 2021 13:17:18 +0000
Message-Id: <20210308131718.546055-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.31.0.rc1.246.gcd05c9c855
In-Reply-To: <D99DD9AD-54E5-4357-BA50-8B9CAE23084E@amazon.com>
References: <D99DD9AD-54E5-4357-BA50-8B9CAE23084E@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 552955ed7f ("clone: use more conventional config/option layering",
2020-10-01), clone learned to read configuration options earlier in its
execution, before creating the new repository.  However, that led to a
problem: if the core.bare setting is set to false in the global config,
cloning a bare repository segfaults.  This happens because the
repository is falsely thought to be non-bare, but clone has set the work
tree to NULL, which is then dereferenced.

The code to initialize the repository already considers the fact that a
user might want to override the --bare option for git init, but it
doesn't take into account clone, which uses a different option.  Let's
just check that the work tree is not NULL, since that's how clone
indicates that the repository is bare.  This is also the case for git
init, so we won't be regressing that case.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
It appears from my reading of the init code that we did intentionally
already honor core.bare in some case, so I have not implemented ignoring
that here and instead went for the limited approach.

 builtin/init-db.c        | 4 ++--
 t/t5606-clone-options.sh | 7 +++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index dcc45bef51..f82efe4aff 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -212,6 +212,7 @@ static int create_default_files(const char *template_path,
 	int reinit;
 	int filemode;
 	struct strbuf err = STRBUF_INIT;
+	const char *work_tree = get_git_work_tree();
 
 	/* Just look for `init.templatedir` */
 	init_db_template_dir = NULL; /* re-set in case it was set before */
@@ -235,7 +236,7 @@ static int create_default_files(const char *template_path,
 	 * We must make sure command-line options continue to override any
 	 * values we might have just re-read from the config.
 	 */
-	is_bare_repository_cfg = init_is_bare_repository;
+	is_bare_repository_cfg = init_is_bare_repository || !work_tree;
 	if (init_shared_repository != -1)
 		set_shared_repository(init_shared_repository);
 
@@ -299,7 +300,6 @@ static int create_default_files(const char *template_path,
 	if (is_bare_repository())
 		git_config_set("core.bare", "true");
 	else {
-		const char *work_tree = get_git_work_tree();
 		git_config_set("core.bare", "false");
 		/* allow template config file to override the default */
 		if (log_all_ref_updates == LOG_REFS_UNSET)
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index 52e5789fb0..9b62708d76 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -104,6 +104,13 @@ test_expect_success 'redirected clone -v does show progress' '
 
 '
 
+test_expect_success 'clone does not segfault with --bare and core.bare=false' '
+	test_config_global core.bare false &&
+	git clone --bare "file://$(pwd)/parent" clone-bare &&
+	git -C clone-bare rev-parse --is-bare-repository >is-bare &&
+	test "$(cat is-bare)" = true
+'
+
 test_expect_success 'chooses correct default initial branch name' '
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
 	git -c init.defaultBranch=foo init --bare empty &&
