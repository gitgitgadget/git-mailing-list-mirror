From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 0/3] Introduce config variable "diff.primer"
Date: Sun, 25 Jan 2009 17:07:56 -0500
Message-ID: <20090125220756.GA18855@coredump.intra.peff.net>
References: <1232904657-31831-1-git-send-email-keith@cs.ucla.edu> <7vr62rcee5.fsf@gitster.siamese.dyndns.org> <alpine.GSO.2.00.0901251239000.12651@kiwi.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Keith Cascio <keith@CS.UCLA.EDU>
X-From: git-owner@vger.kernel.org Sun Jan 25 23:09:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRDAS-0006rN-Rt
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 23:09:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbZAYWH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 17:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbZAYWH6
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 17:07:58 -0500
Received: from peff.net ([208.65.91.99]:46231 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750846AbZAYWH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 17:07:58 -0500
Received: (qmail 28422 invoked by uid 107); 25 Jan 2009 22:08:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 25 Jan 2009 17:08:06 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 25 Jan 2009 17:07:56 -0500
Content-Disposition: inline
In-Reply-To: <alpine.GSO.2.00.0901251239000.12651@kiwi.cs.ucla.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107109>

On Sun, Jan 25, 2009 at 12:41:21PM -0800, Keith Cascio wrote:

> > I am puzzled.
> > 
> > The gitattributes mechanism is about per-path settings, but I do not
> > think a mnemonicprefix that is per-path makes much sense.
> 
> That was just an example (perhaps poorly chosen).  What I meant to
> suggest is making gitattributes consistent with gitconfig WRT at least
> the [diff] section.  But maybe that's not appropriate.  Thanks for the
> insight.

I don't think you want it entirely consistent. What would
diff.renamelimit mean in the context of a gitattribute? But I do think
it makes sense for some (like specific diff options such as whitespace
handling).

Also, if you're going to have options that apply to gitattributes diff
drivers _and_ as a general fallback, I think we need to define when the
fallback kicks in. That is, let's say I have a gitattributes file like
this:

   *.c diff=c

and my config says:

  [diff]
    opt1 = val1_default
    opt2 = val2_default

  [diff "c"]
    opt1 = val1_c

Now obviously if I want to use opt1 for my C files, it should be val1_c.
But if I want to use opt2, what should it use? There are two reasonable
choices, I think:

  1. You use val2_default. The rationale is that the "c" diff driver did
     not define an opt2, so you fall back to the global default.

  2. It is unset. The rationale is that you are using the "c" diff
     driver, and it has left the value unset. The default then means "if
     you have no diff driver setup".

I suspect "1" is what people would want most of the time, but "2" is
actually more flexible (since there is otherwise no way to say "I
explicitly left diff.c.opt2 unset").

If (2) is desired, I think it makes more sense to put such "default"
options into their own diff driver section. Like:

  [diff "default"]
    opt2 = whatever

And then it is more clear that once you have selected the "c" diff
driver, the values in the other "default" are not relevant.

I don't think this is a huge issue overall, but it occurs to me that we
have just added diff.wordRegex and diff.*.wordRegex. So it makes sense
to think for a minute which behavior we want before it ships and we are
stuck with backwards compatibility forever.

-Peff
