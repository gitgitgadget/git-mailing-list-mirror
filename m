Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B80C433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 663FB20DD4
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="sRT5PH0G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393787AbgFSR5c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:57:32 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39554 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404568AbgFSR4l (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 13:56:41 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9072B60A70;
        Fri, 19 Jun 2020 17:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592589391;
        bh=QhWwx5JrFjkmi9fYf3BLeqi+AU9uqTKM8zuKL+dV4ZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=sRT5PH0GRSvX9ZtP2neSToPeVAOl5rv3xTrhLPAoHOI56HjWgujEZ+F49xnazoDOR
         l7GUrLPVd491RrVwe4R0aYCis2Vl0CCqomcpG2V5zEi82ftz4ea3VQiw5e+7rHiWgX
         3YNaNgdMCWBjhHdOkpSyv1TyZjfhIsXy8I/jGFx3t2E2rv46INOSp6VjhVig/GmgD5
         aqkx0Sazsa1BjNO4qBN7QM6/biLSUnP5qi9jqxa4o5igxfh0cBy0eeQISRYkkQU3Oh
         j9cF1QyKVVvm54TO6NBXL//SVlxndMOdI1FBHbPnIPLcqL2yjZRCuG0r5qLhUTBe5L
         uMc0g7ygMfeu3L2q5OgZ1EGRRCSoGlzmplenIwrJ2kayoj7BPjAqCxfHWiRJ0oFj3o
         Q0rmQtEcjLBZoh1c9u1eDOkwKFgaYrByehARMIuMyUcGg0fyJBR6WhTspx5ovj84ud
         05rjgnzvyfQo+D0Si1KGRYFzFCbvW2rFvzM+EH8srDOwXIyphJ0
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 36/44] t1050: pass algorithm to index-pack when outside repo
Date:   Fri, 19 Jun 2020 17:55:53 +0000
Message-Id: <20200619175601.569856-37-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
In-Reply-To: <20200619175601.569856-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200619175601.569856-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When outside a repository, git index-pack is unable to guess the hash
algorithm in use for a pack, since packs don't contain any information
on the algorithm in use. Pass an option to index-pack to help it out in
this test.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t1050-large.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index 7f88ea07c2..6a56d1ca24 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -12,6 +12,7 @@ file_size () {
 }
 
 test_expect_success setup '
+	test_oid_init &&
 	# clone does not allow us to pass core.bigfilethreshold to
 	# new repos, so set core.bigfilethreshold globally
 	git config --global core.bigfilethreshold 200k &&
@@ -177,7 +178,8 @@ test_expect_success 'git-show a large file' '
 
 test_expect_success 'index-pack' '
 	git clone file://"$(pwd)"/.git foo &&
-	GIT_DIR=non-existent git index-pack --strict --verify foo/.git/objects/pack/*.pack
+	GIT_DIR=non-existent git index-pack --object-format=$(test_oid algo) \
+		--strict --verify foo/.git/objects/pack/*.pack
 '
 
 test_expect_success 'repack' '
