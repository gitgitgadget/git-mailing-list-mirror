Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22CE11F43C
	for <e@80x24.org>; Fri, 10 Nov 2017 11:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752751AbdKJLKI (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 06:10:08 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:48847 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752585AbdKJLKG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 06:10:06 -0500
Received: from lindisfarne.localdomain ([92.22.30.94])
        by smtp.talktalk.net with SMTP
        id D7C7etmv6mITaD7CGeDJkv; Fri, 10 Nov 2017 11:10:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1510312204;
        bh=EWLLel6iLTLnUKdlJZSeE8MIR9gC6bHqi56xJvtnxAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=o/jffEMcNCCFzhfygZvJViNZ6SY/ifweOvJfhISSA7iLlMCkotVuSxXHf98wlOpo0
         Byd1s0/RcwZ97yNa+5W5AOik5z0tUH32n/t5Q/tJ7/nX+pMbcuGXqvk9025J35Lssx
         4SAXMV6Z+kZWC2tApRpEFJHOTfrsf4/sOb/cxhho=
X-Originating-IP: [92.22.30.94]
X-Spam: 0
X-OAuthority: v=2.2 cv=W/RIbVek c=1 sm=1 tr=0 a=lje0BXTe3+PqU+djfnm1WA==:117
 a=lje0BXTe3+PqU+djfnm1WA==:17 a=evINK-nbAAAA:8 a=1hiMVKsh0mBqE-q75WoA:9
 a=MEzT_SyuPu8Hlan-:21 a=UsvAgxNaHALTGGpc:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 1/9] t3404: check intermediate squash messages
Date:   Fri, 10 Nov 2017 11:09:41 +0000
Message-Id: <20171110110949.328-2-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171110110949.328-1-phillip.wood@talktalk.net>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171110110949.328-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfLbZ9CrY1Dr/oOY6KyRBMV0goCIU0OSS56iL8NCQSlfmyDtAYu2YTJL1eMJQq7lh7c/uB2LYCFL04/7yGZg9NLTLiKfrBQQVSS76a87mAVal/ML1vJ3k
 2Fw6Xut9FC4uvutavz6YRqpEZMEN9L+lVjlLoK2ZIGAu5BleN8Nr9FrVinCyinQ/P3AHuktM9wZ2rh6MEqFK3FlyOCynHg/OP//eepk4/tBRdhaOTfVyA1A+
 OaOP1nCtVScZjf/KalT55+TXk4p90R3yfLtSncFIys28CK9+Xxfb3LCgOPE7eLIU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When there is more than one squash/fixup command in a row check the
intermediate messages are correct.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3404-rebase-interactive.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 6a82d1ed876dd5d1073dc63be8ba5720adbf12e3..9ed0a244e6cdf34c7caca8232f0c0a8cf4864c42 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -453,6 +453,10 @@ test_expect_success C_LOCALE_OUTPUT 'squash and fixup generate correct log messa
 		git rebase -i $base &&
 	git cat-file commit HEAD | sed -e 1,/^\$/d > actual-squash-fixup &&
 	test_cmp expect-squash-fixup actual-squash-fixup &&
+	git cat-file commit HEAD@{2} |
+		grep "^# This is a combination of 3 commits\."  &&
+	git cat-file commit HEAD@{3} |
+		grep "^# This is a combination of 2 commits\."  &&
 	git checkout to-be-rebased &&
 	git branch -D squash-fixup
 '
-- 
2.15.0

