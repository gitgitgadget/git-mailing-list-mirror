Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EA9C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 17:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6F9261102
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 17:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhHBRAc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 13:00:32 -0400
Received: from beige.elm.relay.mailchannels.net ([23.83.212.16]:14762 "EHLO
        beige.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229640AbhHBRAb (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 2 Aug 2021 13:00:31 -0400
X-Sender-Id: dreamhost|x-authsender|novalis@novalis.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id DAEC33432A0;
        Mon,  2 Aug 2021 17:00:20 +0000 (UTC)
Received: from pdx1-sub0-mail-a13.g.dreamhost.com (100-96-18-112.trex-nlb.outbound.svc.cluster.local [100.96.18.112])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id B07423433FA;
        Mon,  2 Aug 2021 17:00:19 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|novalis@novalis.org
Received: from pdx1-sub0-mail-a13.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.96.18.112 (trex/6.3.3);
        Mon, 02 Aug 2021 17:00:20 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|novalis@novalis.org
X-MailChannels-Auth-Id: dreamhost
X-Relation-Coil: 3b2c650373c9edfd_1627923620525_396051373
X-MC-Loop-Signature: 1627923620525:685706595
X-MC-Ingress-Time: 1627923620524
Received: from pdx1-sub0-mail-a13.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a13.g.dreamhost.com (Postfix) with ESMTP id 2DE83806B9;
        Mon,  2 Aug 2021 10:00:17 -0700 (PDT)
Received: from corey.lan (unknown [98.113.183.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by pdx1-sub0-mail-a13.g.dreamhost.com (Postfix) with ESMTPSA id B0885806B4;
        Mon,  2 Aug 2021 10:00:15 -0700 (PDT)
X-DH-BACKEND: pdx1-sub0-mail-a13
From:   David Turner <dturner@twosigma.com>
To:     git@vger.kernel.org, novalis@novalis.org
Cc:     David Turner <dturner@twosigma.com>
Subject: [PATCH v2 2/3] diff --submodule=diff: do not fail on ever-initialied deleted submodules
Date:   Mon,  2 Aug 2021 13:00:03 -0400
Message-Id: <20210802170004.4103535-2-dturner@twosigma.com>
X-Mailer: git-send-email 2.11.GIT
In-Reply-To: <20210802170004.4103535-1-dturner@twosigma.com>
References: <20210802170004.4103535-1-dturner@twosigma.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If you have ever initialized a submodule, open_submodule will open it.
If you then delete the submodule's worktree directory (but don't
remove it from .gitmodules), git diff --submodule=diff would error out
as it attempted to chdir into the now-deleted working tree directory.

Instead, we chdir into the submodule's git directory and run the diff
from there.

Signed-off-by: David Turner <dturner@twosigma.com>
---
 submodule.c                                  |  10 ++
 t/t4060-diff-submodule-option-diff-format.sh | 157 +++++++++++++++++++++++++--
 2 files changed, 160 insertions(+), 7 deletions(-)

diff --git a/submodule.c b/submodule.c
index 0b1d9c1dde..d13d103975 100644
--- a/submodule.c
+++ b/submodule.c
@@ -710,6 +710,16 @@ void show_submodule_inline_diff(struct diff_options *o, const char *path,
 		strvec_push(&cp.args, oid_to_hex(new_oid));
 
 	prepare_submodule_repo_env(&cp.env_array);
+
+	if (!is_directory(path)) {
+		// fall back to absorbed git dir, if any
+		if (!sub)
+			goto done;
+		cp.dir = sub->gitdir;
+		strvec_push(&cp.env_array, GIT_DIR_ENVIRONMENT "=.");
+		strvec_push(&cp.env_array, GIT_WORK_TREE_ENVIRONMENT "=.");
+	}
+
 	if (start_command(&cp))
 		diff_emit_submodule_error(o, "(diff failed)\n");
 
diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
index 69b9946931..82a64e0f5d 100755
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
@@ -757,9 +779,67 @@ test_expect_success 'diff --submodule=diff with .git file' '
 	diff_cmp expected actual
 '
 
+mv sm2 sm2-bak
+
+test_expect_success 'deleted submodule with .git file' '
+	git diff-index -p --submodule=diff HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm1 $head7...0000000 (submodule deleted)
+	Submodule sm2 $head9...0000000 (submodule deleted)
+	diff --git a/sm2/foo8 b/sm2/foo8
+	deleted file mode 100644
+	index 1234567..89abcde
+	--- a/sm2/foo8
+	+++ /dev/null
+	@@ -1 +0,0 @@
+	-foo8
+	diff --git a/sm2/foo9 b/sm2/foo9
+	deleted file mode 100644
+	index 1234567..89abcde
+	--- a/sm2/foo9
+	+++ /dev/null
+	@@ -1 +0,0 @@
+	-foo9
+	EOF
+	diff_cmp expected actual
+'
+
+echo submodule-to-blob>sm2
+
+test_expect_success 'typechanged(submodule->blob) submodule with .git file' '
+	git diff-index -p --submodule=diff HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm1 $head7...0000000 (submodule deleted)
+	Submodule sm2 $head9...0000000 (submodule deleted)
+	diff --git a/sm2/foo8 b/sm2/foo8
+	deleted file mode 100644
+	index 1234567..89abcde
+	--- a/sm2/foo8
+	+++ /dev/null
+	@@ -1 +0,0 @@
+	-foo8
+	diff --git a/sm2/foo9 b/sm2/foo9
+	deleted file mode 100644
+	index 1234567..89abcde
+	--- a/sm2/foo9
+	+++ /dev/null
+	@@ -1 +0,0 @@
+	-foo9
+	diff --git a/sm2 b/sm2
+	new file mode 100644
+	index 1234567..89abcde
+	--- /dev/null
+	+++ b/sm2
+	@@ -0,0 +1 @@
+	+submodule-to-blob
+	EOF
+	diff_cmp expected actual
+'
+
+rm sm2
+mv sm2-bak sm2
+
 test_expect_success 'setup nested submodule' '
-	git submodule add -f ./sm2 &&
-	git commit -a -m "add sm2" &&
 	git -C sm2 submodule add ../sm2 nested &&
 	git -C sm2 commit -a -m "nested sub" &&
 	head10=$(git -C sm2 rev-parse --short --verify HEAD)
@@ -790,6 +870,7 @@ test_expect_success 'diff --submodule=diff with moved nested submodule HEAD' '
 
 test_expect_success 'diff --submodule=diff recurses into nested submodules' '
 	cat >expected <<-EOF &&
+	Submodule sm1 17243c9...0000000 (submodule deleted)
 	Submodule sm2 contains modified content
 	Submodule sm2 $head9..$head10:
 	diff --git a/sm2/.gitmodules b/sm2/.gitmodules
@@ -829,4 +910,66 @@ test_expect_success 'diff --submodule=diff recurses into nested submodules' '
 	diff_cmp expected actual
 '
 
+(cd sm2; commit_file nested)
+commit_file sm2
+
+mv sm2 sm2-bak
+
+test_expect_success 'diff --submodule=diff recurses into deleted nested submodules' '
+	cat >expected <<-EOF &&
+	Submodule sm1 17243c9...0000000 (submodule deleted)
+	Submodule sm2 67d632f...0000000 (submodule deleted)
+	diff --git a/sm2/.gitmodules b/sm2/.gitmodules
+	deleted file mode 100644
+	index 3a816b8..0000000
+	--- a/sm2/.gitmodules
+	+++ /dev/null
+	@@ -1,3 +0,0 @@
+	-[submodule "nested"]
+	-	path = nested
+	-	url = ../sm2
+	diff --git a/sm2/foo8 b/sm2/foo8
+	deleted file mode 100644
+	index db9916b..0000000
+	--- a/sm2/foo8
+	+++ /dev/null
+	@@ -1 +0,0 @@
+	-foo8
+	diff --git a/sm2/foo9 b/sm2/foo9
+	deleted file mode 100644
+	index 9c3b4f6..0000000
+	--- a/sm2/foo9
+	+++ /dev/null
+	@@ -1 +0,0 @@
+	-foo9
+	Submodule nested b55928c...0000000 (submodule deleted)
+	diff --git a/sm2/nested/file b/sm2/nested/file
+	deleted file mode 100644
+	index ca281f5..0000000
+	--- a/sm2/nested/file
+	+++ /dev/null
+	@@ -1 +0,0 @@
+	-nested content
+	diff --git a/sm2/nested/foo8 b/sm2/nested/foo8
+	deleted file mode 100644
+	index db9916b..0000000
+	--- a/sm2/nested/foo8
+	+++ /dev/null
+	@@ -1 +0,0 @@
+	-foo8
+	diff --git a/sm2/nested/foo9 b/sm2/nested/foo9
+	deleted file mode 100644
+	index 9c3b4f6..0000000
+	--- a/sm2/nested/foo9
+	+++ /dev/null
+	@@ -1 +0,0 @@
+	-foo9
+	EOF
+	git diff --submodule=diff >actual 2>err &&
+	test_must_be_empty err &&
+	diff_cmp expected actual
+'
+
+mv sm2-bak sm2
+
 test_done
-- 
2.11.GIT

