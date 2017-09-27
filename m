Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FF6C20281
	for <e@80x24.org>; Wed, 27 Sep 2017 06:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752478AbdI0GBL (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 02:01:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:51566 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752373AbdI0GBK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 02:01:10 -0400
Received: (qmail 25348 invoked by uid 109); 27 Sep 2017 06:00:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 06:00:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11448 invoked by uid 111); 27 Sep 2017 06:01:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 02:01:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Sep 2017 02:01:07 -0400
Date:   Wed, 27 Sep 2017 02:01:07 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/7] avoid looking at errno for short read_in_full()
 returns
Message-ID: <20170927060107.duocwl3mf62zvgjp@sigill.intra.peff.net>
References: <20170927055424.22ati3g24xaqtqrk@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170927055424.22ati3g24xaqtqrk@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a caller tries to read a particular set of bytes via
read_in_full(), there are three possible outcomes:

  1. An error, in which case -1 is returned and errno is
     set.

  2. A short read, in which fewer bytes are returned and
     errno is unspecified (we never saw a read error, so we
     may have some random value from whatever syscall failed
     last).

  3. The full read completed successfully.

Many callers handle cases 1 and 2 together by just checking
the result against the requested size. If their combined
error path looks at errno (e.g., by calling die_errno), they
may report a nonsense value.

Let's fix these sites by having them distinguish between the
two error cases. That avoids the random errno confusion, and
lets us give more detailed error messages.

Signed-off-by: Jeff King <peff@peff.net>
---
 pack-write.c |  7 ++++++-
 sha1_file.c  | 11 ++++++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/pack-write.c b/pack-write.c
index a333ec6754..fea6284192 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -213,14 +213,19 @@ void fixup_pack_header_footer(int pack_fd,
 	git_SHA_CTX old_sha1_ctx, new_sha1_ctx;
 	struct pack_header hdr;
 	char *buf;
+	ssize_t read_result;
 
 	git_SHA1_Init(&old_sha1_ctx);
 	git_SHA1_Init(&new_sha1_ctx);
 
 	if (lseek(pack_fd, 0, SEEK_SET) != 0)
 		die_errno("Failed seeking to start of '%s'", pack_name);
-	if (read_in_full(pack_fd, &hdr, sizeof(hdr)) != sizeof(hdr))
+	read_result = read_in_full(pack_fd, &hdr, sizeof(hdr));
+	if (read_result < 0)
 		die_errno("Unable to reread header of '%s'", pack_name);
+	else if (read_result != sizeof(hdr))
+		die_errno("Unexpected short read for header of '%s'",
+			  pack_name);
 	if (lseek(pack_fd, 0, SEEK_SET) != 0)
 		die_errno("Failed seeking to start of '%s'", pack_name);
 	git_SHA1_Update(&old_sha1_ctx, &hdr, sizeof(hdr));
diff --git a/sha1_file.c b/sha1_file.c
index 5a2014811f..09ad64ce55 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1748,10 +1748,15 @@ static int index_core(unsigned char *sha1, int fd, size_t size,
 		ret = index_mem(sha1, "", size, type, path, flags);
 	} else if (size <= SMALL_FILE_SIZE) {
 		char *buf = xmalloc(size);
-		if (size == read_in_full(fd, buf, size))
-			ret = index_mem(sha1, buf, size, type, path, flags);
+		ssize_t read_result = read_in_full(fd, buf, size);
+		if (read_result < 0)
+			ret = error_errno("read error while indexing %s",
+					  path ? path : "<unknown>");
+		else if (read_result != size)
+			ret = error("short read while indexing %s",
+				    path ? path : "<unknown>");
 		else
-			ret = error_errno("short read");
+			ret = index_mem(sha1, buf, size, type, path, flags);
 		free(buf);
 	} else {
 		void *buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
-- 
2.14.2.988.g01c8b37dde

