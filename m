Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D6FC1FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 13:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934762AbdCXN2V (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 09:28:21 -0400
Received: from siwi.pair.com ([209.68.5.199]:33523 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754022AbdCXN2T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 09:28:19 -0400
Received: from jeffhostetler.2jll4ugiwlvuzhh55dqabi0nia.bx.internal.cloudapp.net (unknown [40.76.14.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 0126684616;
        Fri, 24 Mar 2017 09:28:12 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH] read-cache: call verify_hdr() in a background thread
Date:   Fri, 24 Mar 2017 13:27:51 +0000
Message-Id: <1490362071-46932-2-git-send-email-git@jeffhostetler.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1490362071-46932-1-git-send-email-git@jeffhostetler.com>
References: <1490362071-46932-1-git-send-email-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teash do_read_index() in read-cache.c to call verify_hdr()
in a background thread while the forground thread parses
the index and builds the_index.

This is a performance optimization to reduce the overall
time required to get the index into memory.

Testing on Windows (using the OpenSSL SHA1 routine) showed
that parsing the index and computing the SHA1 take almost
equal time, so this patch effectively reduces the startup
time by 1/2.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 read-cache.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 86 insertions(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 9054369..27c63a3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1564,6 +1564,83 @@ static void post_read_index_from(struct index_state *istate)
 	tweak_untracked_cache(istate);
 }
 
+#ifdef NO_PTHREADS
+
+struct verify_hdr_thread_data {
+	struct cache_header *hdr;
+	size_t size;
+};
+
+/*
+ * Non-threaded version does all the work immediately.
+ * Returns < 0 on error or bad signature.
+ */
+static int verify_hdr_start(struct verify_hdr_thread_data *d)
+{
+	return verify_hdr(d->hdr, (unsigned long)d->size);
+}
+
+static int verify_hdr_finish(struct verify_hdr_thread_data *d)
+{
+	return 0;
+}
+
+#else
+
+#include <pthread.h>
+
+/*
+ * Require index file to be larger than this threshold before
+ * we bother using a background thread to verify the SHA.
+ */
+#define VERIFY_HDR_THRESHOLD    (1024)
+
+struct verify_hdr_thread_data {
+	pthread_t thread_id;
+	struct cache_header *hdr;
+	size_t size;
+	int result;
+};
+
+/*
+ * Thread proc to run verify_hdr() computation in a background thread.
+ */
+static void *verify_hdr_thread_proc(void *_data)
+{
+	struct verify_hdr_thread_data *d = _data;
+	d->result = verify_hdr(d->hdr, (unsigned long)d->size);
+	return NULL;
+}
+
+/*
+ * Threaded version starts background thread and returns zero
+ * to indicate that we don't know the hash is bad yet.  If the
+ * index is too small, we just do the work imediately.
+ */
+static int verify_hdr_start(struct verify_hdr_thread_data *d)
+{
+	if (d->size < VERIFY_HDR_THRESHOLD)
+		return verify_hdr(d->hdr, (unsigned long)d->size);
+
+	if (pthread_create(&d->thread_id, NULL, verify_hdr_thread_proc, d))
+		die_errno("unable to start verify_hdr_thread");
+
+	return 0;
+}
+
+static int verify_hdr_finish(struct verify_hdr_thread_data *d)
+{
+	if (d->size < VERIFY_HDR_THRESHOLD)
+		return 0;
+
+	if (pthread_join(d->thread_id, NULL))
+		die_errno("unable to join verify_hdr_thread");
+
+	return d->result;
+}
+
+#endif
+
 /* remember to discard_cache() before reading a different cache! */
 int do_read_index(struct index_state *istate, const char *path, int must_exist)
 {
@@ -1574,6 +1651,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	void *mmap;
 	size_t mmap_size;
 	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
+	struct verify_hdr_thread_data data;
 
 	if (istate->initialized)
 		return istate->cache_nr;
@@ -1600,7 +1678,10 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	close(fd);
 
 	hdr = mmap;
-	if (verify_hdr(hdr, mmap_size) < 0)
+
+	data.hdr = hdr;
+	data.size = mmap_size;
+	if (verify_hdr_start(&data) < 0)
 		goto unmap;
 
 	hashcpy(istate->sha1, (const unsigned char *)hdr + mmap_size - 20);
@@ -1649,6 +1730,10 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 		src_offset += 8;
 		src_offset += extsize;
 	}
+
+	if (verify_hdr_finish(&data) < 0)
+		goto unmap;
+
 	munmap(mmap, mmap_size);
 	return istate->cache_nr;
 
-- 
2.7.4

