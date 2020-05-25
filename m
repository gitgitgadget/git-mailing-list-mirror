Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F16EC433E2
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14A6C2073B
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="MmuhxG1p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390487AbgEYUAI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 16:00:08 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38716 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390460AbgEYUAA (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 May 2020 16:00:00 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A4DA960D1C;
        Mon, 25 May 2020 19:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590436800;
        bh=74qW95Zvoq9O2u0va6v/nSh8paXnLt0Me5nQURj92D4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=MmuhxG1pQWW/NeS1jxfCvrVw3EVkgl6WIJrjp2twv3Gn7Lu2xEM+jzdDnggngrPmP
         MS1ID5sUMjvaCn3lv9oTNA0px6JS94y/1GcfybG+8ZMaY0tfd/vNepElEeCzyZV75d
         nCYiat+ZFffpX7Al1/3nK4DpIyMWImeq8jsOoSwRomlcUdF+ud4cpR0B7k50UR7Znx
         mqmLHGpXyRoDBulWlU9XY0UhVtuexm3KWb+4vw0D15N/2jZbk2C+qSINPalTNMDY7i
         emhBynLUVzLMa93UtlP0ZQupsl+LtaZU1UqFP97vmiClLVQhdPRhJYTD9cQe/Pvw/Z
         9V7jzNdkwrHa4RWwQ3UjJsRgoXmInEsmT6gN9Sc0gkTMHIWegPR4M9yKfuJSdz4lcn
         H5RLI+2FG72G1F5nhLq4A2xuwt733P/fnF3tX4a/Zbgmf1FPG7sbY6Rdeb+jamWxlF
         nmfg7VTE+a9zbCibGagPmDYqKdWOlgO79ujN1COSTKxoDYL0b/5
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 39/44] t5702: offer an object-format capability in the test
Date:   Mon, 25 May 2020 19:59:25 +0000
Message-Id: <20200525195930.309665-40-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652
In-Reply-To: <20200525195930.309665-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200525195930.309665-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to make this test work with SHA-256, offer an object-format
capability so that both sides use the same algorithm.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5702-protocol-v2.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 5039e66dc4..116358b9ac 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -13,6 +13,7 @@ start_git_daemon --export-all --enable=receive-pack
 daemon_parent=$GIT_DAEMON_DOCUMENT_ROOT_PATH/parent
 
 test_expect_success 'create repo to be served by git-daemon' '
+	test_oid_init &&
 	git init "$daemon_parent" &&
 	test_commit -C "$daemon_parent" one
 '
@@ -394,6 +395,7 @@ test_expect_success 'even with handcrafted request, filter does not work if not
 	# Custom request that tries to filter even though it is not advertised.
 	test-tool pkt-line pack >in <<-EOF &&
 	command=fetch
+	object-format=$(test_oid algo)
 	0001
 	want $(git -C server rev-parse master)
 	filter blob:none
