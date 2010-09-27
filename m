From: Jeff King <peff@peff.net>
Subject: Re: git push on tracking branches
Date: Mon, 27 Sep 2010 13:53:39 -0400
Message-ID: <20100927175339.GA10650@sigill.intra.peff.net>
References: <6958088.371432.1285602164529.JavaMail.root@mail.hq.genarts.com>
 <15793457.371451.1285603241207.JavaMail.root@mail.hq.genarts.com>
 <20100927160548.GA10256@sigill.intra.peff.net>
 <4CA0D178.6070704@letterboxes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Stephen Bash <bash@genarts.com>
To: Nick <oinksocket@letterboxes.org>
X-From: git-owner@vger.kernel.org Mon Sep 27 19:53:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0Htd-0004tR-5v
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 19:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759173Ab0I0Rxo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 13:53:44 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:52498 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759105Ab0I0Rxo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 13:53:44 -0400
Received: (qmail 18674 invoked by uid 111); 27 Sep 2010 17:53:43 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 27 Sep 2010 17:53:43 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Sep 2010 13:53:39 -0400
Content-Disposition: inline
In-Reply-To: <4CA0D178.6070704@letterboxes.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157359>

On Mon, Sep 27, 2010 at 06:16:40PM +0100, Nick wrote:

> The "tracking" setting does seem more sensible and intuitive, given that current
> git practice requires setting up explicit tracking relationships between branches.

It depends on your workflow. If you consider push to be a way of moving
commits in your private repo to a public publishing point, then matching
makes a lot more sense. But if you are emulating a centralized VCS
topology where you replace "svn commit" with "git commit && git push",
then probably pushing HEAD or "tracking" makes more sense.

The former is how git was originally conceived by Linus, and how many
people still use it (notably the kernel and git itself work this way).
But obviously yes, there are lots of people who use it more in the
latter way.

> For example, I find it surprising, perhaps even alarming, that by default, git
> will try and push my changes on branch A to the branch origin/A - even if I
> created it to track origin/B.  Why allow the possibility of A tracking a
> non-matching branch origin/B, and have the default push setting ignore that?

What if I create a topic branch from the master branch, like:

  $ git checkout -b topic origin/master

Now I want to publish my topic for others to see. What should the
behavior be?

With matching, I can do:

  $ hack hack hack
  $ git push ;# oops, we push nothing, because topic is not
              # already published
  $ git push origin topic ;# now topic is published under its
                           # own name
  $ hack hack hack
  $ git push ;# topic is synced to its published version,
              # even though its upstream remains origin/master

With tracking, I get:

  $ hack hack hack
  $ git push ;# we just pushed topic commits to master!

So again. It depends on workflow. Do you think of a branch with a
different name than its upstream as a separate topic based on that
upstream? Or do you think of it as a local version of upstream, simply
with a different name?

> Not only that, but I frequently get asked by puzzled colleagues, new to git, why
> "git push" seems to fail all the time when they're pushing their changes.  (The
> errors arise because of the default "matching" setting: many of the matching
> branches fail to push cleanly because the remote branch has silently changed. My
> latest answer is to tell them to set push.default to "tracking", or to do that
> for them.)

Yeah, one confusing aspect of matching is that it pushes things besides
the HEAD you are on. But I would argue that setting push.default to
"current" is safer than tracking. It pushes only HEAD to a ref of the
same name. In the case that you name your branch after the upstream
branch, this is the same as tracking. In the case that you have named it
something else, it assumes it is acting as a feature branch built on the
upstream, but will never accidentally push feature commits onto the
upstream branch.

> I'm curious: why isn't "tracking" the default and recommended option?
> "Historical reasons" might explain the first, but not the second.

Historical reasons. :)

If you want to read more, there was a lot of discussion on this about a
year and a half ago, which led to push.default being created. My quick
search came up with this thread:

  http://thread.gmane.org/gmane.comp.version-control.git/112757

but I seem to recall there being more philosophical discussion around
the topic, too. You might have to dig around in that general timeframe
of the list archive.

-Peff
