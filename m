From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: How to get rid of doubled branch after renaming a branch in svn-repository
Date: Wed, 01 Dec 2010 15:01:32 +0100
Message-ID: <4CF6553C.70500@drmicha.warpmail.net>
References: <0a6b49e3cc0b08a717c0d6141073f32d@tropezien.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: pacco@tropezien.de
X-From: git-owner@vger.kernel.org Wed Dec 01 15:04:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNnHr-0002pF-Py
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 15:04:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755338Ab0LAODt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 09:03:49 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:40541 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755138Ab0LAODs (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Dec 2010 09:03:48 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id EE33B5A9;
	Wed,  1 Dec 2010 09:03:47 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Wed, 01 Dec 2010 09:03:47 -0500
X-Sasl-enc: 8CElgCC6RIfNFLfFs3oMQdv871nxH217vKWll1+Igs4A 1291212227
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 77809407C59;
	Wed,  1 Dec 2010 09:03:47 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101103 Fedora/1.0-0.33.b2pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.6
In-Reply-To: <0a6b49e3cc0b08a717c0d6141073f32d@tropezien.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162518>

pacco@tropezien.de venit, vidit, dixit 01.12.2010 13:48:
>  Hi,
> 
>  I'm using git-svn as a tracking-tool for a Subversion repository.
>  I currently detected an unexpected branch, seeming dead, but visible 
>  using 'git branch -a'. I checked the svn log and saw that someone has 
>  moved/renamed a branch. That results in a deletion of the old branch and 
>  an adding of a copy of the old branch with the new branch name.
> 
>  The scenario is like that:
> 
>  $ git branch -a
>  * master
>    remotes/svnrepos/git-svn-test
> 
>  # Rename the branch (move) in the SVN-repos
>  $ svn mv https://svn.repos/branches/git-svn-test 
>  https://svn.repos/branches/git-svn-test-new
> 
>  # Update git-repository
>  $ git svn fetch
> 
>  $ git branch -a
>  * master
>    remotes/svnrepos/git-svn-test
>    remotes/svnrepos/git-svn-test-new
> 
>  You see the problem. Within Subversion simply a new repository version 
>  now no longer "showing" the git-svn-test-branch was created. But within 
>  git both branches stay visible.
>  Well, I know that renaming a branch is really not that favoured action.
>  But I expected that git-svn gathers also this deletion and removes the 
>  obsolete branch.
> 
>  So, am I doing something wrong? Or am I expecting the wrong behaviour? 
>  Or is that simply a feature, not a bug, and must be handled manually?
> 

Branches in svn and git are different. If you delete a branch in svn,
the "content" is still there in the sense that it is there in previous
revisions. You only delete a pointer in your svn-filesystem.

In git, a branch points at a commit, and deleting a branch means making
that commit pointerless (unless it is pointed to by other branches or
tags). So far there's some similarity. But now, if that commit and all
its descendants are "pointerless" (can't be reached from a named ref)
git will garbage collect them after a while. They're considered pointless ;)

svn records the rename as a copy+delete (it also sets some rename info
which git-svn seems to ignore). So, git-svn stays on the safe side by
keeping the branch. Note that deleting the branch would possibly delete
at least some info since the branch name is not recorded in the commit
(if you use svn.noMetadata).

You can safely delete the branch if you're sure its head commit is
contained in some other branch (as will be for an ordinary rename).

Michael
