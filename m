Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AAC91F991
	for <e@80x24.org>; Wed,  2 Aug 2017 10:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752868AbdHBKo6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 06:44:58 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:19419 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752802AbdHBKow (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 06:44:52 -0400
Received: from lindisfarne.localdomain ([92.22.28.33])
        by smtp.talktalk.net with SMTP
        id cr8nd8nSUiSHacr91dwioE; Wed, 02 Aug 2017 11:44:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1501670691; bh=dUDmrDN+P42G8VY4sMPoWDC5iwsxl1CWemyocVgXkYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=ctT2BHOY0WVIwmGvN6gIxoswFYOHxmne7Kk43Ljcn6BD2QBDnN0OjTAZJ/peqQ/+G
         wiw6gd5tEvypoqi9FjKi42bEal3FoArks7W/QnG+fduYOFmQw4iCHyL8KEx8XGyC1M
         VSaft7WkgbjTTOsqHeoTI+X4Q4f/QYG1fumRJzw4=
X-Originating-IP: [92.22.28.33]
X-Spam: 0
X-OAuthority: v=2.2 cv=UoATD64B c=1 sm=1 tr=0 a=BeSdjzhxhZnKGFP9cxuqMA==:117
 a=BeSdjzhxhZnKGFP9cxuqMA==:17 a=evINK-nbAAAA:8 a=edZChGTwqRupLB35ZbsA:9
 a=hnRqJLJbb7wSGUDe:21 a=laUHkEsl5FVuuehE:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 6/6] cherry-pick/revert: reject --rerere-autoupdate when continuing
Date:   Wed,  2 Aug 2017 11:44:20 +0100
Message-Id: <20170802104420.12809-7-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20170802104420.12809-1-phillip.wood@talktalk.net>
References: <20170802104420.12809-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfHgTvAKC5DzJMwXWW/jNZWquGPQiWHTnLai/0GbLU8Wwy7vr44e8FZ+DXIwkTQDlcUYx3S6WeFvcPxd6Ofdr8BHQGBszDtH5x+JpcgE3JRJ4e5kJBYDf
 B1Fy0CB9lpdpET7RndUApAUEzVNclFWHtyuLr3+O0IH2oqGrDqbzH2pnhPoQtfGvF2gJ2Fv2OOuNQTZbahkJ3DkCBgNoTcaTSghAulfL7oRlQ5QKZWrJuba/
 q3lILs8howUQs1jUW0Jamw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

cherry-pick and revert should not accept --[no-]rerere-autoupdate once
they have started.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

This will break scripts that pass --[no-]rerere-autoupdate to 'git
cherry-pick --continue'. I don't think that this will be an issue for
the vast majority of users as I think most people will have assumed
that you cannot pass any other options with '--continue'.
'--rerere-autoupdate' is mentioned by 'git cherry-pick -h' but it is
not mentioned in the documentation. Hopefully a note in the release
notes should be enough to alert anyone who is affected by this.

builtin/revert.c              |  2 ++
 t/t3504-cherry-pick-rerere.sh | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/builtin/revert.c b/builtin/revert.c
index 16028b9ea82edee9cf41044c69a47e8994d78fc6..b9d927eb09c9ed87c84681df1396f4e6d9b13c97 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -155,6 +155,8 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 				"--strategy-option", opts->xopts ? 1 : 0,
 				"-x", opts->record_origin,
 				"--ff", opts->allow_ff,
+				"--rerere-autoupdate", opts->allow_rerere_auto == RERERE_AUTOUPDATE,
+				"--no-rerere-autoupdate", opts->allow_rerere_auto == RERERE_NOAUTOUPDATE,
 				NULL);
 	}
 
diff --git a/t/t3504-cherry-pick-rerere.sh b/t/t3504-cherry-pick-rerere.sh
index af316cb40b7b16c95881eb8483eea4f6191c7cfa..a267b2d144df4a84f18ba4907b317e757ba98f16 100755
--- a/t/t3504-cherry-pick-rerere.sh
+++ b/t/t3504-cherry-pick-rerere.sh
@@ -65,6 +65,19 @@ test_expect_success 'cherry-pick conflict with --no-rerere-autoupdate' '
 	git reset --hard bar-dev
 '
 
+test_expect_success 'cherry-pick --continue rejects --rerere-autoupdate' '
+	test_must_fail git cherry-pick --rerere-autoupdate foo..bar-master &&
+	test_cmp foo-expect foo &&
+	git diff-files --quiet &&
+	test_must_fail git cherry-pick --continue --rerere-autoupdate >actual 2>&1 &&
+	echo "fatal: cherry-pick: --rerere-autoupdate cannot be used with --continue" >expect &&
+	test_i18ncmp expect actual &&
+	test_must_fail git cherry-pick --continue --no-rerere-autoupdate >actual 2>&1 &&
+	echo "fatal: cherry-pick: --no-rerere-autoupdate cannot be used with --continue" >expect &&
+	test_i18ncmp expect actual &&
+	git cherry-pick --abort
+'
+
 test_expect_success 'cherry-pick --rerere-autoupdate more than once' '
 	test_must_fail git cherry-pick --rerere-autoupdate --rerere-autoupdate foo..bar-master &&
 	test_cmp foo-expect foo &&
-- 
2.13.3

