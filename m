From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] stash: require a clean index to apply
Date: Sun, 7 Jun 2015 08:40:05 -0400
Message-ID: <20150607124001.GA11042@peff.net>
References: <5570F094.10007@quantopian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Kamens <jkamens@quantopian.com>
X-From: git-owner@vger.kernel.org Sun Jun 07 14:40:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1ZsE-0000Y5-0F
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jun 2015 14:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015AbbFGMkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2015 08:40:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:42316 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751555AbbFGMkK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2015 08:40:10 -0400
Received: (qmail 30444 invoked by uid 102); 7 Jun 2015 12:40:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 07 Jun 2015 07:40:09 -0500
Received: (qmail 25481 invoked by uid 107); 7 Jun 2015 12:40:11 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 07 Jun 2015 08:40:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Jun 2015 08:40:05 -0400
Content-Disposition: inline
In-Reply-To: <5570F094.10007@quantopian.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270968>

On Thu, Jun 04, 2015 at 08:43:00PM -0400, Jonathan Kamens wrote:

> I'm writing about the patch that Jeff King submitted on April 22, in
> <20150422193101.GC27945@peff.net>, in particular,
> https://github.com/git/git/commit/ed178ef13a26136d86ff4e33bb7b1afb5033f908 .
> It appears that this patch was included in git 2.4.2, and it breaks my
> workflow.
> 
> In particular, I have a pre-commit hook whith does the following:
> 
> 1. Stash unstaged changes ("git stash -k").
> 2. Run flake8 over all staged changes.
> 3. If flake8 complains, then error out of the commit.
> 4. Otherwise, apply the stash and exit.

Hrm. The new protection in v2.4.2 is meant to prevent you from losing
your index state during step 4 when we run into a conflict. But here you
know something that git doesn't: that we just created the stash based on
this same state, so it should apply cleanly.

So besides the obvious fix of reverting the patch, we could perhaps do
something along the lines of:

  1. Add a --force option to tell git to do it anyway.

  2. Only have the protection kick in when we would in fact have a
     conflict. This is probably hard to implement, though, as we don't
     know until we do the merge (so it would probably involve teaching
     merge a mode where it bails immediately on conflicts rather than
     writing out the conflicted entries to the index).

However, I am puzzled by something in your workflow: does it work when
you have staged and working tree changes to the same hunk? For example:

  [differing content for HEAD, index, and working tree]
  $ git init
  $ echo base >file && git add file && git commit -m base
  $ echo index >file && git add file
  $ echo working >file

  [make our stash]
  $ git stash -k
  Saved working directory and index state WIP on master: dc7f0dd base
  HEAD is now at dc7f0dd base

  [new version]
  $ git.v2.4.2 stash apply
  Cannot apply stash: Your index contains uncommitted changes.

  [old version]
  $ git.v2.4.1 stash apply
  Auto-merging file
  CONFLICT (content): Merge conflict in file
  $ git diff
  diff --cc file
  index 9015a7a,d26b33d..0000000
  --- a/file
  +++ b/file
  @@@ -1,1 -1,1 +1,5 @@@
  ++<<<<<<< Updated upstream
   +index
  ++=======
  + working
  ++>>>>>>> Stashed changes

So v2.4.1 shows a conflict, and loses the index state you had. Is there
something more to your hook that I'm missing (stash options, or
something else) that covers this case?

> The reason I have to do things this way is as follows. Suppose I did the
> following:
> 
> 1. Stage changes that have a flake8 violation.
> 2. Fix the flake8 violation in the unstaged version of the staged file.
> 3. Commit the previously staged changes.
> 
> If my commit hook runs over the unstaged version of the file, then it won't
> detect the flake8 violation, and as a result the violation will be
> committed.

Yeah, the fundamental pattern makes sense. You want to test what is
going into the commit, not what happens to be in the working tree.

One way to do that would be to checkout the proposed index to a
temporary directory and operate on that. But of course that's
inefficient if most of the files are unchanged.

Are you running flake8 across the whole tree, or just on the files with
proposed changes? Does it need to see the whole tree? If you can get
away with feeding it single files, then it should be very efficient to
loop over the output of "git diff-index HEAD" and feed the proposed
updated blobs to it. If you can get away with feeding single lines, then
feeding the actual diffs to it would be even better, but I assume that
is not enough (I do not use flake8 myself).

-Peff
