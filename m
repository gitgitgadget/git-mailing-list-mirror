Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A59BC433E4
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F3B720719
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="n3Hts2vk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgGZTyq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 15:54:46 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40668 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726832AbgGZTyo (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Jul 2020 15:54:44 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A877A60CF6;
        Sun, 26 Jul 2020 19:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595793282;
        bh=6vdJnTtdikEyvh2eoGCAUKW9eW10Iio5RbuTQEHrp4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=n3Hts2vkTTWbgkV7UwUT2I0/WyPfFIinhYFwjoidX+5vFwjC0JpkvxMFarSF9KvgO
         8pFVboBU9otUnegBTZhx/cw2KO2ClTG5OMwABGp9VfVRf1rkFbtahnkdVDg8zohQ+L
         7CJuvaHiP6k9DFpeOyBvx7IQVvLn9XQZuvYHiXsL6Pd8mbsN10THPQD6vXDdDAW7IH
         UPTxeWctdOMliccU8Bff1Pf/QislL/8hDL0di/x1n32rHq7ijUt/GG20XnaNhrvD1D
         PRHGm7YunILaL9yj8T9OmZu+J7B+zRl09EzvFAsZAh8P+uj6xT+MokOugfGiX/IfSq
         1W4XTOE2k6lhKrc1C0awd9Xgq7cTxd+ViB8/8tgiZ2stmVK2kyHu+PG5y9GZaLXmGZ
         EED6HiZ5EJ5rgNH+DPW6AWCg4LL1MWPijFEbF1Ejngq5EYb7fKZPAyKITFa4za+sy3
         EvpxOxMTvyvU/LGRNApcOzBwCbKAX42pY/c+n4ffGT2qfAqxho3
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 05/39] t6100: make hash size independent
Date:   Sun, 26 Jul 2020 19:53:50 +0000
Message-Id: <20200726195424.626969-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc2.160.gd0b3904b262
In-Reply-To: <20200726195424.626969-1-sandals@crustytoothpaste.net>
References: <20200726195424.626969-1-sandals@crustytoothpaste.net>
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
