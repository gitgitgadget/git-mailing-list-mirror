From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] format-patch: introduce format.defaultTo
Date: Tue, 7 Jan 2014 15:56:18 -0500
Message-ID: <20140107205618.GA28102@sigill.intra.peff.net>
References: <1389028732-27760-1-git-send-email-artagnon@gmail.com>
 <1389028732-27760-3-git-send-email-artagnon@gmail.com>
 <xmqqlhythrzq.fsf@gitster.dls.corp.google.com>
 <CALkWK0kZn44x98td9YXNT5VfhVs=ueeSty9M7Vh08bdoGjGQYg@mail.gmail.com>
 <xmqqa9f8j2n8.fsf@gitster.dls.corp.google.com>
 <20140106201854.GA28162@sigill.intra.peff.net>
 <CALkWK0k21W4gz9Rm8CyLMwjXq2A9wvm=XCVDsqs06oeW3VUg6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 21:56:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0dhJ-0004vK-0o
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 21:56:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753487AbaAGU4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 15:56:22 -0500
Received: from cloud.peff.net ([50.56.180.127]:56687 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751500AbaAGU4U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 15:56:20 -0500
Received: (qmail 23706 invoked by uid 102); 7 Jan 2014 20:56:20 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Jan 2014 14:56:20 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jan 2014 15:56:18 -0500
Content-Disposition: inline
In-Reply-To: <CALkWK0k21W4gz9Rm8CyLMwjXq2A9wvm=XCVDsqs06oeW3VUg6w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240152>

On Tue, Jan 07, 2014 at 03:40:56AM +0530, Ramkumar Ramachandra wrote:

> Jeff King wrote:
> > Yeah, I had similar thoughts. I personally use "branch.*.merge" as
> > "forkedFrom", and it seems like we are going that way anyway with things
> > like "git rebase" and "git merge" defaulting to upstream.
> 
> My issue with that is that I no idea where my branch is with respect
> to my forked upstream; I find that extremely useful when doing
> re-spins.

Right. I think there are two separate relationships, and they are both
shoe-horned into "upstream". The solution is to let them be configured
separately (and fallback on each other as appropriate to make the burden
less on the user).

> push.default = upstream is a bit of a disaster, in my opinion. I've
> advocated push.default = current on multiple occasions, and wrote the
> initial remote.pushDefault series with that configuration in mind.

Yeah, I agree with all of that.

> > I wonder if it is too late to try to clarify this dual usage. It kind of
> > seems like the push config is "this is the place I publish to". Which,
> > in many workflows, just so happens to be the exact same as the place you
> > forked from. Could we introduce a new branch.*.pushupstream variable
> > that falls back to branch.*.merge? Or is that just throwing more fuel on
> > the fire (more sand in the pit in my analogy, I guess).
> 
> We already have a branch.*.pushremote, and I don't see the value of
> branch.*.pushbranch (what you're referring to as pushupstream, I
> assume) except for Gerrit users.

Yes, "pushbranch" is probably a better name for what I am referring to.
I agree that pushremote is probably enough for sane cases. I seem to
recall that people advocating the "upstream" push-default thought that
branch name mapping was a useful feature, but I might be
mis-remembering. I will let those people speak up for the feature if
they see fit; it seems somewhat crazy to me.

> Frankly, I don't use full triangular workflows myself mainly because
> my prompt is compromised: when I have a branch.*.remote different from
> branch.*.pushremote, I'd like to see where my branch is with respect
> to @{u} and @{publish} (not yet invented);

Yes, as two separate relationships, you would theoretically want to be
able to see them separately (or simultaneously side by side). Whether
exposing that in the prompt is too clunky, I don't know (I don't even
show ahead/behind in my prompt, but rather prefer to query it when I
care; I have a separate script that queries the ahead/behind against my
publishing point, but it would be nice if git handled this itself).

> > I admit I haven't thought it through yet, though. And even if it does
> > work, it may throw a slight monkey wrench in the proposed push.default
> > transition.
> 
> We're transitioning to push.default = simple which is even simpler
> than current.

Simpler in the sense that it is less likely to do something unexpected.
But the rules are actually more complicated. Two examples:

  1. Imagine I make a feature branch "foo" forked off of origin/master, then
     "git push" with no arguments. The "current" scheme would go to
     "foo" on origin, but "upstream" would go to "master". Since they
     don't agree, "simple" will punt and tell me to be more specific.

  2. Imagine I have set my default push remote to "publish", am on
     master (forked from "origin/master") and I run "git push" without
     arguments. "current" would push to "master" on "publish". But
     "upstream" will complain, because we are not pushing to our
     upstream remote. I believe "simple" will therefore reject this.

In both cases, I think "current" does the sane thing, and "simple" makes
things more complicated. The one saving grace it has is that it punts on
these cases rather than potentially doing something destructive that the
user did not intend.

-Peff
