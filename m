Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E322CC43215
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B491220715
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="aII81M0+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfK0TBz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:01:55 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50960 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727010AbfK0TBz (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 27 Nov 2019 14:01:55 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 585F461AAB
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 19:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1574881314;
        bh=+ZHk6tbQNxH7o1ZNjSu8T62AaDHcWDTvMg4zY5r8vQo=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=aII81M0+grRwiul4/Q+KjKqh42jKBSrQSY58IXVpNlwXl+rU9Qdc0jo8DLgjNZz+/
         fFBDlxfG5uRFWD/dusku9VpshKB7fiFXRVlZ7xoYGYolLV9psslI4IMKpvqQUADyBA
         Wfqozb0dQwHDqJ37l26rOqF5MTx7lCdwvA0osKpyAASKp/nTZGMxkjlKL4nYeOB+kJ
         4V5JzGJ2qCXSDsi4n3AGFMscjJ/AfRx+/bLlge/mRaVmu5VzBRUErUmvSof15faJsl
         qFVV5heUQ7BDAuqZB6d5uOpuC7KtAhIndsoUwc45UtJkgP+ADR1gT5bLSkdwOUHl59
         UhpaIG86OBpVu/kNajzQ0FJC/cbK+HfCYnTydwHDCPrOby5/V3K4YK08x8G1y7yeu6
         wD6YsGjaWVgWiBhODfOKaiQzu6IkOrBxj10O6vEqps3eRwVIoxGrl3MWb/8vd9DGlV
         6ymxD0U55xsaO31Q/j15HwLnO3hr5oeEa14x87ZdtF3V0xL2OhG
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH 1/1] t9001: avoid including non-trailing NUL bytes in variables
Date:   Wed, 27 Nov 2019 19:01:42 +0000
Message-Id: <20191127190142.64271-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf
In-Reply-To: <20191127190142.64271-1-sandals@crustytoothpaste.net>
References: <20191127190142.64271-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In this test, we have a command substitution whose output starts with a
NUL byte.  bash and dash strip out any NUL bytes from the output; zsh
does not.  As a consequence, zsh fails this test, since the command line
argument we use the variable in is truncated by the NUL byte.

POSIX says of a command substitution that if "the output contains any
null bytes, the behavior is unspecified," so all of the shells are in
compliance with POSIX.  To make our code more portable, let's avoid
prefacing our variables with NUL bytes and instead leave only the
trailing one behind.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t9001-send-email.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 997f90b42b..51be0b8cd6 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -2066,7 +2066,7 @@ test_expect_success $PREREQ 'leading and trailing whitespaces are removed' '
 	TO1=$(echo "QTo 1 <to1@example.com>" | q_to_tab) &&
 	TO2=$(echo "QZto2" | qz_to_tab_space) &&
 	CC1=$(echo "cc1" | append_cr) &&
-	BCC1=$(echo "Q bcc1@example.com Q" | q_to_nul) &&
+	BCC1=$(echo " bcc1@example.com Q" | q_to_nul) &&
 	git send-email \
 	--dry-run \
 	--from="	Example <from@example.com>" \
