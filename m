Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21502C433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 01:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02059611CA
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 01:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbhDZBEs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Apr 2021 21:04:48 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41840 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231566AbhDZBEp (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Apr 2021 21:04:45 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id F3CE8607A2;
        Mon, 26 Apr 2021 01:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1619399014;
        bh=IHd1nof/YW/R9WMalCpXSBUaTj6ofYzcMNCUwVNuRoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=a8AUr6XH1NXYGwXXD4xxgcYHY0wggc0cwVsLRVVoN4E6gpB4kqgGtumypYxS4xLfS
         HnrqWaJBLb1TINKpF5iZvBQ+jYALLhJHxJw0YpTqXOQCBa9SxZXoi/EZAFroONthME
         Pr6ertvN/6BL2rRgM/5/EilMr5RnCz+esGXjEJYbNYjU5MDtEwBsELKEHZqUgw2qMv
         xQG8UQhoCxtAK258U+5AWJ+q4B4npU5fpXsZpJxvdqEaPqk7O3pAZBpuy7aGcFd4L/
         s0mb2CpNahnJtD+Moa8+j9zxf5LnhMuZRqOGqJ0bG5sXgpY6mzno54b6HTeLIr96hB
         oNNHOpqaGliWn0PcG8naabRt+OZCCsqPsa1QFRBW0FJ7zDiTAD40yJkVPhbHIoPsWZ
         nR+dCSErq3ewnDtTBtrO9UEhtuSFdCooOzloV+i4s5zJ+ohtcEq6etl2CPb8hwPf5l
         CxzXnflwdjm7dAX32GB0RciEo4DSg2NMsRtcapjZnysEu70UYgg
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 09/13] builtin/show-index: set the algorithm for object IDs
Date:   Mon, 26 Apr 2021 01:02:57 +0000
Message-Id: <20210426010301.1093562-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d
In-Reply-To: <20210426010301.1093562-1-sandals@crustytoothpaste.net>
References: <20210426010301.1093562-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In most cases, when we load the hash of an object into a struct
object_id, we load it using one of the oid* or *_oid_hex functions.
However, for git show-index, we read it in directly using fread.  As a
consequence, set the algorithm correctly so the objects can be used
correctly both now and in the future.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/show-index.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/show-index.c b/builtin/show-index.c
index 8106b03a6b..0e0b9fb95b 100644
--- a/builtin/show-index.c
+++ b/builtin/show-index.c
@@ -71,9 +71,11 @@ int cmd_show_index(int argc, const char **argv, const char *prefix)
 			uint32_t off;
 		} *entries;
 		ALLOC_ARRAY(entries, nr);
-		for (i = 0; i < nr; i++)
+		for (i = 0; i < nr; i++) {
 			if (fread(entries[i].oid.hash, hashsz, 1, stdin) != 1)
 				die("unable to read sha1 %u/%u", i, nr);
+			entries[i].oid.algo = hash_algo_by_ptr(the_hash_algo);
+		}
 		for (i = 0; i < nr; i++)
 			if (fread(&entries[i].crc, 4, 1, stdin) != 1)
 				die("unable to read crc %u/%u", i, nr);
