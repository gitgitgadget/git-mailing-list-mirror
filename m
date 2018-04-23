Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F6C41F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932809AbeDWXlB (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:41:01 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60700 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932794AbeDWXku (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Apr 2018 19:40:50 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4F10A60D6B;
        Mon, 23 Apr 2018 23:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524526849;
        bh=1QcKAvhreT5MFmnNP3WyM5HZQbTKy+FVTwjVeFm6gj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=LwfPwlhP4I0w8iaD5MWRfAU4d6leDQplMpl8ZFINoDeMZsY/zFqlIkR2fzS9Q4z7R
         M3IrcoA6mV/bAjtVf7BM6e79Z7HiQtObnRPourlF9/MT0oAq8Zf/4EktbXRnGz0eIk
         ABqMsJzuPZ2O/jrCaW4vvX6DSTxAfgLOFHx5zE28sU+7hE5Qo2HD+CHjUMczEvv1GH
         4+ya6kEDlpSlOxfwr8NiLH+GrQok0PAYypQyk1dXCZzjtGIC4ItQ3W4s+dVXK15Pc2
         Qt+K8N9krUBoRUsuLosfAa0gtzFvO9cq3PXhwu08Gc0cN75pkhhX+zhyuVjp8L4IV+
         HgjHcQoJlOxtm4rveL+LmwB8lmEO+a4RpneyNvW+W0kKmz0v9Cxx8JnISbHC2KFtxk
         RM7volG4++a4pQ+fWgeBFvueT0B7qMpFGu5ufRCICfetqkH8IbB16+GMMvrNBk2MhL
         sZbm+gbNjukAdibDb/T03DFwwDuhw1MnvAptL88KIF/xBPKFtCb
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 40/41] add--interactive: compute the empty tree value
Date:   Mon, 23 Apr 2018 23:39:50 +0000
Message-Id: <20180423233951.276447-41-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180423233951.276447-1-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
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
