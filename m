Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F3BE1F576
	for <e@80x24.org>; Thu,  1 Mar 2018 10:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967577AbeCAKvk (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 05:51:40 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:41819 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967595AbeCAKvZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 05:51:25 -0500
Received: from lindisfarne.localdomain ([92.22.16.137])
        by smtp.talktalk.net with SMTP
        id rLnoeYfgY59cnrLnzexaGV; Thu, 01 Mar 2018 10:51:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1519901480;
        bh=BbB5Iwmjucr5OD0+0d6qpeboUjDL1yHtD3kgVhn7cao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=Ugg3Yv7zZdvq5i2u1W0rLZ2ZHi/KHn/r5OCKBHKA+AqAK1gsVfFNiOZWaXJEB0fsn
         Mmi9OsPOGQqd5YLHPVF89iSuzPjIDmeMklJ92pCnJXPKTb50yL6OVyOejoSffTIF4q
         KOgkmG6DhOQkZ9TbLoz+ZSVFCMQ8axH1FYq6k/O4=
X-Originating-IP: [92.22.16.137]
X-Spam: 0
X-OAuthority: v=2.3 cv=Yr8hubQX c=1 sm=1 tr=0 a=nWy375ASyxHoIYnPohIYMA==:117
 a=nWy375ASyxHoIYnPohIYMA==:17 a=evINK-nbAAAA:8 a=btPmDDSnAHUVDtEEeN8A:9
 a=z2bXthiuOIam2nBN:21 a=hEE-zIYjV4AsxFf3:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 9/9] add -p: don't rely on apply's '--recount' option
Date:   Thu,  1 Mar 2018 10:51:03 +0000
Message-Id: <20180301105103.24268-10-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180301105103.24268-1-phillip.wood@talktalk.net>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
 <20180301105103.24268-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfIMoawzzOP79XO5ZfGXbjOzuR+gQX+nYe6xg5Qyqr+yeTI9bfg+BJH/iV68LUJm1e84haXt0Y2riaW115SbITHA6kaSY3+bpO+Cu679wBpvWm4csEcW5
 R9GHJfWMMnYQhQmrx57QpvSZVD440NDdNvBV06jAV2dAikFXN0FoOWKiT5sHDbo1zwXKuv510TMSp+eECgUnc37xAryFM4byyo1a/4EXRFAzDuFeAM3RqoMc
 GLR25VI8B+/iFv3Iwmp2XVlM+CVZto4h65R3/zLwgDUUx5awiQaQOaP+0i6r1Oax8Zf1STYkhoSv1auvlfhGsPQMOWT8+SEIBzEIdT3z3Zg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Now that add -p counts patches properly it should be possible to turn
off the '--recount' option when invoking 'git apply'

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Notes:
    I can't think of a reason why this shouldn't be OK but I can't help
    feeling slightly nervous about it. I've made it a separate patch so it
    can be easily dropped or reverted if I've missed something.

 git-add--interactive.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 3226c2c4f0..a64c0db57d 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -677,7 +677,7 @@ sub add_untracked_cmd {
 sub run_git_apply {
 	my $cmd = shift;
 	my $fh;
-	open $fh, '| git ' . $cmd . " --recount --allow-overlap";
+	open $fh, '| git ' . $cmd . " --allow-overlap";
 	print $fh @_;
 	return close $fh;
 }
-- 
2.16.1

