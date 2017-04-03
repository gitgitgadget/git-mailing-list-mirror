Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 775662096C
	for <e@80x24.org>; Mon,  3 Apr 2017 18:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbdDCSxb (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 14:53:31 -0400
Received: from siwi.pair.com ([209.68.5.199]:36316 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752071AbdDCSxa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 14:53:30 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id C71EF84646;
        Mon,  3 Apr 2017 14:53:23 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v4 1/4] read-cache: core.checksumindex
Date:   Mon,  3 Apr 2017 18:53:03 +0000
Message-Id: <20170403185306.36164-2-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170403185306.36164-1-git@jeffhostetler.com>
References: <20170403185306.36164-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach git to skip verification of the SHA-1 checksum at the end of
the index file in verify_hdr() called from read_index() when the
core.checksumIndex configuration variable is set to false.

The checksum verification is for detecting disk corruption, and for
small projects, the time it takes to compute SHA-1 is not that
significant, but for gigantic repositories this calculation adds
significant time to every command.

On the Linux kernel repository, the effect is rather trivial.
The time to reading its index with 58k entries drops from 0.0284 sec
down to 0.0155 sec.

On my Windows source tree (450MB index), I'm seeing a savings of 0.6
seconds -- read_index() went from 1.2 to 0.6 seconds.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt |  8 ++++++++
 read-cache.c             | 12 ++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 47603f5..0f72bdd 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -267,6 +267,14 @@ advice.*::
 		show directions on how to proceed from the current state.
 --
 
+core.checksumIndex::
+	Tell Git to validate the checksum at the end of the index
+	file to detect corruption.  Defaults to `true`.  Those who
+	work on a project with too many files may want to set this
+	variable to `false` to make it faster to load the index (in
+	exchange for reliability, but in general modern disks are
+	reliable enough for most people).
+
 core.fileMode::
 	Tells Git if the executable bit of files in the working tree
 	is to be honored.
diff --git a/read-cache.c b/read-cache.c
index 9054369..dd64cde 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1376,12 +1376,24 @@ static int verify_hdr(struct cache_header *hdr, unsigned long size)
 	git_SHA_CTX c;
 	unsigned char sha1[20];
 	int hdr_version;
+	int do_checksum = 1; /* default to true for now */
 
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

