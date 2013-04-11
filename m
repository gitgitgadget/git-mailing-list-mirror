From: Jeff King <peff@peff.net>
Subject: Re: regression: "96b9e0e3 config: treat user and xdg config
 permission problems as errors" busted git-daemon
Date: Thu, 11 Apr 2013 16:08:18 -0400
Message-ID: <20130411200818.GE1255@sigill.intra.peff.net>
References: <1365572015.4658.51.camel@marge.simpson.net>
 <20130410135605.GB4694@odin.tremily.us>
 <1365651583.19620.8.camel@marge.simpson.net>
 <20130411054207.GE27795@sigill.intra.peff.net>
 <7vwqs9jd0t.fsf@alter.siamese.dyndns.org>
 <20130411172424.GC1255@sigill.intra.peff.net>
 <20130411181103.GJ27070@google.com>
 <20130411181439.GA2820@sigill.intra.peff.net>
 <7vwqs8hmh1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Mike Galbraith <bitbucket@online.de>,
	"W. Trevor King" <wking@tremily.us>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 11 22:08:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQNnL-0004zu-Cn
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 22:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633Ab3DKUI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 16:08:27 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40894 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753650Ab3DKUI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 16:08:26 -0400
Received: (qmail 18970 invoked by uid 107); 11 Apr 2013 20:10:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 11 Apr 2013 16:10:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Apr 2013 16:08:18 -0400
Content-Disposition: inline
In-Reply-To: <7vwqs8hmh1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220922>

On Thu, Apr 11, 2013 at 12:54:34PM -0700, Junio C Hamano wrote:

> > I could go either way. I think 96b9e0e is the right thing to do
> > conceptually, but I kind of doubt it was affecting all that many people.
> > And though it's _possible_ for it to be a security problem, I find it
> > much more likely that the site admin tries to set some config, gets
> > annoyed when it doesn't work, and debugs it. So from a practical
> > perspective, 96b9e0e may be doing more harm than good, even though it's
> > the right thing.
> 
> Recent reports in this thread make us think so, I guess.
> 
> But reverting 96b9e0e alone would not help these people very much
> though.  They will have reams of warning messages in their server
> logs, and the way to "fix" it would be the same as the way to work
> around the access_or_die(), namely, to set $HOME to point at a more
> appropriate place before running "git daemon".

Yeah, if we revert 96b9e0e, it would only make sense to revert the
warnings, too. Going halfway does not help anyone.

> I also have a suspicion that your patch makes things worse for
> people who are more adept at these issues around running daemons
> than the people who introduced this problem in the first place (eh,
> that's "us").  It is plausible that they may run multiple instances
> of "initially root but setuid() to an unprivileged user" daemons,
> giving each of them a separate play area by setting $HOME to
> different values, just for management's ease not necessarily for
> security (hence sharing the same unprivileged user), which will be
> broken by the patch that unconditionally overrides $HOME.

Yes, we would definitely be breaking them with this patch. I don't know
how common that is. As you noted, it is a bad idea security-wise (if
everything runs as "nobody", then the services are not insulated from
each other), but I can perhaps see a case where all git repos are owned
by the "git" user, but they may be accessed by different config
profiles, which are managed by $HOME.

You could still accomplish the same thing with git by setting
XDG_CONFIG_HOME, though that of course requires effort from the admin.
Sub-programs may not necessarily respect $XDG_CONFIG_HOME, though (e.g.,
anything run from a post-receive hook). On the other hand, people do not
generally push through git-daemon. But that feels like a weak argument.

-Peff
