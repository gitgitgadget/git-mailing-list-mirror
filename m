Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F25C433F4
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB3032070B
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ED7tlqjX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgGMCto (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 22:49:44 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40684 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726991AbgGMCtd (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Jul 2020 22:49:33 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1C07060A6B;
        Mon, 13 Jul 2020 02:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594608572;
        bh=ESSekoAdRTmOfsf7qIhpt9ZyM67fkWjpVvr9uTkNfYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ED7tlqjXlPZ/3lod2w01c3wMV7V7VBI8opSTuLuPT9IL4INfBv8xUUxBkgYh/r5hx
         0ULo/a+Obme2BDe2v2uCpPwq2BDsx76arqxFeqJlqL8YayoP46g4llrTEOrbMXyqbE
         y1XIsnLcr0vw+hXdkQfgo/S6uIYyIAdLHy7+oc3qy3x65rHX3VoMs+yd+9hgYCbT2M
         WonvYQT+1bbgUb0KmNXuRjuGarBJEfbDud6T40B+HVDFeOdr9ONYOWkhtiFU7jBcG+
         BsQMaItJ9aO8yk7Q0eR4pr24+JYIk6wPpx7N/y696Dx6T1TBLGCIdfvueOc8cQclPo
         Tzd+l2PsRwuyp+AjK3QlDQAYXwEx8iKuLfbJVCNvYh5ekyIJ1fFicUveVDIdZzWGeN
         LshcSNJKfuDx+TieLd6IEKPpzLJmf5kv1LhSIuiTPDgGs/Bv5LLeEQGan7dZ+g68RB
         PaZqONuwwlIShWHKOiRZHE7hcTCgAQcu65z3EtOf0hWJpXK0V/v
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 19/39] t8003: make hash size independent
Date:   Mon, 13 Jul 2020 02:48:49 +0000
Message-Id: <20200713024909.3714837-20-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
References: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One assertion in this test invokes git with core.abbrev set to "40".
Since we're expecting the full hash length, use test_oid to look up the
full hash length for the hash in use.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t8003-blame-corner-cases.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
index 9130b887d2..ebe79aa4ea 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -6,6 +6,7 @@ test_description='git blame corner cases'
 pick_fc='s/^[0-9a-f^]* *\([^ ]*\) *(\([^ ]*\) .*/\1-\2/'
 
 test_expect_success setup '
+	test_oid_init &&
 
 	echo A A A A A >one &&
 	echo B B B B B >two &&
@@ -306,7 +307,7 @@ test_expect_success 'blame coalesce' '
 	$oid 1) ABC
 	$oid 2) DEF
 	EOF
-	git -c core.abbrev=40 blame -s giraffe >actual &&
+	git -c core.abbrev=$(test_oid hexsz) blame -s giraffe >actual &&
 	test_cmp expect actual
 '
 
