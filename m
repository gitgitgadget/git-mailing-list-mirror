Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0251A2023C
	for <e@80x24.org>; Fri,  8 Jul 2016 09:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754200AbcGHJMc (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 05:12:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:41868 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754074AbcGHJM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 05:12:26 -0400
Received: (qmail 5121 invoked by uid 102); 8 Jul 2016 09:12:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 Jul 2016 05:12:27 -0400
Received: (qmail 11907 invoked by uid 107); 8 Jul 2016 09:12:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 Jul 2016 05:12:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Jul 2016 05:12:22 -0400
Date:	Fri, 8 Jul 2016 05:12:22 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/8] write_file: add pointer+len variant
Message-ID: <20160708091222.GF10152@sigill.intra.peff.net>
References: <20160708090400.GA26594@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160708090400.GA26594@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

There are many callsites which could use write_file, but for
which it is a little awkward because they have a strbuf or
other pointer/len combo. Specifically:

 1. write_file() takes a format string, so we have to use
    "%s" or "%.*s", which are ugly.

 2. Using any form of "%s" does not handle embedded NULs in
    the output. That probably doesn't matter for our
    call-sites, but it's nicer not to have to worry.

 3. It's less efficient; we format into another strbuf
    just to do the write. That's probably not measurably
    slow for our uses, but it's simply inelegant.

We can fix this by providing a helper to write out the
formatted buffer, and just calling it from write_file().

Note that we don't do the usual "complete with a newline"
that write_file does. If the caller has their own buffer,
there's a reasonable chance they're doing something more
complicated than a single line, and they can call
strbuf_complete_line() themselves.

We could go even further and add strbuf_write_file(), but it
doesn't save much:

  -  write_file_buf(path, sb.buf, sb.len);
  +  strbuf_write_file(&sb, path);

It would also be somewhat asymmetric with strbuf_read_file,
which actually returns errors rather than dying (and the
error handling is most of the benefit of write_file() in the
first place).

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h   |  6 ++++++
 wrapper.c | 16 +++++++++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index 3f6c53f..9d6ad4f 100644
--- a/cache.h
+++ b/cache.h
@@ -1745,6 +1745,12 @@ static inline ssize_t write_str_in_full(int fd, const char *str)
 	return write_in_full(fd, str, strlen(str));
 }
 
+/**
+ * Open (and truncate) the file at path, write the contents of buf to it,
+ * and close it. Dies if any errors are encountered.
+ */
+extern void write_file_buf(const char *path, const char *buf, size_t len);
+
 extern void write_file(const char *path, const char *fmt, ...);
 
 /* pager.c */
diff --git a/wrapper.c b/wrapper.c
index 7c126b8..b827206 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -640,22 +640,28 @@ int xsnprintf(char *dst, size_t max, const char *fmt, ...)
 	return len;
 }
 
+void write_file_buf(const char *path, const char *buf, size_t len)
+{
+	int fd = xopen(path, O_WRONLY | O_CREAT | O_TRUNC, 0666);
+	if (write_in_full(fd, buf, len) != len)
+		die_errno(_("could not write to %s"), path);
+	if (close(fd))
+		die_errno(_("could not close %s"), path);
+}
+
 void write_file(const char *path, const char *fmt, ...)
 {
 	va_list params;
 	struct strbuf sb = STRBUF_INIT;
-	int fd = xopen(path, O_WRONLY | O_CREAT | O_TRUNC, 0666);
 
 	va_start(params, fmt);
 	strbuf_vaddf(&sb, fmt, params);
 	va_end(params);
 
 	strbuf_complete_line(&sb);
-	if (write_in_full(fd, sb.buf, sb.len) != sb.len)
-		die_errno(_("could not write to %s"), path);
+
+	write_file_buf(path, sb.buf, sb.len);
 	strbuf_release(&sb);
-	if (close(fd))
-		die_errno(_("could not close %s"), path);
 }
 
 void sleep_millisec(int millisec)
-- 
2.9.0.393.g704e522

