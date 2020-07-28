Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC24C433EA
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FEB2207E8
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="nVXvDrtt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbgG1XfD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 19:35:03 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40862 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730024AbgG1XfB (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Jul 2020 19:35:01 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 60F1F61013;
        Tue, 28 Jul 2020 23:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595979300;
        bh=zmmreqcVssM8fklRR8fjcy4ONQ0aizZ1+4lGjEODa9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=nVXvDrttKfjG80VKgE6H6dNppsaUxwnIu6kxaE49a0wRuGe1NbWdboSNi6crRpId0
         lIKLFd7t1+W13WB5aMFVyBh4LRvKR3YrY47XTeJCMmwR/Pylo5wG6wRaiV4BlJCVUJ
         NTNf0AZqC8Jze0cSmwa8564TYKfRdtqUKvPFYAjF/VZzOxpL6c2hHRS3+nOOkpHYYW
         MEeZUsGo7H8wQrpOyBKSHzvasWtrpfJF90PoflX27FHPxSu4sF7lMl7REB/AgngLKk
         7DKE9qXHFbhQvvw6j1BV1JXxBvb1kymzYCgO0zYarQRuD3IMmo1GyyVx64Kd+axi6m
         cIxN9u2YB7iHYfiVWPjho/LVUCdLM4dwVpKkNqEarIuxJxypBZmSKmFwC3dkn+4pjg
         ngW3HEhQoXtC8y7/603DQzrlRCT0o5CzPCotjxTeHQSa6Kwy6P1uxKwN0b6dOvaNns
         Czkr/SeW2rNvO0hjWDQXaD6Lz2a2qzrQoiCBy89wAJX2HhLkkll
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 12/39] t7201: abstract away SHA-1-specific constants
Date:   Tue, 28 Jul 2020 23:34:19 +0000
Message-Id: <20200728233446.3066485-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6
In-Reply-To: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes variables for object IDs instead of
using hard-coded hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t7201-co.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index b696bae5f5..4d62b9b00f 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -230,9 +230,10 @@ test_expect_success 'switch to another branch while carrying a deletion' '
 test_expect_success 'checkout to detach HEAD (with advice declined)' '
 
 	git config advice.detachedHead false &&
+	rev=$(git rev-parse --short renamer^) &&
 	git checkout -f renamer && git clean -f &&
 	git checkout renamer^ 2>messages &&
-	test_i18ngrep "HEAD is now at 7329388" messages &&
+	test_i18ngrep "HEAD is now at $rev" messages &&
 	test_line_count = 1 messages &&
 	H=$(git rev-parse --verify HEAD) &&
 	M=$(git show-ref -s --verify refs/heads/master) &&
@@ -248,9 +249,10 @@ test_expect_success 'checkout to detach HEAD (with advice declined)' '
 
 test_expect_success 'checkout to detach HEAD' '
 	git config advice.detachedHead true &&
+	rev=$(git rev-parse --short renamer^) &&
 	git checkout -f renamer && git clean -f &&
 	GIT_TEST_GETTEXT_POISON=false git checkout renamer^ 2>messages &&
-	grep "HEAD is now at 7329388" messages &&
+	grep "HEAD is now at $rev" messages &&
 	test_line_count -gt 1 messages &&
 	H=$(git rev-parse --verify HEAD) &&
 	M=$(git show-ref -s --verify refs/heads/master) &&
