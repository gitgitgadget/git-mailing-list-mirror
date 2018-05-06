Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73A0C200B9
	for <e@80x24.org>; Sun,  6 May 2018 23:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751992AbeEFXSt (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 19:18:49 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41110 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751932AbeEFXSm (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 May 2018 19:18:42 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1ED3460766;
        Sun,  6 May 2018 23:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525648720;
        bh=a54fx2QFDcZFx3mHVRa5yJD9t+U/NnWPWc8H+sSctOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=NreuSnNMQ4IbMZEbL3mYcRroXjRrOokJyrmUzEv6Gx7cv0F64sRLcupaPFVvvtVDh
         JGcD6KhcO3QYSrUDYAKVtdRbWQVfOuJtyETBdbIW2m1W5vHm9HkKw0FIqFZ2VTD+JV
         TISZojsuCo1cGMv6BlfSSlC10w/pqAioeZg9d9RP22589bEFNhMbH+wW0e/XCta4nr
         j1nozNUOevce7RPbSK593i+cyhSHhhm/SKSHr31QjysQZ2L9WTq83LSzN2i8UZVmQy
         7TQjtchEfNXTepC1PP6d2JkHXFE52SAA20e3mPwRAmcbjfOUYnf3oSWjE7fRFP4qKU
         nOSVpyVxG/OfVC5+N/meuPmNtEPw7eqJCtDY6oMFZYhN7nOyjwix77lXv3xYvYP2ik
         S0IXFu5mzzy28l2Hu1RYX0z5AM+XCCxzcGvvilvhz+ZxNTKzGz+MbAo1478UMD340G
         rZzQpgLrylm/CDKETamsqfkxAtG6JwQvOE7HsLz7ERWXN6keCEh
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 10/28] t: skip pack tests if not using SHA-1
Date:   Sun,  6 May 2018 23:17:34 +0000
Message-Id: <20180506231752.975110-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180506231752.975110-1-sandals@crustytoothpaste.net>
References: <20180506231752.975110-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These tests rely on creating packs with specially named objects which
are necessarily dependent on the hash used.  Skip these tests if we're
not using SHA-1.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5308-pack-detect-duplicates.sh | 6 ++++++
 t/t5309-pack-delta-cycles.sh      | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/t/t5308-pack-detect-duplicates.sh b/t/t5308-pack-detect-duplicates.sh
index 156ae9e9d3..6845c1f3c3 100755
--- a/t/t5308-pack-detect-duplicates.sh
+++ b/t/t5308-pack-detect-duplicates.sh
@@ -4,6 +4,12 @@ test_description='handling of duplicate objects in incoming packfiles'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-pack.sh
 
+if ! test_have_prereq SHA1
+then
+       skip_all='not using SHA-1 for objects'
+       test_done
+fi
+
 # The sha1s we have in our pack. It's important that these have the same
 # starting byte, so that they end up in the same fanout section of the index.
 # That lets us make sure we are exercising the binary search with both sets.
diff --git a/t/t5309-pack-delta-cycles.sh b/t/t5309-pack-delta-cycles.sh
index 3e7861b075..491556dad9 100755
--- a/t/t5309-pack-delta-cycles.sh
+++ b/t/t5309-pack-delta-cycles.sh
@@ -4,6 +4,12 @@ test_description='test index-pack handling of delta cycles in packfiles'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-pack.sh
 
+if ! test_have_prereq SHA1
+then
+       skip_all='not using SHA-1 for objects'
+       test_done
+fi
+
 # Two similar-ish objects that we have computed deltas between.
 A=01d7713666f4de822776c7622c10f1b07de280dc
 B=e68fe8129b546b101aee9510c5328e7f21ca1d18
