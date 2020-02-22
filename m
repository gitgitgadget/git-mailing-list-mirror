Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEF9C35673
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 20:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75DAD206ED
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 20:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Chs6H5AS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgBVUSF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Feb 2020 15:18:05 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39070 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726701AbgBVUSF (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 Feb 2020 15:18:05 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 19F726079A;
        Sat, 22 Feb 2020 20:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1582402684;
        bh=/dCY9ZOjdkRbtIiLjKtv2SiaFulNStX+W0DRcg4rGNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Chs6H5ASR9O3twFRLfw/w8hp2tgQIqQTTefxndoJVXTMiNSqUsAmWjhsUr/LwSDVD
         LKFUws+Lcq7tfJQFJV1ZGyPTQySGubCtVn+ewUKfUAb/yc4h+Lbiv6dA5F03QWVw7T
         dWnuE3QEqgW/i4Oq6+d7Hm+vrYnAP3Br+TeufJ7cxyVBDvuvqha/L2ZzcJpBrMWoR/
         6EjEgbS4+xGEktFG8IogaHo3AdOmS+/vsGqVNvgZ4/37S7uUB9wpZha7/b8p6YUn10
         NLTIN0E/9jw/JVcFfPwtynUd7VQvQqjiFiNt6NReeuT38ObCRjj5bpa6NLLqFmZ+jc
         wOBj8Uff5socVSeEokN0evBcvSQc9w5hxj2FKRXtnpql1+DBdT07lG4eg+lOiFzpJC
         WRTVpjZCLUKDVT9isENpqIe0ZDhbqbr/nvgrt2nD50yUPjzogAp02GJfc8m/5xLzTJ
         MR9aGoSDM8N91lvCOzcDqzi2jFyIXP1oqL1xAnr4k6h9lM6qFTc
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH v2 01/24] builtin/pack-objects: make hash agnostic
Date:   Sat, 22 Feb 2020 20:17:26 +0000
Message-Id: <20200222201749.937983-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801
In-Reply-To: <20200222201749.937983-1-sandals@crustytoothpaste.net>
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid hard-coding a hash size, instead preferring to use the_hash_algo.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/pack-objects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 940fbcb7b3..fceac7b462 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -879,7 +879,7 @@ static void write_reused_pack_one(size_t pos, struct hashfile *out,
 			len = encode_in_pack_object_header(header, sizeof(header),
 							   OBJ_REF_DELTA, size);
 			hashwrite(out, header, len);
-			hashwrite(out, base_sha1, 20);
+			hashwrite(out, base_sha1, the_hash_algo->rawsz);
 			copy_pack_data(out, reuse_packfile, w_curs, cur, next - cur);
 			return;
 		}
