Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB69A1F803
	for <e@80x24.org>; Thu, 10 Jan 2019 04:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfAJE0L (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 23:26:11 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58372 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727213AbfAJE0K (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 9 Jan 2019 23:26:10 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c537:b034:2963:7e8f])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B245C60FE5;
        Thu, 10 Jan 2019 04:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1547094369;
        bh=HabsrqUUoT7hrNPkoE0xU3MI89JUerus5bsDVbIcHb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=xbDCE2ZCWKGfF6/N8R/7lGJhoGqR6ULhjGjrqNvk6xNZUw++vk+9JPkKoLir7eK7V
         lLOKT+QXRUAzADfhOumsCHoah20gfDWJRdAUwcsLY6H6lnfw7AN8d9s19L/st9QXFL
         j1RwkKXNTyVWr6SJk86ImZH69yaSRSHs25Fs6mtMB5bKg8/WkuiEej2kX5gvm0W06F
         ddjRI+ddUwMT18lBKf/nTbJJu7/xyKjfgW3emM4f1IOKhKVbgFP/sLOQGIttED6zFa
         smWbCjK7gQ3+pMKhw2yxpTE+eQ1/YnqjymswWeHQiGVWCy36AKoUL5PiHZ+hdIIcQ7
         HYFInHTzjRoUQhyGHocJHTDIQtP7nPqkncsvQ/We6PTHsPMi1nHXn7IXe9FKyURmo6
         K1ZyBBB5cwGFB2vH8QbzmTuVZKONS7wn9DF03cLN7p1/MUiWGzVWH7g7oqA4O07ydQ
         NHdfNcmYyF9ucZsgPaujTZWE+5wP/RmXDRHfvv0sPKfa2QmfAOD
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/5] match-trees: use hashcpy to splice trees
Date:   Thu, 10 Jan 2019 04:25:49 +0000
Message-Id: <20190110042551.915769-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3
In-Reply-To: <20190110042551.915769-1-sandals@crustytoothpaste.net>
References: <CAN0heSqLUWpwRdeUvYj2KnDX-QxSOnWOdKWz77RjHKJ3AFUGEQ@mail.gmail.com>
 <20190110042551.915769-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we're splicing trees, we're writing directly from one location into
a buffer that is exactly the same size as a tree object. If the current
hash algorithm is SHA-1, we may not have a full 32 (GIT_MAX_RAWSZ) bytes
available to write, nor would we want to write that many bytes even if
we did. In a future commit, we'll split out hashcpy to respect
the_hash_algo while oidcpy uses GIT_MAX_RAWSZ, so convert the oidcpy to
a hashcpy so we copy the right number of bytes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 match-trees.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/match-trees.c b/match-trees.c
index feca48a5fd..b1fbd022d1 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -224,7 +224,7 @@ static int splice_tree(const struct object_id *oid1, const char *prefix,
 	} else {
 		rewrite_with = oid2;
 	}
-	oidcpy(rewrite_here, rewrite_with);
+	hashcpy(rewrite_here->hash, rewrite_with->hash);
 	status = write_object_file(buf, sz, tree_type, result);
 	free(buf);
 	return status;
