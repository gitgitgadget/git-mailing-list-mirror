From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv5 23/23] Provide 'git merge --abort' as a synonym to 'git
 reset --merge'
Date: Mon, 25 Oct 2010 12:02:59 +0200
Message-ID: <201010251203.00389.johan@herland.net>
References: <1287965333-5099-1-git-send-email-johan@herland.net>
 <1287965333-5099-24-git-send-email-johan@herland.net>
 <20101025013217.GA25355@burratino>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, bebarino@gmail.com, avarab@gmail.com,
	gitster@pobox.com, srabbelier@gmail.com,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 25 12:03:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAJtb-0000fT-4y
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 12:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754980Ab0JYKDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Oct 2010 06:03:07 -0400
Received: from smtp.getmail.no ([84.208.15.66]:37000 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754775Ab0JYKDG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Oct 2010 06:03:06 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAU00LMQBX2I470@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 25 Oct 2010 12:03:02 +0200 (MEST)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id CEFC41798FF5_CC555D5B	for <git@vger.kernel.org>; Mon,
 25 Oct 2010 10:03:01 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 3F9821796343_CC555D5F	for <git@vger.kernel.org>; Mon,
 25 Oct 2010 10:03:01 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAU00L6GBX1LR30@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 25 Oct 2010 12:03:01 +0200 (MEST)
User-Agent: KMail/1.13.5 (Linux/2.6.35-ARCH; KDE/4.5.2; x86_64; ; )
In-reply-to: <20101025013217.GA25355@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159936>

On Monday 25 October 2010, Jonathan Nieder wrote:
> Johan Herland wrote:
> > --- a/Documentation/git-merge.txt
> > +++ b/Documentation/git-merge.txt
> > @@ -13,6 +13,7 @@ SYNOPSIS
> > 
> >                                                     However, if there
> > +were uncommitted changes when the merge started (and these changes
> > +did not interfere with the merge itself, otherwise the merge would
> > +have refused to start), and then additional modifications were made
> > +to these uncommitted changes, 'git merge --abort' will not be able
> > +reconstruct the original (pre-merge) uncommitted changes. Therefore:
>
> I do not find this clear.  Could you give an example?

I'll try. Given these commands:

  git init
  echo foo > foo
  echo bar > bar
  echo baz > baz
  git add foo bar baz
  git commit -m initial
  git checkout -b side
  echo blarg > bar
  echo blazg > baz
  git commit -a -m "side"
  git checkout master
  echo xyzzy > bar
  git commit -a -m "xyzzy"

We now have the following repo, in terms of bar/baz's contents:

  bar/baz---xyzzy/baz    <-- master
         \
          --blarg/blazg  <-- side

Now, before we merge side into master, consider what uncommitted changes we 
can make before starting the merge:

  A. (no changes)

  B. Change foo to something different [echo blech > foo]

  C. Same as (B), plus stage foo [git add foo]

  D. Change bar to something different [echo blech > bar]

  E. Same as (D), plus stage bar [git add bar]

  F. Change baz to something different [echo blech > baz]

  G. Same as (F), plus stage baz [git add baz]

  H. Change baz to "blazg" [echo blazg > baz]

  I. Same as (H), plus stage baz [git add baz]

AFAICS, this is a complete list of pre-merge uncommitted changes we can 
make. Everything else is either uninteresting, or can be classified in terms 
of (a combination of) the above 9 cases.

Now, we can immediately disregard cases (C), (D), (E), (F), (G) and (H), 
since 'git merge' refuses to start merging:

  $ git merge side
  error: Your local changes to the following files would be overwritten by
  merge:
          foo/bar/baz
  Please, commit your changes or stash them before you can merge.
  Aborting

So we're left with considering cases (A), (B) and (I). These cases are 
preserved by the merge, in that:

  A. Non-changes are still non-changes after the merge.

  B. Uncommitted changes are still uncommitted changes.

  I. Staged changes (matching the other branch) are still staged changes.

Now, my experiments in t7609 (although I now see that I have failed to 
properly recreate case (I); this will be fixed in the next iteration) 
demonstrate that 'git merge --abort' will preserve uncommitted changes, and 
discard staged changes. As such cases (A) and (B) will be preserved by 'git 
merge --abort', while case (I) will be lost.

Furthermore, experiments (in t7609) show that 'git merge --abort' is unable 
to identify any changes done after the merge attempt and before 'git merge 
--abort'. As such, if you make any more staged or unstaged changes, they 
will be handled by 'git merge --abort' as though they happened before the 
merge (i.e. unstaged changes are preserved, staged changes are discarded).

I should therefore update the documentation to be a little broader in its 
warning against merging with uncommitted changes. Maybe something like:

  However, if there were uncommitted changes when the merge started,
  'git merge --abort' will in some cases be unable to recreate these
  changes. Especially if further changes were made after the merge was
  started, 'git merge --abort' is unable to reconstruct the original
  (pre-merge) changes. Therefore:

> References:
> 
> http://thread.gmane.org/gmane.comp.version-control.git/136356/focus=136773
> http://thread.gmane.org/gmane.comp.version-control.git/151799/focus=151812

Thanks. I hadn't read those before preparing these. Instead I tried to 
document the current behaviour by testing all scenarios (that I could think 
of) in t7609, and documenting the results, extensively in t7609 and somewhat 
more abbreviated in the man page.

> > +--abort::
> > +	Abort the current conflict resolution process, and
> > +	reconstruct the pre-merge state.
> > ++
> > +Any uncommitted worktree changes present when the merge started,
> > +will only be preserved if they have not been further modified
> > +since the merge started.
> 
> Ah, maybe I see: is the problem this procedure?
> 
>  1. Make changes to file foo.c (without staging them).
>  2. Try a merge (which cannot touch foo.c, or the merge would have
>     been aborted automatically) which fails with conflicts.
>  3. As a result of semantic conflicts, make some changes to foo.c.
>  4. Wish to return to the state from the end of step 1.

Exactly. That's one of the cases presented above.

> But I find the following more likely:
> 
>  1. Make changes to file foo.c (without staging them).
>  2. Try a merge (which cannot touch foo.c, or the merge would have
>     been aborted automatically) which fails with conflicts.
>  3. Walk away in disgust.
>  4. Return, make some more changes to foo.c.
>  5. Notice the merge in progress --- oh! --- and abort it.

Yeah, in that case the current behaviour will actually work for you, as long 
as you DON'T stage your changes (staged + abort => changes lost, d'oh).

