Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437EBC433FE
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 182F8206D9
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Rvkiru29"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgGMCt5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 22:49:57 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40798 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728688AbgGMCt4 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Jul 2020 22:49:56 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DBB1060A5E;
        Mon, 13 Jul 2020 02:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594608565;
        bh=6vdJnTtdikEyvh2eoGCAUKW9eW10Iio5RbuTQEHrp4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Rvkiru29Eyrgw7eooh2FK+bTtGGY2Y/BYHF2/pk9enkDOc5OwwJ497poBNy/rRiIp
         znM8f38QNMHePcL6hAy3z8eW+Kbqiytmi5AxvW+5gBhIq+k7larRyvSKCLZt4j/aoJ
         /Vd8FGprqxJB7FzOFcv3r2GhkUUQheUKvtZur4R+KPqzt/EqNSGAELcCX+X4nd8sUX
         QeFKFXGaSKrXh/x3y52eizzch43Oma+XHOmTzyaINdb3WqC5fytTTDOAnGAS0/tTUk
         yLhi9MdNVGau/iI8WtKKi4DEqyRxKGer5mV+WbXdjTrxjDVRnGA2X1cE1tfGXdJ5mP
         qmK50NccFE/+xZjCNezTZPK1EuQB9WrzEJjkXbzJhKamnwIvg8kHIGCDmBpYrYrHvo
         yeoeksbQB1jU9Mpq3Vda3GqxVLDKcUGhmB4AXTsypbCAszHwj3cX/MjGLAD3ke2D1x
         hdGJo60y0JVODu4qDjS5mCPJIgviZTkRddxt+1YRcHQ9qRiLMyd
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 05/39] t6100: make hash size independent
Date:   Mon, 13 Jul 2020 02:48:35 +0000
Message-Id: <20200713024909.3714837-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
References: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of hard-coding a constant 40, split the output of rev-list by
field.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t6100-rev-list-in-order.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t6100-rev-list-in-order.sh b/t/t6100-rev-list-in-order.sh
index b2bb0a7f61..e934bc239c 100755
--- a/t/t6100-rev-list-in-order.sh
+++ b/t/t6100-rev-list-in-order.sh
@@ -22,7 +22,7 @@ test_expect_success 'setup a commit history with trees, blobs' '
 
 test_expect_success 'rev-list --in-commit-order' '
 	git rev-list --in-commit-order --objects HEAD >actual.raw &&
-	cut -c 1-40 >actual <actual.raw &&
+	cut -d" " -f1 >actual <actual.raw &&
 
 	git cat-file --batch-check="%(objectname)" >expect.raw <<-\EOF &&
 		HEAD^{commit}
@@ -49,7 +49,7 @@ test_expect_success 'rev-list --in-commit-order' '
 
 test_expect_success 'rev-list lists blobs and trees after commits' '
 	git rev-list --objects HEAD >actual.raw &&
-	cut -c 1-40 >actual <actual.raw &&
+	cut -d" " -f1 >actual <actual.raw &&
 
 	git cat-file --batch-check="%(objectname)" >expect.raw <<-\EOF &&
 		HEAD^{commit}
