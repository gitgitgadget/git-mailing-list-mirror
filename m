Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 105E21F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 23:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758389AbcHCXCz (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 19:02:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:54419 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751183AbcHCXCy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 19:02:54 -0400
Received: (qmail 22859 invoked by uid 102); 3 Aug 2016 23:01:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 19:01:45 -0400
Received: (qmail 8021 invoked by uid 107); 3 Aug 2016 23:02:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 19:02:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Aug 2016 19:01:42 -0400
Date:	Wed, 3 Aug 2016 19:01:42 -0400
From:	Jeff King <peff@peff.net>
To:	larsxschneider@gmail.com
Cc:	git@vger.kernel.org
Subject: [PATCH 7/7] write_or_die: drop write_or_whine_pipe()
Message-ID: <20160803230141.fujy7umrihw2utpu@sigill.intra.peff.net>
References: <20160803225600.fgm23bdacunmrw44@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160803225600.fgm23bdacunmrw44@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This function has no callers, and is not likely to gain any
because it's confusing to use.

It unconditionally complains to stderr, but _doesn't_ die.
Yet any caller which wants a "gentle" write would generally
want to suppress the error message, because presumably
they're going to write a better one, and/or try the
operation again.

And the check_pipe() call leads to confusing behaviors. It
means we die for EPIPE, but not for other errors, which is
confusing and pointless.

On top of all that, it has unusual error return semantics,
which makes it easy for callers to get it wrong.

Let's drop the function, and if somebody ever needs to
resurrect something like it, they can fix these warts.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h        |  1 -
 write_or_die.c | 12 ------------
 2 files changed, 13 deletions(-)

diff --git a/cache.h b/cache.h
index b5f76a4..3885911 100644
--- a/cache.h
+++ b/cache.h
@@ -1740,7 +1740,6 @@ extern int copy_file(const char *dst, const char *src, int mode);
 extern int copy_file_with_time(const char *dst, const char *src, int mode);
 
 extern void write_or_die(int fd, const void *buf, size_t count);
-extern int write_or_whine_pipe(int fd, const void *buf, size_t count, const char *msg);
 extern void fsync_or_die(int fd, const char *);
 
 extern ssize_t read_in_full(int fd, void *buf, size_t count);
diff --git a/write_or_die.c b/write_or_die.c
index 9816879..0734432 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -82,15 +82,3 @@ void write_or_die(int fd, const void *buf, size_t count)
 		die_errno("write error");
 	}
 }
-
-int write_or_whine_pipe(int fd, const void *buf, size_t count, const char *msg)
-{
-	if (write_in_full(fd, buf, count) < 0) {
-		check_pipe(errno);
-		fprintf(stderr, "%s: write error (%s)\n",
-			msg, strerror(errno));
-		return 0;
-	}
-
-	return 1;
-}
-- 
2.9.2.670.g42e63de
