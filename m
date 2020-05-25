Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84401C433E1
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6032B2073B
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Pal+HS1V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390469AbgEYUAD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 16:00:03 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38720 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390438AbgEYT76 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 May 2020 15:59:58 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9D56A60D14;
        Mon, 25 May 2020 19:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590436796;
        bh=Mo6wZuC9p3nChbBxsGl44GyZeJquT3ZYpX4+z7OuAXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Pal+HS1VZGU1EhADht+iCnJ+7u16QcTNQjtspEGQoRRNJ99ZgspWE+NDSG/pziCff
         j8W5wQDYSHK18YP6W5kj58IzuMZz1GSUQ2kCY5miOh82wrmF3cGIpUiwCcZOkueOad
         AJt5yEny2VDCM6HuYXtoh5q3EQFpcWUQEJ6m7ZoQTphbqNcFrAjfLnHk1BGiCM44T9
         1QBy4v6HMtrIJeFylMOzmC4Fe6sBTwzUBy5j5IbvXrAV/AuVnwtfUJ9Pn/9SJJkq+p
         x7/2Z1dMxBTHUv2IRc9Lh8s/kc2gkEMW1Pt2atZMflHeltY/aUBuTTZnQdlUQEkpvd
         GrpebolJiLWoRbEj5UU34cvZILgxvbE8ZF4hENgDFUc5Qc0QqNQwhuaf9Yzvn21m4k
         B6IUwdSg6hgX1wZu4MhOvse876lZL/rzkykwTpgeAsfx1YYUC5D603PiRoKK8CfKqF
         zOt8okS2+Ki0wu4vQQMOkSU9IvuBUQXQuDYLFo8ZAmwbkRASR+l
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 32/44] t5500: make hash independent
Date:   Mon, 25 May 2020 19:59:18 +0000
Message-Id: <20200525195930.309665-33-sandals@crustytoothpaste.net>
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

This test has hard-coded pkt-lines with object IDs.  The pkt-line
lengths necessarily differ between hash algorithms, so generate these
lines with the packetize helper so they're always the right size.  In
addition, we will require an object-format capability for SHA-256, so
pass that capability on to the upload-pack process.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5500-fetch-pack.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 8c54e34ef1..dfed113247 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -871,9 +871,10 @@ test_expect_success 'shallow since with commit graph and already-seen commit' '
 
 	GIT_PROTOCOL=version=2 git upload-pack . <<-EOF >/dev/null
 	0012command=fetch
+	$(echo "object-format=$(test_oid algo)" | packetize)
 	00010013deepen-since 1
-	0032want $(git rev-parse other)
-	0032have $(git rev-parse master)
+	$(echo "want $(git rev-parse other)" | packetize)
+	$(echo "have $(git rev-parse master)" | packetize)
 	0000
 	EOF
 	)
