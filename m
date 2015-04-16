From: Jeff King <peff@peff.net>
Subject: [PATCH 3/9] strbuf_getwholeline: use getc_unlocked
Date: Thu, 16 Apr 2015 04:49:06 -0400
Message-ID: <20150416084906.GC17938@peff.net>
References: <20150416084733.GA17811@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Rasmus Villemoes <rv@rasmusvillemoes.dk>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 10:49:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YifU3-0000n9-17
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 10:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756917AbbDPItL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 04:49:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:46098 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756904AbbDPItJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 04:49:09 -0400
Received: (qmail 21564 invoked by uid 102); 16 Apr 2015 08:49:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Apr 2015 03:49:09 -0500
Received: (qmail 23435 invoked by uid 107); 16 Apr 2015 08:49:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Apr 2015 04:49:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Apr 2015 04:49:06 -0400
Content-Disposition: inline
In-Reply-To: <20150416084733.GA17811@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267264>

strbuf_getwholeline calls getc in a tight loop. On modern
libc implementations, the stdio code locks the handle for
every operation, which means we are paying a significant
overhead.  We can get around this by locking the handle for
the whole loop and using the unlocked variant.

Running "git rev-parse refs/heads/does-not-exist" on a repo
with an extremely large (1.6GB) packed-refs file went from:

  real    0m18.900s
  user    0m18.472s
  sys     0m0.448s

to:

  real    0m10.953s
  user    0m10.384s
  sys     0m0.580s

for a wall-clock speedup of 42%. All times are best-of-3,
and done on a glibc 2.19 system.

Note that we call into strbuf_grow while holding the lock.
It's possible for that function to call other stdio
functions (e.g., printing to stderr when dying due to malloc
error); however, the POSIX.1-2001 definition of flockfile
makes it clear that the locks are per-handle, so we are fine
unless somebody else tries to read from our same handle.
This doesn't ever happen in the current code, and is
unlikely to be added in the future (we would have to do
something exotic like add a die_routine that tried to read
from stdin).

Signed-off-by: Jeff King <peff@peff.net>
---
 strbuf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/strbuf.c b/strbuf.c
index 14f337d..af2bad4 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -443,12 +443,14 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
 		return EOF;
 
 	strbuf_reset(sb);
-	while ((ch = getc(fp)) != EOF) {
+	flockfile(fp);
+	while ((ch = getc_unlocked(fp)) != EOF) {
 		strbuf_grow(sb, 1);
 		sb->buf[sb->len++] = ch;
 		if (ch == term)
 			break;
 	}
+	funlockfile(fp);
 	if (ch == EOF && sb->len == 0)
 		return EOF;
 
-- 
2.4.0.rc2.384.g7297a4a
