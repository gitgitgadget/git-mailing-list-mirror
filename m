Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3BAC1F597
	for <e@80x24.org>; Thu, 19 Jul 2018 12:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731126AbeGSM5f (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 08:57:35 -0400
Received: from david.siemens.de ([192.35.17.14]:40108 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727421AbeGSM5f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 08:57:35 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by david.siemens.de (8.15.2/8.15.2) with ESMTPS id w6JCECPr030439
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jul 2018 14:14:12 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id w6JCEB1j018134;
        Thu, 19 Jul 2018 14:14:11 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH] t/t5534: do not unset GIT_COMMITTER_EMAIL for other tests
Date:   Thu, 19 Jul 2018 14:14:09 +0200
Message-Id: <20180719121409.6143-1-henning.schild@siemens.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <xmqqbmb4lbhh.fsf@gitster-ct.c.googlers.com>
References: <xmqqbmb4lbhh.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unsetting the varibale for good can have unwanted effects for new
tests added in the future It also meant we needed to hardcode the
value for "user.signingkey".
Move the unset into a subshell, get rid of the hardcoded
"committer@example.com", and switch the GPG variant to using test_config
just like GPGSM.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 t/t5534-push-signed.sh | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
index 0cb88aa6f..f6d674156 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -194,10 +194,12 @@ test_expect_success GPG 'fail without key and heed user.signingkey' '
 
 	EOF
 
-	unset GIT_COMMITTER_EMAIL &&
-	git config user.email hasnokey@nowhere.com &&
-	test_must_fail git push --signed dst noop ff +noff &&
-	git config user.signingkey committer@example.com &&
+	test_config user.email hasnokey@nowhere.com &&
+	(
+		unset GIT_COMMITTER_EMAIL &&
+		test_must_fail git push --signed dst noop ff +noff
+	) &&
+	test_config user.signingkey $GIT_COMMITTER_EMAIL &&
 	git push --signed dst noop ff +noff &&
 
 	(
@@ -241,11 +243,14 @@ test_expect_success GPGSM 'fail without key and heed user.signingkey x509' '
 	E_O_F
 
 	EOF
-	unset GIT_COMMITTER_EMAIL &&
+
 	test_config user.email hasnokey@nowhere.com &&
 	test_config user.signingkey "" &&
-	test_must_fail git push --signed dst noop ff +noff &&
-	test_config user.signingkey committer@example.com &&
+	(
+		unset GIT_COMMITTER_EMAIL &&
+		test_must_fail git push --signed dst noop ff +noff
+	) &&
+	test_config user.signingkey $GIT_COMMITTER_EMAIL &&
 	git push --signed dst noop ff +noff &&
 
 	(
-- 
2.16.4

