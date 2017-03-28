Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54B9620966
	for <e@80x24.org>; Tue, 28 Mar 2017 19:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755650AbdC1TIA (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 15:08:00 -0400
Received: from siwi.pair.com ([209.68.5.199]:62729 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755494AbdC1TH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 15:07:56 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 54F5B84632;
        Tue, 28 Mar 2017 15:07:54 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v3 1/2] read-cache: core.checksumindex
Date:   Tue, 28 Mar 2017 19:07:31 +0000
Message-Id: <20170328190732.59486-2-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170328190732.59486-1-git@jeffhostetler.com>
References: <20170328190732.59486-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach git to skip verification of the index SHA in verify_hdr()
in read_index().

This is a performance optimization.  The index file SHA verification
can be considered an ancient relic from the early days of git and only
useful for detecting disk corruption.  For small repositories, this
SHA calculation is not that significant, but for gigantic repositories
this calculation adds significant time to every command.

Added "core.checksumindex" to enable/disable the SHA verification.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 read-cache.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index 9054369..2ab4b74 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1376,12 +1376,24 @@ static int verify_hdr(struct cache_header *hdr, unsigned long size)
 	git_SHA_CTX c;
 	unsigned char sha1[20];
 	int hdr_version;
+	int do_checksum = 0;
 
 	if (hdr->hdr_signature != htonl(CACHE_SIGNATURE))
 		return error("bad signature");
 	hdr_version = ntohl(hdr->hdr_version);
 	if (hdr_version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < hdr_version)
 		return error("bad index version %d", hdr_version);
+
+	/*
+	 * Since we run very early in command startup, git_config()
+	 * may not have been called yet and the various "core_*"
+	 * global variables haven't been set.  So look it up
+	 * explicitly.
+	 */
+	git_config_get_bool("core.checksumindex", &do_checksum);
+	if (!do_checksum)
+		return 0;
+
 	git_SHA1_Init(&c);
 	git_SHA1_Update(&c, hdr, size - 20);
 	git_SHA1_Final(sha1, &c);
-- 
2.9.3

