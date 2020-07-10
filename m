Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE59CC433E0
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC88F20663
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="xy4dJeqR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgGJCs1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:48:27 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40366 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726509AbgGJCs0 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Jul 2020 22:48:26 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EDE7860A5D;
        Fri, 10 Jul 2020 02:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594349305;
        bh=OgCPGLxbLEhOK6+oRjiyLc+hvZl35cGnjxku2gGi4NE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=xy4dJeqRXTYswSpUH8nYvOYbwUG3xSwndKUtnKeYa7dPkeHzNGYNDilGmLjb4XGFK
         7stnZ9Dgzph9AQRfdw9eQnCSgywXIA8/1I6GCPppSR6WlXzAln8ghfiUZAF+qFZWIo
         9/3CIH8bhjM6bOQ8AFk3kv9Q6ivqgwA/q6y6aG8RFW0lNuFdw9K26m1XGD8rV9vsj3
         kwC4s7jLF2+Z/qjKe2wbWRP2mQWH3UzqiGTJ7BSSquQCousucZGeuNPc/wWMhgcH3X
         AdJOPSd3kj+RGDcG+Khl5pWGiamrAFM2vi7g7BnSiOoGfsJ+So+Kexqpu/honHXnav
         YEkTHWHor+h7OQFsvOqP7qB6xbjpXYjMxqsjHBSGPCGbQ6dHCwMN4SNX0UtgAoD1bh
         9w2Suij7+fwJp3t9vrZoundMPP1YE0ql9WqzsXbJubKa7+GrrC74DA/ySGORWsjQbd
         28s5ybwOfL0ENrBoJta7zmieh3fAOy7DyQqWRFmFnp4L6rqVsHU
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 03/38] t3305: make hash agnostic
Date:   Fri, 10 Jul 2020 02:46:53 +0000
Message-Id: <20200710024728.3100527-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
References: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
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
