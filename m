From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Avoid crippled getpass function on Solaris
Date: Mon, 6 Aug 2012 20:35:41 -0400
Message-ID: <20120807003541.GA18219@sigill.intra.peff.net>
References: <1344208672-20028-1-git-send-email-bwalton@artsci.utoronto.ca>
 <7vboio231n.fsf@alter.siamese.dyndns.org>
 <1344220427-sup-3468@pinkfloyd.chass.utoronto.ca>
 <20120806193958.GA10039@sigill.intra.peff.net>
 <1344287843-sup-6200@pinkfloyd.chass.utoronto.ca>
 <20120806213404.GA14320@sigill.intra.peff.net>
 <1344290892-sup-1108@pinkfloyd.chass.utoronto.ca>
 <20120806223113.GA16298@sigill.intra.peff.net>
 <m2pq73zkmu.fsf@igel.home>
 <20120807002318.GA17498@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, Tay Ray Chuan <rctay89@gmail.com>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Aug 07 02:36:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyXmT-0000zh-4G
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 02:36:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756333Ab2HGAgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Aug 2012 20:36:09 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53925 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756295Ab2HGAfp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2012 20:35:45 -0400
Received: (qmail 21885 invoked by uid 107); 7 Aug 2012 00:35:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Aug 2012 20:35:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Aug 2012 20:35:41 -0400
Content-Disposition: inline
In-Reply-To: <20120807002318.GA17498@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203002>

On Mon, Aug 06, 2012 at 08:23:18PM -0400, Jeff King wrote:

> This is all moot if we end up ripping stdio out of this code for other
> reasons, but it does give us another option for a fix.

And here is what that patch would look like:

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

The opposite direction (writing immediately followed by
reading) is also disallowed, but our fflush immediately
after printing the prompt is sufficient to satisfy the
standard.
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
