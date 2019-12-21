Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC47C2D0C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40875206B7
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="g+Kuqt6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfLUTuS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 14:50:18 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42040 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727419AbfLUTuP (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 21 Dec 2019 14:50:15 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C2388607F7;
        Sat, 21 Dec 2019 19:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1576957814;
        bh=CE8W+hbzxW69lNpuuAEEZbZMto24yBepJwkH88NGSiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=g+Kuqt6M0/bj2b6hMZAmWkRBVDLg5cT5lFqUirZveybDkh49jnvvIU4d8ZF99qMad
         /MReUEbFaYQju+Y3ibT3FrR8uErp1QNv/3mBgbHhT7r/97SzuHlTIAMh2I3qaFtL5t
         y55W9DIhCb3bi75Hy0G21bOnd9tisyRhgm5/PnCriY2gXIMst9L0+X2l7xW4DhE6hY
         GhXYp4JEgXngPQToc6ngwveFPcRrffW+qVxBLuLyg7BRc1N77PEq364SXV4wXiF/lZ
         afLXD8vQeN4V43S0dI4cfKE3puLaA9EGZ2/TFuGM+4H34JEiu0t8drpqRH7aUagDII
         Vr6pddIgAb7/xSNjMOGEDL8Mi6ej4fyrEdn7K/w/yapAI0sD/Cvp7f4uLkPe0j/VUa
         X3EEPBulWltJaC+CFqSNSrfi3zSSR8PkNfcz7amq4VOlh8x5RN2HVxfOOny1zQyY9j
         O2JY6EZMVn3b8JLTk4S1FiORuXWJk/zHdowHobl0TfpxlI+5dUK
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 17/20] t5540: make hash size independent
Date:   Sat, 21 Dec 2019 19:49:33 +0000
Message-Id: <20191221194936.1346664-18-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.24.1.658.g99f4b37f93
In-Reply-To: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
References: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use regex values based on $OID_REGEX instead of hard-coding them based
on expected object ID lengths.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5540-http-push-webdav.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/t5540-http-push-webdav.sh b/t/t5540-http-push-webdav.sh
index a094fd5e71..d476c33509 100755
--- a/t/t5540-http-push-webdav.sh
+++ b/t/t5540-http-push-webdav.sh
@@ -134,15 +134,13 @@ test_expect_success 'MKCOL sends directory names with trailing slashes' '
 
 x1="[0-9a-f]"
 x2="$x1$x1"
-x5="$x1$x1$x1$x1$x1"
-x38="$x5$x5$x5$x5$x5$x5$x5$x1$x1$x1"
-x40="$x38$x2"
+xtrunc=$(echo $OID_REGEX | sed -e "s/\[0-9a-f\]\[0-9a-f\]//")
 
 test_expect_success 'PUT and MOVE sends object to URLs with SHA-1 hash suffix' '
 	sed \
 		-e "s/PUT /OP /" \
 		-e "s/MOVE /OP /" \
-	    -e "s|/objects/$x2/${x38}_$x40|WANTED_PATH_REQUEST|" \
+	    -e "s|/objects/$x2/${xtrunc}_$OID_REGEX|WANTED_PATH_REQUEST|" \
 		"$HTTPD_ROOT_PATH"/access.log |
 	grep -e "\"OP .*WANTED_PATH_REQUEST HTTP/[.0-9]*\" 20[0-9] "
 
