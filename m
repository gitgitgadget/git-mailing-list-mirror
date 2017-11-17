Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 593E0201C8
	for <e@80x24.org>; Fri, 17 Nov 2017 11:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754686AbdKQLgN (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 06:36:13 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:33845 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754374AbdKQLgL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Nov 2017 06:36:11 -0500
Received: from lindisfarne.localdomain ([92.22.34.132])
        by smtp.talktalk.net with SMTP
        id FevAeP1Zopb8rFewKexNEe; Fri, 17 Nov 2017 11:36:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1510918569;
        bh=EWLLel6iLTLnUKdlJZSeE8MIR9gC6bHqi56xJvtnxAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=A4EqVL78kWDG+5CDxDsWjIVlQzYOe80Tz6hKQ3gFAHLLzLpcKk9vH3lChTIWlWfQv
         albXzj18Ts7yRrAiTQet9HcmgBWZlMwY7GKyXsh8wLYFseJeBrXWqT7MxqRDYlN1Yy
         kjmeeYVMRFk/fVc7u7wWiiC4f/xOU07XKgX0vYbI=
X-Originating-IP: [92.22.34.132]
X-Spam: 0
X-OAuthority: v=2.2 cv=ZM2noTzb c=1 sm=1 tr=0 a=2gYdyS03q/cwff7SV6P5Ng==:117
 a=2gYdyS03q/cwff7SV6P5Ng==:17 a=evINK-nbAAAA:8 a=1hiMVKsh0mBqE-q75WoA:9
 a=MEzT_SyuPu8Hlan-:21 a=UsvAgxNaHALTGGpc:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 1/8] t3404: check intermediate squash messages
Date:   Fri, 17 Nov 2017 11:34:45 +0000
Message-Id: <20171117113452.26597-2-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171117113452.26597-1-phillip.wood@talktalk.net>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171117113452.26597-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfAfFN8C9+tAkiFsqARbQG/1RhcQn3EwA6Cyb5Qf5N4kWR4RZive3fqEBPHR4wVMHJzmgbce/5USfO4WuyHD3YHMD7ZCh1DzQvW8S1qyrEUcb/R05aowY
 XyxYQZ7hgRwXgYtR+AyOByUZN0pviBxENjVEzKoGs5uauPjq6KYqOj4/vpk0xqay4kBWnfQyE/yNBSzO9lAssKFrAZ6yU8eZu4Ru16+c7nPb//j9HsnHzy3k
 oeb64xE2Q3asMnuFtmqP+OJ14hwF08Gy50JQueinjYiAMnPvBynZmvFXTH8t7c4M
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

