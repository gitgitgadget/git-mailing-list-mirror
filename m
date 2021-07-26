Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB82C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 18:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8689B60F6F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 18:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbhGZSB0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 14:01:26 -0400
Received: from bee.birch.relay.mailchannels.net ([23.83.209.14]:21419 "EHLO
        bee.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231901AbhGZSB0 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 26 Jul 2021 14:01:26 -0400
X-Sender-Id: dreamhost|x-authsender|novalis@novalis.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id A6FF3641AE7;
        Mon, 26 Jul 2021 18:34:19 +0000 (UTC)
Received: from pdx1-sub0-mail-a52.g.dreamhost.com (100-96-27-225.trex.outbound.svc.cluster.local [100.96.27.225])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 07BC3642467;
        Mon, 26 Jul 2021 18:34:19 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|novalis@novalis.org
Received: from pdx1-sub0-mail-a52.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.96.27.225 (trex/6.3.3);
        Mon, 26 Jul 2021 18:34:19 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|novalis@novalis.org
X-MailChannels-Auth-Id: dreamhost
X-Quick-Arch: 7041f11167addd83_1627324459359_807480853
X-MC-Loop-Signature: 1627324459359:1267826197
X-MC-Ingress-Time: 1627324459359
Received: from pdx1-sub0-mail-a52.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a52.g.dreamhost.com (Postfix) with ESMTP id D78B67F0D8;
        Mon, 26 Jul 2021 11:34:17 -0700 (PDT)
Received: from corey.lan (unknown [98.113.183.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by pdx1-sub0-mail-a52.g.dreamhost.com (Postfix) with ESMTPSA id 238B97F74A;
        Mon, 26 Jul 2021 11:34:14 -0700 (PDT)
X-DH-BACKEND: pdx1-sub0-mail-a52
From:   David Turner <dturner@twosigma.com>
To:     git@vger.kernel.org
Cc:     David Turner <dturner@twosigma.com>
Subject: [PATCH 2/3] diff --submodule=diff: do not fail on ever-initialied deleted submodules
Date:   Mon, 26 Jul 2021 14:33:57 -0400
Message-Id: <20210726183358.3255233-2-dturner@twosigma.com>
X-Mailer: git-send-email 2.11.GIT
In-Reply-To: <20210726183358.3255233-1-dturner@twosigma.com>
References: <20210726183358.3255233-1-dturner@twosigma.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If you have ever initialized a submodule, open_submodule will open it.
If you then delete the submodule's worktree directory (but don't
remove it from .gitmodules), git diff --submodule=diff would crash as
it attempted to chdir into the now-deleted working tree directory.

Signed-off-by: David Turner <dturner@twosigma.com>
---
 submodule.c                                  |  3 ++
 t/t4060-diff-submodule-option-diff-format.sh | 45 ++++++++++++++++++++++++----
 2 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/submodule.c b/submodule.c
index 0b1d9c1dde..9031527a16 100644
--- a/submodule.c
+++ b/submodule.c
@@ -673,6 +673,9 @@ void show_submodule_inline_diff(struct diff_options *o, const char *path,
 	    !(right || is_null_oid(two)))
 		goto done;
 
+	if (!is_directory(path))
+		goto done;
+
 	if (left)
 		old_oid = one;
 	if (right)
diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
index 69b9946931..10e330c08a 100755
--- a/t/t4060-diff-submodule-option-diff-format.sh
+++ b/t/t4060-diff-submodule-option-diff-format.sh
@@ -703,10 +703,26 @@ test_expect_success 'path filter' '
 	diff_cmp expected actual
 '
 
-commit_file sm2
+cat >.gitmodules <<-EOF
+[submodule "sm2"]
+	path = sm2
+	url = bogus_url
+EOF
+git add .gitmodules
+commit_file sm2 .gitmodules
+
 test_expect_success 'given commit' '
 	git diff-index -p --submodule=diff HEAD^ >actual &&
 	cat >expected <<-EOF &&
+	diff --git a/.gitmodules b/.gitmodules
+	new file mode 100644
+	index 1234567..89abcde
+	--- /dev/null
+	+++ b/.gitmodules
+	@@ -0,0 +1,3 @@
+	+[submodule "sm2"]
+	+path = sm2
+	+url = bogus_url
 	Submodule sm1 $head7...0000000 (submodule deleted)
 	Submodule sm2 0000000...$head9 (new submodule)
 	diff --git a/sm2/foo8 b/sm2/foo8
@@ -728,15 +744,21 @@ test_expect_success 'given commit' '
 '
 
 test_expect_success 'setup .git file for sm2' '
-	(cd sm2 &&
-	 REAL="$(pwd)/../.real" &&
-	 mv .git "$REAL" &&
-	 echo "gitdir: $REAL" >.git)
+	git submodule absorbgitdirs sm2
 '
 
 test_expect_success 'diff --submodule=diff with .git file' '
 	git diff --submodule=diff HEAD^ >actual &&
 	cat >expected <<-EOF &&
+	diff --git a/.gitmodules b/.gitmodules
+	new file mode 100644
+	index 1234567..89abcde
+	--- /dev/null
+	+++ b/.gitmodules
+	@@ -0,0 +1,3 @@
+	+[submodule "sm2"]
+	+path = sm2
+	+url = bogus_url
 	Submodule sm1 $head7...0000000 (submodule deleted)
 	Submodule sm2 0000000...$head9 (new submodule)
 	diff --git a/sm2/foo8 b/sm2/foo8
@@ -757,6 +779,19 @@ test_expect_success 'diff --submodule=diff with .git file' '
 	diff_cmp expected actual
 '
 
+mv sm2 sm2-bak
+
+test_expect_success 'deleted submodule with .git file' '
+	git diff-index -p --submodule=diff HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm1 $head7...0000000 (submodule deleted)
+	Submodule sm2 $head9...0000000 (submodule deleted)
+	EOF
+	diff_cmp expected actual
+'
+
+mv sm2-bak sm2
+
 test_expect_success 'setup nested submodule' '
 	git submodule add -f ./sm2 &&
 	git commit -a -m "add sm2" &&
-- 
2.11.GIT

