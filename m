From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: confusion over git-cherry-pick, git-merge and git-cherry
Date: Thu, 25 Feb 2010 00:07:01 +0100
Message-ID: <201002250007.01934.trast@student.ethz.ch>
References: <20100224213923.GV14244@morganstanley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Kevin Green <Kevin.T.Green@morganstanley.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 00:07:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkQKI-0007bf-Qp
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 00:07:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758195Ab0BXXH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 18:07:26 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:27806 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758181Ab0BXXHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 18:07:25 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Thu, 25 Feb
 2010 00:07:23 +0100
Received: from thomas.localnet (84.74.100.59) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Thu, 25 Feb
 2010 00:07:02 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.12-0.1-desktop; KDE/4.4.0; x86_64; ; )
In-Reply-To: <20100224213923.GV14244@morganstanley.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141000>

On Wednesday 24 February 2010 22:39:23 Kevin Green wrote:
>   Here's what the history currently looks like:
>
>
>                       B'-----M beta
>                     /       /
>                o---A---B---C alpha
>
>
> I would expect git-cherry to recognize that B' has the same content as
> B and thus show me a '-' sign in front.  Instead, I get the following
> output from 'git-cherry alpha beta'
>
>   $ git cherry alpha beta
>   + B'
[...]
> Can someone please explain to me why git-cherry doesn't notice that the
> duplicate commit has the same content?  Shouldn't it?   Shouldn't I get
> the following output:
>
>   $ git cherry alpha beta
>   - B'

The problem here is that when looking at the range alpha..beta as
above, git-cherry only filters out commits in beta..alpha.  I suspect
this is an optimization decision, to avoid having to scan more
history.  It's sort-of implied in the manpage when talking about the
fork-point [which is an extremely old term for the merge-base from the
very first docs back in 52a22d1 ([PATCH] Subject: [PATCH] Add some
documentation., 2005-08-26)!].

Now of course your merge means beta..alpha is empty.

By the way, git log --left-right --cherry-pick alpha...beta does the
same.

> To give some further background on what I'm trying to do, I would like
> to prevent changes getting made in the beta branch that don't already
> exist in alpha.  I'm enforcing this with a server side hook that does a
> git-cherry and checks if any of the lines start with a '+'.  This works
> great until I allow changes to be cherry-picked from alpha.  The first
> cherry-pick works, but then when the whole of alpha is later merged in,
> the hook fails to allow any subsequent push to 'beta'.

I tried to come up with a neat solution, possibly using boundary
commits, but unfortunately there seems to be another problem.  Suppose
your history is this:

  *   79a8170 (HEAD, beta) Merge branch 'alpha' into beta
  |\
  | * 5c8e233 (alpha) Revert "B"
  * | 26f9c5f B
  | * 1d5e497 B
  | * a1eaae7 bar
  |/
  * 8c675da foo

I.e., after B was cherry-picked over to beta, it was reverted on
alpha.  In the presumed "unstable" and "more stable" branch I'm
reading into your model, this probably indicates that B was bad and
needs to be thrown out.

The merge, however, appears to "resurrect" the change because it only
looks at the differences between the merge-base (foo) and alpha/beta,
respectively.  This is the right behaviour for a merge: one side did a
change B where the other did nothing.

So no matter how well you filter your beta branch, this model doesn't
give the right results anyway.

That being said, you can obviously brute force your idea by checking
whether all patch ids in 'git log -p old-beta..beta | git patch-id'
also appear in 'git log -p alpha | git patch-id', where 'old-beta' is
what the hook got as the old value of 'beta'.  It will just get
unbearably slow really quick because the latter is an unrestricted
'log' and runs all the way back to your history *while generating
diffs*, so you'll want to cache that list and only add the new ones as
they arrive.

> The output of git-log looks like this (which is also unfortunate):
>
>   $ git log --pretty=oneline
>   M  Merge branch 'alpha' into beta
>   B' change 2
>   C  change 3
>   B  change 2
>   A  change 1
>   o  initial commit

Why is that unfortunate?

If you mean the ordering, look into --topo-order or --date-order.

--
Thomas Rast
trast@{inf,student}.ethz.ch
