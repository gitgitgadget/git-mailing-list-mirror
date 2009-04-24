From: Josef Wolf <jw@raven.inka.de>
Subject: How to sync two svn repositories via git? (reloaded)
Date: Fri, 24 Apr 2009 09:08:37 +0200
Message-ID: <20090424070836.GA15420@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: "To:git"@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 24 09:12:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxFZn-0003yT-7X
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 09:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753250AbZDXHKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 03:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752547AbZDXHKY
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 03:10:24 -0400
Received: from quechua.inka.de ([193.197.184.2]:59478 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751952AbZDXHKX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 03:10:23 -0400
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1LxFYE-0001SI-4j; Fri, 24 Apr 2009 09:10:22 +0200
Received: by raven.inka.de (Postfix, from userid 1000)
	id 1B7AE2CC66; Fri, 24 Apr 2009 09:08:37 +0200 (CEST)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>,
	"To:git"@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117416>

Hello,

I have two subversion repositories which I would like to synchronize via
git-svn.  For this, I have set up a git repository and configured two
branches to track the subversion repositories via git-svn:

    mkdir test-sync
    cd    test-sync
    git svn init --stdlayout file://$REPOSDIR/svn-first

    for repos in svn-first svn-second; do
        git config svn-remote.$repos.url      file://$REPOSDIR/$repos
        git config svn-remote.$repos.fetch    trunk:refs/remotes/$repos/trunk
        git config svn-remote.$repos.branches branches/*:refs/remotes/$repos/*
        git config svn-remote.$repos.tags     tags/*:refs/remotes/$repos/tags/*
        git svn fetch -R $repos
        git checkout -b $repos $repos/trunk
    done
    git gc

This gives me two remote and two local branches:

    master
    svn-first
  * svn-second
    svn-first/trunk
    svn-second/trunk

As a first step, I tried to "mirror" the manual "merges" that were done
between the subversion repositories in the past:

    git checkout svn-first
    git cherry-pick svn-second-sha1 .... # repeat as needed

    git checkout svn-second
    git cherry-pick svn-first-sha1 .... # repeat as needed

So I've spent almost 4 weeks to cherry-pick and resolve all the conflicts.
Looks good so far, since

    git diff svn-first svn-second
    git diff svn-first/trunk svn-first/trunk
    git diff svn-second/trunk svn-second/trunk

give me the desired outputs.  Now I do

    git checkout svn-first
    git merge -s ours svn-second
    git checkout svn-second
    git merge -s ours svn-first

to tell git that the branches are in sync.

But now, when I try to

    git checkout svn-second
    git svn rebase

I get lots of conflicts.  When I inspect the .git/rebase-apply directory
and the conflicts, it looks like "git svn rebase" tries to re-apply all
the commits from svn-first.  When I omit the "git merge -s ours svn-first"
command, it does not re-apply those commits.  So it looks like the
"git merge -s ours" wipes some information that git-svn needs to know
what was already merged.

What am I missing?  I thought the "ours" strategy is meant to tell git
that everything from that branch was merged, either manually or by
cherry-pick.

Any hints how to track this down?

BTW: this is git version 1.6.0.2
