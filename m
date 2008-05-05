From: Jeff King <peff@peff.net>
Subject: Re: To page or not to page
Date: Mon, 5 May 2008 17:59:25 -0400
Message-ID: <20080505215924.GA9228@sigill.intra.peff.net>
References: <70F76C0E-E16D-4047-873D-7FD19FDBB55D@sb.org> <20080502054508.GA28506@sigill.intra.peff.net> <20080502060930.GA1079@sigill.intra.peff.net> <7vd4o5xm62.fsf@gitster.siamese.dyndns.org> <20080502125553.GB2923@sigill.intra.peff.net> <7v1w4ky3hh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kevin Ballard <kevin@sb.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 06 00:00:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jt8jE-00085U-FV
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 00:00:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760362AbYEEV7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 17:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760400AbYEEV7Y
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 17:59:24 -0400
Received: from peff.net ([208.65.91.99]:4360 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760316AbYEEV7X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 17:59:23 -0400
Received: (qmail 32208 invoked by uid 111); 5 May 2008 21:59:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 05 May 2008 17:59:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 May 2008 17:59:25 -0400
Content-Disposition: inline
In-Reply-To: <7v1w4ky3hh.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81310>

On Fri, May 02, 2008 at 11:18:02AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > My bigger worry is that this affects only builtins. Which makes it
> > sufficient for turning off the pager for anything that does USE_PAGER.
> 
> Hmm. How about doing things this way?
> 
>  - at the beginning of handle_options() remember argv[0]
> 
>  - restructure handle_options() so that it does not run setup_pager() and
>    setenv("GIT_PAGER", "cat", 1) inside the loop, but instead remember
>    what we had on the command line;
> 
>  - after the handle_options() loop, if we saw an explicit --pager,
>    --no-pager, that's the decision;
> 
>  - otherwise:
> 
>    - look at argv[0] to see what the command is;
> 
>    - do the config thing to see if there is user preference; if there is
>      one, that setting decides;
> 
>    - otherwise:
> 
>      - see the built-in defaults;
> 
>  - and finally use or not use pager depending on what we found above.

OK, that makes some sense. I think some of what you describe is just
refactoring (e.g., it doesn't matter if we actually do things when we
see --no-pager or afterwards, since it always takes precedence). The key
things are:

  - work not just on running builtins, but before we even figure out
    whether we have a builtin or a script

  - in my patch the config just says "ignore the default USE_PAGER", but
    it really should be "turn off the pager via GIT_PAGER=cat". That way
    you can say pager.stash = false, and it will impact the git-diff
    invocation run by stash.

But that isn't to say the refactoring isn't worth doing to keep things
clean. I will take a stab at restructuring it the way you specified.

There is one remaining annoyance, though: this code is only run via the
git wrapper. That means that you will get different behavior for
"git-stash" versus "git stash". To make that work, we would have to put
equivalent support into each script (although we could hit several at
once with git-sh-setup.sh) and each non-builtin.

-Peff
