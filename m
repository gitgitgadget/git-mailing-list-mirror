Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1DFD1F991
	for <e@80x24.org>; Wed,  2 Aug 2017 10:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752882AbdHBKpC (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 06:45:02 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:4216 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752632AbdHBKov (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 06:44:51 -0400
Received: from lindisfarne.localdomain ([92.22.28.33])
        by smtp.talktalk.net with SMTP
        id cr8nd8nSUiSHacr8zdwio1; Wed, 02 Aug 2017 11:44:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1501670690; bh=V8gm1yHTfgJ2/7ZVt0R5+WVHht93VgVx3ryB9yKnu98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=hcAmHEle1u/WvpwOv/fPx76HCKM65q+x/932sKn1gXZtnoV9UDOHr6oXp3NsoTwcJ
         4j6DaC5ROJVDXVD0RS2S60KsrDDWIQFs4X5jDb+5CreZeq09R8yLRu8gkkdd68nhic
         mJKeeMcnOuIUzo84CIdfeTgWwsfvOaEiYUm2HJkU=
X-Originating-IP: [92.22.28.33]
X-Spam: 0
X-OAuthority: v=2.2 cv=UoATD64B c=1 sm=1 tr=0 a=BeSdjzhxhZnKGFP9cxuqMA==:117
 a=BeSdjzhxhZnKGFP9cxuqMA==:17 a=evINK-nbAAAA:8 a=ybZZDoGAAAAA:8
 a=TFI1dL8njlTN7UusS84A:9 a=6yDAeypQnEwp4k4m:21 a=qCjG1D5TqGipxbua:21
 a=RfR_gqz1fSpA9VikTjo0:22 a=0RhZnL1DYvcuLYC8JZ5M:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 3/6] rebase -i: honor --rerere-autoupdate
Date:   Wed,  2 Aug 2017 11:44:17 +0100
Message-Id: <20170802104420.12809-4-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20170802104420.12809-1-phillip.wood@talktalk.net>
References: <20170802104420.12809-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfGFgNDPmHmHxbaa6KO3FNj8ydScWMeFLeEPctnOWT+5K227wVrwj9LUGxnVnV+YNfx6QyJB5omdtwrUczAQ1isL599QPrsA5edWE8No8x8QjLQIoD5wW
 aFJQqdyryPuocn5IzV/Puv5q2pn4kF0H7hYRZXmEJQEvV/TkkHCYnGeL0xGaQmt/Hm0woWjhZ8DxhP4q9cSXzieCcslf1E2ppIdVEg+fd5nBTap6BaZWREna
 99E2GIwkZGPiazsOy5QyXA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Interactive rebase was ignoring '--rerere-autoupdate'. Fix this by
reading it appropriate file when restoring the sequencer state for an
interactive rebase and passing '--rerere-autoupdate' to merge and
cherry-pick when rebasing with '--preserve-merges'.

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 git-rebase--interactive.sh |  7 ++++---
 sequencer.c                | 10 ++++++++++
 t/t3418-rebase-continue.sh |  3 +++
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 90b1fbe9cf6e8dfb2f4331916809fa40bf9050d2..29b7e8824b53abeaa68780b95d5954f67f734098 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -281,7 +281,7 @@ pick_one () {
 
 	test -d "$rewritten" &&
 		pick_one_preserving_merges "$@" && return
-	output eval git cherry-pick \
+	output eval git cherry-pick $allow_rerere_autoupdate \
 			${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")} \
 			"$strategy_args" $empty_args $ff "$@"
 
@@ -393,7 +393,8 @@ pick_one_preserving_merges () {
 			merge_args="--no-log --no-ff"
 			if ! do_with_author output eval \
 			'git merge ${gpg_sign_opt:+"$gpg_sign_opt"} \
-				$merge_args $strategy_args -m "$msg_content" $new_parents'
+				$allow_rerere_autoupdate $merge_args \
+				$strategy_args -m "$msg_content" $new_parents'
 			then
 				printf "%s\n" "$msg_content" > "$GIT_DIR"/MERGE_MSG
 				die_with_patch $sha1 "$(eval_gettext "Error redoing merge \$sha1")"
@@ -401,7 +402,7 @@ pick_one_preserving_merges () {
 			echo "$sha1 $(git rev-parse HEAD^0)" >> "$rewritten_list"
 			;;
 		*)
-			output eval git cherry-pick \
+			output eval git cherry-pick $allow_rerere_autoupdate \
 				${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")} \
 				"$strategy_args" "$@" ||
 				die_with_patch $sha1 "$(eval_gettext "Could not pick \$sha1")"
diff --git a/sequencer.c b/sequencer.c
index 3010faf86398697469e903318a35421d911acb23..7dc0670d902291b8054072d32cc0c8979c13598c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -127,6 +127,7 @@ static GIT_PATH_FUNC(rebase_path_onto, "rebase-merge/onto")
 static GIT_PATH_FUNC(rebase_path_autostash, "rebase-merge/autostash")
 static GIT_PATH_FUNC(rebase_path_strategy, "rebase-merge/strategy")
 static GIT_PATH_FUNC(rebase_path_strategy_opts, "rebase-merge/strategy_opts")
+static GIT_PATH_FUNC(rebase_path_allow_rerere_autoupdate, "rebase-merge/allow_rerere_autoupdate")
 
 static inline int is_rebase_i(const struct replay_opts *opts)
 {
@@ -1479,6 +1480,15 @@ static int read_populate_opts(struct replay_opts *opts)
 				free(opts->gpg_sign);
 				opts->gpg_sign = xstrdup(buf.buf + 2);
 			}
+			strbuf_reset(&buf);
+		}
+
+		if (read_oneliner(&buf, rebase_path_allow_rerere_autoupdate(), 1)) {
+			if (!strcmp(buf.buf, "--rerere-autoupdate"))
+				opts->allow_rerere_auto = RERERE_AUTOUPDATE;
+			else if (!strcmp(buf.buf, "--no-rerere-autoupdate"))
+				opts->allow_rerere_auto = RERERE_NOAUTOUPDATE;
+			strbuf_reset(&buf);
 		}
 
 		if (file_exists(rebase_path_verbose()))
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 2b746f1559ad21a5ebf3bebd726c9a1b3d071c5a..fcfdd197bd352a9dca10233c2ba6d2aa4a66149e 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -141,5 +141,8 @@ test_rerere_autoupdate () {
 
 test_rerere_autoupdate
 test_rerere_autoupdate -m
+GIT_SEQUENCE_EDITOR=: && export GIT_SEQUENCE_EDITOR
+test_rerere_autoupdate -i
+test_rerere_autoupdate --preserve-merges
 
 test_done
-- 
2.13.3

