From: Jeff King <peff@peff.net>
Subject: Re: git-credential-cache--daemon quits on SIGHUP, can we change it
 to ignore instead?
Date: Tue, 27 Oct 2015 14:47:02 -0400
Message-ID: <20151027184702.GB12717@sigill.intra.peff.net>
References: <CAM-tV-_JPazYxeDYogtQTRfBxONpSZwb3u5pPanB=F9XnLnZyg@mail.gmail.com>
 <CAM-tV-_eOgnhqsTFN6kKW=tcS7gAPYaxskBaxnJZo3bsx02HZg@mail.gmail.com>
 <xmqqfv18awj4.fsf@gitster.mtv.corp.google.com>
 <CAM-tV-8VXtB5uRgqP9dFpww6AaLzasPV46tCiquz=nz=ksBNng@mail.gmail.com>
 <CAM-tV-9sNgHncsWRPh36tEY3YFORUJBA-Q6W5R=mvX_KhSmWEQ@mail.gmail.com>
 <xmqqfv0ylwa7.fsf@gitster.mtv.corp.google.com>
 <20151026215016.GA17419@sigill.intra.peff.net>
 <xmqqoafkci6j.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Noam Postavsky <npostavs@users.sourceforge.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 19:47:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr9H4-0001qJ-M1
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 19:47:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965018AbbJ0SrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 14:47:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:48677 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964913AbbJ0SrF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 14:47:05 -0400
Received: (qmail 18738 invoked by uid 102); 27 Oct 2015 18:47:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Oct 2015 13:47:05 -0500
Received: (qmail 26940 invoked by uid 107); 27 Oct 2015 18:47:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Oct 2015 14:47:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Oct 2015 14:47:02 -0400
Content-Disposition: inline
In-Reply-To: <xmqqoafkci6j.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280288>

On Tue, Oct 27, 2015 at 10:52:52AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > But these days, people often have several simultaneous sessions open.
> > They may have multiple ssh sessions to a single machine, or they may
> > have a bunch of terminal windows open, each of which has a login shell
> > and will send HUP to its children when it exits. In that case, you have
> > a meta-session surrounding those individual terminal sessions, and you
> > probably do want to keep the cache going as long as the meta session[1].
> > ...
> > [1] Of course we have no idea when that meta-session is closed. But if
> >     you have a script that runs on X logout, for instance, you could put
> >     "git credential-cache exit" in it.
> 
> Yes.  Probably the right way forward is to make it a non-issue by
> teaching users how to control the lifetime of the "daemon" process,
> and wean them off relying on "it is auto-spawned if you forgot to
> start", as that convenience of auto-spawning is associated with
> "...but how it is auto-shutdown really depends on many things in
> your specific environment", which is the issue.

I dunno. I think the auto-spawn is really what makes it usable; you can
drop it in with "git config credential.helper config" and forget about
it. Anything more fancy requires touching your login/startup files.
Certainly I'm not opposed to people setting it up outside of the
auto-spawn, but I wouldn't want that feature to go away.

AFAICT, it works pretty well out of the box for most setups (where
terminals do _not_ send SIGHUP; so we auto-start, and then it holds the
credential until the timer expires).

I am a little surprised that credential-cache gets wide use. I would
think most people would prefer to use a system-specific secure-storage
helper. I don't know what the state of the art is for that on Linux[1], but
we seem to have only gnome-keyring in contrib/.

-Peff

[1] I use Linux, but I do not use any of the common desktop
    environments. However, I have my own personal read-only key program
    that speaks the helper protocol.
