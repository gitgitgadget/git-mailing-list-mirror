From: Jeff King <peff@peff.net>
Subject: [PATCH 3/6] strbuf_getwholeline: use getc_unlocked
Date: Sat, 4 Apr 2015 21:11:10 -0400
Message-ID: <20150405011110.GC30127@peff.net>
References: <20150405010611.GA15901@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 05 03:11:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeZ5q-0001Oz-7R
	for gcvg-git-2@plane.gmane.org; Sun, 05 Apr 2015 03:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559AbbDEBLN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2015 21:11:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:42550 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752353AbbDEBLN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2015 21:11:13 -0400
Received: (qmail 19405 invoked by uid 102); 5 Apr 2015 01:11:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 04 Apr 2015 20:11:13 -0500
Received: (qmail 1907 invoked by uid 107); 5 Apr 2015 01:11:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 04 Apr 2015 21:11:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Apr 2015 21:11:10 -0400
Content-Disposition: inline
In-Reply-To: <20150405010611.GA15901@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266792>

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
I don't think the complexity is worth it, but if we wanted to be more
careful about the locks, I think it would probably involve growing the
buffer, locking, doing unlocked reads until it's full, and then
unlocking for the next round of growth.

I also considered optimizing the "term == '\n'" case by using fgets, but
it gets rather complex (you have to pick a size, fgets into it, and then
keep going if you didn't get a newline). Also, fgets sucks, because you
have to call strlen() immediately after to find out how many bytes you
got!

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
2.4.0.rc0.363.gf9f328b
