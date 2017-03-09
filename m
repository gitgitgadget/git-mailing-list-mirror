Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B43BD1FBEC
	for <e@80x24.org>; Thu,  9 Mar 2017 09:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753516AbdCIJyW (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 04:54:22 -0500
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:40988
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752657AbdCIJyN (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Mar 2017 04:54:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1489053181;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=kGyLpAeqrQxuaJhJVq6b68DKD5/mlryYEFQtMmYK8eY=;
        b=ZgCbrIXC7l68tYHCL148Z7v6+gAJ4ahUGXspAex3LIVsMD5ATKWFVO44cefgaiGr
        k5yitGVqb1evX+8fmNWKIX3gT0Whhb7+Evg4rePZ80IkZj4CPtszZYEXaQ99OlI1fpj
        vKm3lKAxyer3kKZEly76wh5+Iy19UZEboWVQzGPw=
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015ab27c6633-c61f56f2-0504-4af3-badc-34246cf635aa-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015ab26fcf13-1659be12-a85c-47be-9a77-8f1b0b8a3897-000000@eu-west-1.amazonses.com>
References: <0102015ab26fcf13-1659be12-a85c-47be-9a77-8f1b0b8a3897-000000@eu-west-1.amazonses.com>
Subject: [PATCH v2] t2027: avoid using pipes
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Thu, 9 Mar 2017 09:53:01 +0000
X-SES-Outgoing: 2017.03.09-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Whenever a git command is present in the upstream of a pipe, its failure
gets masked by piping and hence it should be avoided for testing the
upstream git command. By writing out the output of the git command to
a file, we can test the exit codes of both the commands as a failure exit
code in any command is able to stop the && chain.

Signed-off-by: Prathamesh <pc44800@gmail.com>
---
 t/t2027-worktree-list.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
index 848da5f..daa7a04 100755
--- a/t/t2027-worktree-list.sh
+++ b/t/t2027-worktree-list.sh
@@ -31,7 +31,7 @@ test_expect_success '"list" all worktrees from main' '
 	test_when_finished "rm -rf here && git worktree prune" &&
 	git worktree add --detach here master &&
 	echo "$(git -C here rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD)" >>expect &&
-	git worktree list | sed "s/  */ /g" >actual &&
+	git worktree list >out && sed "s/  */ /g" <out >actual &&
 	test_cmp expect actual
 '
 
@@ -40,7 +40,7 @@ test_expect_success '"list" all worktrees from linked' '
 	test_when_finished "rm -rf here && git worktree prune" &&
 	git worktree add --detach here master &&
 	echo "$(git -C here rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD)" >>expect &&
-	git -C here worktree list | sed "s/  */ /g" >actual &&
+	git -C here worktree list >out && sed "s/  */ /g" <out >actual &&
 	test_cmp expect actual
 '
 
@@ -73,7 +73,7 @@ test_expect_success '"list" all worktrees from bare main' '
 	git -C bare1 worktree add --detach ../there master &&
 	echo "$(pwd)/bare1 (bare)" >expect &&
 	echo "$(git -C there rev-parse --show-toplevel) $(git -C there rev-parse --short HEAD) (detached HEAD)" >>expect &&
-	git -C bare1 worktree list | sed "s/  */ /g" >actual &&
+	git -C bare1 worktree list >out && sed "s/  */ /g" <out >actual &&
 	test_cmp expect actual
 '
 
@@ -96,7 +96,7 @@ test_expect_success '"list" all worktrees from linked with a bare main' '
 	git -C bare1 worktree add --detach ../there master &&
 	echo "$(pwd)/bare1 (bare)" >expect &&
 	echo "$(git -C there rev-parse --show-toplevel) $(git -C there rev-parse --short HEAD) (detached HEAD)" >>expect &&
-	git -C there worktree list | sed "s/  */ /g" >actual &&
+	git -C there worktree list >out && sed "s/  */ /g" <out >actual &&
 	test_cmp expect actual
 '
 
@@ -118,9 +118,9 @@ test_expect_success 'broken main worktree still at the top' '
 		cd linked &&
 		echo "worktree $(pwd)" >expected &&
 		echo "ref: .broken" >../.git/HEAD &&
-		git worktree list --porcelain | head -n 3 >actual &&
+		git worktree list --porcelain >out && head -n 3 out >actual &&
 		test_cmp ../expected actual &&
-		git worktree list | head -n 1 >actual.2 &&
+		git worktree list >out && head -n 1 out >actual.2 &&
 		grep -F "(error)" actual.2
 	)
 '
@@ -134,7 +134,7 @@ test_expect_success 'linked worktrees are sorted' '
 		test_commit new &&
 		git worktree add ../first &&
 		git worktree add ../second &&
-		git worktree list --porcelain | grep ^worktree >actual
+		git worktree list --porcelain >out && grep ^worktree out >actual
 	) &&
 	cat >expected <<-EOF &&
 	worktree $(pwd)/sorted/main

--
https://github.com/git/git/pull/336
