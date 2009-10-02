From: Scott Wiersdorf <scott@perlcode.org>
Subject: git as a versioned filesystem
Date: Fri, 2 Oct 2009 10:49:29 -0600
Message-ID: <20091002164929.GA12725@perlcode.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 02 19:16:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtljX-0001Mh-EH
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 19:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757263AbZJBRPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2009 13:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755882AbZJBRPp
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 13:15:45 -0400
Received: from deep2.securesites.net ([198.65.247.173]:3904 "EHLO
	deep2.securesites.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071AbZJBRPp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2009 13:15:45 -0400
X-Greylist: delayed 1577 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Oct 2009 13:15:44 EDT
Received: from deep2.securesites.net (localhost [127.0.0.1])
	by deep2.securesites.net (8.13.6.20060614/8.13.6) with ESMTP id n92GnVON066079
	for <git@vger.kernel.org>; Fri, 2 Oct 2009 10:49:31 -0600 (MDT)
Received: (from scott@localhost)
	by deep2.securesites.net (8.13.6.20060614/8.13.6/Submit) id n92GnV3l066075
	for git@vger.kernel.org; Fri, 2 Oct 2009 10:49:31 -0600 (MDT)
Mail-Followup-To: Scott Wiersdorf <scott@perlcode.org>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.3i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (deep2.securesites.net [127.0.0.1]); Fri, 02 Oct 2009 10:49:31 -0600 (MDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129449>

Hi all,

First off, I'm *not* using git as a typical VCS on the front-end; I'm
using it for dist control on the back-end. I'm also fairly new to git
(about a week and a half into it).

The Scene
=========

For source control, we're using CVS (migrating off of it, btw--I only
have limited influence around here). We build our software, etc,
etc. and then we have the developers scp/rsync/untar their builds on a
*master disk image*.

This master disk image is disted via rsync to a few thousand servers
to keep them all up to date and in sync, etc. This works mostly fine
and I can't really change this system.

The Problem
===========

Our problem has been that occasionally bad stuff gets put in the
master image and we have no easy way to revert it or to allow the QA
team to cherry-pick/revert changes to that master image.

The Solution
============

Git seems like the perfect tool for this, but I'm still not sure how
to adapt it to our situation. I'm building a tool that uses git to let
the developers commit their binary changes to this master image into
the git repository, which hopefully will allow me to offer the QA team
some ability to cherry-pick updates or revert regressions and make a
clean dist image from week to week.

The Question
============

What I need to know from y'all is: is there a better way, a more
git-like way, to accomplish this. Here's the model I *want* to follow:

-----a----b--T1-------c--------d-e---f------g [master]
               \   (a)  \
                ----|----c'---                [B1]

Here is branch B1 created from the master at some point in time T1. On
branch B1, I revert commit (a) and cherry-pick commit (c):

  git checkout master
  git branch B1
  git checkout B1
  git revert a
  git cherry-pick c

At this point, B1 is our "perfect image" and we're ready to dist it. I
check it out elsewhere and rsync it, etc. Wonderful.

But now it's a few weeks later and we're ready to do another
dist. What I *want* to do is create a *copy* of branch B1 to give the
release manager a reference point for him to bring things up to
date. What is the best way to do that?

If I branch off of B1, now I have the burden of doing a whole lot of
cherry-picks and having a challenging time getting things back in sync:

-----a----b--T1-------c--------d-e---f------g [master]
               \   (a)  \         \   \
                ----|----c'---     \   \      [B1]
                               \    \   \
                                -----e'--f'---[B2]

Ugh. Now B2 is kind of a mess. If I rebase it on master, I'll get (d)
and maybe (a) again, which I don't want. [side question: unless
there's a way to rebase on master but still exclude
commits... possible?]. B3 and B4 are going to look even worse and the
risk of drifting so far away from the master is unappealing.

Ideally I'd want each week's release to come directly from the master,
kind of the flying-fish approach:

                               ----e'--f'---  [B2]
                             /    /   /
-----a----b--T1-------c--------d-e---f------g [master]
               \   (a)  \
                ----|----c'---                [B1]

The problem with this is that now B2 contains (a), so I'll have to
revert that again--which I can do happily--but I just wonder if
there's a better way. If it's possible to simply *copy* branch B1 to
B2 without making B2 a branch off of B1.

In the absence of a git-branch-copy, is there something that would
help me do set intersection and subtraction between branches?
Something like this:

  git log B1
  ... bunch of commit ids ...
  git log B2
  ... bunch of commit ids ...

  ## find the intersection(B1, B2)

  ## revert all the things missing in B1 from B2

  ## now B2 is the same as B1--assuming git is idempotent (is it?)

  ## is there way besides rebase to clean out a revert as if it never
  ## happened? I suppose I could branch again and repeat this as
  ## needed.

Am I even thinking about this correctly?

Keep in mind that these commits are not source code commits; they're
file system changes of all kinds: updated binaries and libraries, new
directory trees, removed directory trees, etc. It's much closer to a
package manager in spirit than a VCS.

I feel like I'm missing something grand in git-rev-list or git-log or
git-bisect some other tool that will make all my troubles
disappear. I've read an awful lot of the man pages, but am still very
new to git and I'm certain I've missed some subtleties.

Any ideas? I'm not even sure I'm asking the right questions. I'll
accept any advice on this subject.

Scott
-- 
Scott Wiersdorf
<scott@perlcode.org>
