Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90CF620705
	for <e@80x24.org>; Thu,  7 Jul 2016 20:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbcGGUcH (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 16:32:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:41631 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751153AbcGGUcE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 16:32:04 -0400
Received: (qmail 5959 invoked by uid 102); 7 Jul 2016 20:32:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 07 Jul 2016 16:32:03 -0400
Received: (qmail 7535 invoked by uid 107); 7 Jul 2016 20:32:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 07 Jul 2016 16:32:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Jul 2016 16:31:58 -0400
Date:	Thu, 7 Jul 2016 16:31:58 -0400
From:	Jeff King <peff@peff.net>
To:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] am: ignore return value of write_file()
Message-ID: <20160707203157.GA11804@sigill.intra.peff.net>
References: <577EB546.1090007@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <577EB546.1090007@web.de>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 07, 2016 at 10:02:14PM +0200, René Scharfe wrote:

> write_file() either returns 0 or dies, so there is no point in checking
> its return value.  The callers of the wrappers write_state_text(),
> write_state_count() and write_state_bool() consequently already ignore
> their return values.  Stop pretenting we care and make them void.

Makes sense. Originally it took "fatal" as a parameter, but it was split
into two functions in 12d6ce1 (write_file(): drop "fatal" parameter,
2015-08-24). The return value on the non-gentle version could have been
dropped at that point.

Arguably we could get rid of the gentle form entirely, as below. The
diffstat is certainly pleasing, but maybe we would eventually want it
for another caller. I dunno. I won't be offended if we drop this as
churn.

-- >8 --
Subject: [PATCH] write_file: drop "gently" form

We have two forms of write_file(): one that dies, and one
that returns an error. However, the latter has only a single
caller, which immediately dies anyway (after producing a
message that is not really any more informative than
write_file's generic die(), and arguably worse because it
does not give the actual filename).

Let's convert that site to use the non-gentle form. At that
point the gentle form has no callers, and we can simplify
the implementation of write_file.

Signed-off-by: Jeff King <peff@peff.net>
---
As a fun aside, this patch was generated using "--patience",
which gives a much closer to result to what I actually
changed than Myers diff (not meaningful to the patch, but
I'm just always on the lookout for cases where the
algorithms produce meaningfully different results).

 builtin/branch.c |  5 +----
 cache.h          |  3 +--
 wrapper.c        | 56 ++++++++++++--------------------------------------------
 3 files changed, 14 insertions(+), 50 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 2ecde53..15232c4 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -618,10 +618,7 @@ static int edit_branch_description(const char *branch_name)
 		    "  %s\n"
 		    "Lines starting with '%c' will be stripped.\n",
 		    branch_name, comment_line_char);
-	if (write_file_gently(git_path(edit_description), "%s", buf.buf)) {
-		strbuf_release(&buf);
-		return error_errno(_("could not write branch description template"));
-	}
+	write_file(git_path(edit_description), "%s", buf.buf);
 	strbuf_reset(&buf);
 	if (launch_editor(git_path(edit_description), &buf, NULL)) {
 		strbuf_release(&buf);
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
+	if (fd < 0)
+		die_errno(_("could not open %s for writing"), path);
+
+	va_start(params, fmt);
 	strbuf_vaddf(&sb, fmt, params);
+	va_end(params);
+
 	strbuf_complete_line(&sb);
-	if (write_in_full(fd, sb.buf, sb.len) != sb.len) {
-		int err = errno;
-		close(fd);
-		strbuf_release(&sb);
-		errno = err;
-		if (fatal)
-			die_errno(_("could not write to %s"), path);
-		return -1;
-	}
+	if (write_in_full(fd, sb.buf, sb.len) != sb.len)
+		die_errno(_("could not write to %s"), path);
 	strbuf_release(&sb);
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
-
-	va_start(params, fmt);
-	status = write_file_v(path, 1, fmt, params);
-	va_end(params);
-	return status;
-}
-
-int write_file_gently(const char *path, const char *fmt, ...)
-{
-	int status;
-	va_list params;
-
-	va_start(params, fmt);
-	status = write_file_v(path, 0, fmt, params);
-	va_end(params);
-	return status;
+	if (close(fd))
+		die_errno(_("could not close %s"), path);
 }
 
 void sleep_millisec(int millisec)
-- 
2.9.0.393.g704e522

