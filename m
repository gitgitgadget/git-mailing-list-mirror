Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6CAE20A29
	for <e@80x24.org>; Wed, 27 Sep 2017 06:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752473AbdI0GAb (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 02:00:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:51556 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752470AbdI0GAa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 02:00:30 -0400
Received: (qmail 25309 invoked by uid 109); 27 Sep 2017 06:00:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 06:00:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11430 invoked by uid 111); 27 Sep 2017 06:01:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 02:01:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Sep 2017 02:00:28 -0400
Date:   Wed, 27 Sep 2017 02:00:28 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/7] prefer "!=" when checking read_in_full() result
Message-ID: <20170927060028.ehddn5zwf6v6jsvs@sigill.intra.peff.net>
References: <20170927055424.22ati3g24xaqtqrk@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170927055424.22ati3g24xaqtqrk@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Comparing the result of read_in_full() using less-than is
potentially dangerous, as a negative return value may be
converted to an unsigned type and be considered a success.
This is discussed further in 561598cfcf (read_pack_header:
handle signed/unsigned comparison in read result,
2017-09-13).

Each of these instances is actually fine in practice:

 - in get-tar-commit-id, the HEADERSIZE macro expands to a
   signed integer. If it were switched to an unsigned type
   (e.g., a size_t), then it would be a bug.

 - the other two callers check for a short read only after
   handling a negative return separately. This is a fine
   practice, but we'd prefer to model "!=" as a general
   rule.

So all of these cases can be considered cleanups and not
actual bugfixes.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/get-tar-commit-id.c | 2 +-
 csum-file.c                 | 2 +-
 pkt-line.c                  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/get-tar-commit-id.c b/builtin/get-tar-commit-id.c
index 6d9a79f9b3..cd3e656828 100644
--- a/builtin/get-tar-commit-id.c
+++ b/builtin/get-tar-commit-id.c
@@ -26,7 +26,7 @@ int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix)
 		usage(builtin_get_tar_commit_id_usage);
 
 	n = read_in_full(0, buffer, HEADERSIZE);
-	if (n < HEADERSIZE)
+	if (n != HEADERSIZE)
 		die("git get-tar-commit-id: read error");
 	if (header->typeflag[0] != 'g')
 		return 1;
diff --git a/csum-file.c b/csum-file.c
index a172199e44..2adae04073 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -19,7 +19,7 @@ static void flush(struct sha1file *f, const void *buf, unsigned int count)
 
 		if (ret < 0)
 			die_errno("%s: sha1 file read error", f->name);
-		if (ret < count)
+		if (ret != count)
 			die("%s: sha1 file truncated", f->name);
 		if (memcmp(buf, check_buffer, count))
 			die("sha1 file '%s' validation error", f->name);
diff --git a/pkt-line.c b/pkt-line.c
index 647bbd3bce..93ea311443 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -258,7 +258,7 @@ static int get_packet_data(int fd, char **src_buf, size_t *src_size,
 	}
 
 	/* And complain if we didn't get enough bytes to satisfy the read. */
-	if (ret < size) {
+	if (ret != size) {
 		if (options & PACKET_READ_GENTLE_ON_EOF)
 			return -1;
 
-- 
2.14.2.988.g01c8b37dde

