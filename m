Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E92BC43457
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60BC6206D9
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="0ILhpKWK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbgGMCt4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 22:49:56 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40790 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725892AbgGMCtz (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Jul 2020 22:49:55 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D9B3560A5D;
        Mon, 13 Jul 2020 02:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594608564;
        bh=OgCPGLxbLEhOK6+oRjiyLc+hvZl35cGnjxku2gGi4NE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=0ILhpKWKe03vK2HE7rDnAPjvUOaXRRxUgDNWfwWK0WX87xitY8NS4Ew9wOk2N2IMs
         oPSHfocfCycYKK3uueUtdGyzGTXEo3oKHq2JLeaJAcrcyzkwwHyPejIblSMfuiLvrU
         6zgq+0FbpQt7+ugX0HyMFIWcP+PVrrnratrwrEQYdWwz1xXM90X8/4WjXDdPp392g8
         DS1ot1AnK9OsPurzv6m2uV4GHNkIxQSegAgMGJXrOz2eS0Hyb2FC38+/FhJuWSatZe
         QqkG59poTlHsx9hSWqqjrQOO4Ab657+6WbXiC4CdnEVl81D6c036i4h796GUQ+tInI
         c0UP34iIAh0fmQBG+8LkxigLPbaOJ7kZD122BO/AVgP69lnc+JPkwS2iuapnYnjxMN
         EdypRpkuENSs/3z7nKnsIQ5EWy8JHIcVGDUsIZ1qeUi9G32lXHinEV+UZnw3N0Pc33
         lQ7WiZ+DpWRSjJZopsT09vVBmQr0jEeUdrxgDf1vtlCLbxaG2Fc
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 03/39] t3305: make hash agnostic
Date:   Mon, 13 Jul 2020 02:48:33 +0000
Message-Id: <20200713024909.3714837-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
References: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When computing the fanout length, let's use test_oid to look up the
hexadecimal size of the hash in question instead of hard-coding a value.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t3305-notes-fanout.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t3305-notes-fanout.sh b/t/t3305-notes-fanout.sh
index 3b4753e1b4..d5a94b7174 100755
--- a/t/t3305-notes-fanout.sh
+++ b/t/t3305-notes-fanout.sh
@@ -7,7 +7,7 @@ test_description='Test that adding/removing many notes triggers automatic fanout
 path_has_fanout() {
 	path=$1 &&
 	fanout=$2 &&
-	after_last_slash=$((40 - $fanout * 2)) &&
+	after_last_slash=$(($(test_oid hexsz) - $fanout * 2)) &&
 	echo $path | grep -q "^\([0-9a-f]\{2\}/\)\{$fanout\}[0-9a-f]\{$after_last_slash\}$"
 }
 
@@ -31,6 +31,7 @@ all_notes_have_fanout() {
 }
 
 test_expect_success 'tweak test environment' '
+	test_oid_init &&
 	git checkout -b nondeterminism &&
 	test_commit A &&
 	git checkout --orphan with_notes;
