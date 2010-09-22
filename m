From: Seth Robertson <in-gitvger@baka.org>
Subject: Re: Find out on which branch a commit was originally made) (was ANNOUNCE git-what-branch)
Date: Wed, 22 Sep 2010 19:26:19 -0400
Message-ID: <201009222326.o8MNQJ2E022410@no.baka.org>
References: <1jp42v5.w5dez21d3nlciM%lists@haller-berlin.de> <4C973E5B.4090201@gmail.com> <4C9782A3.5010005@gmail.com> <201009210015.o8L0FcJt020691@no.baka.org> <4C981475.10404@gmail.com> <201009221635.o8MGZnLD024629@no.baka.org>
        <4C9A66AF.5000302@gmail.com>
Cc: Stefan Haller <lists@haller-berlin.de>, git@vger.kernel.org
To: Artur Skawina <art.08.09@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 23 01:26:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyYhw-0005dG-Bd
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 01:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644Ab0IVX03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Sep 2010 19:26:29 -0400
Received: from tsutomu.baka.org ([66.114.72.182]:38560 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750782Ab0IVX02 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Sep 2010 19:26:28 -0400
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id o8MNQMAq019810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 22 Sep 2010 19:26:22 -0400
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id o8MNQJ2E022410;
	Wed, 22 Sep 2010 19:26:19 -0400
In-reply-to: <4C9A66AF.5000302@gmail.com>
Comments: In reply to a message from "Artur Skawina <art.08.09@gmail.com>" dated "Wed, 22 Sep 2010 22:27:27 +0200."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156840>


In message <4C9A66AF.5000302@gmail.com>, Artur Skawina writes:

    This started in a thread about locating dead topic branche

Isn't that pretty easy to do?  `git fsck --unreachable master | grep
commits`?  Post-processing that to assemble branches would seem to be
fairly simple.

But yes, I wanted something completely different.  Something more
like: if a bug was introduced in commit X, what releases or branches
has it contaminated (or more positively, if a feature was introduced,
where was it made available).  The simple case is figuring out on
which branch a commit was originally made.

I was unhappy when I realized that another way code could get out was
through cherry-picks, and that there doesn't seem any non-brute force
(computing checksums of patches for every patch in the tree) method to
discover them.

    Two things make the above trivial history a bit more complicated.
    A) one side-branch can merge another, and build on top of changes that
       are not yet available on 'master'; the result can then appear in master
       via either one or both paths. This is why showing when and how a change
       became visible on every side branch can be interesting.

Quite.  I encountered this a few different ways and even when I fixed
it during the reverse parse, I failed to learn my lesson and it was a
problem during the forward parse.  I think the latest version is
fairly bullet-proof.

    B) when a side branch does not contain any new changes, but is
       made uptodate wrt master, the resulting history could end up
       like this:

     m-> m -> m -> m -> m -> m -> m ->   master
      \           /      \       /
       b -> b -> b        c ->  c ->    side-branch#1

       What happened was -- git "optimized" the simple merge away, turning it
       into a fast-forward, saving one merge commit, but loosing the link
       connecting the 'c' and 'b' parts of 'side-branch#1'.

    Do you (anybody) happen to know a public repo, w/ history as above, ie
    w/ more then one long-lived branch that has seen some fast-forwards?
    I wonder how reliable recovering the missing link would be...

I have a real (non-public, sorry) tree that did something approaching
this:

->m->m->m->m->m---------m
       /     /         /
b->b->b->b->b------b->b->
 \     \     \    /
  t->t->t->t->t->t

However, due to fast-forwarding, it was turned into something like this:

->m->m->m->m->m---------m
       /     /         /
b->?->?->?->?------b->b->
 \     \     \    /
  t->t->t->t->t->t
  b  b  b  b  b  b

I don't think there is any way to figure out what happened given git's
available information.

I was just saying on #git a few hours ago, though, that I think git
needed a tree anonymizing program.  As long as one does not go
overboard, it doesn't seem too difficult.  That probably means I just
have not thought about the problem hard enough.  Of course, it would
only replicate what is, not how you got there.

    And there's no reason why this operation should take ~20 minutes, even
    for the randomly chosen, but real, worst case. But finding a good repo
    to test w/ would take longer than writing the code...

It only takes 8 seconds per test on the linux kernel, which all things
considered is rather fast.  The real problem is that each test is
treated independently.  If someone got the complete history of the
project and built a tree out of it, it would be extremely fast to run
additional tests even ignoring the obvious optimiziations of not
researching known paths.

The question is, will this functionality be needed often enough to
spend the time necessary to optimize it?


					-Seth Robertson
