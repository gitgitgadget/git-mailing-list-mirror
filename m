From: Jeff King <peff@peff.net>
Subject: Re: Finding a branch point in git
Date: Mon, 28 May 2012 02:20:26 -0400
Message-ID: <20120528062026.GB11174@sigill.intra.peff.net>
References: <CAMP44s0f7AJPQSTDgvy0U7vx8nxzq2a3vMhSr2Tcc61fetFkJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 28 08:20:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYtK3-0006Va-FM
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 08:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753510Ab2E1GUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 May 2012 02:20:49 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:33979
	"EHLO peff.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752996Ab2E1GUs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 02:20:48 -0400
Received: (qmail 5828 invoked by uid 107); 28 May 2012 06:20:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 May 2012 02:20:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 May 2012 02:20:26 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s0f7AJPQSTDgvy0U7vx8nxzq2a3vMhSr2Tcc61fetFkJA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198628>

On Sun, May 27, 2012 at 02:37:32PM +0200, Felipe Contreras wrote:

> When discussing git vs. mercurial, and what can mercurial do that git
> can't, I inevitably see somebody mention that mercurial branches can
> be used to find the branch point (the point at which a branch started;
> even if it's a long-lived one that has been merged to 'master'
> multiple times).
> 
> There have been a few solutions in stackoverflow[1], but none that
> work in all cases.
> 
> But I think I've found an ad-hoc one that uses the commit messages to
> find the first merge of a branch, and then the merge-base.
> 
> For reference, if somebody is interested:
> 
> ---
> [alias]
>     branch-point = !sh -c 'merge=$(git rev-list --min-parents=2
> --grep="Merge.*$1" --all | tail -1) && git merge-base $merge^1
> $merge^2'
> ---

I think this approach works for two-branch cases, but there is some
subtlety with the regex. My initial thought was that you were looking
for "Merge 'branch_A'" in the commit message (and that is what is
implied by your stackoverflow response). If you always merge the topic
into the main branch, then you will find the first merge. But imagine
this history:

-- X -- A -- B -- C -- D --  E  (master)
         \         \        /
          \         \      /
           G -- H -- I -- J  (branch A)

where I is a merge from master to branch A (e.g., for testing), and then
E is a merge from branch A to master (the actual integration).

Searching for "Merge 'branch_A'" will find E, and then you will take
the merge base of J and D, which is C. But the answer you want is A.
However, we also say "Merge master into 'branch_A'" when HEAD is not
master. So your regex _would_ catch that, and would find I, for which
the merge base is A.

What about a history with multiple branches?

--X--A--B--C--D----E  (master)
      \           /
       G--H--I---J   (branch X)
           \    /
            K--L    (branch Y)

where Y is merged to X (commit J), and then X is merged to master
(commit E). Searching for the earliest merge mentioning X will find J,
the merge between X and Y. But the merge base of its parents is H.

You can improve your regex by specifying a pair of branches and
looking for "Merge X into master" and "Merge master into X" (IOW, make
sure we don't see merges between X and other branches). Then you would
find E, which yields the correct answer.

There are also even more complex cases. It doesn't make much sense to
ask about where branch Y split from master, since it actually came from
branch X in the above example. But let's say we branched straight from
master, merged our result to X, which got merged to master, and then we
built some more commits on Y and merged them to master. Like:

--X--A--B--C--D----E--F (master)
     |\           /  /
     | \         /  /
      \ G--H----I  /  (branch X)
       \       /  /
        K--L--M--O  (branch Y)

The only merge between master and X is F, but its merge base is M. We
missed the earlier merge to master because it actually happened across
two different commits.

-Peff
