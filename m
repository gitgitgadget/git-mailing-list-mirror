From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] Split up default "core" config parsing into helper
	routine
Date: Wed, 18 Jun 2008 19:13:16 -0400
Message-ID: <20080618231316.GB23053@sigill.intra.peff.net>
References: <alpine.LFD.1.10.0806181524490.2907@woody.linux-foundation.org> <alpine.LFD.1.10.0806181529570.2907@woody.linux-foundation.org> <20080618224919.GA22599@sigill.intra.peff.net> <alpine.LFD.1.10.0806181552590.2907@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Denis Bueno <dbueno@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jun 19 01:14:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K96rX-0001Hc-0r
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 01:14:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892AbYFRXNT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 19:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752420AbYFRXNT
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 19:13:19 -0400
Received: from peff.net ([208.65.91.99]:2585 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752075AbYFRXNT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 19:13:19 -0400
Received: (qmail 13867 invoked by uid 111); 18 Jun 2008 23:13:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 18 Jun 2008 19:13:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jun 2008 19:13:16 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0806181552590.2907@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85422>

On Wed, Jun 18, 2008 at 03:58:13PM -0700, Linus Torvalds wrote:

> >         if (!prefixcmp(var, "core."))
> >                 return git_default_core_config(var+5, value);
> 
> I considered it, but I think that screws up error reporting (ie if some 
> value is unparseable, it would then print out the wrong variable name).

Good point.

> Yeah, I know. I love the config file format (quite frankly, anybody who 
> thinks XML and friends are sane is a total moron and should be shot before 
> they reproduce), but the whole parsing code was a really quick hack. 

I actually find the hierarchy a bit nonsensical. We talk about
core.pager and branch.master.remote, but the config file doesn't look
like that. So I buy that it's

[core]
  pager

but then it seems kind of arbitrary to have

[branch "master"]
  remote

instead of

[branch]
  master.remote

or

[branch]
  [master]
    remote

which is of course impossible because we don't have a "close section"
syntax element.

It seems like the '.' implies hierarchy, but the syntax of the file
doesn't really follow it. But that's a minor issue, and really not worth
the pain it would take to change at this point.

> I've several times wanted to rewrite it so that it does something smarter 
> (parse it once, save it in a nice data structure), but let's face it, the 
> upside is rather small. So I've never really ended up having the energy.

I think we need to refactor what happens at the beginning of the 'git'
wrapper, and this may be part of it. But as it stands now, the worktree
setup is a minefield of bugs (e.g., calling a command via an alias
versus directly can get you different results for whether you have a
worktree!), and a simple patch I did to make pager use configurable blew
up in my face due to implicit constraints in when we look at the config
file (i.e., it mostly worked, but reading the config file implied doing
a setup_git_directory, which then screwed up a later invocation of
setup_git_directory).

So I think those things need cleaning up, and refactoring the config
reading could probably be part of that. I might try to look at it in the
next release cycle.

> > Then we could do useful things like say "you specified core.foobar, but
> > there is no such variable."
> 
> No. We could already do that (just add it to the end of 
> git_default_core_config - it should be called last even if there was a 
> chain), but avoid doing that very much on purpose.
> 
> Why? Because it's really irritating to have a parser that complains about 
> newer values (or old deprecated ones) that don't matter for that version 
> of the program. 

Even a "check my config for bogosity" program would be nice, and then it
wouldn't bug you all the time. But you _can't_ do it now, because the
callback mechanism only looks at a subset of the values. IOW, there is
no single function that you call that represents every config value;
different programs use different callbacks.

In the case of just core.*, though, you might be able to get away with
it (I don't know how closely we've adhered to "all of core.* is in
git_default_config).

-Peff
