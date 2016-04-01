From: Jeff King <peff@peff.net>
Subject: Re: GIT_CONFIG - what's the point?
Date: Fri, 1 Apr 2016 10:53:49 -0400
Message-ID: <20160401145349.GA16196@sigill.intra.peff.net>
References: <CAL20dLDQsti1qW7CrrEifPAhPp1snq9r5MgJL+mDwhLqhe6fyQ@mail.gmail.com>
 <20160401123830.GB12019@sigill.intra.peff.net>
 <CAL20dLDkmjpXdmHv0MdoUEe43s9TjqrOLS2ud8HHGCF2vahWNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matthew Persico <matthew.persico@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 16:53:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am0SU-0002Dv-0R
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 16:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118AbcDAOxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 10:53:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:42379 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751876AbcDAOxx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 10:53:53 -0400
Received: (qmail 3867 invoked by uid 102); 1 Apr 2016 14:53:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Apr 2016 10:53:52 -0400
Received: (qmail 25313 invoked by uid 107); 1 Apr 2016 14:53:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Apr 2016 10:53:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Apr 2016 10:53:49 -0400
Content-Disposition: inline
In-Reply-To: <CAL20dLDkmjpXdmHv0MdoUEe43s9TjqrOLS2ud8HHGCF2vahWNQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290541>

On Fri, Apr 01, 2016 at 10:31:12AM -0400, Matthew Persico wrote:

> Let me explain my scenario. I have an nfs mounted home directory. It
> is used across multiple machines. I use different colored xterms for
> each machine. But that means that the one set of colors in my one
> .gitconfig file don't work against all my screen backgrounds. I'm
> trying to find a way to tune the git colors per login. The ability to
> set colors in an environment variable (like most UNIX utils support)
> would be the easiest way to do this. Failing that, I was hoping that
> by setting GIT_CONFIG per login, I could tune the color schemes with
> different config files.
> 
> Since that is not how GIT_CONFIG is used, I have simply decided to
> squint where necessary, or open up a neutral colored xterm for the
> diff, regardless of machine.
> 
> Yes, I could probably do diffs in many other ways, but git diff at the
> command line is usually the most expedient.

I think per-environment config is a reasonable thing to want. I can
think of three approaches with varying drawbacks:

  1. The cleanest thing would be for git's config-include directive to
     respect environment variables somehow. We do expand $HOME in

       [include]
       path = ~/.whatever

     but only $HOME (and if you're willing to set $HOME, you can just
     point to a different ~/.gitconfig in the first place).

     So the drawback is that it doesn't currently work, and would need a
     patch to git. ;)

  2. If you don't want to change $HOME, you might be OK with changing
     $XDG_CONFIG_HOME, which could then point to your machine-specific
     user-level config (and could use an include to pull in the common
     bits). See "git help config" for more details (particularly, I
     think the XDG source only kicks in if you have no ~/.gitconfig, but
     I might be misremembering the details).

     The drawback is that other things besides git use $XDG_CONFIG_HOME,
     so you might be affecting them.

     You could probably come up with some elaborate scheme where each
     host has its own $XDG_CONFIG_HOME, and you symlink in the common
     bits. Or something. But that gets complicated pretty fast.

  3. The "git -c" mechanism communicates config to sub-processes via the
     $GIT_CONFIG_PARAMETERS variable. Its format and even existence are
     undocumented, but something like this would probably do what you
     want:

       export GIT_CONFIG_PARAMETERS="'config1=value1' 'config2=value2'"

     The drawback is that it is definitely not officially supported.
     However, I don't think there any plans to get rid of it (and if
     anything, I'd suspect in the future the parser may get less picky,
     and it might become an officially supported interface; but don't
     quote me on that).

-Peff
