From: Jeff King <peff@peff.net>
Subject: [PATCH 6/9] strbuf_getwholeline: avoid calling strbuf_grow
Date: Thu, 16 Apr 2015 04:58:54 -0400
Message-ID: <20150416085854.GF17938@peff.net>
References: <20150416084733.GA17811@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Rasmus Villemoes <rv@rasmusvillemoes.dk>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 10:59:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YifdY-0006a8-KF
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 10:59:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754318AbbDPI7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 04:59:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:46119 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753335AbbDPI64 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 04:58:56 -0400
Received: (qmail 22020 invoked by uid 102); 16 Apr 2015 08:58:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Apr 2015 03:58:56 -0500
Received: (qmail 23566 invoked by uid 107); 16 Apr 2015 08:59:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Apr 2015 04:59:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Apr 2015 04:58:54 -0400
Content-Disposition: inline
In-Reply-To: <20150416084733.GA17811@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267267>

As with the recent speedup to strbuf_addch, we can avoid
calling strbuf_grow() in a tight loop of single-character
adds by instead checking strbuf_avail.

Note that we would instead call strbuf_addch directly here,
but it does more work than necessary: it will NUL-terminate
the result for each character read. Instead, in this loop we
read the characters one by one and then add the terminator
manually at the end.

Running "git rev-parse refs/heads/does-not-exist" on a repo
with an extremely large (1.6GB) packed-refs file went from
(best-of-5):

  real    0m10.948s
  user    0m10.548s
  sys     0m0.412s

to:

  real    0m8.601s
  user    0m8.084s
  sys     0m0.524s

for a wall-clock speedup of 21%.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Jeff King <peff@peff.net>
---
Our "don't write a NUL for each character" optimization is only possible
because we're intimate with the strbuf details here. I thought about
making a strbuf_addch_unsafe interface to let other callers do this,
too. But the only other caller that would use it is the config reader,
and I measured only a 3% speedup there. Which I don't think is worth the
extra API complexity.

Whereas here it does make a big difference. Switching to strbuf_addch
knocks us back up into the 9.5s range. I think the difference is that
our lines are much longer than the tokens we're parsing in the config
file. So the percentage of wasted NUL writes is much higher here.

 strbuf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/strbuf.c b/strbuf.c
index af2bad4..921619e 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -445,7 +445,8 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
 	strbuf_reset(sb);
 	flockfile(fp);
 	while ((ch = getc_unlocked(fp)) != EOF) {
-		strbuf_grow(sb, 1);
+		if (!strbuf_avail(sb))
+			strbuf_grow(sb, 1);
 		sb->buf[sb->len++] = ch;
 		if (ch == term)
 			break;
-- 
2.4.0.rc2.384.g7297a4a
