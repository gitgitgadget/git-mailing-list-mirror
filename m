Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D98D71F453
	for <e@80x24.org>; Thu, 25 Oct 2018 20:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbeJZFWE (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 01:22:04 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:38269 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbeJZFWD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 01:22:03 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 42gzhy67pmz5tmJ;
        Thu, 25 Oct 2018 22:47:46 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id B1BBD130;
        Thu, 25 Oct 2018 22:47:45 +0200 (CEST)
Subject: [PATCH 3/2] rebase -i: recognize short commands without arguments
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.43.v2.git.gitgitgadget@gmail.com>
 <pull.43.v3.git.gitgitgadget@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <fff6fec5-88c9-4125-bf51-5e96e34bf1f6@kdbg.org>
Date:   Thu, 25 Oct 2018 22:47:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <pull.43.v3.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sequencer instruction 'b', short for 'break', is rejected:

  error: invalid line 2: b

The reason is that the parser expects all short commands to have
an argument. Permit short commands without arguments.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 I'll send a another patch in a moment that tests all short
 sequencer commands, but it is independent from this topic.

 sequencer.c                | 3 ++-
 t/lib-rebase.sh            | 2 +-
 t/t3418-rebase-continue.sh | 4 +++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index ee3961ec63..3107f59ea7 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1954,7 +1954,8 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 		if (skip_prefix(bol, todo_command_info[i].str, &bol)) {
 			item->command = i;
 			break;
-		} else if (bol[1] == ' ' && *bol == todo_command_info[i].c) {
+		} else if ((bol + 1 == eol || bol[1] == ' ') &&
+			   *bol == todo_command_info[i].c) {
 			bol++;
 			item->command = i;
 			break;
diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 584604ee63..86572438ec 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -49,7 +49,7 @@ set_fake_editor () {
 		case $line in
 		squash|fixup|edit|reword|drop)
 			action="$line";;
-		exec*|break)
+		exec*|break|b)
 			echo "$line" | sed 's/_/ /g' >> "$1";;
 		"#")
 			echo '# comment' >> "$1";;
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 185a491089..b282505aac 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -243,7 +243,9 @@ unset GIT_SEQUENCE_EDITOR
 
 test_expect_success 'the todo command "break" works' '
 	rm -f execed &&
-	FAKE_LINES="break exec_>execed" git rebase -i HEAD &&
+	FAKE_LINES="break b exec_>execed" git rebase -i HEAD &&
+	test_path_is_missing execed &&
+	git rebase --continue &&
 	test_path_is_missing execed &&
 	git rebase --continue &&
 	test_path_is_file execed
-- 
2.19.1.406.g1aa3f475f3
