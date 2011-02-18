From: Jeff King <peff@peff.net>
Subject: Re: Merging limitations after directory renames -- interesting test
 repo
Date: Fri, 18 Feb 2011 17:21:51 -0500
Message-ID: <20110218222151.GB4258@sigill.intra.peff.net>
References: <AANLkTimsQmOLDENX27YqpicBeFFZrfgEAsLvFiJqoV7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 23:22:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqYi8-0004TY-W2
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 23:22:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758631Ab1BRWVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 17:21:55 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:54176 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753589Ab1BRWVy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 17:21:54 -0500
Received: (qmail 3480 invoked by uid 111); 18 Feb 2011 22:21:53 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 18 Feb 2011 22:21:53 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Feb 2011 17:21:51 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimsQmOLDENX27YqpicBeFFZrfgEAsLvFiJqoV7w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167232>

[cc'ing Linus, who is usually interested in deep rename issues]

On Fri, Feb 18, 2011 at 01:58:48PM -0500, Martin Langhoff wrote:

> Fetch git://dev.laptop.org/git/users/martin/etherpad and try to merge
> pg and master. A ton of work is left to do by hand, and you don't even

s{git/}{} in your url.

>  - Many paths that shoud succeed don't seem to succeed.

Hmm. Two questions:

  1. Did you bump up your merge.renamelimit? It's hard to see because it
     scrolls off the screen amidst the many conflicts, but the first
     message is:

       warning: too many files (created: 425 deleted: 1093), skipping
       inexact rename detection

     which you want to use. Try "git config merge.renamelimit
     10000". Which runs pretty snappily on my machine; I wonder if we
     should up the default limit.

  2. Which version of git are you using? Commit 83c9031 produces some
     funky results on merges. It's not in any released version of git,
     but it is in master.

> After using git merge, tell me if this file doesn't look like at least
> git should have _attempted_ a diff3 on it:
>
>    gitk --all  -- etherpad/bin/rebuildjar.sh
>    trunk/etherpad/bin/rebuildjar.sh
>    trunk/trunk/etherpad/bin/rebuildjar.sh

So assuming the two issues above are not a problem, merge says:

  CONFLICT (rename/delete): Rename
  trunk/etherpad/bin/rebuildjar.sh->etherpad/bin/rebuildjar.sh in
  origin/pg and deleted in HEAD

about this and many other files. But that doesn't seem right. Both sides
did the same rename. But we don't seem to detect it on "master":

  $ base=`git merge-base master origin/pg`
  $ git diff -M --summary $base master | grep rebuildjar
   create mode 100755 etherpad/bin/rebuildjar.sh
   delete mode 100755 trunk/etherpad/bin/rebuildjar.sh

Hmm. That is probably because it was substantially rewritten:

  $ wc -l etherpad/bin/rebuildjar.sh
  161

  $ git diff --stat \
      $base:trunk/etherpad/bin/rebuildjar.sh \
      master:etherpad/bin/rebuildjar.sh
   .../etherpad => master:etherpad}/bin/rebuildjar.sh |   92 +++++++++++++-
   1 files changed, 89 insertions(+), 3 deletions(-)

You can ignore the rename-looking bit in the diffstat; it's an artifact
of the way single-blob diffs are done. But the important thing to note
is that it was mostly rewritten on the master branch, and that's why the
rename isn't found.

This seems like an interesting case with respect to git's philosophy of
automatic rename detection. Usually the notion of "if it is so far apart
that we can't do rename detection, a 3-way merge is not likely to be
interesting" works.

But in this case, that may not hold. We have identical renames on either
side, but one side has been modified a lot. The 3-way merge may very
well be useful, but we never get there, because we don't even consider
that the two endpoints may be related.

You can simulate the 3-way merge that would happen with:

  $ git show origin/pg:etherpad/bin/rebuildjar.sh >pg
  $ git show master:etherpad/bin/rebuildjar.sh >master
  $ git show $base:trunk/etherpad/bin/rebuildjar.sh >base
  $ git merge-file master base pg
  $ $EDITOR master

It's an ugly merge, but way more useful than dumping with a
rename/delete conflict.

I'm not sure of the right solution. I guess if there was some way to say
"no really, these are renames" it would make your merge easier. But I
wonder if we can somehow be more clever.

>  - Git diff seems confused, says "path needs merge" instead of giving
> me a diff. May be related to the first problem
>     git diff -- etherpad/bin/rebuildjar.sh

I think this is a side effect of the rename/delete conflict. There is
nothing to diff against on one side.

-Peff
