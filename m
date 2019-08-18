Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E0241F461
	for <e@80x24.org>; Sun, 18 Aug 2019 19:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfHRTVA (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 15:21:00 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57816 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727122AbfHRTVA (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Aug 2019 15:21:00 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E94AA6073E;
        Sun, 18 Aug 2019 19:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566156056;
        bh=99RdzmeZuXBMWE7I62G1cTehTZHTAN8mv28au5hvcEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=OR7hZCi8aWAcUMK8MEfziQfZ6Ub1n/NIZ2Te94Hp1C3IqWBZxA6g8CX5IzV6y2hbQ
         HObpgGJltnT5MdQqKrrdBh6dBLDWvV9sVXy9k2a+QGZjuBtroqVcGE4qGXVlTi4cJ4
         yet8tLC+NHshJaInIsLC9RRFT7Uc58JUizgSfBqQqTDB9CVLcoNgQGqb6+/qUJaFdP
         qVcNai8LWra637JTAWI19q1smDYzvJ9RDAZdDhWL/JNn/FWtyEpw1QXjkL67/W8gFX
         D+qOsu/niEQTL+lWwEU9lpoea//A391qMJsNtNB2DgCa6U4dJqD6Y+mUnNIvf7aUoT
         11sRWIQW2oCWq+MM1IHR5ufZdoFaeC+xeD3BX0rNL3HxMg4bG67pF3n8cwbYfRhOBe
         dWNmUcyuiBhSt6JA649TNw8hcF8jjAtfwIBFjkdIWCd+VW4qThxYer93TDhn7o4lrd
         Yp/Cm62+m3W/SKOiqyvxlu7k4ubWQVZEozhDU16oDiZsdyp1+eC
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 08/14] t3506: make hash independent
Date:   Sun, 18 Aug 2019 19:16:40 +0000
Message-Id: <20190818191646.868106-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
In-Reply-To: <20190818191646.868106-1-sandals@crustytoothpaste.net>
References: <20190818191646.868106-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test uses a hard-coded object ID to ensure that the result of
cherry-pick --ff is correct.  Use test_oid to make this work for both
SHA-1 and SHA-256.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t3506-cherry-pick-ff.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/t/t3506-cherry-pick-ff.sh b/t/t3506-cherry-pick-ff.sh
index 127dd0082f..9d5adbc130 100755
--- a/t/t3506-cherry-pick-ff.sh
+++ b/t/t3506-cherry-pick-ff.sh
@@ -16,7 +16,11 @@ test_expect_success setup '
 	git add file1 &&
 	test_tick &&
 	git commit -m "second" &&
-	git tag second
+	git tag second &&
+	test_oid_cache <<-EOF
+	cp_ff sha1:1df192cd8bc58a2b275d842cede4d221ad9000d1
+	cp_ff sha256:e70d6b7fc064bddb516b8d512c9057094b96ce6ff08e12080acc4fe7f1d60a1d
+	EOF
 '
 
 test_expect_success 'cherry-pick using --ff fast forwards' '
@@ -102,7 +106,7 @@ test_expect_success 'cherry pick a root commit with --ff' '
 	git add file2 &&
 	git commit --amend -m "file2" &&
 	git cherry-pick --ff first &&
-	test "$(git rev-parse --verify HEAD)" = "1df192cd8bc58a2b275d842cede4d221ad9000d1"
+	test "$(git rev-parse --verify HEAD)" = "$(test_oid cp_ff)"
 '
 
 test_expect_success 'cherry-pick --ff on unborn branch' '
