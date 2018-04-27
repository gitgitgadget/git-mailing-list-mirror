Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 422831F424
	for <e@80x24.org>; Fri, 27 Apr 2018 22:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932947AbeD0Wbf (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 18:31:35 -0400
Received: from mout.gmx.net ([212.227.17.20]:43565 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932940AbeD0Wbe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 18:31:34 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LraSn-1eFWNo47OX-013NRL; Sat, 28 Apr 2018 00:31:30 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Wink Saville <wink@saville.com>
Subject: [PATCH 3/6] rebase -i --root: let the sequencer handle even the initial part
Date:   Sat, 28 Apr 2018 00:31:22 +0200
Message-Id: <1c8740eaa916351832cbea4cf75b77e5dc965db8.1524868165.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524868165.git.johannes.schindelin@gmx.de>
References: <cover.1524868165.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:OCOLGZkInENZ2AfbMsXD5eh8GgmSDEiyEBEknw2UYaMRnhrdDk/
 v3oaxlmGB+mJ0N17XQCKaSghB7BALFj3HkIjWnqn5jOFh3juv5jZC3K2tGttAwcTIn0LwRB
 F9FU5HH4LgvHdRhfbmKO4s3ba84sYqoubsJfnbi3BvS+vAJ296CmFk3e1CGmQha1WPU+jUW
 cuIvCZI0cTfHZ6e9PE15Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1utqirjwBdk=:Io1HH8zWTWn9pL0xTG+Vn9
 XIdUONrFgHByiuQ5lgiFlfO6FH2ApSLMPHUlHzlOrTpbDh1us3/R273AVHULuUh1r0GlCZhVT
 wk+Ejf6ScKmrps/GPQAFbIEINhsnKQm62/xhdgs1vxMZ/VXKGIJ8ywi5DnUT3e17LS2v0KNoL
 H6eZOSAG0Or04HO3KgNi9pY/zzicf1K/tkFCbxMeIEYXkmZUYRK1nZw9sWnzfuzJZENfJgJrH
 FZHdTkvOhD70xkys4cTwnLR72FS6F9vOtK6vhQU5w1OBYT8DFbTc8tiOXrBTUyo/E/5DusgY7
 TE7Dk1K/430DcivSymEf7boQmXiawDzhl0aFN+H+X/qCTzwV7hmmR6aHFJ6NjgOETcmCJFkWC
 Vbs/IBCefzOSEe/A+dpRQ4V3nPOhvsAFMmytgbbTvCHh+eV3+aM5GbojPxF4X6gVxKhKyXvKs
 OIrbGX8rbr79C/S/+bMw2oaz5ygFOSaQnJSem8ciWYeZ4w2LwEM5pzRFA91qJ3ydAznSP6ckc
 ZXFESKqrt8PRBJPNwnZ5c/VqD6Skv7FMSMZBvWbuNjwty0wzn+sC6t1YSY5pIeFtD4HUFbNMR
 YxB2pwzDE4i1lwFUJehoGEh/DN4IxUqps8HXscUS7vSpsxMy3P9OR0ErlnoUWAqVq+r/87NvF
 rv9MOmq4NGGQUrQKXGnA9ZV9tP/BrG3H0cvftrinfnv4u6Q46ON1YcH8TmEhwcDhsJ9hrNutY
 ZxziJp6190w0jirqcd6tne7yWA2t45V2+3hoYURIXoeaNvaXWdzGfHXOOQwYAJ7b4vbf1Ryqm
 14J4Uej
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In this developer's earlier attempt to accelerate interactive rebases by
converting large parts from Unix shell script into portable, performant
C, the --root handling was specifically excluded (to simplify the task a
little bit; it still took over a year to get that reduced set of patches
into Git proper).

This patch ties up that loose end: now only --preserve-merges uses the
slow Unix shell script implementation to perform the interactive rebase.

As the rebase--helper reports progress to stderr (unlike the scripted
interactive rebase, which reports it to stdout, of all places), we have
to adjust a couple of tests that did not expect that for `git rebase -i
--root`.

This patch fixes -- at long last! -- the really old bug reported in
6a6bc5bdc4d (add tests for rebasing root, 2013-06-06) that rebasing with
--root *always* rewrote the root commit, even if there were no changes.

The bug still persists in --preserve-merges mode, of course, but that
mode will be deprecated as soon as the new --rebase-merges mode
stabilizes, anyway.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh        |  4 +++-
 t/t3404-rebase-interactive.sh     | 19 +++++++++++++------
 t/t3421-rebase-topology-linear.sh |  6 +++---
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index cbf44f86482..2f4941d0fc9 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -894,6 +894,8 @@ init_revisions_and_shortrevisions () {
 	else
 		revisions=$onto...$orig_head
 		shortrevisions=$shorthead
+		test -z "$squash_onto" ||
+		echo "$squash_onto" >"$state_dir"/squash-onto
 	fi
 }
 
@@ -948,7 +950,7 @@ EOF
 	die "Could not skip unnecessary pick commands"
 
 	checkout_onto
-	if test -z "$rebase_root" && test ! -d "$rewritten"
+	if test ! -d "$rewritten"
 	then
 		require_clean_work_tree "rebase"
 		exec git rebase--helper ${force_rebase:+--no-ff} $allow_empty_message \
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 59c766540e5..c65826ddace 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1204,10 +1204,6 @@ test_expect_success 'drop' '
 	test A = $(git cat-file commit HEAD^^ | sed -ne \$p)
 '
 
-cat >expect <<EOF
-Successfully rebased and updated refs/heads/missing-commit.
-EOF
-
 test_expect_success 'rebase -i respects rebase.missingCommitsCheck = ignore' '
 	test_config rebase.missingCommitsCheck ignore &&
 	rebase_setup_and_clean missing-commit &&
@@ -1215,7 +1211,9 @@ test_expect_success 'rebase -i respects rebase.missingCommitsCheck = ignore' '
 	FAKE_LINES="1 2 3 4" \
 		git rebase -i --root 2>actual &&
 	test D = $(git cat-file commit HEAD | sed -ne \$p) &&
-	test_i18ncmp expect actual
+	test_i18ngrep \
+		"Successfully rebased and updated refs/heads/missing-commit" \
+		actual
 '
 
 cat >expect <<EOF
@@ -1227,15 +1225,24 @@ To avoid this message, use "drop" to explicitly remove a commit.
 Use 'git config rebase.missingCommitsCheck' to change the level of warnings.
 The possible behaviours are: ignore, warn, error.
 
+Rebasing (1/4)
+Rebasing (2/4)
+Rebasing (3/4)
+Rebasing (4/4)
 Successfully rebased and updated refs/heads/missing-commit.
 EOF
 
+cr_to_nl () {
+	tr '\015' '\012'
+}
+
 test_expect_success 'rebase -i respects rebase.missingCommitsCheck = warn' '
 	test_config rebase.missingCommitsCheck warn &&
 	rebase_setup_and_clean missing-commit &&
 	set_fake_editor &&
 	FAKE_LINES="1 2 3 4" \
-		git rebase -i --root 2>actual &&
+		git rebase -i --root 2>actual.2 &&
+	cr_to_nl <actual.2 >actual &&
 	test_i18ncmp expect actual &&
 	test D = $(git cat-file commit HEAD | sed -ne \$p)
 '
diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
index e7438ad06ac..99b2aac9219 100755
--- a/t/t3421-rebase-topology-linear.sh
+++ b/t/t3421-rebase-topology-linear.sh
@@ -328,9 +328,9 @@ test_run_rebase () {
 		test_cmp_rev c HEAD
 	"
 }
-test_run_rebase failure ''
-test_run_rebase failure -m
-test_run_rebase failure -i
+test_run_rebase success ''
+test_run_rebase success -m
+test_run_rebase success -i
 test_run_rebase failure -p
 
 test_run_rebase () {
-- 
2.17.0.windows.1.33.gfcbb1fa0445


