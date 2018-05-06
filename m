Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 178EA200B9
	for <e@80x24.org>; Sun,  6 May 2018 23:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752081AbeEFXTL (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 19:19:11 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41226 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751989AbeEFXTC (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 May 2018 19:19:02 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4972B60769;
        Sun,  6 May 2018 23:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525648740;
        bh=tNmE6YX8OIp3qF4zgyIdkeJH75tkcyLNAr3nE8efhx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=MarMMoVMkeqWlr1URzhPOORwMUq/bxBjZE3yEJB51xqosc5xrAGgdS6ZqIzFkJ9xD
         yHemCU8cORQVuB9pw3b6YhhylzYIGKwdqXnEYyFj7CLbY9zShncZcowsulLkrws7Tu
         XxuKB9O8r1zOxrZ8wECoWFfMVO80DExXNAKS3RnsYEu+2sLKl4/APSKIz2AoJ5JlKp
         /Rc/wioPboU/BKphesf6DgbmIlRc8Z9aV6V/SmhPVmHgiyaqf1DPcSguHx22J2GiFC
         9LUXTfutOsR3XeLpL5vnHzg1+/6BzDFZ34364aqq8ZgwmPg6djfykgdbD/Qcf9OAnV
         QNsym0YQkLT1CP2ri5uj+5e5KTq8SechYE5OAQ1bW2o9qG5kbEEFJlCpfoLjjMP4yV
         eM66Ge+u6gJKRjQwlyE7j7N4RT1nn/1buGSlEUJQ4GUx7SGsbOXQKTgGx7d0c0Ly9Z
         khS7Ro+8Wb7wTLNIjI1iBmDyqIIfa1DN+iC4Bb9aGYdRuvkf93D
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 24/28] t4205: sort log output in a hash-independent way
Date:   Sun,  6 May 2018 23:17:48 +0000
Message-Id: <20180506231752.975110-25-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180506231752.975110-1-sandals@crustytoothpaste.net>
References: <20180506231752.975110-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test enumerates log entries and then sorts them.  For SHA-1, this
produces results that happen to sort in the order specified in the test,
but for other hash algorithms they sort differently.  Ensure we sort the
log entries in a hash-independent way by sorting on the ref name instead
of the object ID.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4205-log-pretty-formats.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 591f35daaf..2052cadb11 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -516,22 +516,22 @@ test_expect_success 'log decoration properly follows tag chain' '
 	git commit --amend -m shorter &&
 	git log --no-walk --tags --pretty="%H %d" --decorate=full >actual &&
 	cat <<-EOF >expected &&
-	$head1  (tag: refs/tags/tag2)
 	$head2  (tag: refs/tags/message-one)
 	$old_head1  (tag: refs/tags/message-two)
+	$head1  (tag: refs/tags/tag2)
 	EOF
-	sort actual >actual1 &&
+	sort -k3 actual >actual1 &&
 	test_cmp expected actual1
 '
 
 test_expect_success 'clean log decoration' '
 	git log --no-walk --tags --pretty="%H %D" --decorate=full >actual &&
 	cat >expected <<-EOF &&
-	$head1 tag: refs/tags/tag2
 	$head2 tag: refs/tags/message-one
 	$old_head1 tag: refs/tags/message-two
+	$head1 tag: refs/tags/tag2
 	EOF
-	sort actual >actual1 &&
+	sort -k3 actual >actual1 &&
 	test_cmp expected actual1
 '
 
