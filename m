Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A55E720286
	for <e@80x24.org>; Wed, 13 Sep 2017 17:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751326AbdIMRQl (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 13:16:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:37082 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751167AbdIMRQc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 13:16:32 -0400
Received: (qmail 22903 invoked by uid 109); 13 Sep 2017 17:16:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 17:16:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16611 invoked by uid 111); 13 Sep 2017 17:17:05 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 13:17:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Sep 2017 13:16:28 -0400
Date:   Wed, 13 Sep 2017 13:16:28 -0400
From:   Jeff King <peff@peff.net>
To:     demerphq <demerphq@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 4/7] convert less-trivial versions of "write_in_full() != len"
Message-ID: <20170913171628.o4euxlzk4imlf4tv@sigill.intra.peff.net>
References: <20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The prior commit converted many sites to check the return
value of write_in_full() for negativity, rather than a
mismatch with the input length. This patch covers similar
cases, but where the return value is stored in an
intermediate variable. These should get the same treatment,
but they need to be reviewed more carefully since it would
be a bug if the return value is stored in an unsigned type
(which indeed, it is in one of the cases).

Signed-off-by: Jeff King <peff@peff.net>
---
 entry.c              | 5 +++--
 refs/files-backend.c | 2 +-
 streaming.c          | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/entry.c b/entry.c
index cb291aa88b..1c7e3c11d5 100644
--- a/entry.c
+++ b/entry.c
@@ -257,7 +257,8 @@ static int write_entry(struct cache_entry *ce,
 	char *new;
 	struct strbuf buf = STRBUF_INIT;
 	unsigned long size;
-	size_t wrote, newsize = 0;
+	ssize_t wrote;
+	size_t newsize = 0;
 	struct stat st;
 	const struct submodule *sub;
 
@@ -332,7 +333,7 @@ static int write_entry(struct cache_entry *ce,
 			fstat_done = fstat_output(fd, state, &st);
 		close(fd);
 		free(new);
-		if (wrote != size)
+		if (wrote < 0)
 			return error("unable to write file %s", path);
 		break;
 	case S_IFGITLINK:
diff --git a/refs/files-backend.c b/refs/files-backend.c
index f8b91fff3f..489471bbcf 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1549,7 +1549,7 @@ static int log_ref_write_fd(int fd, const struct object_id *old_oid,
 
 	written = len <= maxlen ? write_in_full(fd, logrec, len) : -1;
 	free(logrec);
-	if (written != len)
+	if (written < 0)
 		return -1;
 
 	return 0;
diff --git a/streaming.c b/streaming.c
index 6f1c60f12b..5892b50bd8 100644
--- a/streaming.c
+++ b/streaming.c
@@ -540,7 +540,7 @@ int stream_blob_to_fd(int fd, const struct object_id *oid, struct stream_filter
 			kept = 0;
 		wrote = write_in_full(fd, buf, readlen);
 
-		if (wrote != readlen)
+		if (wrote < 0)
 			goto close_and_exit;
 	}
 	if (kept && (lseek(fd, kept - 1, SEEK_CUR) == (off_t) -1 ||
-- 
2.14.1.874.ge7b2e05270

