Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E72CC433DF
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4300D20679
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="sNdF6jlq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390519AbgEYUAO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 16:00:14 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38722 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390451AbgEYT77 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 May 2020 15:59:59 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5245260D18;
        Mon, 25 May 2020 19:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590436798;
        bh=QhWwx5JrFjkmi9fYf3BLeqi+AU9uqTKM8zuKL+dV4ZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=sNdF6jlq2fH/+QuMoXHCxYKP4LbD/L9bd8DKG2xQOkJwMnM2DCDg7lDpq++JDxr1j
         KrE3uHfo3nxcJoijZhovKEHSYbq/l0JikTqVqcnoY6+gryQpjry8FWbswkK6qX14mA
         gyIvf4wigkpKQjTJDApU3DCyIHn3OlGcEXFGpYjWnt7Arc+b1cRDhcs92kOjohQ/4X
         +wUDgXivOwdwREqooyHVNjc1VIeSVNsbJOyVzxH3+qFogQhDpmEJ2I8hKsDbMT8mZM
         8XPZ6Vp2yonxXB5SW4X4k8EuI4AWo2XTneIO9LzTrx/P9Ly4yHthnDcUA6cpDji1NB
         1Al+Nmnlbe3BPgwdnISePOq9fXoec4vKpRwgwyL9t8xJXadqCvtZxtYzMnX4SMpCpO
         Y1yZOu27ZL9ta4s0L+7DlbN0bpmXYNkQ1K0Co2x8XEtE/WaSnOXfy8G9ByGSGpRXrK
         QKE4efkXuzgfkjN+mLVYosi2Yy/vsY65j7LvAAZJGU/5h/I8NXu
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 36/44] t1050: pass algorithm to index-pack when outside repo
Date:   Mon, 25 May 2020 19:59:22 +0000
Message-Id: <20200525195930.309665-37-sandals@crustytoothpaste.net>
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
