From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] config: do not ungetc EOF
Date: Thu, 5 Feb 2015 16:28:47 -0500
Message-ID: <20150205212847.GA2360@peff.net>
References: <20150205065327.GA7807@peff.net>
 <20150205210024.GA30724@peff.net>
 <xmqqr3u4jbyj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 22:28:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJTyp-0001VA-7T
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 22:28:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752698AbbBEV2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 16:28:50 -0500
Received: from cloud.peff.net ([50.56.180.127]:45759 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751322AbbBEV2u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 16:28:50 -0500
Received: (qmail 12347 invoked by uid 102); 5 Feb 2015 21:28:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 Feb 2015 15:28:49 -0600
Received: (qmail 2970 invoked by uid 107); 5 Feb 2015 21:28:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 Feb 2015 16:28:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Feb 2015 16:28:47 -0500
Content-Disposition: inline
In-Reply-To: <xmqqr3u4jbyj.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263408>

On Thu, Feb 05, 2015 at 01:16:36PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Thu, Feb 05, 2015 at 01:53:27AM -0500, Jeff King wrote:
> >
> >> I also notice that config_buf_ungetc does not actually ungetc the
> >> character we give it; it just rewinds one character in the stream. This
> >> is fine, because we always feed the last-retrieved character. I dunno if
> >> it is worth fixing (it also would have fixed this infinite loop, but for
> >> the wrong reason; we would have stuck "-1" back into the stream, and
> >> retrieved it on the next fgetc rather than the same '\r' over and over).
> >
> > Here's a patch to deal with that. I'm not sure if it's worth doing or
> > not.
> 
> I am not sure, either.  If this were to become stdio emulator over
> random in-core data used throughout the system, perhaps.
> 
> But in its current form it is tied to the implementation of config.c
> very strongly, so...

Yeah, that was my thinking, and why I have doubts. Maybe a comment would
make more sense, like the patch below. I am also OK with just leaving
it as-is.

-- >8 --
Subject: [PATCH] config_buf_ungetc: document quirks in a comment

Our config_buf_ungetc implements just enough for the config
code to work. That's OK, but we would not want anyone to
mistakenly move it elsewhere as a general purpose ungetc.

Signed-off-by: Jeff King <peff@peff.net>
---
 config.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/config.c b/config.c
index 2c63099..089a94f 100644
--- a/config.c
+++ b/config.c
@@ -71,6 +71,12 @@ static int config_buf_fgetc(struct config_source *conf)
 	return EOF;
 }
 
+/*
+ * Note that this is not a real ungetc replacement. It only rewinds
+ * the position, and ignores the "c" parameter, rather than
+ * putting it into our (const) buffer. That's good enough for
+ * the callers here, though.
+ */
 static int config_buf_ungetc(int c, struct config_source *conf)
 {
 	if (conf->u.buf.pos > 0)
-- 
2.3.0.rc1.287.g761fd19
