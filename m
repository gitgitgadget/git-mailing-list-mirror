From: Jeff King <peff@peff.net>
Subject: Re: Proposal: branch.<name>.remotepush
Date: Thu, 7 Feb 2013 23:48:36 -0500
Message-ID: <20130208044836.GC4157@sigill.intra.peff.net>
References: <CALkWK0nA4hQ0VWivk3AVVVq8Rbb-9CpQ9xFsSOsTQtvo4w08rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 05:49:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3ftV-0006SH-Tn
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 05:49:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759902Ab3BHEsi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 23:48:38 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39099 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755038Ab3BHEsi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 23:48:38 -0500
Received: (qmail 26120 invoked by uid 107); 8 Feb 2013 04:50:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 07 Feb 2013 23:50:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Feb 2013 23:48:36 -0500
Content-Disposition: inline
In-Reply-To: <CALkWK0nA4hQ0VWivk3AVVVq8Rbb-9CpQ9xFsSOsTQtvo4w08rw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215751>

On Thu, Feb 07, 2013 at 09:44:59PM +0530, Ramkumar Ramachandra wrote:

> This has been annoying me for a really long time, but I never really
> got around to scratching this particular itch.  I have a very common
> scenario where I fork a project on GitHub.  I have two configured
> remotes: origin which points to "git://upstream" and mine which points
> to "ssh://mine".  By default, I always want to pull `master` from
> origin and push to mine.

Same here. Even without GitHub, working on git.git I treat Junio as my
"origin", but push to a publishing point.

> Unfortunately, there's only a branch.<name>.remote which specifies
> which remote to use for both pulling and pushing.  There's also a
> remote.<name>.pushurl, but I get the feeling that this exists for an
> entirely different reason: when I have a server with a
> highly-available read-only mirror of the repository at
> git://anongit.*, and a less-available committer-only mirror at
> ssh://*.

Yeah, you don't want to use pushurl. It makes the assumption that you
are pushing to the same remote, so when you, e.g., push to the remote's
refs/heads/master, it will update refs/remotes/origin/master. But that's
not right; that ref should be tracking the true origin, not what you
pushed to.

> How about a branch.<name>.remotepush that specifies a special remote
> for pushing, falling back to branch.<name>.remote?

Sure, though I wonder if you really want a per-branch config, or if you
just want remote.pushDefault or similar, so that you do not have to
configure each branch independently as you create it. I'm imagining
lookup rules something like:

  1. If we are on branch $b, check branch.$b.pushRemote.

  2. If not set, check remote.pushDefault.

  3. If not set, check branch.$b.remote.

  4. If not set, check remote.default (there was a proposal for this a
     few months ago, but it got stalled).

  5. If not set, use "origin".

And then fetching could do the same, with s/push/fetch/. In both cases,
if you are not using the new variables, the behavior is the same as
the current behavior.

-Peff
