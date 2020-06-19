Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC01C433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DBB120DD4
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="0vkz0LMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404146AbgFSR41 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:56:27 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39458 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393718AbgFSR4Z (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 13:56:25 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9E4F560A6A;
        Fri, 19 Jun 2020 17:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592589380;
        bh=kxdnbajG1wJnUj09iiv6Qr7Gsgj4V99GqZeQ8laS6MM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=0vkz0LMdUX9LyCH91NFRQdM3NpDyreHoG88NjEImj8xHxh1ISnRquS0RITPE+TKtI
         fSGfKW887Ktx7PO+zEVNTQxELN5Kf/NvSoXfom6guj7/QVvrayB9Tb0dsLV4lAycWD
         n1MMF9t3wwto7PFJEjSXxHke/8nZjRt02PKxNHy2rBnKbq9+wOvEo27Gml9Z+PWgik
         z0qRfcRd3d2CaCFFYA9WFOf6tx7aryDHZWPptnBpWNM54ryi05uFJXxucV5IMvPz74
         iUQGq/UU4NlYhm85RqGFReAHb+BrIP4Ylqq5QHNxCKvGy8Vkj9xmF/ZfkOaZOURsJn
         BC5yDjyx3SJZzVlh0aUpn4u5AEFSvRPnwq3xSwUHmXO+8M2jSnMKyitO91YGlAbBTf
         BNQRhr1m0Dg7ESZW4RSCzma3puP1Huik5/S2yrfbnJkQgnaRzpoMTvgNYtUN9LoomT
         l4Fp2X+alVkhpFqv7O+eaJMYC5jPQkOvXYwAVThD7uiUfrT8OC5
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 13/44] fetch-pack: detect when the server doesn't support our hash
Date:   Fri, 19 Jun 2020 17:55:30 +0000
Message-Id: <20200619175601.569856-14-sandals@crustytoothpaste.net>
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

Detect when the server doesn't support our hash algorithm and abort.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 fetch-pack.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fetch-pack.c b/fetch-pack.c
index d8bbf45ee2..c090030680 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1040,6 +1040,8 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 		print_verbose(args, _("Server supports %s"), "deepen-relative");
 	else if (args->deepen_relative)
 		die(_("Server does not support --deepen"));
+	if (!server_supports_hash(the_hash_algo->name, NULL))
+		die(_("Server does not support this repository's object format"));
 
 	if (!args->no_dependents) {
 		mark_complete_and_common_ref(negotiator, args, &ref);
