Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AA071FCA0
	for <e@80x24.org>; Mon, 27 Mar 2017 21:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752432AbdC0VJz (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 17:09:55 -0400
Received: from siwi.pair.com ([209.68.5.199]:52746 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751968AbdC0VJx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 17:09:53 -0400
Received: from jeffhostetler.2jll4ugiwlvuzhh55dqabi0nia.bx.internal.cloudapp.net (unknown [40.76.14.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 10CBD84617;
        Mon, 27 Mar 2017 17:09:52 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2 1/2] read-cache: skip index SHA verification
Date:   Mon, 27 Mar 2017 21:09:38 +0000
Message-Id: <1490648979-49580-2-git-send-email-git@jeffhostetler.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1490648979-49580-1-git-send-email-git@jeffhostetler.com>
References: <1490648979-49580-1-git-send-email-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach git to skip verification of the index SHA in read_index().

This is a performance optimization.  The index file SHA verification
can be considered an ancient relic from the early days of git and only
useful for detecting disk corruption.  For small repositories, this
SHA calculation is not that significant, but for gigantic repositories
this calculation adds significant time to every command.

I added a global "skip_verify_index" variable to control this and
allow it to be tested.

I did not create a config setting for this because of chicken-n-egg
problems with the loading the config and the index.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 cache.h      | 5 +++++
 read-cache.c | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/cache.h b/cache.h
index 80b6372..4e9182f 100644
--- a/cache.h
+++ b/cache.h
@@ -740,6 +740,11 @@ extern int protect_ntfs;
 extern int git_db_env, git_index_env, git_graft_env, git_common_dir_env;
 
 /*
+ * When set, skip verification of the index SHA in read_index().
+ */
+extern int skip_verify_index;
+
+/*
  * Include broken refs in all ref iterations, which will
  * generally choke dangerous operations rather than letting
  * them silently proceed without taking the broken ref into
diff --git a/read-cache.c b/read-cache.c
index 9054369..1ca69c3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -46,6 +46,8 @@
 struct index_state the_index;
 static const char *alternate_index_output;
 
+int skip_verify_index = 1;
+
 static void set_index_entry(struct index_state *istate, int nr, struct cache_entry *ce)
 {
 	istate->cache[nr] = ce;
@@ -1382,6 +1384,10 @@ static int verify_hdr(struct cache_header *hdr, unsigned long size)
 	hdr_version = ntohl(hdr->hdr_version);
 	if (hdr_version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < hdr_version)
 		return error("bad index version %d", hdr_version);
+
+	if (skip_verify_index)
+		return 0;
+
 	git_SHA1_Init(&c);
 	git_SHA1_Update(&c, hdr, size - 20);
 	git_SHA1_Final(sha1, &c);
-- 
2.7.4

