Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7CCD1F404
	for <e@80x24.org>; Thu,  4 Jan 2018 21:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752732AbeADVcN (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 16:32:13 -0500
Received: from mout.gmx.net ([212.227.15.19]:58094 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751952AbeADVcM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 16:32:12 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M1F72-1emX4e2nGq-00tAd8; Thu, 04
 Jan 2018 22:31:56 +0100
Date:   Thu, 4 Jan 2018 22:31:52 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Kim Gybels <kgybels@infogroep.be>,
        "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Subject: [PATCH] rebase -p: fix quoting when calling `git merge`
Message-ID: <8cafe900ce97d885c58f4a7f02e748d2ae3b02a2.1515101305.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:V1Q20p2sMCl74phZc1RP7gsduNE2cQsCV4pEBj1LYIcTmvn0cHD
 gh7XTeCP7gLtXcDKw/z5RGYO0rEkouMei8SCpRAhIe4ly+UcgspJh0OcU32urfwmhZxdjA7
 trUEKr/0udZvGC04LQ9waO/8TbqMGkPHesj7+0ok6YzhXUaOvc78J6z07UAiJ9Ye+6HumVh
 JzNz0JPPbEyEPqB0xee2g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xim+GIDC870=:oIdA75C0OebABxKA87w+W+
 kFODKizk7Iwd+TFucMJnushsXgIxBJ4SP3IGcV+qZ/JFnOrejsGWhKoY2XW3+rj9Sr2caD3Oc
 Nu0WWQF9k2QpwQ5lrwVpIK2gBg9HQFTnCUGCOjvo5fOCn6RhFoh3dq6l7++sutcQ7kD8wWCVC
 RluCjk/y6kD2vLEHkxe1xzm/eFFdPdtsB6kqKxbmaWFT5rNbfjjdeN1cU8nzdMO9GyYzAh3Px
 FnqxtWhbBEbGMBaJ56R47J0Q84Ct/FyGXPdP97TBAuhQOCchAZzjJa+Y1C3iWuYX5uO9/SUrs
 GCWZk5HeVP/II6c64CwAlk0AfU1f5qf63fudMpOD8FruxLcRdGxBWBMOp7A2iw+BJ0jA4n2+m
 qKMxe4SNp16+SX/eWqyC+nna5JIDLVj9qAVcj4qK3dk89yP4AWwLYgCMdYz04DWwLLn61wkjp
 hlXGzzovF7N2hMHYcj1/rx5JG7z0gT7g304m5X8HZMzcxjTdT9SL8hfy9w27XEaGNsCGt8X8u
 xRm4mwc+9Jvuea0GKuBdG8sO6nW4Us06LNdKjc0sM38giZnfdxq7aQS4tHoYKSxf7lrkpZu61
 0568jne88XfFhZmYrBZy5DjggQtpuLrynoW1gvYiEJ9jDzKZOmkIiejagEpUduKsYOURCHgst
 vWNDY6G34hkG26rZC+VHVDlH6oqQM88fP/8wnR+BkhMaLR1rP9UWgplCRFFDdx9wt8wLno90c
 at46bo8i93oKnIhYjqt2XngiGI7iMx7PtRer//qKwZcrVHX4SSmL6qlpIDC+BypPtG1/keTxf
 gc48k42U+CmG37mV50u3sGHN4BPAA0I6L02E4kDL90XC27+Zl8eCCmGPBRkHm6cutegyF7v
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It has been reported that strategy arguments are not passed to `git
merge` correctly when rebasing interactively, preserving merges.

The reason is that the strategy arguments are already quoted, and then
quoted again.

This fixes https://github.com/git-for-windows/git/issues/1321

Original-patch-by: Kim Gybels <kgybels@infogroep.be>
Also-reported-by: Matwey V. Kornilov <matwey.kornilov@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh |  9 ++++++---
 t/t3418-rebase-continue.sh | 14 ++++++++++++++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index e3f5a0abf3c..085aa068cbb 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -392,9 +392,12 @@ pick_one_preserving_merges () {
 			new_parents=${new_parents# $first_parent}
 			merge_args="--no-log --no-ff"
 			if ! do_with_author output eval \
-			'git merge ${gpg_sign_opt:+"$gpg_sign_opt"} \
-				$allow_rerere_autoupdate $merge_args \
-				$strategy_args -m "$msg_content" $new_parents'
+				git merge ${gpg_sign_opt:+$(git rev-parse \
+					--sq-quote "$gpg_sign_opt")} \
+				$allow_rerere_autoupdate "$merge_args" \
+				"$strategy_args" \
+				-m $(git rev-parse --sq-quote "$msg_content") \
+				"$new_parents"
 			then
 				printf "%s\n" "$msg_content" > "$GIT_DIR"/MERGE_MSG
 				die_with_patch $sha1 "$(eval_gettext "Error redoing merge \$sha1")"
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index fcfdd197bd3..7c91a85f43a 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -74,6 +74,20 @@ test_expect_success 'rebase --continue remembers merge strategy and options' '
 	test -f funny.was.run
 '
 
+test_expect_success 'rebase passes merge strategy options correctly' '
+	rm -fr .git/rebase-* &&
+	git reset --hard commit-new-file-F3-on-topic-branch &&
+	test_commit theirs-to-merge &&
+	git reset --hard HEAD^ &&
+	test_commit some-commit &&
+	test_tick &&
+	git merge --no-ff theirs-to-merge &&
+	FAKE_LINES="1 edit 2 3" git rebase -i -f -p -m \
+		-s recursive --strategy-option=theirs HEAD~2 &&
+	test_commit force-change &&
+	git rebase --continue
+'
+
 test_expect_success 'setup rerere database' '
 	rm -fr .git/rebase-* &&
 	git reset --hard commit-new-file-F3-on-topic-branch &&

base-commit: 1eaabe34fc6f486367a176207420378f587d3b48
-- 
2.15.1.windows.2.391.g0b42e3c56de

Published-As: https://github.com/dscho/git/releases/tag/rebase-strategy-opts-v1
Fetch-It-Via: git fetch https://github.com/dscho/git rebase-strategy-opts-v1
