From: Jeff King <peff@peff.net>
Subject: Re: old but persistent problem: bad line length character
Date: Tue, 7 Jun 2011 14:06:25 -0400
Message-ID: <20110607180624.GA23752@sigill.intra.peff.net>
References: <alpine.DEB.1.10.1106071832470.4175@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Peter Kleiweg <p.c.j.kleiweg@rug.nl>
X-From: git-owner@vger.kernel.org Tue Jun 07 20:06:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU0fw-0004Tt-My
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 20:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753046Ab1FGSG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 14:06:29 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40041
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751618Ab1FGSG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 14:06:28 -0400
Received: (qmail 18646 invoked by uid 107); 7 Jun 2011 18:06:34 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Jun 2011 14:06:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jun 2011 14:06:25 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.1106071832470.4175@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175243>

On Tue, Jun 07, 2011 at 06:33:07PM +0200, Peter Kleiweg wrote:

> I get this error message with git version 1.7.5.GIT: 
> 
>     fatal: protocol error: bad line length character:
> 
> Git version 1.4.4.4 works fine.

I can't reproduce the problem here.  Can you try bisecting to find the
commit that introduces the problem?

> How do bugs in Git get solved? I can't find an issue tracker. 

You send an email to the mailing list and people work on it. :)

> Details:
> 
> $ export GIT_TRACE=1
> $ export GIT_TRACE_PACKET=1
> $ git push 
> trace: built-in: git 'push'
> trace: run_command: 'ssh' 'github' 'git-receive-pack '\''pebbe/Gabmap.git'\''' 
> fatal: protocol error: bad line length character:

Your "ssh github" is weird. Usually that would be "ssh git@github.com",
unless you have set up an alias in .ssh/config. Is that the case? If so,
can you show us the alias? Is it going through a proxy machine or
anything exotic?

> Setting GIT_TRACE_PACKET doesn't seem to have any effect.

That's probably because we never get any packets; the very first one is
bogus, and we abort.

> I added some debug code in pkt-line.c, function 
> packet_read_line(). This tells me that 'buffer' that is passed 
> to packet_read_line() contains nothing but null characters, 
> while 'size' is set to 1000.

Yeah, it's expecting data to be written into it. You need to see what
packet_read_line reads into linelen via safe_read (which is also printed
in the error message, so it looks from the above like it contains NULs).

> Running the ssh command as listed by trace works fine:
> 
> $ ssh github git-receive-pack 'pebbe/Gabmap.git'
> 00720444852406fd34c3eb0c8cdcb05cd2af979d2b34 refs/heads/master report-status delete-refs side-band-64k ofs-delta
> 0000

That looks normal. I wonder why git is not getting the same data.

-Peff
