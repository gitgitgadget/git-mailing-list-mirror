From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] strbuf_getwholeline: use getc_unlocked
Date: Sun, 5 Apr 2015 00:56:15 -0400
Message-ID: <20150405045614.GA12053@peff.net>
References: <20150405010611.GA15901@peff.net>
 <20150405011110.GC30127@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 05 06:58:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yecdo-00011K-4B
	for gcvg-git-2@plane.gmane.org; Sun, 05 Apr 2015 06:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbbDEE4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2015 00:56:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:42567 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750746AbbDEE4R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2015 00:56:17 -0400
Received: (qmail 4287 invoked by uid 102); 5 Apr 2015 04:56:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 04 Apr 2015 23:56:18 -0500
Received: (qmail 2887 invoked by uid 107); 5 Apr 2015 04:56:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 05 Apr 2015 00:56:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Apr 2015 00:56:15 -0400
Content-Disposition: inline
In-Reply-To: <20150405011110.GC30127@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266796>

On Sat, Apr 04, 2015 at 09:11:10PM -0400, Jeff King wrote:

> I also considered optimizing the "term == '\n'" case by using fgets, but
> it gets rather complex (you have to pick a size, fgets into it, and then
> keep going if you didn't get a newline). Also, fgets sucks, because you
> have to call strlen() immediately after to find out how many bytes you
> got!

My initial attempt at this had been to _just_ use fgets, but the
optimization becomes much simpler if you just do an initial fgets, and
then follow up with character reads. In most cases, the initial fgets
is big enough to get the whole line.

I.e., doing:

diff --git a/strbuf.c b/strbuf.c
index 2facd5f..f319d8d 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -443,6 +443,18 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
 		return EOF;
 
 	strbuf_reset(sb);
+
+	if (term == '\n') {
+		strbuf_grow(sb, 256);
+		if (!fgets(sb->buf, sb->alloc - 1, fp)) {
+			strbuf_release(sb);
+			return EOF;
+		}
+		sb->len = strlen(sb->buf);
+		if (sb->buf[sb->len - 1] == '\n')
+			return 0;
+	}
+
 	flockfile(fp);
 	while ((ch = getc_unlocked(fp)) != EOF) {
 		strbuf_grow_ch(sb);

on top of the series drops me from:

  real    0m8.573s
  user    0m8.072s
  sys     0m0.508s

to:

  real    0m6.671s
  user    0m6.216s
  sys     0m0.460s

which is back to the v2.0.0 number. Even with the extra strlen, it seems
that what fgets does internally beats repeated getc calls. Which I guess
is not too surprising, as each getc() will have to check for underflow
in the buffer. Perhaps there is more room to micro-optimize
strbuf_getwholeline, but I kind of doubt it.

The big downside is that our input strings are no longer NUL-clean
(reading "foo\0bar\n" would yield just "foo". I doubt that matters in
the real world, but it does fail a few of the tests (e.g., t7008 tries
to read a list of patterns which includes NUL, and we silently truncate
the pattern rather than read in the NUL and barf).

So we'd have to either:

  1. Decide that doesn't matter.

  2. Have callers specify a "damn the NULs, I want it fast" flag.

  3. Find some alternative that is more robust than fgets, and faster
     than getc. I don't think there is anything in stdio, but I am not
     above dropping in a faster non-portable call if it is available,
     and then falling back to the current code otherwise.

-Peff
