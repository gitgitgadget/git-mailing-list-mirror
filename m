From: Jeff King <peff@peff.net>
Subject: Re: How to fix =?utf-8?B?4oCcWW91ciBicmFu?=
 =?utf-8?Q?ch_and_'origin=2Fmaster'_have_diverged?= =?utf-8?B?4oCd?= after
 editing a commit that came before a pull?
Date: Fri, 19 Nov 2010 23:36:28 -0500
Message-ID: <20101120043628.GB20725@sigill.intra.peff.net>
References: <AANLkTikr+uGrO2EB9WQk+CXeOm7jiYxdbhGzRRvgc9B9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Yang Zhang <yanghatespam@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 20 05:36:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJfBo-0001rH-1e
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 05:36:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932660Ab0KTEge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 23:36:34 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:54580 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932257Ab0KTEgd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 23:36:33 -0500
Received: (qmail 31243 invoked by uid 111); 20 Nov 2010 04:36:33 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 20 Nov 2010 04:36:33 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Nov 2010 23:36:28 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTikr+uGrO2EB9WQk+CXeOm7jiYxdbhGzRRvgc9B9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161823>

On Fri, Nov 19, 2010 at 04:36:46PM -0800, Yang Zhang wrote:

> In the following scenario:
> 
> 1. Make commits A, B, C
> 2. Pull, getting commits D, E
> 3. Make more commits F, G, H, ...
> 4. Realize that you need to tweak B
> 5. Tweak B using git rebase -i and git commit --amend
> 
> Now git status says:
> 
>   Your branch and 'origin/master' have diverged.
> 
> How should I fix this? Thanks.

When you change a commit, you also change every commit after it (since
each points to its predecessor by a parent pointer). So you create an
alternate history. IOW, you had this:

  A--B--C

and pulled to get this:

  A--B--C--D--E

or maybe this:

  A--B--C--Merge
          /
      D--E

depending on how those other commits relate to what you have. Then you
made more commits, like (let's look at the non-merge case):

  A--B--C--D--E--F--G--H

Then you tweaked B. The rebase replayed every commit after that, but
each one is not exactly the same as the other. So now you have:

    B--C--D--E--F--G--H
   /
  A--B'--C'--D'--E'--F'--G'--H'

where the top branch of history is what you used to have (and is
accessible via the reflog as branch@{1}). But your actual branch is at
H'. So if you "git pull" again, as you tried, it will try to merge D and
E from upstream. So:

                            D--E
                                \
  A--B'--C'--D'--E'--F'--G'--H'--Merge

which is definitely not what you want. The problem is that you have
rewritten upstream's commits, because you rebased across a set of
commits that contained things you had pulled.

To fix it, what you want to do is recreate the history on top of B' as
it happened on top of B. So first you go back to C', the last commit
just before the commits from upstream that were rewritten. (you will
have pick its sha1 out of the log):

  git checkout -b temp B'

You should then have:

  A--B'--C'

on a temporary branch. Now re-pull from upstream (you could also
manually rebase those commits, but this is probably simpler, especially
if there actually was a merge):

  git pull remote_name branch_name

Note that you need to explicitly mention where you pulled from, since
the temp branch will not be configured to pull in the same way (if you
don't have any special config set up, it should be "git pull origin
master").

And now you have:

  A--B'--C'--D--E

at which point we can rebase the last bit of your branch on top:

  git rebase --onto temp F'^ branch_name

where "branch_name" is the name of the branch where this mess happened
(presumably "master"), and F' is the first commit that is worth saving
after you pulled from upstream. And that gives you:

  A--B'--C'--D--E--F''--G''--H''

where F'' corresponds to the original F, but actually has a different
commit id (because of different parentage) than F or F'.

At that point your original branch should be in the state you want. You
can delete the temp branch with "git branch -D temp".

So that's the most general way to do it. It's a little convoluted
because of the way rebase works (you can't say "rebase those commits on
top of me", but rather have to say "rebase me on top of these commits",
which leads us to use the temporary branch).

Depending on the relationship of F, G, and H to D and E, it could be
much simpler to just re-order history. So from your your broken state,
which remember is:

  A--B'--C'--D'--E'--F'--G'--H'

do a "git rebase -i", and just _delete_ all of the commits you pulled
from upstream (D and E in this case). Now you have:

  A--B'--C'--F''--G''--H''

and now repeat your pull to get:

  A--B'--C'--F''--G''--H''--D--E

Which is very simple and straightforward. But it relies on it being
acceptable for F, G, and H to come before D and E in the history.


Whew, that turned out long. Hopefully it helps, and did not just confuse
you more. :)

-Peff
