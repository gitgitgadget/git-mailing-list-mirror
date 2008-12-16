From: Jeff King <peff@peff.net>
Subject: Re: git-diff should not fire up $PAGER if there is no diff
Date: Tue, 16 Dec 2008 02:44:14 -0500
Message-ID: <20081216074414.GB2468@coredump.intra.peff.net>
References: <874p15x94i.fsf@jidanni.org> <20081216005658.GB3679@coredump.intra.peff.net> <d4bc1a2a0812152235l14ec80bbr130a7ab152ad6b8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: jidanni@jidanni.org, git@vger.kernel.org
To: Stefan Karpinski <stefan.karpinski@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 08:45:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCUca-00027A-L4
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 08:45:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113AbYLPHoR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 02:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752340AbYLPHoR
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 02:44:17 -0500
Received: from peff.net ([208.65.91.99]:2555 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752276AbYLPHoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 02:44:16 -0500
Received: (qmail 11565 invoked by uid 111); 16 Dec 2008 07:44:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 16 Dec 2008 02:44:15 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Dec 2008 02:44:14 -0500
Content-Disposition: inline
In-Reply-To: <d4bc1a2a0812152235l14ec80bbr130a7ab152ad6b8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103256>

On Tue, Dec 16, 2008 at 01:35:53AM -0500, Stefan Karpinski wrote:

> > On Mon, Dec 15, 2008 at 7:56 PM, Jeff King <peff@peff.net> wrote:
> >  2. detect EOF before starting the pager. We in fact already delay
> >     running the pager in the forked process until we have some activity
> >     on the pipe, but I don't know if there is a portable way of
> >     detecting that that activity is EOF without performing an actual
> >     read() call (which is undesirable, since it eats the first byte of
> >     output that should go to the pager).
> 
> Wouldn't ungetc work? Or is that not portable enough? (It would only
> work here because the EOF has to be the first character.)

No, it won't work. ungetc works on the buffered stdio object, so it is
useful for pushing back characters onto the buffer to be read later in
the program from the same buffer. But in this case, we are going to
execv() (or on Windows, spawn) the pager, meaning it will throw away
anything that has been read() from the pipe and put in the buffer.

So we would need a system call to push a character back to the OS, so
that it was available for read() by the pager process.

-Peff
