Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7795C433E0
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8B7B2075F
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Mx/WiaVv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390643AbgEYUAd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 16:00:33 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38722 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390418AbgEYT7y (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 May 2020 15:59:54 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 10B8B60D07;
        Mon, 25 May 2020 19:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590436791;
        bh=sxSDhOXns0vesz2DtA7y4piK/iRpR30k7wtrsZNC1VU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Mx/WiaVv9dKpzs0X329sUQKXSpqUj64H7ir46EQyHVw10NErcL0mB8ajU7O0FLw3J
         l7Z1BQryfxHyXT6z8RR0x+OLmJVVZkU+ybFx9jHu+P0fNEa1MqhRdaWBO8vGCfCiis
         C1fOFO7r+hfmoTGiv3nXPZtheW7JPs3NSutTf2rUgIQotyIYB/Kcpz6ZlCmvunC3Mz
         F5h0b+62g7s0cBIbefUByolb97uY42DJtvmUMghlkJvKx/tg9CsHip8GXMHnvnJamL
         EcAwx1cZcm9u/vv9Kiz0kq70UUKmpEXvECXaasW5gYzXCNH+xRxs+1Oevta+m7uvF5
         YDvzKSVtqf6UbYkpHpn+jkf/08u6M6WGcmK/k6XKKvHe7Zx98scZzVtS2Uxx+xSAGC
         TzxJ8AwhBFL3wWbO9hy/lM+E7JEe9g+UULfxaKex1GT8bBG6wQ3XNSEaVO7vIMAOqN
         /spmlxAMF0d9VYtqY1JdQkjGPpWYFCS/KfxBk//Wn+DTQT+z6a3
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 19/44] builtin/clone: initialize hash algorithm properly
Date:   Mon, 25 May 2020 19:59:05 +0000
Message-Id: <20200525195930.309665-20-sandals@crustytoothpaste.net>
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

When performing a clone, we don't know what hash algorithm the other end
will support.  Currently, we don't support fetching data belonging to a
different algorithm, so we must know what algorithm the remote side is
using in order to properly initialize the repository.  We can know that
only after fetching the refs, so if the remote side has any references,
use that information to reinitialize the repository with the correct
hash algorithm information.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/clone.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index cb48a291ca..f27d38bc8e 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1217,6 +1217,15 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	refs = transport_get_remote_refs(transport, &ref_prefixes);
 
 	if (refs) {
+		int hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
+
+		/*
+		 * Now that we know what algorithm the remote side is using,
+		 * let's set ours to the same thing.
+		 */
+		initialize_repository_version(hash_algo);
+		repo_set_hash_algo(the_repository, hash_algo);
+
 		mapped_refs = wanted_peer_refs(refs, &remote->fetch);
 		/*
 		 * transport_get_remote_refs() may return refs with null sha-1
