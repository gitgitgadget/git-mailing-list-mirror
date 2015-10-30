From: Jeff King <peff@peff.net>
Subject: Re: git-credential-cache--daemon quits on SIGHUP, can we change it
 to ignore instead?
Date: Thu, 29 Oct 2015 20:10:01 -0400
Message-ID: <20151030001000.GA2123@sigill.intra.peff.net>
References: <CAM-tV-_JPazYxeDYogtQTRfBxONpSZwb3u5pPanB=F9XnLnZyg@mail.gmail.com>
 <CAM-tV-_eOgnhqsTFN6kKW=tcS7gAPYaxskBaxnJZo3bsx02HZg@mail.gmail.com>
 <xmqqfv18awj4.fsf@gitster.mtv.corp.google.com>
 <CAM-tV-8VXtB5uRgqP9dFpww6AaLzasPV46tCiquz=nz=ksBNng@mail.gmail.com>
 <CAM-tV-9sNgHncsWRPh36tEY3YFORUJBA-Q6W5R=mvX_KhSmWEQ@mail.gmail.com>
 <xmqqfv0ylwa7.fsf@gitster.mtv.corp.google.com>
 <20151026215016.GA17419@sigill.intra.peff.net>
 <xmqqoafkci6j.fsf@gitster.mtv.corp.google.com>
 <20151027184702.GB12717@sigill.intra.peff.net>
 <CAM-tV--B3HaC1DcORfnx9bWW9-quyk0=pQDxmvonc=6dgrMOxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Noam Postavsky <npostavs@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Oct 30 01:10:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrxGt-0002db-JW
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 01:10:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758253AbbJ3AKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2015 20:10:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:50110 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757876AbbJ3AKE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2015 20:10:04 -0400
Received: (qmail 28869 invoked by uid 102); 30 Oct 2015 00:10:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Oct 2015 19:10:03 -0500
Received: (qmail 17204 invoked by uid 107); 30 Oct 2015 00:10:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Oct 2015 20:10:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Oct 2015 20:10:01 -0400
Content-Disposition: inline
In-Reply-To: <CAM-tV--B3HaC1DcORfnx9bWW9-quyk0=pQDxmvonc=6dgrMOxA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280464>

On Tue, Oct 27, 2015 at 11:46:20PM -0400, Noam Postavsky wrote:

> > I dunno. I think the auto-spawn is really what makes it usable; you can
> > drop it in with "git config credential.helper config" and forget about
> > it. Anything more fancy requires touching your login/startup files.
> > Certainly I'm not opposed to people setting it up outside of the
> > auto-spawn, but I wouldn't want that feature to go away.
> 
> Perhaps we could express the auto-spawn more explicitly, something
> like "git config credential.pre-helper start-cache-daemon". A way to
> run a command before the credential helpers start would be useful to
> our magit workaround for this issue (currently we start the daemon
> before "push", "fetch", and "pull", but it won't work with user
> aliases that run those commands).

I'm not clear on when the pre-helper would be run. Git runs the helper
when it needs a credential. What git command would start it? Or are you
proposing a new credential interface for programs (like magit) to call
along the lines of "do any prep work you need; I might be asking for a
credential soon", without having to know the specifics of the user's
helper config.

You can do that already like:

  echo url=dummy://a:b@c/ | git credential approve

though I guess for some helpers, that may actually store the bogus
value (for the cache, it inserts a dummy cache entry, but that's not a
problem; something with permanent storage would be more annoying).

I guess the most elegant thing would be to add an "init" command to the
helper interface. So magit would run:

  git credential init

which would then see that we have "credential.helper" defined as "foo",
and would run:

  git credential-foo init

which could be a noop, start a daemon, or whatever, depending on how the
helper operates.

I dunno. It almost seems like adding a credentialcache.ignoreHUP option
would be less hacky. :)

> I'm not sure it's that widely used. Perhaps most people use ssh-agent?
> That's what I do, though I've been experimenting with credential-cache
> since it was brought up by a magit user.

I don't know. Certainly up until a few years ago, anybody sane was using
ssh-agent, because the http password stuff was so awful (no storage, and
we didn't even respect 401s for a long time). But these days sites like
GitHub push people into using https as the protocol of choice. Mostly, I
think, because there was a lot of support load in teaching people to set
up ssh. But I guess a lot of those people are on non-Linux platforms.

-Peff
