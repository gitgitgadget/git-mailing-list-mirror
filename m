From: Jeff King <peff@peff.net>
Subject: Re: regression: "96b9e0e3 config: treat user and xdg config
 permission problems as errors" busted git-daemon
Date: Fri, 12 Apr 2013 15:58:54 -0400
Message-ID: <20130412195854.GA7795@sigill.intra.peff.net>
References: <7vr4igfj9w.fsf@alter.siamese.dyndns.org>
 <20130412050550.GA15724@sigill.intra.peff.net>
 <20130412112636.GC20178@odin.tremily.us>
 <20130412144855.GA17968@sigill.intra.peff.net>
 <7vk3o7g29s.fsf@alter.siamese.dyndns.org>
 <20130412161600.GA20492@sigill.intra.peff.net>
 <20130412170505.GA2383@sigill.intra.peff.net>
 <7vbo9jehfx.fsf@alter.siamese.dyndns.org>
 <20130412190152.GB4108@sigill.intra.peff.net>
 <7vr4ifcytk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "W. Trevor King" <wking@tremily.us>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Mike Galbraith <bitbucket@online.de>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 21:59:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQk7j-0004h0-2m
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 21:59:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920Ab3DLT66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 15:58:58 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43138 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753296Ab3DLT65 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 15:58:57 -0400
Received: (qmail 30254 invoked by uid 107); 12 Apr 2013 20:00:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 12 Apr 2013 16:00:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Apr 2013 15:58:54 -0400
Content-Disposition: inline
In-Reply-To: <7vr4ifcytk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221022>

On Fri, Apr 12, 2013 at 12:51:19PM -0700, Junio C Hamano wrote:

> >> If the access() failed due to ENOENT, the caller will get a negative
> >> return from this function and will treat it as "ok, it does not
> >> exist", with the original or the updated code.  This new case is
> >> treated the same way by the existing callers, i.e. pretending as if
> >> there is _no_ file in that unreadable $HOME directory.
> >
> > Exactly.
> 
> The explanation you are replying to was meant to illustrate how this
> is not "inaccessible is OK", but is "treat inaccessible as missing",
> by the way.

Ah, I see the distinction you were making. Yes, that is what I was
thinking (and what the patch does); I just used the word "OK" instead.

> Well, at least to me, the documentation update was never about
> "oops, we broke it", but was about "be careful where the HOME you
> are using actually is" from the beginning of the suggestion.  I was
> actually planning to apply it to maint-1.8.1 that predates the xdg
> stuff, and that is why the text only suggests to set HOME for the
> config.

Yes; I think the only change needed would be to the commit message I
proposed (if you even picked that up; I didn't look).

> > Do you have an opinion on just dropping the environment variable
> > completely and behaving this way all the time? It would "just fix" the
> > cases people running into using su/sudo, too.
> 
> With the tightening, people who used --user=daemon, expecting that
> they can later tweak the behaviour by touching ~daemon/.gitconfig,
> got an early warning that they need to set HOME themselves, but with
> any variant of the patch under discussion, as long as loosening is
> on by default, will no longer get that benefit.
> 
> I am not yet convinced if that is a real "fix/cure".
> 
> So, no, I have not even reached the point where I can form an
> opinion if this behaviour should be the default.

OK. I'll hold off for now while we stew on it. Jonathan's patch looks OK
to me, but it has the same issue. But I think every path has to be one
of:

  1. We annoy sysadmins who need to take an extra step to handle the
     HOME situation with --user (the current behavior, or any other
     proposal that they have to opt into).

  2. We annoy sysadmins who want to set HOME with --user, either by
     making what they want to do impossible, or making them set an extra
     variable or option to accomplish what used to work (my patch to set
     HOME with --user).

  3. We loosen the check, so some cases which might be noteworthy are
     not caught (my patch, Jonathan's patch, etc).

I think any solution will have to fall into one of those slots. So we
need to pick the least evil one, and then hammer out its least evil
form.

-Peff
