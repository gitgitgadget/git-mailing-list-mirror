Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42F4120966
	for <e@80x24.org>; Wed,  5 Apr 2017 18:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756053AbdDESGr (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 14:06:47 -0400
Received: from siwi.pair.com ([209.68.5.199]:59741 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755602AbdDESGq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 14:06:46 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id EB9B2846C6;
        Wed,  5 Apr 2017 14:06:44 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v6] read-cache: force_verify_index_checksum
Date:   Wed,  5 Apr 2017 18:06:25 +0000
Message-Id: <20170405180625.12439-2-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170405180625.12439-1-git@jeffhostetler.com>
References: <20170405180625.12439-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach git to skip verification of the SHA1-1 checksum at the end of
the index file in verify_hdr() which is called from read_index()
unless the "force_verify_index_checksum" global variable is set.

Teach fsck to force this verification.

The checksum verification is for detecting disk corruption, and for
small projects, the time it takes to compute SHA-1 is not that
significant, but for gigantic repositories this calculation adds
significant time to every command.

These effect can be seen using t/perf/p0002-read-cache.sh:

================
BEFORE:
$ ./p0002-read-cache.sh
0002.1: read_cache/discard_cache 1000 times   0.66(0.58+0.08)

AFTER:
$ ./p0002-read-cache.sh
0002.1: read_cache/discard_cache 1000 times   0.30(0.28+0.01)
================

Also, using the t/perf/p0004-read-tree.sh test that I created
in a parallel patch series.

https://public-inbox.org/git/20170404210847.50860-1-git@jeffhostetler.com/

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsck.c  |  1 +
 cache.h         |  2 ++
 read-cache.c    |  7 +++++++
 t/t1450-fsck.sh | 13 +++++++++++++
 4 files changed, 23 insertions(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 1a5cacc..5512d06 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -771,6 +771,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	}
 
 	if (keep_cache_objects) {
+		verify_index_checksum = 1;
 		read_cache();
 		for (i = 0; i < active_nr; i++) {
 			unsigned int mode;
diff --git a/cache.h b/cache.h
index 80b6372..87f13bf 100644
--- a/cache.h
+++ b/cache.h
@@ -685,6 +685,8 @@ extern void update_index_if_able(struct index_state *, struct lock_file *);
 extern int hold_locked_index(struct lock_file *, int);
 extern void set_alternate_index_output(const char *);
 
+extern int verify_index_checksum;
+
 /* Environment bits from configuration mechanism */
 extern int trust_executable_bit;
 extern int trust_ctime;
diff --git a/read-cache.c b/read-cache.c
index 9054369..c4205aa 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1371,6 +1371,9 @@ struct ondisk_cache_entry_extended {
 			    ondisk_cache_entry_extended_size(ce_namelen(ce)) : \
 			    ondisk_cache_entry_size(ce_namelen(ce)))
 
+/* Allow fsck to force verification of the index checksum. */
+int verify_index_checksum;
+
 static int verify_hdr(struct cache_header *hdr, unsigned long size)
 {
 	git_SHA_CTX c;
@@ -1382,6 +1385,10 @@ static int verify_hdr(struct cache_header *hdr, unsigned long size)
 	hdr_version = ntohl(hdr->hdr_version);
 	if (hdr_version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < hdr_version)
 		return error("bad index version %d", hdr_version);
+
+	if (!verify_index_checksum)
+		return 0;
+
 	git_SHA1_Init(&c);
 	git_SHA1_Update(&c, hdr, size - 20);
 	git_SHA1_Final(sha1, &c);
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 33a51c9..fc1acb5 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -689,4 +689,17 @@ test_expect_success 'bogus head does not fallback to all heads' '
 	! grep $blob out
 '
 
+test_expect_success 'detect corrupt index file in fsck' '
+	cp .git/index .git/index.backup &&
+	test_when_finished "mv .git/index.backup .git/index" &&
+	echo zzzzzzzz >zzzzzzzz &&
+	test_when_finished "rm zzzzzzzz" &&
+	git add zzzzzzzz &&
+	sed -e "s/zzzzzzzz/yyyyyyyy/" .git/index >.git/index.yyy &&
+	rm .git/index &&
+	mv .git/index.yyy .git/index &&
+	test_when_finished "rm .git/index" &&
+	test_must_fail git fsck --cache
+'
+
 test_done
-- 
2.9.3

