From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] config: do not ungetc EOF
Date: Thu, 5 Feb 2015 16:00:24 -0500
Message-ID: <20150205210024.GA30724@peff.net>
References: <20150205065327.GA7807@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Heiko Voigt <hvoigt@hvoigt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 05 22:00:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJTXM-0005qz-Hy
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 22:00:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752882AbbBEVA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 16:00:28 -0500
Received: from cloud.peff.net ([50.56.180.127]:45734 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751062AbbBEVA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 16:00:27 -0500
Received: (qmail 11127 invoked by uid 102); 5 Feb 2015 21:00:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 Feb 2015 15:00:27 -0600
Received: (qmail 2673 invoked by uid 107); 5 Feb 2015 21:00:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 Feb 2015 16:00:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Feb 2015 16:00:24 -0500
Content-Disposition: inline
In-Reply-To: <20150205065327.GA7807@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263405>

On Thu, Feb 05, 2015 at 01:53:27AM -0500, Jeff King wrote:

> I also notice that config_buf_ungetc does not actually ungetc the
> character we give it; it just rewinds one character in the stream. This
> is fine, because we always feed the last-retrieved character. I dunno if
> it is worth fixing (it also would have fixed this infinite loop, but for
> the wrong reason; we would have stuck "-1" back into the stream, and
> retrieved it on the next fgetc rather than the same '\r' over and over).

Here's a patch to deal with that. I'm not sure if it's worth doing or
not.

-- >8 --
Subject: [PATCH] config_buf_ungetc: warn when pushing back a random character

Our config code simulates a stdio stream around a buffer,
but our fake ungetc() does not behave quite like the real
one. In particular, we only rewind the position by one
character, but do _not_ actually put the character from the
caller into position.

It turns out that this does not matter, because we only ever
push back the character we just read. In other words, such
an assignment would be a noop. But because the function is
called ungetc, and because it takes a character parameter,
it is a mistake waiting to happen.

Actually assigning the character into the buffer would be
ideal, but our pointer is actually a "const" copy of the
buffer. We do not know who the real owner of the buffer is
in this code, and would not want to munge their contents.

Instead, we can simply add an assertion that matches what
the current caller does, and will let us know if new callers
are added that violate the contract.

Signed-off-by: Jeff King <peff@peff.net>
---
 config.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index 2c63099..b74cc47 100644
--- a/config.c
+++ b/config.c
@@ -73,8 +73,12 @@ static int config_buf_fgetc(struct config_source *conf)
 
 static int config_buf_ungetc(int c, struct config_source *conf)
 {
-	if (conf->u.buf.pos > 0)
-		return conf->u.buf.buf[--conf->u.buf.pos];
+	if (conf->u.buf.pos > 0) {
+		conf->u.buf.pos--;
+		if (conf->u.buf.buf[conf->u.buf.pos] != c)
+			die("BUG: config_buf can only ungetc the same character");
+		return c;
+	}
 
 	return EOF;
 }
-- 
2.3.0.rc1.287.g761fd19
