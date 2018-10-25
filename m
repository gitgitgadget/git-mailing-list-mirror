Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E674B1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 20:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbeJZF3F (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 01:29:05 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:37038 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbeJZF3F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 01:29:05 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 42gzs320ylz5tll;
        Thu, 25 Oct 2018 22:54:47 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id E9E10256;
        Thu, 25 Oct 2018 22:54:46 +0200 (CEST)
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH sg/test-rebase-editor-fix] t3404-rebase-interactive: test
 abbreviated commands
Message-ID: <94c0b5b6-ac31-101b-80a0-ac78196e0f62@kdbg.org>
Date:   Thu, 25 Oct 2018 22:54:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test each short command at least once. The commands changed here
are chosen such that

- tests do not have a prerequisite,
- the 'git rebase' command is not guarded by test_must_fail.

The pick commands are optional noise words in the FAKE_LINES
variable. Test them, too.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 This patch must be placed on top of sg/test-rebase-editor-fix.
 It has a textual conflict with my sequencer 'b' fix from some
 minutes ago, but the resolution should be obvious:

 - 		exec*|break|b)
  -		exec_*|x_*)
 ++		exec_*|x_*|break|b)

 t/lib-rebase.sh               |  4 ++--
 t/t3404-rebase-interactive.sh | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 2ca9fb69d6..0c93d00bdd 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -47,9 +47,9 @@ set_fake_editor () {
 	action=pick
 	for line in $FAKE_LINES; do
 		case $line in
-		pick|squash|fixup|edit|reword|drop)
+		pick|p|squash|s|fixup|f|edit|e|reword|r|drop|d)
 			action="$line";;
-		exec*)
+		exec_*|x_*)
 			echo "$line" | sed 's/_/ /g' >> "$1";;
 		"#")
 			echo '# comment' >> "$1";;
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 352a52e59d..d36ee4f807 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -114,7 +114,7 @@ test_expect_success 'rebase -i with exec allows git commands in subdirs' '
 	git checkout master &&
 	mkdir subdir && (cd subdir &&
 	set_fake_editor &&
-	FAKE_LINES="1 exec_cd_subdir_&&_git_rev-parse_--is-inside-work-tree" \
+	FAKE_LINES="1 x_cd_subdir_&&_git_rev-parse_--is-inside-work-tree" \
 		git rebase -i HEAD^
 	)
 '
@@ -499,7 +499,7 @@ test_expect_success 'squash works as expected' '
 	git checkout -b squash-works no-conflict-branch &&
 	one=$(git rev-parse HEAD~3) &&
 	set_fake_editor &&
-	FAKE_LINES="1 squash 3 2" EXPECT_HEADER_COUNT=2 \
+	FAKE_LINES="1 s 3 2" EXPECT_HEADER_COUNT=2 \
 		git rebase -i HEAD~3 &&
 	test $one = $(git rev-parse HEAD~2)
 '
@@ -732,7 +732,7 @@ test_expect_success 'reword' '
 	git show HEAD^ | grep "D changed" &&
 	FAKE_LINES="reword 1 2 3 4" FAKE_COMMIT_MESSAGE="B changed" git rebase -i A &&
 	git show HEAD~3 | grep "B changed" &&
-	FAKE_LINES="1 reword 2 3 4" FAKE_COMMIT_MESSAGE="C changed" git rebase -i A &&
+	FAKE_LINES="1 r 2 pick 3 p 4" FAKE_COMMIT_MESSAGE="C changed" git rebase -i A &&
 	git show HEAD~2 | grep "C changed"
 '
 
@@ -758,7 +758,7 @@ test_expect_success 'rebase -i can copy notes over a fixup' '
 	git reset --hard n3 &&
 	git notes add -m"an earlier note" n2 &&
 	set_fake_editor &&
-	GIT_NOTES_REWRITE_MODE=concatenate FAKE_LINES="1 fixup 2" git rebase -i n1 &&
+	GIT_NOTES_REWRITE_MODE=concatenate FAKE_LINES="1 f 2" git rebase -i n1 &&
 	git notes show > output &&
 	test_cmp expect output
 '
@@ -1208,7 +1208,7 @@ rebase_setup_and_clean () {
 test_expect_success 'drop' '
 	rebase_setup_and_clean drop-test &&
 	set_fake_editor &&
-	FAKE_LINES="1 drop 2 3 drop 4 5" git rebase -i --root &&
+	FAKE_LINES="1 drop 2 3 d 4 5" git rebase -i --root &&
 	test E = $(git cat-file commit HEAD | sed -ne \$p) &&
 	test C = $(git cat-file commit HEAD^ | sed -ne \$p) &&
 	test A = $(git cat-file commit HEAD^^ | sed -ne \$p)
-- 
2.19.1.406.g1aa3f475f3
