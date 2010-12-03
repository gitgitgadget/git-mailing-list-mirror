From: Jeff King <peff@peff.net>
Subject: Re: duplicate commits after git rebase -i HEAD~10
Date: Fri, 3 Dec 2010 10:34:35 -0500
Message-ID: <20101203153435.GA6069@sigill.intra.peff.net>
References: <AANLkTi=W9MyCuOuk49AtCxR7nTa5xkddY_2HkhOvQip-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Mathieu Malaterre <mathieu.malaterre@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 16:34:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POXem-0001ei-9c
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 16:34:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826Ab0LCPej (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 10:34:39 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:33658 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751085Ab0LCPei (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 10:34:38 -0500
Received: (qmail 23013 invoked by uid 111); 3 Dec 2010 15:34:36 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 03 Dec 2010 15:34:36 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Dec 2010 10:34:35 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=W9MyCuOuk49AtCxR7nTa5xkddY_2HkhOvQip-@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162805>

On Fri, Dec 03, 2010 at 04:04:53PM +0100, Mathieu Malaterre wrote:

>   I am trying to understand what I did wrong in my git rebase and
> eventually I would like to repair my mistakes. Basically after a git
> rebase, I ended up with duplicate *identical* commits. One was on the
> master branch and one was on a local branch which was merge to master.

They're not quite identical. They may make the same logical change, but
they are based on different history.

The mistake you made is to rebase commits that have been published on
another branch. Generally you would throw away the "originals" after
rebasing, but in this case, the master branch already knows about them
(due to the merge), so that may not be an option.

How you proceed with fixing it depends on what your history looks like,
and how much of it you are willing to rewrite. From your description,
your history looks something like:

             F----G <-- original branch
            /      \
  ...A--B--C--D--E--M <-- master
            \
             F'--G' <-- rebased branch

where F' is the commit matching F, and so forth. Due to merge M, master
contains the commits from the original branch, but your newly rebased
branch has the matching ones.

If you have not actually published the merged value of master to anyone
else, and you have not built anything on top of master, then it is safe
to redo that merge, like:

  git checkout master
  git reset --hard HEAD^
  git merge your-branch

If you have built on top of master, you can still redo the merge, but
you would then need to replay those new commits on top of the new merge:

 # make a new branch at master just before the merge; you will have to
 # find the commit id of the merge via "git log" or gitk
 git checkout tmp-branch M^

 # now redo the merge, using the rebased commits
 git merge your-branch

 # and now we rebase master, using just the commits from _after_ the
 # merge, on top of our re-done merge
 git rebase --onto tmp-branch M master

 # the rebase command leaves us on "master" as a side effect; we can now
 # delete tmp-branch
 git branch -d tmp-branch

If you have published your merged master for others to build on top of,
then you probably don't want to rewrite it, as it will cause pain for
others. Just live with the commits you've published, and redo your
changes as new commits on top. To restore the state of your-branch to
what it was before the rebase, look in the reflog ("git log -g
your-branch"), then reset it ("git checkout your-branch; git reset
--hard your-branch@{1}" (or whatever reflog entry looks to be correct)).

You may want to also look at this thread, which shows a similar problem,
and in which I drew a lot more pictures, which may help explain:

  http://article.gmane.org/gmane.comp.version-control.git/161823

-Peff
