From: Jeff King <peff@peff.net>
Subject: [PATCH 1/6] strbuf_getwholeline: use getc macro
Date: Sat, 4 Apr 2015 21:07:35 -0400
Message-ID: <20150405010734.GA30127@peff.net>
References: <20150405010611.GA15901@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 05 03:07:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeZ2M-0007Qu-Kn
	for gcvg-git-2@plane.gmane.org; Sun, 05 Apr 2015 03:07:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628AbbDEBHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2015 21:07:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:42542 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752559AbbDEBHh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2015 21:07:37 -0400
Received: (qmail 19262 invoked by uid 102); 5 Apr 2015 01:07:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 04 Apr 2015 20:07:37 -0500
Received: (qmail 1832 invoked by uid 107); 5 Apr 2015 01:07:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 04 Apr 2015 21:07:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Apr 2015 21:07:35 -0400
Content-Disposition: inline
In-Reply-To: <20150405010611.GA15901@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266790>

strbuf_getwholeline calls fgetc in a tight loop. Using the
getc form, which can be implemented as a macro, should be
faster (and we do not care about it evaluating our argument
twice, as we just have a plain variable).

On my glibc system, running "git rev-parse
refs/heads/does-not-exist" on a file with an extremely large
(1.6GB) packed-refs file went from (best of 3 runs):

  real    0m19.383s
  user    0m18.876s
  sys     0m0.528s

to:

  real    0m18.900s
  user    0m18.472s
  sys     0m0.448s

for a wall-clock speedup of 2.5%.

Signed-off-by: Jeff King <peff@peff.net>
---
Not that exciting a speedup. But later we will switch to getc_unlocked,
and I wanted to measure how much of that was coming from the macro, and
how much from the locking.

 strbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/strbuf.c b/strbuf.c
index 88cafd4..14f337d 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -443,7 +443,7 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
 		return EOF;
 
 	strbuf_reset(sb);
-	while ((ch = fgetc(fp)) != EOF) {
+	while ((ch = getc(fp)) != EOF) {
 		strbuf_grow(sb, 1);
 		sb->buf[sb->len++] = ch;
 		if (ch == term)
-- 
2.4.0.rc0.363.gf9f328b
