From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: git-bisect working only from toplevel dir
Date: Thu, 24 Nov 2011 08:06:59 +0100
Message-ID: <20111124070659.GC6291@m62s10.vlinux.de>
References: <20111123145034.GB17927@angband.pl>
 <7vd3cibqqe.fsf@alter.siamese.dyndns.org>
 <20111123192329.GA21630@sigill.intra.peff.net>
 <7vzkfma7q9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Adam Borowski <kilobyte@angband.pl>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 24 08:07:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTTOs-0006By-EE
	for gcvg-git-2@lo.gmane.org; Thu, 24 Nov 2011 08:07:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752017Ab1KXHHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Nov 2011 02:07:06 -0500
Received: from mailout-de.gmx.net ([213.165.64.23]:43580 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750987Ab1KXHHF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2011 02:07:05 -0500
Received: (qmail invoked by alias); 24 Nov 2011 07:07:02 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp013) with SMTP; 24 Nov 2011 08:07:02 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX192dOsObfB2XH5XYie7hoxuhp1TwXwXd991+dq9D0
	QExHAaogX8fql7
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id E034ED4003; Thu, 24 Nov 2011 08:06:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vzkfma7q9.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185891>

On Wed, Nov 23, 2011 at 12:45:18PM -0800, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > On Wed, Nov 23, 2011 at 11:09:29AM -0800, Junio C Hamano wrote:
> >
> >> As to the approach, I suspect that it would be far better if it made
> >> workable with cd_to_toplevel at the beginning, instead of saying
> >> SUBDIRECTORY_OK.
> >> 
> >> After all, the current directory may disappear during the course of
> >> bisection, upon checking out a revision that did not have the directory
> >> you started your bisection from.
> >
> > But from what directory would you expect:
> >
> >   git bisect run make
> 
> My usual way to enlighten somebody is by forcing him/her to think the
> consequences, but because you did the thinking for the OP in this thread
> instead, it didn't work. Makes me somewhat sad ;-<.
> 
> > If we cd_to_toplevel, we can remember the prefix that we started from
> > and cd to it before running the user's command, but there is no
> > guarantee that it actually exists. Maybe that commit should be
> > considered indeterminate then?
> 
> Yeah that sounds like a reasonable thing to do.
> 
> > I dunno. I haven't thought that hard about it. But I don't think it's
> > quite as simple as just telling bisect it's OK to run from a subdir.
> 
> Absolutely. Saying SUBDIRECTORY_OK without thinking about the consequence
> through is a good discussion starter but is not a good patch.
> 
> Also didn't we make bisect workable in a bare repository recently? So the
> start-up sequence has to be something more elaborate like...
> 
>         . git-sh-setup
>         if we are in a bare repository
>         then
>          	: we are happy...nothing funky needs to be done
> 	elif we are not in a working tree
> 		barf
> 	elif we are not at the top
>         	prefix=$(git rev-parse --show-prefix)
> 		cd_to_toplevel
> 	fi
> 
> and then inside bisect_next() you would check if $prefix exists, and go
> there to run bisect--helper (or fail to go there and say "cannot test").
> 

But is the "cannot test" aka exit(127) the best we can do in this case?
I think having a failing make, because someone has checked in code which doesn't
even compile, is something totally different than having no Makefile at all,
because the directory doesn't even exist. To me, this seems more like an error
in the run script to not handle all the cases of the (dis)appearing directory.

On the other hand we don't waste much time trying to test such an "untestable"
commit, because this check will be fast because no compiling is involved.
The only time wasted will bethe build time for the "usable" commits and the
time the user needs to figure out why the heck some(/most?) of his commits
are "untestable".
