From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] t/test-lib.sh: Let test_must_fail fail on signals
	only
Date: Thu, 17 Jul 2008 02:01:43 -0400
Message-ID: <20080717060143.GA3338@sigill.intra.peff.net>
References: <1215877672-17049-1-git-send-email-s-beyer@gmx.net> <20080716051829.GB4030@segfault.peff.net> <7v4p6qwezy.fsf@gitster.siamese.dyndns.org> <20080717051833.GA3100@sigio.intra.peff.net> <7v3am9m5ne.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 08:02:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJMZh-0001LH-Jn
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 08:02:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569AbYGQGBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 02:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752534AbYGQGBq
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 02:01:46 -0400
Received: from peff.net ([208.65.91.99]:1115 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751870AbYGQGBq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 02:01:46 -0400
Received: (qmail 12802 invoked by uid 111); 17 Jul 2008 06:01:44 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.138)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 17 Jul 2008 02:01:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Jul 2008 02:01:43 -0400
Content-Disposition: inline
In-Reply-To: <7v3am9m5ne.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88805>

On Wed, Jul 16, 2008 at 10:38:45PM -0700, Junio C Hamano wrote:

> "Only the least significant 8 bits (that is, status & 0377) shall be
> available to a waiting parent process".  So it is not just "at least on
> Linux" but is a well defined behaviour.
> 
> http://www.opengroup.org/onlinepubs/000095399/functions/exit.html

Ah, thanks. I read that same text in the Linux manpage but didn't think
to check that it was POSIX. However, some of our systems aren't quite
POSIX...check out 2488df84 (builtin run_command: do not exit with -1) by
Johannes Sixt [who is now cc'd]. I assume that was a Windows fallout.

> I would however agree that when we do mean 255 we should probably write
> 255, not (-1).  It is easier to document things that way.

I started to fix the callsites that Stephan mentioned, but it really is
convenient to be able to 'return error("foo")' (or even return
func_that_calls_error(), and tracking down deep calls is time consuming
and error prone). So maybe we should just enhance the change from
2488df84 and special case "-1" into "1"?

diff --git a/git.c b/git.c
index 6b600b5..4f28e8c 100644
--- a/git.c
+++ b/git.c
@@ -240,7 +240,7 @@ static int run_command(struct cmd_struct *p, int argc, const char **argv)
 
 	status = p->fn(argc, argv, prefix);
 	if (status)
-		return status & 0xff;
+		return status == -1 ? 1 : status & 0xff;
 
 	/* Somebody closed stdout? */
 	if (fstat(fileno(stdout), &st))

-Peff
