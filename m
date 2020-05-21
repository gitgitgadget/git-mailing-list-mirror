Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25168C433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 02:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1F9F2070A
	for <git@archiver.kernel.org>; Thu, 21 May 2020 02:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="z6ypRgY3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgEUCHX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 22:07:23 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38560 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726840AbgEUCHW (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 20 May 2020 22:07:22 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 48EB46081C;
        Thu, 21 May 2020 02:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590026841;
        bh=u0F7TYsiSuPsD5di/m95+1LRvD9Z5KHOK/3MDxTh3Dg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=z6ypRgY3582rd4oQxfsYUHL7mdky4Rq9Au6A8EbT+O3JqdsojjpnSTBZziaN1a6rJ
         QoLMgqS9HTV5HmiqElqb3i/uxa2v0XFRnmU5rxbaE9q2Z0W3PZL0HLdCebXsDcYWu8
         VuQFgiZtUo9idGvs7O9YWBIwtzOnMjX3ck50fCcK9os5/CpeojqTNvnAJvThS/vhNu
         NwthF/qRZHK6ZesgrELp2ayB6xxe/CqZNjmztkRoG8AREw1EfYmRzze/i74qdwIjcp
         JTwXISLQJvCW+9GGJwIaLElQpvBPc4BLaVdScCCCAayslEcgdbxHJNUWFkfmRRhSs6
         0J0UAA+4/zCLhzQop9IjJ46K3jDU81Qju0/17u3nNXKbXkQaKcBVgThVja56EJKE6l
         N90vi7pct+2qfTB8uHc54zwQMfLDGRz7KiC9MShr726BveXsB8tTmfbnqen1aeObzJ
         arSlND5yqyY1N2EgvjIgfsFLK2Go9c9RAcC2MCrqN6FDEDIuJya
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/2] t2060: add a test for switch with --orphan and --discard-changes
Date:   Thu, 21 May 2020 02:07:12 +0000
Message-Id: <20200521020712.1620993-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652
In-Reply-To: <20200521020712.1620993-1-sandals@crustytoothpaste.net>
References: <ef72aedf-4264-e386-9563-050c54483c93@gmail.com>
 <20200521020712.1620993-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have several code paths in the checkout code which are traversed only
in this case, due to switch having different defaults from checkout.
Let's add a test that the combination of options works and produces the
expected behavior.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t2060-switch.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
index f9efa29dfb..2c1b8c0d6d 100755
--- a/t/t2060-switch.sh
+++ b/t/t2060-switch.sh
@@ -68,6 +68,14 @@ test_expect_success 'new orphan branch from empty' '
 	test_cmp expected tracked-files
 '
 
+test_expect_success 'orphan branch works with --discard-changes' '
+	test_when_finished git switch master &&
+	echo foo >foo.txt &&
+	git switch --discard-changes --orphan new-orphan2 &&
+	git ls-files >tracked-files &&
+	test_must_be_empty tracked-files
+'
+
 test_expect_success 'switching ignores file of same branch name' '
 	test_when_finished git switch master &&
 	: >first-branch &&
