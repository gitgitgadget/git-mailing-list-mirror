From: Jeff King <peff@peff.net>
Subject: [PATCH 1/9] strbuf_getwholeline: use getc macro
Date: Thu, 16 Apr 2015 04:48:23 -0400
Message-ID: <20150416084822.GA17938@peff.net>
References: <20150416084733.GA17811@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Rasmus Villemoes <rv@rasmusvillemoes.dk>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 10:48:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YifTM-0000KT-1F
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 10:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932841AbbDPIs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 04:48:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:46086 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753444AbbDPIsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 04:48:25 -0400
Received: (qmail 21535 invoked by uid 102); 16 Apr 2015 08:48:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Apr 2015 03:48:25 -0500
Received: (qmail 23397 invoked by uid 107); 16 Apr 2015 08:48:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Apr 2015 04:48:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Apr 2015 04:48:23 -0400
Content-Disposition: inline
In-Reply-To: <20150416084733.GA17811@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267262>

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
2.4.0.rc2.384.g7297a4a
