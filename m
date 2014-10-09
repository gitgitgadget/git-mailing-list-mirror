From: Jeff King <peff@peff.net>
Subject: Re: Some PRETTY FORMATS format:<string> options don't work with
 git-archive export-subst $Format:$
Date: Thu, 9 Oct 2014 15:07:22 -0400
Message-ID: <20141009190722.GA415@peff.net>
References: <CAMsgyKb_-Xm0DH1-xVZa0XHs59nZsOxGwwLWKx-YiTmsJtrFHQ@mail.gmail.com>
 <CAMsgyKYKAUXamcGOtUi3Bq-u4B9JaG2sk-Gttf+A1U2mwhghrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Derek Moore <derek.p.moore@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 09 21:07:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcJ3h-0002O8-Op
	for gcvg-git-2@plane.gmane.org; Thu, 09 Oct 2014 21:07:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbaJITH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2014 15:07:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:56876 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751065AbaJITHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2014 15:07:25 -0400
Received: (qmail 32492 invoked by uid 102); 9 Oct 2014 19:07:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Oct 2014 14:07:24 -0500
Received: (qmail 26951 invoked by uid 107); 9 Oct 2014 19:07:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Oct 2014 15:07:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Oct 2014 15:07:22 -0400
Content-Disposition: inline
In-Reply-To: <CAMsgyKYKAUXamcGOtUi3Bq-u4B9JaG2sk-Gttf+A1U2mwhghrw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 09, 2014 at 12:42:39PM -0500, Derek Moore wrote:

> As far as I've tested it would seem only %N doesn't resolve inside of
> $Format:$, until I maybe do unit tests for this to identify any
> others.

Yes, %N is somewhat special in that the calling code needs to initialize
the notes tree itself. We can't just do it lazily when we see the first
%N because _which_ notes we show depends on other options (e.g., for
log, if you've used --notes-ref, --show-notes=..., etc).

So in theory you need something like 5b16360 (pretty: Initialize notes
if %N is used, 2010-04-13), but adapted for git-archive. The trick,
though, is that we do not even see the format string until we are
looking at a particular file with a $Format$ marker. So you'd have to
lazily initialize notes there (and if you want to support picking
specific notes refs, you'd have to teach git-archive new options to do
so[1]).

Here's a quick-and-dirty patch that makes the snippet you posted earlier
do what I think you expected. I haven't tested it beyond that, and am
not planning to push it forward myself, but please feel free to use it
as a basis for building a solution.

---
diff --git a/archive.c b/archive.c
index 952a659..3af781e 100644
--- a/archive.c
+++ b/archive.c
@@ -5,6 +5,7 @@
 #include "archive.h"
 #include "parse-options.h"
 #include "unpack-trees.h"
+#include "notes.h"
 
 static char const * const archive_usage[] = {
 	N_("git archive [options] <tree-ish> [<path>...]"),
@@ -38,6 +39,8 @@ static void format_subst(const struct commit *commit,
 	if (src == buf->buf)
 		to_free = strbuf_detach(buf, NULL);
 	for (;;) {
+		struct userformat_want ufw = {0};
+		struct strbuf notes = STRBUF_INIT;
 		const char *b, *c;
 
 		b = memmem(src, len, "$Format:", 8);
@@ -50,10 +53,31 @@ static void format_subst(const struct commit *commit,
 		strbuf_reset(&fmt);
 		strbuf_add(&fmt, b + 8, c - b - 8);
 
+		userformat_find_requirements(fmt.buf, &ufw);
+		if (ufw.notes) {
+			static int initialized;
+			if (!initialized) {
+				init_display_notes(NULL);
+				initialized = 1;
+			}
+			format_display_notes(commit->object.sha1, &notes,
+					     get_log_output_encoding(), 1);
+			/*
+			 * trim trailing newlines from note content, which is
+			 * probably more appropriate for $Format$; should
+			 * this actually remove internal newlines, too?
+			 */
+			strbuf_rtrim(&notes);
+		}
+		ctx.notes_message = notes.buf;
+
 		strbuf_add(buf, src, b - src);
 		format_commit_message(commit, fmt.buf, buf, &ctx);
 		len -= c + 1 - src;
 		src  = c + 1;
+
+		ctx.notes_message = NULL;
+		strbuf_release(&notes);
 	}
 	strbuf_add(buf, src, len);
 	strbuf_release(&fmt);

-Peff

[1] I think you could get pretty far using `git -c core.notesRef=foo` to
    give ad-hoc config, as the notes code should use that as the
    ultimate default. But I didn't try it.
