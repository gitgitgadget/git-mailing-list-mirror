From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Support specific color for a specific remote branches
Date: Wed, 10 Aug 2011 06:16:12 -0600
Message-ID: <20110810121611.GA17071@sigill.intra.peff.net>
References: <1312818553-25042-1-git-send-email-avivey@gmail.com>
 <7v8vr3zsh1.fsf@alter.siamese.dyndns.org>
 <20110808205214.GG18294@sigill.intra.peff.net>
 <7v62m7wpxg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Aviv Eyal <avivey@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 10 14:16:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qr7hz-0004AG-P0
	for gcvg-git-2@lo.gmane.org; Wed, 10 Aug 2011 14:16:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753857Ab1HJMQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Aug 2011 08:16:22 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39875
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753829Ab1HJMQW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2011 08:16:22 -0400
Received: (qmail 16073 invoked by uid 107); 10 Aug 2011 12:16:53 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Aug 2011 08:16:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Aug 2011 06:16:12 -0600
Content-Disposition: inline
In-Reply-To: <7v62m7wpxg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179065>

On Mon, Aug 08, 2011 at 02:31:39PM -0700, Junio C Hamano wrote:

> But in real-life, it is entirely plausible that people with multiple
> integration branches are taking advantage of the simplicity of the old
> layout, i.e.
> 
>     [remote "origin"]
>     	fetch = refs/heads/master:refs/heads/origin
>         fetch = refs/heads/next:refs/heads/next
>         fetch = refs/heads/maint:refs/heads/maint
>         fetch = +refs/heads/pu:refs/heads/pu
>
> [...]
>
> Now, for these repositories, is "next" a local branch or a remote one? I
> have a feeling that it might be easier to understand if we label anything
> that you can update with "checkout && commit" a local one for the purpose
> of "branch -r" listing; IOW, the current "git branch -r" classification
> would match this use pattern better, even though refs/heads/next _is_ an
> RHS of a rule to follow others.

Agreed, that really muddies the idea of what is a "remote branch" and
what is not. I think there is a sense among users that "local branches"
and "remote branches" are mutually exclusive sets, even though by some
definitions they may not be (i.e., if you define the former by where in
the refs/ hierarchy they exist, and the latter by being the RHS of a
remote fetch refspec).

> In that sense, I would be entirely happy if the configuration variable
> used in this series were branch.<namepattern>.color and let you specify
> 
> 	[branch "refs/heads"] color = yellow
>         [branch "refs/remotes/origin"] color = purple
>         [branch "refs/remotes/nitfol"] color = cyan

There are two issues I see with that:

  1. Until now, "branch" sections like this have always been about local
     branches.  What are the rules for defining something like
     "branch.refs/remotes/origin/foo.merge"? Knowing how the code works,
     it is easy to say it is a noop, as we will never look at it. But I
     wonder how it looks from the perspective if a recent git user.

  2. Until now, "branch" sections specify full refs, not subsets or
     wildcard patterns. What does "branch.refs/heads.merge" mean?
     A noop? A wildcard with slightly lesser precedence than
     "branch.refs/heads/foo.merge"?

If we are going to go this route, I think it is really about introducing
properties not on branches, but on subsets of the ref namespace. So
might say:

  [ref "refs/heads/*"] color = yellow

which says "whenever you are dealing with this part of the refs
namespace, my preferred color is yellow". And "git branch" happens to
respect that (and we could just as easily have a "%(refcolor)" marker in
git-for-each-ref).

I know the difference is subtle, but I just think it removes entirely
the question about what is a branch and what is not. Furthermore, it
naturally extends to other commands (e.g., you could color subsets of
the tag namespace differently), to more complex layouts (e.g., if we
end up moving fetched tags into the refs/remotes namespace eventually),
and to other properties besides color (though I haven't though up any
applications).

> It becomes complicated (and for no good reason, in my opinion; see the
> "next" example above) if you try to tie this with remote.<name> hierarchy,
> as it obviously becomes illogical not to use the "RHS of a fetch refspec"
> logic when we are talking about remote.<name>.

We've been discussing the coloring issue here. But the other thread I
pointed out was about asking "which fetched branches do we have locally
for this remote?".  Which is a very reasonable thing to ask, and which
don't do a good job of answering right now. And I think it has to
do the "RHS of a fetch refspec thing".

Right now you can do "git remote show". But:

  1. It's very heavyweight. It shows you way more than you want in most
     cases, and it touches the network by default (there is a "-n"
     option, but touching the network by default makes it pretty
     un-git).

  2. It's not as easily discoverable as "git branch -r". It's not
     unreasonable for users to mentally go through the sequence:

       a. "git branch" shows me branches

       b. oh, it has an "-r" option for remotes

       c. how do I limit to one remote?

I'm not sure what the right solution is. Going from 2b to 2c is a very
natural thing for a user to want to do. But it means jumping from one
definition of "remote" (i.e., everything under "refs/remotes") to
another (the config defined by remote "foo"). In the default config,
that is a natural jump, as they are semantically connected. But they
don't have to be.

-Peff
