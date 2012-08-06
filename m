From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH] Avoid crippled getpass function on Solaris
Date: Mon, 06 Aug 2012 17:31:00 -0400
Message-ID: <1344287843-sup-6200@pinkfloyd.chass.utoronto.ca>
References: <1344208672-20028-1-git-send-email-bwalton@artsci.utoronto.ca> <7vboio231n.fsf@alter.siamese.dyndns.org> <1344220427-sup-3468@pinkfloyd.chass.utoronto.ca> <20120806193958.GA10039@sigill.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Tay Ray Chuan <rctay89@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 06 23:31:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyUtO-0006Pm-UD
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 23:31:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753747Ab2HFVbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Aug 2012 17:31:08 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:53536 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186Ab2HFVbG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2012 17:31:06 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:54718 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SyUtB-0007dp-1U; Mon, 06 Aug 2012 17:31:01 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SyUtA-0004Pj-RM; Mon, 06 Aug 2012 17:31:00 -0400
In-reply-to: <20120806193958.GA10039@sigill.intra.peff.net>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202990>

Excerpts from Jeff King's message of Mon Aug 06 15:39:58 -0400 2012:
> On Sun, Aug 05, 2012 at 10:35:06PM -0400, Ben Walton wrote:
> 
> > Excerpts from Junio C Hamano's message of Sun Aug 05 21:59:48 -0400 2012:
> > > Wouldn't
> > > 
> > >     #if solaris
> > >         #define getpass getpassphrase
> > >         #endif
> > > 
> > > without anything else be more than sufficient?
> > 
> > Yes, it would, but I was hoping to make it more explicit that the
> > function getpass may be substituted with something else.
> 
> I don't think that's important. Either the thing is a drop-in replica of
> getpass, or it is not. In the former case, it's OK for it to be
> transparent that it has been replaced. In the latter case, it should not
> be a #define replacement at all, but should be its own alternative in
> compat/terminal.c (just like HAVE_DEV_TTY is).  From my reading of
> getpassphrase, it does seem to be a drop-in replacement.

It is a drop in replacement (identical signature) so that's no issue.
I can simplify this to the form suggested by Junio if that's
preferrable.  My idea of explicitness was for the programmer though.
I think it's easier for someone else reading this code later to
realize that the GETPASS function may change depending on conditions.

But, as I said, I'm not adverse to changing this in any way, I simply
want the improved functionality and am not married to the approach.
(I considered about three different ways of doing this before
submitting.)

> So I'm OK conceptually with the patch if we can't do any better. But
> getpass still sucks. It doesn't handle echoing, and it may or may
> not fall back to reading from stdin if the tty isn't available
> (which is disastrous for remote-curl, whose stdin is speaking the
> remote-helper protocol to git). So I'd really prefer to make
> HAVE_DEV_TTY work with Solaris if we can.

I poked through getpass in the opensolaris code and it did fall back
to reading from stdin[1] if there were issues opening /dev/tty so
there is room for trouble here.  That doesn't mean that other versions
of Solaris did it this way, but it's fairly likely that they did given
the culture.

> I'm happy to spend a few cycles on it.  I don't have access to any
> real Solaris boxes these days, but I imagine I can get OpenSolaris
> running under VirtualBox without too much trouble...

I'm also happy to do this work and have ready access to Solaris 8-11.
Would it be reasonable to support using getpassphrase() if
!HAVE_DEV_TTY in addition to making the HAVE_DEV_TTY code function on
Solaris too?  That would provide a harm reduction for Solaris users
that (for some reason) disabled the nicer interface...but maybe it's
too much?

> PS If we do go the getpassphrase route, does it make sense to
>    introduce HAVE_GETPASSPHRASE? We usually try to provide one layer
>    of indirection by naming our #defines after features, and then
>    connecting systems to the feature defines via the Makefile. But
>    maybe Solaris is the only system that has getpassphrase.

I had considered this but thought that it was too heavy weight given
that I'm not aware of other platforms that have this naming split
depending on desired buffer size and that getpass on most platforms
won't have this crippling size limitation.

If it's worth improving both paths for the HAVE_DEV_TTY code on
Solaris, I can add this support if that's considered the better
approach.

Thanks
-Ben

[1] http://src.opensolaris.org/source/xref/onnv/onnv-gate/usr/src/lib/libbc/libc/gen/common/getpass.c#65
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
