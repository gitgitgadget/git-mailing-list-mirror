From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Enable HAVE_DEV_TTY for Solaris
Date: Tue, 7 Aug 2012 00:10:26 -0400
Message-ID: <20120807041026.GA21918@sigill.intra.peff.net>
References: <20120807003541.GA18219@sigill.intra.peff.net>
 <1344308862-24635-1-git-send-email-bwalton@artsci.utoronto.ca>
 <7v4nofxt89.fsf@alter.siamese.dyndns.org>
 <20120807040326.GA18682@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ben Walton <bwalton@artsci.utoronto.ca>, git@vger.kernel.org,
	rctay89@gmail.com, schwab@linux-m68k.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 06:11:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Syb8V-0002FF-Nm
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 06:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782Ab2HGEKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 00:10:30 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54092 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750702Ab2HGEKa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 00:10:30 -0400
Received: (qmail 24153 invoked by uid 107); 7 Aug 2012 04:10:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Aug 2012 00:10:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Aug 2012 00:10:26 -0400
Content-Disposition: inline
In-Reply-To: <20120807040326.GA18682@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203011>

On Tue, Aug 07, 2012 at 12:03:26AM -0400, Jeff King wrote:

> > So which direction do you guys want to go?  Use the "bidirectional
> > stdio with fseek()" for now, with the expectation that Tay's other
> > series will rewrite it to fd based one?
> 
> I think so. The stdio fix is short and obviously correct, and then Tay
> can either refactor or not as he sees fit for his topic (although if we
> do switch to just a terminal_can_prompt() interface and get rid of the
> term_t ugliness, then there is not even any need to do the rewrite).

And here it is again, this time with a signed-off-by (I fixed my script
after our last discussion, but accidentally copied an old version to the
Solaris VM I just installed. ;) ).

-- >8 --
Subject: [PATCH] terminal: seek when switching between reading and writing

When a stdio stream is opened in update mode (e.g., "w+"),
the C standard forbids switching between reading or writing
without an intervening positioning function. Many
implementations are lenient about this, but Solaris libc
will flush the recently-read contents to the output buffer.
In this instance, that meant writing the non-echoed password
that the user just typed to the terminal.

Fix it by inserting a no-op fseek between the read and
write.

The opposite direction (writing followed by reading) is also
disallowed, but our intervening fflush is an acceptable
positioning function for that alternative.

Signed-off-by: Jeff King <peff@peff.net>
---
 compat/terminal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/compat/terminal.c b/compat/terminal.c
index 6d16c8f..bbb038d 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -59,6 +59,7 @@ char *git_terminal_prompt(const char *prompt, int echo)
 
 	r = strbuf_getline(&buf, fh, '\n');
 	if (!echo) {
+		fseek(fh, SEEK_CUR, 0);
 		putc('\n', fh);
 		fflush(fh);
 	}
