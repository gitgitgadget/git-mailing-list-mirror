From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] receive-pack: allow for hiding refs outside the
 namespace
Date: Fri, 30 Oct 2015 17:46:19 -0400
Message-ID: <20151030214618.GA11426@sigill.intra.peff.net>
References: <1445846999-8627-1-git-send-email-lfleischer@lfos.de>
 <xmqqk2q9h05h.fsf@gitster.mtv.corp.google.com>
 <20151027053916.3030.8259@typhoon.lan>
 <20151027055911.4877.94179@typhoon.lan>
 <20151027143207.18755.82151@s-8d3a2f8b.on.site.uni-stuttgart.de>
 <xmqqmvv0jb67.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lukas Fleischer <lfleischer@lfos.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 22:46:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsHVC-0005hw-7J
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 22:46:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758916AbbJ3VqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 17:46:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:50676 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757943AbbJ3VqV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 17:46:21 -0400
Received: (qmail 19387 invoked by uid 102); 30 Oct 2015 21:46:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Oct 2015 16:46:21 -0500
Received: (qmail 26860 invoked by uid 107); 30 Oct 2015 21:46:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Oct 2015 17:46:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Oct 2015 17:46:19 -0400
Content-Disposition: inline
In-Reply-To: <xmqqmvv0jb67.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280547>

On Fri, Oct 30, 2015 at 02:31:28PM -0700, Junio C Hamano wrote:

> Lukas Fleischer <lfleischer@lfos.de> writes:
> 
> > 1. There does not seem to be a way to pass configuration parameters to
> >    git-shell commands. Right now, the only way to work around this seems
> >    to write a wrapper script around git-shell that catches
> >    git-receive-pack commands and executes something like
> >    
> >        git -c receive.hideRefs=[...] receive-pack [...]
> >    
> >    instead of forwarding those commands to git-shell.
> 
> This part we have never discussed in the thread, I think.  Why do
> you need to override, instead of having these in the repository's
> config files?
> 
> Is it because a repository may host multiple pseudo repositories in
> the form of "namespaces" but they must share the same config file,
> and you would want to customize per "namespace"?
> 
> For that we may want to enhance the [include] mechanism.  Something
> like
> 
> 	[include "namespace=foo"]
>         	path = /path/to/foo/specific/config.txt
> 
> 	[include "namespace=bar"]
>         	path = /path/to/bar/specific/config.txt
> 
> Cc'ing Peff as we have discussed this kind of conditional inclusion
> in the past...

Yeah, that sort of conditional matching is exactly what I had intended
for the "subsection" of include to be. We just haven't come up with a
good condition to act as our first use case. :)

I am happy with any syntax that does not paint us into a corner (and
your example above looks fine, assuming we could later add other keys on
the left-hand of the "=").

I am slightly confused, though, where the namespace is set in such a
git-shell example. I have no really used ref namespaces myself, but my
understanding is that they have to come from the environment. You can
similarly set config through the environment. I don't think we've ever
publicized that, but it is how "git -c" works. E.g.:

  $ git -c alias.foo='!env' -c another.option=true foo | grep GIT_
  GIT_CONFIG_PARAMETERS='alias.foo='\!'env' 'another.option=true'

I think it is very particular that you single-quote each item, though:

  $ GIT_CONFIG_PARAMETERS=foo.bar=true git config foo.bar
  error: bogus format in GIT_CONFIG_PARAMETERS
  fatal: unable to parse command-line config

  $ GIT_CONFIG_PARAMETERS="'foo.bar=true'" git config foo.bar
  true

So we may want to make it a little more friendly before truly
recommending it as an interface, but I don't think there is any
conceptual problem with doing so.

-Peff
