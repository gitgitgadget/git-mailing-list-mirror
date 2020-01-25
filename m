Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FFBC35247
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 559702071A
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Q2KhcavU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgAYXBE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 18:01:04 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:46844 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728901AbgAYXAy (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Jan 2020 18:00:54 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0727261488;
        Sat, 25 Jan 2020 23:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579993253;
        bh=UDDWDfHq6vQ4mafDgi/0WqfOho8EmhNcpUk8RRIhlEI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Q2KhcavUnG4pHSsNK1UdUZvzDeCmKj6GiLwCpwMmI1Hwzh2F0asnXa5vbKvLWLOGi
         eHJgwlYEN1PhTP7cAFzJCaxEX8HpCDXUhAtG6wohTLK0/bxIDTRC/eLdSYyYQ3+NCP
         8CqAw3XSIkTV5Q67ckT3h8S5gEfgzeYFLbwVOxTz/S9HwTY0ZL+DH4mvX7FUJ3PDjK
         NmU14oKb4zt2huZ7JnbXC0WkUfLERk04Echm0CzW2nqVWiXIf4w66pYivQFoX4D/7Q
         C1PrCzn8cmf/gp3fkionah8ogNCkUtRWOfmvan0Swv2DDeitIHImG8/Nq7/9G48Zi/
         GbQg0XUhNPjambuOcxToi7ZSfvJqCpZPqNOdWSoL7OzKjvOx9bZQXW4Zr2G7ecbN4r
         z1tEc68GkrCMYix+b6VZsQhTImi4R20mDq8rAOLY+0XYlu4uChKkHq/ve+CxCR1sCW
         4ScIAAUUKOui5HplPzP62ZM1ta30RrOMmJpRCXRkXsftDbLg7DS
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 22/23] t6006: make hash size independent
Date:   Sat, 25 Jan 2020 23:00:33 +0000
Message-Id: <20200125230035.136348-28-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.24.g3f081b084b0
In-Reply-To: <20200125230035.136348-1-sandals@crustytoothpaste.net>
References: <20200125230035.136348-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of hard-coding the length of an object ID when creating a tree,
compute it for the hash in use using the translation tables.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t6006-rev-list-format.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index ebdc49c496..7e82e43a63 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -32,6 +32,7 @@ changed_iso88591=$(echo "$changed" | iconv -f utf-8 -t $test_encoding)
 truncate_count=20
 
 test_expect_success 'setup' '
+	test_oid_init &&
 	: >foo &&
 	git add foo &&
 	git config i18n.commitEncoding $test_encoding &&
@@ -463,9 +464,10 @@ test_expect_success '--abbrev' '
 '
 
 test_expect_success '%H is not affected by --abbrev-commit' '
+	expected=$(($(test_oid hexsz) + 1)) &&
 	git log -1 --format=%H --abbrev-commit --abbrev=20 HEAD >actual &&
 	len=$(wc -c <actual) &&
-	test $len = 41
+	test $len = $expected
 '
 
 test_expect_success '%h is not affected by --abbrev-commit' '
