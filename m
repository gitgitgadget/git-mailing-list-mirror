From: John Wiegley <johnw@boostpro.com>
Subject: Using Origin hashes to improve rebase behavior
Date: Thu, 10 Feb 2011 16:13:10 -0500
Message-ID: <m21v3fvbix.fsf@hermes.luannocracy.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 10 22:13:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PndpI-0005rj-IH
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 22:13:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757115Ab1BJVNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 16:13:14 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:33460 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757065Ab1BJVNO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 16:13:14 -0500
Received: by qyj19 with SMTP id 19so2786459qyj.19
        for <git@vger.kernel.org>; Thu, 10 Feb 2011 13:13:13 -0800 (PST)
Received: by 10.224.74.80 with SMTP id t16mr17736781qaj.0.1297372392924;
        Thu, 10 Feb 2011 13:13:12 -0800 (PST)
Received: from localhost (207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com [207.172.223.249])
        by mx.google.com with ESMTPS id g28sm8235qck.37.2011.02.10.13.13.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Feb 2011 13:13:12 -0800 (PST)
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.2 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166500>

The following proposal is a check to see if this approach would be sane and
whether someone is already doing similar work.  If not, I offer to implement
this solution.

THE PROBLEM

Say I have a master from which I have branched locally, and that this private
branch has four commits:

    a   b   c
    o---o---o
             \
              o---o---o---o
              1   2   3   4

I then decide to cherry pick commit 3 onto master.  Please believe that my
situation is such that I cannot immediately rebase the private branch to drop
the now-duplicated change.  I end up with this:

    a   b   c   3'
    o---o---o---o
             \
              o---o---o---o
              1   2   3   4

Later, there is work on master which changes the same lines of code that 3'
has changed.  The commit which changes 3' is e*

    a   b   c   3'  d   e*  f
    o---o---o---o---o---o---o
             \
              o---o---o---o
              1   2   3   4

At a later date, I want to rebase the private branch onto master.  What will
happen is that the changes in 3 will conflict with the rewritten changes in
e*.  However, I'd like Git to know that 3 was already incorporated at some
earlier time, and *not consider it during the rebase*, since it doesn't need
to.

THE SOLUTION

For the purposes of this discussion, I'd like to define the term "aggregate
identity" (insert better name here) as a set including: a commit's sha, and
zero or more shas stored in a new field named "Origin-Ids".

If, when cherry-picking, the originating's commit id is stored in the
Origin-Ids field of the cherry-picked commit, then rebase could know whether a
given commit's changes had already been applied.  The logic would look like
this:

  1. When rebasing a branch A onto B, find the common ancestor of A and B.
  2. Examine every commit on B since that common ancestor, collecting a
     set of their aggregate identities.
  3. For each commit on A, ignore it if its aggregate identity occurs in
     that set.

This would cause commit 3 to be ignored during the rebase above, since 3'
would have an origin id referring to 3.

IMPLEMENTATION

A few things need to be done:

 - Extend commit objects to have an Origin field, which can be zero, one or a
   list of hashes.

 - Add an option to git commit so that one or more origin ids can be specified
   at the time any commit is made.  There may be occasions when it's useful to
   explicitly state that a new commit should somehow 'override' the contents
   of another during a rebase.

 - git cherry-pick and git am should add this Origin field, showing the commit
   their contents originated from.

 - git merge --squash would store the commit ids, and the origin ids, of every
   commit involved in the merge into the resulting commit's Origin field.

   Note that nothing can be done about rebasing a squashed merge commit onto
   another squashed merge commit, even though it could be detected that they
   had common changes.  I don't believe it would even be useful to warn about
   this, the user would just have to resolve the conflicts manually.

 - git log could be extended to show the "parentage" (really, the aunt/uncle)
   of commits with origin info, assuming those origin commits are not dangling
   (which is OK, and likely to occur after the originating branch is deleted,
   or if the originating branch is in another repository).

   Where there are multiple Origin ids, a search could be done to find the set
   of most descendent commits, so that history could be usefully shown after
   an octopus squash, for example.

QUESTIONS

Is it allowable to add new metadata fields to a commit, and would this require
bumping the repository version number?  Or should this be implemented by
appending a Header-style textual field at the end of the commit message?

--
  John Wiegley
  BoostPro Computing
  http://www.boostpro.com
