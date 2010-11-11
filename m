From: Seth Robertson <in-gitvger@baka.org>
Subject: Re: How to recover a lost commit...
Date: Thu, 11 Nov 2010 11:49:45 -0500
Message-ID: <201011111649.oABGnjca019731@no.baka.org>
References: <AANLkTinfYTMKicr3V=T=scVpOte_XrmaDgVA_oMj2fYU@mail.gmail.com>
Cc: git <git@vger.kernel.org>
To: Patrick Doyle <wpdster@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 17:49:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGaLS-0000gP-0x
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 17:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754337Ab0KKQtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 11:49:49 -0500
Received: from tsutomu.baka.org ([66.114.72.182]:32921 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753886Ab0KKQtt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 11:49:49 -0500
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id oABGnknD025860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 11 Nov 2010 11:49:46 -0500
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id oABGnjca019731;
	Thu, 11 Nov 2010 11:49:45 -0500
In-reply-to: <AANLkTinfYTMKicr3V=T=scVpOte_XrmaDgVA_oMj2fYU@mail.gmail.com>
Comments: In reply to a message from "Patrick Doyle <wpdster@gmail.com>" dated "Thu, 11 Nov 2010 11:29:10 -0500."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161269>


In message <AANLkTinfYTMKicr3V=T=scVpOte_XrmaDgVA_oMj2fYU@mail.gmail.com>, Patr
ick Doyle writes:

    I've just noticed however, that my work in progress, no longer seems
    to be there, and I'm at a loss to understand why it disappeared.  I've
    tried various checkouts to get it back (the commit containing it was
    286f167).

    But I'm curious... given the reflog show below... can any of you tell
    what I did to myself to shoot myself in the foot?  Aside from "use git
    stash next time dummy", is there any way I could have avoided this?

No problem.  We deal with stuff like this on #git in IRC all of the time.

    $ git reflog
    ce11719... HEAD@{0}: checkout: moving from master to svn_to_git_wip
    40070a1... HEAD@{1}: checkout: moving from svn_to_git_wip to master
    ce11719... HEAD@{2}: ce11719: updating HEAD
    286f167... HEAD@{3}: 286f167: updating HEAD
    d8c9d02... HEAD@{4}: checkout: moving from master to svn_to_git_wip

HEAD@{3} shows that your commit of interest was the head of
svn_to_git_wip.  HEAD@{2} shows that this was changed to whatever
ce11719 points to (apparently the commit before the commit of interest).

"Updating HEAD" is often a sign of running `git reset`

What you probably want to do is:

git checkout svn_to_git_wip
git reset --hard 2867167 (or HEAD@{3} <- caution, number may have changed)
git checkout master
git merge svn_to_git_wip

You could do a three-argument rebase instead of a merge, but merge is
much simpler.

					-Seth Robertson


----------------------------------------------------------------------
286f167... HEAD@{6}: checkout: moving from master to 286f167

Checking out the SHA directly--disconnected head.  Nothing wrong with
that per-se, but probably not where you want to go.

ce11719... HEAD@{14}: rebase: updating HEAD
3638aa3... HEAD@{15}: checkout: moving from svn_to_git_wip to
3638aa3f6e8496b5415ab59bec2a7af07b8ed169

rebasing a disconnected head is definitely not where you want to go.
You should not in general make modifications if you are not on a branch

cb98d3f... HEAD@{26}: checkout: moving from svn_to_git_wip to master
ce11719... HEAD@{27}: HEAD^: updating HEAD
286f167... HEAD@{31}: commit: Saving WIP at the time I switched from SVN to GIT
ce11719... HEAD@{32}: checkout: moving from master to svn_to_git_wip

HEAD@{27} was your original problem.  You made the commit on @{32}
then for some reason did (probably) a `git reset HEAD^` That was the
source of all of your problems.  You should only use `git reset` if
you have not pushed and if you are very sure you want to get rid of a
commit or changes.  It is a powerful command and with great power
comes great responsibility.
