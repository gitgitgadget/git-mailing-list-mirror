Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDC4C2D0F8
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E207B20675
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="IpA1MCh2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731965AbgEMAzC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:55:02 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38172 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731920AbgEMAyy (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 20:54:54 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 28AE860D15;
        Wed, 13 May 2020 00:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589331293;
        bh=Tngbtm4HDKwryfMFXEnLa+X54TrkAxC2lx+1IfD4NYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=IpA1MCh2EDXWE9qJ0UA3eaEzXWz3+U/aD5vtxmSvtkZk27Ka2GDJi6guMjYGfGzCP
         WHcG+OKs89LJVD9v123cl4GWc4OzLr63vGtUK+TnAkvZ9kEj54Zu5M4gZhc2z6sOf4
         r3poEwZ8OfoVb0WzjpsOgpKhESyuSwqFUuJAIEpNKESdeAVTDdjIgiu0IL8/jtuyYJ
         t05vv8If9xNsxME0K0jn1mXd+5n5jKigF4VnNf0tkGOcb3/Y3/6e4t5P5t4E6lJv9j
         L/zX2nM3ohEskxZ+XAkEjkV5gzczmaDp+7hIGLCTWyI623WnJBnW4Gob4aINgoKNZK
         PWf/HllGzrDYuus3nqivCO5Qy9arkJjOc6IjG/0h0EK69TH5umcRJFPaCIYqEqvGZn
         YSbwblUVH5xitOGdqFsiuetJaeU8b/BzkNQiQwPohxElZqa/kkITl9MU5kCTuNwYWR
         cFMTWyo1bPdGwtI8367cUYuAgkNUs53NKUemOsBRnwP9f2Nn7AP
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 36/44] builtin/index-pack: add option to specify hash algorithm
Date:   Wed, 13 May 2020 00:54:16 +0000
Message-Id: <20200513005424.81369-37-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be
In-Reply-To: <20200513005424.81369-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git index-pack is usually run in a repository, but need not be. Since
packs don't contains information on the algorithm in use, instead
relying on context, add an option to index-pack to tell it which one
we're using in case someone runs it outside of a repository.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/index-pack.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 7bea1fba52..89f4962a00 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1760,6 +1760,11 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 					die(_("bad %s"), arg);
 			} else if (skip_prefix(arg, "--max-input-size=", &arg)) {
 				max_input_size = strtoumax(arg, NULL, 10);
+			} else if (skip_prefix(arg, "--object-format=", &arg)) {
+				int hash_algo = hash_algo_by_name(arg);
+				if (hash_algo == GIT_HASH_UNKNOWN)
+					die(_("unknown hash algorithm '%s'"), arg);
+				repo_set_hash_algo(the_repository, hash_algo);
 			} else
 				usage(index_pack_usage);
 			continue;
