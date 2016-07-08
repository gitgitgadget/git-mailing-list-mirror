Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F2B62023C
	for <e@80x24.org>; Fri,  8 Jul 2016 09:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754112AbcGHJJj (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 05:09:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:41856 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753990AbcGHJJh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 05:09:37 -0400
Received: (qmail 4958 invoked by uid 102); 8 Jul 2016 09:09:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 Jul 2016 05:09:39 -0400
Received: (qmail 11860 invoked by uid 107); 8 Jul 2016 09:09:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 Jul 2016 05:09:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Jul 2016 05:09:34 -0400
Date:	Fri, 8 Jul 2016 05:09:34 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/8] write_file: drop "gently" form
Message-ID: <20160708090934.GD10152@sigill.intra.peff.net>
References: <20160708090400.GA26594@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160708090400.GA26594@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

There are no callers left of write_file_gently(). Let's drop
it, as it doesn't seem likely for new callers to be added
(since its inception, the only callers who wanted the gentle
form generally just died immediately themselves, and have
since been converted).

While we're there, let's also drop the "int" return from
write_file, as it is never meaningful (in the non-gentle
form, we always either die or return 0).

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h   |  3 +--
 wrapper.c | 54 +++++++++++-------------------------------------------
 2 files changed, 12 insertions(+), 45 deletions(-)

diff --git a/cache.h b/cache.h
index f1dc289..3f6c53f 100644
--- a/cache.h
+++ b/cache.h
@@ -1745,8 +1745,7 @@ static inline ssize_t write_str_in_full(int fd, const char *str)
 	return write_in_full(fd, str, strlen(str));
 }
 
-extern int write_file(const char *path, const char *fmt, ...);
-extern int write_file_gently(const char *path, const char *fmt, ...);
+extern void write_file(const char *path, const char *fmt, ...);
 
 /* pager.c */
 extern void setup_pager(void);
diff --git a/wrapper.c b/wrapper.c
index 5dc4e15..0349441 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -640,56 +640,24 @@ int xsnprintf(char *dst, size_t max, const char *fmt, ...)
 	return len;
 }
 
-static int write_file_v(const char *path, int fatal,
-			const char *fmt, va_list params)
+void write_file(const char *path, const char *fmt, ...)
 {
+	va_list params;
 	struct strbuf sb = STRBUF_INIT;
 	int fd = open(path, O_RDWR | O_CREAT | O_TRUNC, 0666);
-	if (fd < 0) {
-		if (fatal)
-			die_errno(_("could not open %s for writing"), path);
-		return -1;
-	}
-	strbuf_vaddf(&sb, fmt, params);
-	strbuf_complete_line(&sb);
-	if (write_in_full(fd, sb.buf, sb.len) != sb.len) {
-		int err = errno;
-		close(fd);
-		strbuf_release(&sb);
-		errno = err;
-		if (fatal)
-			die_errno(_("could not write to %s"), path);
-		return -1;
-	}
-	strbuf_release(&sb);
-	if (close(fd)) {
-		if (fatal)
-			die_errno(_("could not close %s"), path);
-		return -1;
-	}
-	return 0;
-}
-
-int write_file(const char *path, const char *fmt, ...)
-{
-	int status;
-	va_list params;
+	if (fd < 0)
+		die_errno(_("could not open %s for writing"), path);
 
 	va_start(params, fmt);
-	status = write_file_v(path, 1, fmt, params);
+	strbuf_vaddf(&sb, fmt, params);
 	va_end(params);
-	return status;
-}
-
-int write_file_gently(const char *path, const char *fmt, ...)
-{
-	int status;
-	va_list params;
 
-	va_start(params, fmt);
-	status = write_file_v(path, 0, fmt, params);
-	va_end(params);
-	return status;
+	strbuf_complete_line(&sb);
+	if (write_in_full(fd, sb.buf, sb.len) != sb.len)
+		die_errno(_("could not write to %s"), path);
+	strbuf_release(&sb);
+	if (close(fd))
+		die_errno(_("could not close %s"), path);
 }
 
 void sleep_millisec(int millisec)
-- 
2.9.0.393.g704e522

