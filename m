From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Revert "rev-parse: remove restrictions on some
 options"
Date: Fri, 26 Feb 2016 18:34:49 -0500
Message-ID: <20160226233449.GA9622@sigill.intra.peff.net>
References: <20160226232507.GA9404@sigill.intra.peff.net>
 <20160226232957.GB9552@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 00:35:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZRuS-0001HZ-Cn
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 00:34:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755278AbcBZXex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 18:34:53 -0500
Received: from cloud.peff.net ([50.56.180.127]:50432 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754003AbcBZXew (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 18:34:52 -0500
Received: (qmail 9728 invoked by uid 102); 26 Feb 2016 23:34:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Feb 2016 18:34:52 -0500
Received: (qmail 8912 invoked by uid 107); 26 Feb 2016 23:35:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Feb 2016 18:35:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Feb 2016 18:34:49 -0500
Content-Disposition: inline
In-Reply-To: <20160226232957.GB9552@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287638>

On Fri, Feb 26, 2016 at 06:29:57PM -0500, Jeff King wrote:

> The best solution here would be to have a full parsing loop
> that handles all options, but only calls setup_git_directory
> as appropriate. Unfortunately, that's a bit complicated to
> implement. We _have_ to handle each option in the order it
> appears on the command line. If the caller asked for:
> 
>   git rev-parse --resolve-git-dir foo/.git --show-toplevel
> 
> then it must receive the two lines of output in the correct
> to know which is which. But asking for:
> 
>   git rev-parse --show-toplevel --resolve-git-dir foo/.git
> 
> is weird; we have to setup_git_directory() for the first
> option.
> 
> So any implementation would probably have to either:
> 
>   - make two passes over the options, first figuring out
>     whether we need a git-dir, and then actually handling
>     the options. That's possible, but it's probably not
>     worth the trouble.
> 
>   - call setup_git_directory() on the fly when an option
>     needs it; that requires annotating all of the options,
>     and there are a considerable number of them.

Having just sent this, of course, it occurs to me that a loop like:

   setup_git_directory_gently(&nongit);
   for (i = 0; i < argc; i++) {
  	if (!strcmp(argv[i], "--local-env-vars"))
  	... and other nongit-ok options ...
  
  	if (nongit)
  		die("need a repo");
  
  	if (!strcmp(argv[i], "--git-dir"))
  	... and other options ...
   }

would probably work. It does still leave things like --parseopt and
--sq-quote as one-offs, though, because they consume the rest of the
command line. And the fact remains that --local-repo-env isn't really
suitable for use with other options.

So I'm still tempted by this "lazy" approach.

-Peff
