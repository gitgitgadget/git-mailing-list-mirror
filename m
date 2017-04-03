Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 277B72096C
	for <e@80x24.org>; Mon,  3 Apr 2017 18:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752169AbdDCSxh (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 14:53:37 -0400
Received: from siwi.pair.com ([209.68.5.199]:36325 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752118AbdDCSxa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 14:53:30 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 5956E84647;
        Mon,  3 Apr 2017 14:53:24 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v4 2/4] fsck: force core.checksumindex=1
Date:   Mon,  3 Apr 2017 18:53:04 +0000
Message-Id: <20170403185306.36164-3-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170403185306.36164-1-git@jeffhostetler.com>
References: <20170403185306.36164-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach fsck to override core.checksumindex and always verify
the index checksum when reading the index.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsck.c |  1 +
 cache.h        |  7 +++++++
 read-cache.c   | 20 +++++++++++++-------
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 1a5cacc..6913233 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -771,6 +771,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	}
 
 	if (keep_cache_objects) {
+		force_core_checksum_index = 1;
 		read_cache();
 		for (i = 0; i < active_nr; i++) {
 			unsigned int mode;
diff --git a/cache.h b/cache.h
index 80b6372..3ebda0a 100644
--- a/cache.h
+++ b/cache.h
@@ -685,6 +685,13 @@ extern void update_index_if_able(struct index_state *, struct lock_file *);
 extern int hold_locked_index(struct lock_file *, int);
 extern void set_alternate_index_output(const char *);
 
+/*
+ * Override "core.checksumindex" config settings.  Allows commands
+ * like "fsck" to force it without altering on-disk settings in case
+ * routines call die() before it can be reset.
+ */
+extern int force_core_checksum_index;
+
 /* Environment bits from configuration mechanism */
 extern int trust_executable_bit;
 extern int trust_ctime;
diff --git a/read-cache.c b/read-cache.c
index dd64cde..36fdc2a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1371,6 +1371,8 @@ struct ondisk_cache_entry_extended {
 			    ondisk_cache_entry_extended_size(ce_namelen(ce)) : \
 			    ondisk_cache_entry_size(ce_namelen(ce)))
 
+int force_core_checksum_index;
+
 static int verify_hdr(struct cache_header *hdr, unsigned long size)
 {
 	git_SHA_CTX c;
@@ -1384,13 +1386,17 @@ static int verify_hdr(struct cache_header *hdr, unsigned long size)
 	if (hdr_version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < hdr_version)
 		return error("bad index version %d", hdr_version);
 
-	/*
-	 * Since we run very early in command startup, git_config()
-	 * may not have been called yet and the various "core_*"
-	 * global variables haven't been set.  So look it up
-	 * explicitly.
-	 */
-	git_config_get_bool("core.checksumindex", &do_checksum);
+	if (force_core_checksum_index)
+		do_checksum = 1;
+	else {
+		/*
+		 * Since we run very early in command startup, git_config()
+		 * may not have been called yet and the various "core_*"
+		 * global variables haven't been set.  So look it up
+		 * explicitly.
+		 */
+		git_config_get_bool("core.checksumindex", &do_checksum);
+	}
 	if (!do_checksum)
 		return 0;
 
-- 
2.9.3

