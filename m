Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05C4C433DF
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 23:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C8BE214DB
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 23:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cavoj.net header.i=@cavoj.net header.b="WS4/lEKx";
	dkim=pass (1024-bit key) header.d=cavoj.net header.i=@cavoj.net header.b="lcV9FHjB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439933AbgJQXQH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 19:16:07 -0400
Received: from lithium.sammserver.com ([168.119.122.30]:33510 "EHLO
        lithium.sammserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439929AbgJQXQG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 19:16:06 -0400
X-Greylist: delayed 4417 seconds by postgrey-1.27 at vger.kernel.org; Sat, 17 Oct 2020 19:16:06 EDT
Received: from mail.sammserver.com (sammserver.wg [10.32.40.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by lithium.sammserver.com (Postfix) with ESMTPS id 50FF3312B5AC;
        Sun, 18 Oct 2020 01:16:05 +0200 (CEST)
Received: by mail.sammserver.com (Postfix, from userid 5011)
        id 098E311209FF; Sun, 18 Oct 2020 01:16:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cavoj.net; s=email;
        t=1602976565; bh=JSWsXvYFer7QVagEfPMHu7EjECEu0gBfEk3TAFh1IQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WS4/lEKxVxcDeYea3BlUnwYLuhTOBdBFjKxdcU+ZwykoDODyuhVqvllM9frPigS4H
         JPW/okCoEVZXTUt7KpCN4GQDDeGGXykNmryfIhukbf/8CStVtuEH5SDsYmBOAIviTj
         ALg+fbKKgVUYJRlQ73HkzOb+b37Xmet7ElhHgjXU=
Received: from fastboi.localdomain (fastboi.wg [10.32.40.5])
        by mail.sammserver.com (Postfix) with ESMTP id C31B511209FA;
        Sun, 18 Oct 2020 01:16:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cavoj.net; s=email;
        t=1602976564; bh=JSWsXvYFer7QVagEfPMHu7EjECEu0gBfEk3TAFh1IQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lcV9FHjB9E8tGhi52tka1evcIoWdzxV5PHIWxx+d3T0wj1XYqh+RX6iiy0MZ3eZCY
         8Xcw6Xpz8smau5iB6bcISj+Pr6dQJTkDX3daAW4TzMDmK3VGOYLyS0xid/jRz8k5sR
         2r0wxgV3dwVIyxXnPcGytTME4j1EVfmMoViQm9b0=
Received: by fastboi.localdomain (Postfix, from userid 1000)
        id B90051420A92; Sun, 18 Oct 2020 01:16:04 +0200 (CEST)
From:   =?UTF-8?q?Samuel=20=C4=8Cavoj?= <samuel@cavoj.net>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Samuel=20=C4=8Cavoj?= <samuel@cavoj.net>
Subject: [PATCH v4 3/3] t3435: add tests for rebase -r GPG signing
Date:   Sun, 18 Oct 2020 01:15:57 +0200
Message-Id: <20201017231557.1001728-3-samuel@cavoj.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201017231557.1001728-1-samuel@cavoj.net>
References: <20201017231557.1001728-1-samuel@cavoj.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add test cases of various combinations of the commit.gpgsign option and
--gpg-sign, --no-gpg-sign flags with rebase -r with the default merge
strategy. This excercises a different code-path from those with octopus
merges or overridden merge strategy with rebase -s.

Signed-off-by: Samuel Čavoj <samuel@cavoj.net>
---
changed v3 -> v4:
    * new
---
 t/t3435-rebase-gpg-sign.sh | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/t/t3435-rebase-gpg-sign.sh b/t/t3435-rebase-gpg-sign.sh
index 2fba21f77a..54120b09d6 100755
--- a/t/t3435-rebase-gpg-sign.sh
+++ b/t/t3435-rebase-gpg-sign.sh
@@ -96,4 +96,32 @@ test_expect_success "rebase -r, merge strategy, commit.gpgsign=true --no-gpg-sig
 	test_must_fail git verify-commit HEAD
 '
 
+test_expect_success 'rebase -r --gpg-sign will sign commit' '
+	git reset --hard merged &&
+	test_unconfig commit.gpgsign &&
+	git rebase -fr --gpg-sign --root &&
+	git verify-commit HEAD
+'
+
+test_expect_success 'rebase -r with commit.gpgsign=true will sign commit' '
+	git reset --hard merged &&
+	git config commit.gpgsign true &&
+	git rebase -fr --root &&
+	git verify-commit HEAD
+'
+
+test_expect_success 'rebase -r --gpg-sign with commit.gpgsign=false will sign commit' '
+	git reset --hard merged &&
+	git config commit.gpgsign false &&
+	git rebase -fr --gpg-sign --root &&
+	git verify-commit HEAD
+'
+
+test_expect_success "rebase -r --no-gpg-sign with commit.gpgsign=true won't sign commit" '
+	git reset --hard merged &&
+	git config commit.gpgsign true &&
+	git rebase -fr --no-gpg-sign --root &&
+	test_must_fail git verify-commit HEAD
+'
+
 test_done
-- 
2.28.0

