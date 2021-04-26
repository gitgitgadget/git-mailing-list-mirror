Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBD2C433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 01:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2105611C9
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 01:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbhDZBEN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Apr 2021 21:04:13 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41764 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231431AbhDZBEM (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Apr 2021 21:04:12 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DDA3B6078E;
        Mon, 26 Apr 2021 01:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1619399011;
        bh=lJUoUmXqQ78YHjDgihcTS1VoUu6vRnZRt/KZ/i6Kl9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=W8DxdbUvCuW4KEnSPcZd7AbJ3tdgjkBeNgxkf4eFPkBbIQEXpg8RgyeglOacENuE2
         FrMgn1T19cNyuP6Jygn1AWzNoxPC+CRtcZKWiYU/0FHEU2Wyx8YUYXSKh+hW4Dg8HR
         GFqhMqpMriprGpL1eQLsKGAQHX3EhoH04i/3w0FQZBJ+arlnrikCUbHvGbj4IJ4l/R
         jpfVQvwhKOmrW44+wtKD0qD2LNGZP+mxUYyboubKE6+D7k8BUBSPLT/zTEid8nzjKs
         487JP0g0j+6RoA6dvUf08sHjdffTOVY2wioc5IeHY+BgBf8CYhF3AOBrFclJbccmqI
         xRoakg+CoTKikkzSQCwWT7cEeUN+3h1k3GQKMhxMH55hei+ab1Y6lBs+wo/32+FbdO
         5mkv/E8Phm9wtj2uMp785jPJyzN06pJEbAEi3Qa8SDr4FArrq10+dXh4ZhyJ/iVYeG
         Td+QgkeLB8o7wUediIrYyiClm+Zt6xaHRqF3F8Gj4L/loWjYm4+
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 03/13] http-push: set algorithm when reading object ID
Date:   Mon, 26 Apr 2021 01:02:51 +0000
Message-Id: <20210426010301.1093562-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d
In-Reply-To: <20210426010301.1093562-1-sandals@crustytoothpaste.net>
References: <20210426010301.1093562-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In most places in the codebase, we use oidread to properly read an
object ID into a struct object_id.  However, in the HTTP code, we end up
needing to parse a loose object path with a slash in it, so we can't do
that.  Let's instead explicitly set the algorithm in this function so we
can rely on it in the future.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 http-push.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/http-push.c b/http-push.c
index b60d5fcc85..5675cd7708 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1022,6 +1022,8 @@ static void remote_ls(const char *path, int flags,
 /* extract hex from sharded "xx/x{38}" filename */
 static int get_oid_hex_from_objpath(const char *path, struct object_id *oid)
 {
+	oid->algo = hash_algo_by_ptr(the_hash_algo);
+
 	if (strlen(path) != the_hash_algo->hexsz + 1)
 		return -1;
 
