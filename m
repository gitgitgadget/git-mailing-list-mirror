From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Avoid crippled getpass function on Solaris
Date: Mon, 6 Aug 2012 15:39:58 -0400
Message-ID: <20120806193958.GA10039@sigill.intra.peff.net>
References: <1344208672-20028-1-git-send-email-bwalton@artsci.utoronto.ca>
 <7vboio231n.fsf@alter.siamese.dyndns.org>
 <1344220427-sup-3468@pinkfloyd.chass.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Mon Aug 06 21:40:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyTA0-0006Dw-DI
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 21:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494Ab2HFTkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Aug 2012 15:40:09 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53595 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756297Ab2HFTkH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2012 15:40:07 -0400
Received: (qmail 17937 invoked by uid 107); 6 Aug 2012 19:40:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Aug 2012 15:40:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Aug 2012 15:39:58 -0400
Content-Disposition: inline
In-Reply-To: <1344220427-sup-3468@pinkfloyd.chass.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202977>

On Sun, Aug 05, 2012 at 10:35:06PM -0400, Ben Walton wrote:

> Excerpts from Junio C Hamano's message of Sun Aug 05 21:59:48 -0400 2012:
> > Wouldn't
> > 
> >     #if solaris
> >         #define getpass getpassphrase
> >         #endif
> > 
> > without anything else be more than sufficient?
> 
> Yes, it would, but I was hoping to make it more explicit that the
> function getpass may be substituted with something else.

I don't think that's important. Either the thing is a drop-in replica of
getpass, or it is not. In the former case, it's OK for it to be
transparent that it has been replaced. In the latter case, it should not
be a #define replacement at all, but should be its own alternative in
compat/terminal.c (just like HAVE_DEV_TTY is).  From my reading of
getpassphrase, it does seem to be a drop-in replacement.

So I'm OK conceptually with the patch if we can't do any better. But
getpass still sucks. It doesn't handle echoing, and it may or may not
fall back to reading from stdin if the tty isn't available (which is
disastrous for remote-curl, whose stdin is speaking the remote-helper
protocol to git). So I'd really prefer to make HAVE_DEV_TTY work with
Solaris if we can.

I'm happy to spend a few cycles on it.  I don't have access to any real
Solaris boxes these days, but I imagine I can get OpenSolaris running
under VirtualBox without too much trouble...

-Peff

PS If we do go the getpassphrase route, does it make sense to introduce
   HAVE_GETPASSPHRASE? We usually try to provide one layer of
   indirection by naming our #defines after features, and then
   connecting systems to the feature defines via the Makefile. But maybe
   Solaris is the only system that has getpassphrase.
