From: Jeff King <peff@peff.net>
Subject: Re: git-credential-cache--daemon quits on SIGHUP, can we change it
 to ignore instead?
Date: Mon, 26 Oct 2015 17:50:16 -0400
Message-ID: <20151026215016.GA17419@sigill.intra.peff.net>
References: <CAM-tV-_JPazYxeDYogtQTRfBxONpSZwb3u5pPanB=F9XnLnZyg@mail.gmail.com>
 <CAM-tV-_eOgnhqsTFN6kKW=tcS7gAPYaxskBaxnJZo3bsx02HZg@mail.gmail.com>
 <xmqqfv18awj4.fsf@gitster.mtv.corp.google.com>
 <CAM-tV-8VXtB5uRgqP9dFpww6AaLzasPV46tCiquz=nz=ksBNng@mail.gmail.com>
 <CAM-tV-9sNgHncsWRPh36tEY3YFORUJBA-Q6W5R=mvX_KhSmWEQ@mail.gmail.com>
 <xmqqfv0ylwa7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Noam Postavsky <npostavs@users.sourceforge.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 22:50:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zqpeq-0008WU-Nl
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 22:50:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707AbbJZVuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 17:50:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:48163 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751998AbbJZVuT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 17:50:19 -0400
Received: (qmail 9987 invoked by uid 102); 26 Oct 2015 21:50:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Oct 2015 16:50:19 -0500
Received: (qmail 18263 invoked by uid 107); 26 Oct 2015 21:50:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Oct 2015 17:50:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Oct 2015 17:50:16 -0400
Content-Disposition: inline
In-Reply-To: <xmqqfv0ylwa7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280231>

On Sun, Oct 25, 2015 at 09:58:56AM -0700, Junio C Hamano wrote:

> >>> I cannot speak for the person who was primarily responsible for
> >>> designing this behaviour, but I happen to agree with the current
> >>> behaviour in the situation where it was designed to be used.  Upon
> >>> the first use in your session, the "daemon" is auto-spawned, you can
> >>> keep talking with that same instance during your session, and you do
> >>> not have to do anything special to shut it down when you log out.
> >>> Isn't that what happens here?
> >>
> >> After looking at this some more, I've discovered this is NOT what
> >> actually happens here. If I "git push" from a shell and then log out
> >> and log in again, another "git push" does NOT ask me for a password.
> >> In other words, the daemon is NOT shut down automatically when I log
> >> out. Given that, does it make sense to change the daemon to ignore
> >> SIGHUP, or is there some way to change it so that it does exit on
> >> logout?
> 
> I have a feeling that it would be moving in a wrong direction to
> change the code to ignore HUP, as I do think "logout to shutdown"
> would be the desired behaviour.  If you are not seeing that happen,
> perhaps the first thing to do is to figure out why and fix the code
> so that it happens?
> 
> I dunno.  I'll cc Peff so that he can take a look when he comes
> back.

I could see it going both ways.

If SIGHUP means "I am logging out, my session is over", then I agree it
makes sense to drop any credentials. And that is what SIGHUP meant when
people logged in through hard-wired terminals.

But these days, people often have several simultaneous sessions open.
They may have multiple ssh sessions to a single machine, or they may
have a bunch of terminal windows open, each of which has a login shell
and will send HUP to its children when it exits. In that case, you have
a meta-session surrounding those individual terminal sessions, and you
probably do want to keep the cache going as long as the meta session[1].

This is all further complicated by bash's huponexit option, which I
think is off by default. So I, for example, have never noticed this
behavior even with multiple xterms, because my cache never actually gets
SIGHUP.  I don't know what shell Noam is using, but I wonder if tweaking
that option (or a similar one if not bash) might be helpful to signal
"let this stuff keep running even after I exit".

But I am also not opposed to making it configurable somehow in git, if
there really are two cases that cannot otherwise be distinguished.

-Peff

[1] Of course we have no idea when that meta-session is closed. But if
    you have a script that runs on X logout, for instance, you could put
    "git credential-cache exit" in it.
