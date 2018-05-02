Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26AE721847
	for <e@80x24.org>; Wed,  2 May 2018 00:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753581AbeEBA1V (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:27:21 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37902 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753533AbeEBA1G (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 May 2018 20:27:06 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DC18A609CB;
        Wed,  2 May 2018 00:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525220825;
        bh=1QcKAvhreT5MFmnNP3WyM5HZQbTKy+FVTwjVeFm6gj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=lNd/KplVrBWtZwl1S9KuxzgIaUtsDx2UQRpxpvHerEywGdO552tZYdo9Ttc1fehQ0
         GWkrPkclaqDoK3ZL6ws4B9drSowrzb6QXtbvKflcXjbCsdvZ9Ft1Ly0yLjuoh1ROti
         BXvrTIhGaycp3ftqsn2nMyV6FDqW1IoroWaSqvVft2SiAVCeWdNzV+wZzj8cg2coRc
         fMgtesOOw1FmIfVQfjN8egD15BZNoMdEBs/Svcl4Eriiy+AUQ3n0Cqt/WwKnOOMppA
         3OxgqQkBNIfBlB+EfXblCgIhrgb+2Lf6rRyyZEoD2JBKcMMrUS+2AK+Eb02Z3q7KoO
         lE5Yk/12Mck1s8YEZK0CONuikqDUYFf4csPBwAGmx4BtbUZ3OR36PRODFnP36IjAoq
         u+UBt9l4LDNZxMe2FnCI6H6eSpjx4QIHp3HGROWI1kNtJBaYAhcnTBqIAYWwnVThva
         SrJuK8ZA+W9VqDUMdJZdA90FYEJ/AvcbI9CjGnU2cpBj9SEhgjS
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 41/42] add--interactive: compute the empty tree value
Date:   Wed,  2 May 2018 00:26:09 +0000
Message-Id: <20180502002610.915892-42-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180502002610.915892-1-sandals@crustytoothpaste.net>
References: <20180502002610.915892-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The interactive add script hard-codes the object ID of the empty tree.
To avoid any problems when changing hashes, compute this value when used
and cache it for any future uses.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 git-add--interactive.perl | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index c1f52e457f..36f38ced90 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -205,8 +205,15 @@ my $status_head = sprintf($status_fmt, __('staged'), __('unstaged'), __('path'))
 	}
 }
 
-sub get_empty_tree {
-	return '4b825dc642cb6eb9a060e54bf8d69288fbee4904';
+{
+	my $empty_tree;
+	sub get_empty_tree {
+		return $empty_tree if defined $empty_tree;
+
+		$empty_tree = run_cmd_pipe(qw(git hash-object -t tree /dev/null));
+		chomp $empty_tree;
+		return $empty_tree;
+	}
 }
 
 sub get_diff_reference {
