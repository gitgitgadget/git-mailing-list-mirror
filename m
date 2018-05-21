Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51EA81F51C
	for <e@80x24.org>; Mon, 21 May 2018 02:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752670AbeEUCCv (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 22:02:51 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50898 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752645AbeEUCCq (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 20 May 2018 22:02:46 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:fc4d:8d90:22bd:91d8])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B4C8D6074A;
        Mon, 21 May 2018 02:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526868164;
        bh=a54fx2QFDcZFx3mHVRa5yJD9t+U/NnWPWc8H+sSctOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=TlJyajqm038qjBmcz4HfuHqfp4EVQn7eNhGgeTYbQ4I893iiRuq+WHEj1Z0ZJuAwo
         LAg4Yhk5lfHf9FrsLzMUcB13uo/U6dcFbc7BbIxjl/p44Je33DohHoUaF9SuSkrZMC
         DDmGnM41I6J0hla9+IrdPksqDsOVlNAmwINcg8fyuROGrBRAMGbUS0dtqxMYzh6R6K
         2xZyykhjY8U7ud1tQ/JgiEVPGPyGKeYvpC5Tztbl/k0NDQYiU/2A30upn/rdlqPjzY
         vCXqRe0eX/SvTN/CElLSUaAweKCY45OnMR8o2QVYG+UIpYR6T/faqM0a1LzRgnmMbw
         GiaKa6FABUWSweNWYrMBwMZ/JFn6ONHuiiGFUxIfXgaY2G/axOb3dO3MAB/tCKHMEh
         QrQY7bwa6i8OwvIJBoSl6/u9fWMPbPlR2Y7JBCa/OEZ7lsvXs3+zQ1r6HYZ8izvumC
         +DjqdWth75jyUFe1v3A2Qf6yUT7cUBvjKUT4KJ3NHUmMRqXcc4g
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v4 10/28] t: skip pack tests if not using SHA-1
Date:   Mon, 21 May 2018 02:01:29 +0000
Message-Id: <20180521020147.648496-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180521020147.648496-1-sandals@crustytoothpaste.net>
References: <20180516015630.661349-1-sandals@crustytoothpaste.net>
 <20180521020147.648496-1-sandals@crustytoothpaste.net>
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
