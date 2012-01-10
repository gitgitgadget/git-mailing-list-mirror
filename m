From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git svn dcommit sends to wrong branch
Date: Tue, 10 Jan 2012 20:43:20 +0100
Message-ID: <87ty438ht3.fsf@thomas.inf.ethz.ch>
References: <20120110161843.GC8196@victor>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 10 20:43:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkhbZ-0001KI-Er
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 20:43:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756715Ab2AJTn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 14:43:27 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:38115 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756677Ab2AJTn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 14:43:26 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 10 Jan
 2012 20:43:23 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.210.26) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 10 Jan
 2012 20:43:23 +0100
In-Reply-To: <20120110161843.GC8196@victor> (Victor Engmark's message of "Tue,
	10 Jan 2012 17:18:43 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.210.26]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188287>

Victor Engmark <victor.engmark@terreactive.ch> writes:

> Commands:
>
> git svn clone -s -r 1:HEAD http://svn/repo
> cd repo
> git commit [thrice, in master only]

Which git version is this?  Before 1.6.5 (b186a261 to be precise)
git-svn pointed master at the branch where the last commit in SVN
happened, which is not necessarily trunk.  After that it tries to point
it at trunk instead.  You can find out, e.g., by saying 'git show' on
the fresh clone and looking at the git-svn-id line.

> git rebase --interactive HEAD~20 [i.e., started rebase in commits before
> the clone]
> [Merged two commits I had made *after* the clone]
> git commit ...
> git dcommit
>
> This created commits on
> <http://svn/repo/branches/branch_name>! Why? Is it because HEAD~20's
> git-svn-id <http://svn/repo/branches/branch_name@22481> is on that
> branch?

The rule is that the commits go to the branch named in the git-svn-id
line of the most recent first-parent ancestor of HEAD.

You can find the "base" commit in question with

  git log -1 --first-parent --grep=^git-svn-id:

> And more importantly, how do I "replay" my commits on trunk?

You need to rebase the commits on trunk, and (very important) strip the
git-svn-id lines from their messages.  If you only had a handful of
commits, your best bet is to use something like

  git checkout -b newbranch
  git rebase -i --onto svn/trunk svn/branch_name  # or whatever git-svn named the remote branches
  # edit all the 'pick' into 'reword'
  # in every commit message editor that pops up, remove the git-svn-id line

  gitk  # make sure that you like the resulting history!
  git svn dcommit

(If you have many commits, git-filter-branch can do the removal
automatically, but it's a bit of a loaded gun pointed at your foot.)

If your git-rebase is too old for 'reword', you can use 'edit' instead
and then, every time that git-rebase drops you into a command line, say

  git commit --amend   # and edit the commit message
  git rebase --continue

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
