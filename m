Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A372AC433E3
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82021207E8
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="pdu570UI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbgG1Xe6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 19:34:58 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40844 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729844AbgG1Xe5 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Jul 2020 19:34:57 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 605FA60AFD;
        Tue, 28 Jul 2020 23:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595979296;
        bh=OgCPGLxbLEhOK6+oRjiyLc+hvZl35cGnjxku2gGi4NE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=pdu570UIV0Tma621rs0fUFa/ZwXCrNRjMTAFruDpxlCMel81Tg41GwzjVYupgaNUd
         sgiSEQUk4j3jbQLiv5UghnfwnbUEeuoZwYb5TwwKmZ+19RFMp/ms5KosgzZwaRIkLB
         TqGZiPtLuhjlRegFjAxWlCcQgBKG5YYnwI02JN8CrJIRlhI9BUvU79zP1LjoLEpVzL
         s3vK7r1ic6hfg2HH7FK4rxp/jAUkT7dc5i55rrGxtghZnvgkl7LY0BVrlikdzk7EMh
         9JWMp4AefdDD4qRYRvJHJ6GohWRx7uKdPu/Xs91dVZA+7c5jVvucp6YOZceyOK5wpQ
         r4cHG2+hHr+uapo7BuBI1IVxZktF6wIBQWxO/rZSOkH18OgsV2M63mavrZn24t4Xg8
         0CZF2xVGq3Jb7pHqjV0sT0KhO+k27nroZB3kno4NtLdzSCQT3m7d5dQ0e7d8MQw4Gg
         YMBoilloUQu5biLA3EKgbrBUqHcEtmQiWJneNrSae1rpvLSB56r
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 03/39] t3305: make hash agnostic
Date:   Tue, 28 Jul 2020 23:34:10 +0000
Message-Id: <20200728233446.3066485-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6
In-Reply-To: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
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
