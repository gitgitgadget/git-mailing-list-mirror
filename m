From: Jeff King <peff@peff.net>
Subject: Re: regression: "96b9e0e3 config: treat user and xdg config
 permission problems as errors" busted git-daemon
Date: Fri, 12 Apr 2013 15:01:52 -0400
Message-ID: <20130412190152.GB4108@sigill.intra.peff.net>
References: <7vvc7sfkwn.fsf@alter.siamese.dyndns.org>
 <20130412043501.GA12942@sigill.intra.peff.net>
 <7vr4igfj9w.fsf@alter.siamese.dyndns.org>
 <20130412050550.GA15724@sigill.intra.peff.net>
 <20130412112636.GC20178@odin.tremily.us>
 <20130412144855.GA17968@sigill.intra.peff.net>
 <7vk3o7g29s.fsf@alter.siamese.dyndns.org>
 <20130412161600.GA20492@sigill.intra.peff.net>
 <20130412170505.GA2383@sigill.intra.peff.net>
 <7vbo9jehfx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "W. Trevor King" <wking@tremily.us>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Mike Galbraith <bitbucket@online.de>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 21:02:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQjEW-0007Et-Qh
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 21:02:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753650Ab3DLTB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 15:01:56 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43075 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752851Ab3DLTB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 15:01:56 -0400
Received: (qmail 28996 invoked by uid 107); 12 Apr 2013 19:03:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 12 Apr 2013 15:03:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Apr 2013 15:01:52 -0400
Content-Disposition: inline
In-Reply-To: <7vbo9jehfx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221014>

On Fri, Apr 12, 2013 at 11:23:46AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So here's what I came up with. I tried to make the exception as tight as
> > possible by checking that $HOME was actually the problem, as that is the
> > common problem (you switch users, but HOME is pointing to the old user).
> > ...
> > diff --git a/daemon.c b/daemon.c
> > index 131b049..6c56cc0 100644
> > --- a/daemon.c
> > +++ b/daemon.c
> > @@ -1091,7 +1091,7 @@ static void drop_privileges(struct credentials *cred)
> >  	if (cred && (initgroups(cred->pass->pw_name, cred->gid) ||
> >  	    setgid (cred->gid) || setuid(cred->pass->pw_uid)))
> >  		die("cannot drop privileges");
> > -	setenv("GIT_CONFIG_INACCESSIBLE_HOME_OK", "1", 0);
> > +	setenv(GIT_INACCESSIBLE_HOME_OK_ENVIRONMENT, "1", 0);
> >  }
> 
> Compared against an unpublished diffbase???

Oops. Forgot I had made a WIP commit before running the diff.

> OK, so the idea is
> 
>  - The environment can tell us to ignore permission errors for paths
>    under $HOME if (and only if) $HOME itself is not readable;
> 
>  - We got a permission error here.  inaccessible_home_ok() will tell
>    us if the path is under $HOME and the above condition holds (in
>    which case it will say "ok, ignore that error").

Exactly.

> which sounds good, but it relies on the caller of this function not
> to try actually reading from the path.

Yes, but that is the only sane thing for the caller to do, since it gets
the same exit code from ENOENT and ENOTDIR already. Probably a comment
describing the return value is in order.

> If the access() failed due to ENOENT, the caller will get a negative
> return from this function and will treat it as "ok, it does not
> exist", with the original or the updated code.  This new case is
> treated the same way by the existing callers, i.e. pretending as if
> there is _no_ file in that unreadable $HOME directory.

Exactly.

> That semantics sounds sane and safe to me.

Thanks. I'll re-roll with a proper commit message and the fixups I
mentioned above. I think we should still do the documentation for
git-daemon. But it is no longer about "oops, we broke git-daemon", but
"you may want know that we do not set HOME in case you are doing
something tricky with config". I'll submit that with the re-roll, too.

Do you have an opinion on just dropping the environment variable
completely and behaving this way all the time? It would "just fix" the
cases people running into using su/sudo, too.

-Peff
