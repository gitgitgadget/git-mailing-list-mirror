From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] vreportf: avoid intermediate buffer
Date: Tue, 11 Aug 2015 14:13:59 -0400
Message-ID: <20150811181359.GB18002@sigill.intra.peff.net>
References: <20150811180524.GB15521@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 20:14:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPE3u-0000Ij-AT
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 20:14:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752251AbbHKSOF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 14:14:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:43750 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751191AbbHKSOE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 14:14:04 -0400
Received: (qmail 27894 invoked by uid 102); 11 Aug 2015 18:14:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Aug 2015 13:14:03 -0500
Received: (qmail 17648 invoked by uid 107); 11 Aug 2015 18:14:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Aug 2015 14:14:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Aug 2015 14:13:59 -0400
Content-Disposition: inline
In-Reply-To: <20150811180524.GB15521@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275706>

When we call "die(fmt, args...)", we end up in vreportf with
two pieces of information:

  1. The prefix "fatal: "

  2. The original fmt and va_list of args.

We format item (2) into a temporary buffer, and then fprintf
the prefix and the temporary buffer, along with a newline.
This has the unfortunate side effect of truncating any error
messages that are longer than 4096 bytes.

Instead, let's use separate calls for the prefix and
newline, letting us hand the item (2) directly to vfprintf.
This is essentially undoing d048a96 (print
warning/error/fatal messages in one shot, 2007-11-09), which
tried to have the whole output end up in a single `write`
call.

But we can address this instead by explicitly requesting
line-buffering for the output handle, and by making sure
that the buffer is empty before we start (so that outputting
the prefix does not cause a flush due to hitting the buffer
limit).

We may still break the output into two writes if the content
is larger than our buffer, but there's not much we can do
there; depending on the stdio implementation, that might
have happened even with a single fprintf call.

Signed-off-by: Jeff King <peff@peff.net>
---
I am not 100% sure on the last statement. On my system, it seems that:

  fprintf(stderr, "%s%s\n", prefix, msg);

will generally result in a single write when stderr is unbuffered (i.e.,
it's default state). Which feels very magical, since it clearly must be
preparing the output in a single buffer to feed to write, and the
contents of prefix and msg may easily exceed BUFSIZ. It looks like
glibc internally uses an 8K buffer to generate "unbuffered" content.
E.g., if I do:

  strace -o /dev/fd/3 -e write \
  git --no-pager log --$(perl -e 'print "a" x 4096') \
  3>&2 2>/dev/null

I get:

  write(2, "fatal: unrecognized argument: --"..., 4129) = 4129

and if I bump the 4096 to 16384, I get:

  write(2, "fatal: unrecognized argument: --"..., 8192) = 8192
  write(2, "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"..., 8192) = 8192
  write(2, "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"..., 33) = 33

So that's kind of weird. I suspect other stdio implementations may
behave differently, and AFAIK the standard is quiet on the subject (so
it would be OK for an implementation to output the prefix, the msg, and
the newline in separate writes, no matter their length).

 usage.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/usage.c b/usage.c
index e4fa6d2..82ff131 100644
--- a/usage.c
+++ b/usage.c
@@ -7,13 +7,21 @@
 #include "cache.h"
 
 static FILE *error_handle;
+static int tweaked_error_buffering;
 
 void vreportf(const char *prefix, const char *err, va_list params)
 {
-	char msg[4096];
 	FILE *fh = error_handle ? error_handle : stderr;
-	vsnprintf(msg, sizeof(msg), err, params);
-	fprintf(fh, "%s%s\n", prefix, msg);
+
+	fflush(fh);
+	if (!tweaked_error_buffering) {
+		setvbuf(fh, NULL, _IOLBF, 0);
+		tweaked_error_buffering = 1;
+	}
+
+	fputs(prefix, fh);
+	vfprintf(fh, err, params);
+	fputc('\n', fh);
 }
 
 static NORETURN void usage_builtin(const char *err, va_list params)
@@ -70,6 +78,7 @@ void set_die_is_recursing_routine(int (*routine)(void))
 void set_error_handle(FILE *fh)
 {
 	error_handle = fh;
+	tweaked_error_buffering = 0;
 }
 
 void NORETURN usagef(const char *err, ...)
-- 
2.5.0.417.g2db689c
