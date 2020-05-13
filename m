Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46482C2D0FA
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C7E320675
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Uv4aKmLx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731900AbgEMAyu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:54:50 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38132 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731826AbgEMAyo (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 20:54:44 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1D2B960D00;
        Wed, 13 May 2020 00:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589331283;
        bh=zpnT9fWOaLV9mwawdgB5SvkQ6uw0gD9jYk+wL9jjyZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Uv4aKmLxHrl8sYwPSebcpzDc1MIRsJWyzcjNiVJ4sAlDiQf0Ir2akvl5x7A91BYh6
         jbPHiWusKz0pyav6gCx9rbO1ddgM1nZrDwDIK26DuzntFJWjc9j68zBv1K69tDesLG
         8diKvg+dSXadshk4msUAXeHxzsxoTsPTDLBTfRLwAchW/FvmcDTPsCyQHVm2V5FY3X
         5PsmYV6y4HIrY+LP1ZHCEi+KCm0+oaVE37fd0OmK0ccyboRe8gEGhOfRAp+qtMiHz/
         GPd5T2lWgWoEBCzfobyyJ+9fHJ+RXVPGt54EnEQUtr1DNPgshtl3PV5UpT1iavItJT
         L1zFdGFHfZq6tq29dkaNazqNWo8eRUhFsaExO3XYCijG62LcgMn3AaW1dxsObP6IkN
         BTFF6SC3rJEk4+Z4sB/fHk4TiXjH2DJ4/IM6CcFoszPtGGpjCnCxp5l+N8bU3s0tzz
         hv69dVnou9DG3hWXTYuXXqECJ5zFLKAASxVwOIDmPUQQcyfVhjy
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 13/44] fetch-pack: detect when the server doesn't support our hash
Date:   Wed, 13 May 2020 00:53:53 +0000
Message-Id: <20200513005424.81369-14-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be
In-Reply-To: <20200513005424.81369-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
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
index f73a2ce6cb..1d277190e7 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1039,6 +1039,8 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 		print_verbose(args, _("Server supports %s"), "deepen-relative");
 	else if (args->deepen_relative)
 		die(_("Server does not support --deepen"));
+	if (!server_supports_hash(the_hash_algo->name, NULL))
+		die(_("Server does not support this repository's object format"));
 
 	if (!args->no_dependents) {
 		mark_complete_and_common_ref(negotiator, args, &ref);
