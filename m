From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] Allow help.htmlpath to be an http: URL
Date: Wed, 27 Jun 2012 18:11:07 -0400
Message-ID: <20120627221106.GE2292@sigill.intra.peff.net>
References: <8d3c71d21710c66e4d5560cec958552b69a22338.1340830514.git.chris@arachsys.com>
 <233b27a14d16a2a1cb38b9f3e07a3a79b09a3256.1340830514.git.chris@arachsys.com>
 <20120627210502.GB2292@sigill.intra.peff.net>
 <7vbok4785a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Chris Webb <chris@arachsys.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 28 00:11:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sk0SB-0007C7-JY
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jun 2012 00:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754023Ab2F0WLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 18:11:12 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:47326
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751587Ab2F0WLL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 18:11:11 -0400
Received: (qmail 4948 invoked by uid 107); 27 Jun 2012 22:11:14 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Jun 2012 18:11:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jun 2012 18:11:07 -0400
Content-Disposition: inline
In-Reply-To: <7vbok4785a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200765>

On Wed, Jun 27, 2012 at 02:32:49PM -0700, Junio C Hamano wrote:

> >>  	/* Check that we have a git documentation directory. */
> >> -	if (stat(mkpath("%s/git.html", html_path), &st)
> >> -	    || !S_ISREG(st.st_mode))
> >> -		die(_("'%s': not a documentation directory."), html_path);
> >> +	if (prefixcmp(html_path, "http:")) {
> >> +		if (stat(mkpath("%s/git.html", html_path), &st)
> >> +				|| !S_ISREG(st.st_mode))
> >> +			die("'%s': not a documentation directory.", html_path);
> >> +	}
> >
> > I'd rather not tie this directly to http. Is there any reason not to
> > allow https, for example? Can we maybe just look for strstr("://")
> > instead? That's the same magic we use to differentiate URLs from paths
> > when looking for repositories.
> 
> One part of me says "any non-standard html-path should be sent to
> the browser".  Another part of me says "what if network is
> unavailable?  Wouldn't it be nice to fall back to use the local
> copy?"

Fallback might be nice, but I really don't want to get into interpreting
what URLs mean or whether the network is up.

> And a small voice in me responds to the latter with "If you have a
> local copy anyway, why would you want to go to the network even if
> you could?"

One reason is that the network version may contain more information (for
example, the git-scm.com versions give you links to related articles,
and also tell you in which versions the documentation changed).

Speaking of versions, this patch is not sufficient to actually point the
browser to the correct version at a site like git-scm.com. We could add
some kind of strbuf_expand magic like "http://git-scm.com/%c/%v" or
something like that (where %c is the command and %v is the git version).
But that is probably over-engineering.

> Which leads me to conclude that it is the right thing to do if
> html_path came from the configuration, not from the compiled-in
> default, to always ask browser to do its thing, and let it fail if
> it has to fail---it is not Git's problem anymore at that point.

I don't know that configured vs compiled-in is the right distinction
there, though. If I'm building a minimal git for a stripped-down machine
and I don't want to include the HTML pages locally, I might want to set
the html path to a URL at build-time. That saves each user from having
to configure it.

-Peff