> > --- a/t/t7609-merge-abort.sh
> > +++ b/t/t7609-merge-abort.sh
> > @@ -3,95 +3,271 @@
> > 
> >  test_description='test aborting in-progress merges'
> >  . ./test-lib.sh
> > 
> > +# Set up repo with conflicting and non-conflicting branches:
> > +#
> > +# master1---master2---foo_foo  <-- master
> > +#        \
> > +#         --clean1             <-- clean_branch
> > +#                 \
> > +#                  --foo_bar   <-- conflict_branch
> 
> [It might be nice to include this in test_description for use by
>  "./t7609-merge-abort.sh --help".]

Agreed. Will fix.

> > +# - dirty worktree before merge matches contents on remote branch
> 
> Or maybe this was the example.  Here was Junio's explanation of it:
> | It will discard the change, the one you independently picked up, but
> | the change agreed with what was done by the the trash history that you
> | are cancelling merge with.  You wouldn't miss losing the same change
> | as in that trash history.

Yeah, but I've now found that I failed to test that case. Will be fixed in 
the next iteration.

> In other words, if the change is also on a remote branch that you want
> not to merge with anyway, it is not likely to be terribly important to
> preserve it in the local tree.  (This is a trade-off between
> convenience in two different scenarios.)

Yeah, it's an argument that will work in some situations, but not all. Say 
you happend to stage something after the merge, but before you 'git merge --
abort'. That change will be obliterated by the --abort, which is likely not 
what you wanted.

> Hope that helps (sorry for the ramble).

That was _immensely_ helpful, since it cleared my own jumbled thoughts on 
the matter, and identified a missing/miscreated case in t7609. Thanks!


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
