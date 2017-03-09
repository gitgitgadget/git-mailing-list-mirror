Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7196F1FBEC
	for <e@80x24.org>; Thu,  9 Mar 2017 09:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753734AbdCIJki (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 04:40:38 -0500
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:57166
        "EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753516AbdCIJke (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Mar 2017 04:40:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1489052356;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=ATnxaCNZyKv2hy8HR77S4LPjXTT5WD8YEPMHJeTMbT0=;
        b=KB3V1sZYc9S1NAYR8DNodFZXIwahPrdAP+B84IEklSqEwl80INZ1mkWkY0BbCwpl
        GdHzxzGvLNf7/C9Vu06q9TbWZPa9sxp4hHAYi26rvuJM4a7nH27GNPNNEY3rhFUptq9
        VYwyMRE8TQKmdxlZ6M22PBeMbYetr2tqf3CfFUy0=
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015ab26fcf13-1659be12-a85c-47be-9a77-8f1b0b8a3897-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015aae7b8536-00c57d0a-1d48-4153-a202-87c4ea9e0e19-000000@eu-west-1.amazonses.com>
References: <0102015aae7b8536-00c57d0a-1d48-4153-a202-87c4ea9e0e19-000000@eu-west-1.amazonses.com>
Subject: [PATCH v2] t2027: avoid using pipes
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Thu, 9 Mar 2017 09:39:16 +0000
X-SES-Outgoing: 2017.03.09-54.240.7.18
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The exit code of the upstream of a pipe is ignored thus we should avoid
using it. By writing out the output of the git command to a file, we
can test the exit codes of both the commands.

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
