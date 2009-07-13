From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Pushing to GitHub doesn't push all branches
Date: Mon, 13 Jul 2009 13:01:15 +0200
Message-ID: <4A5B13FB.4040203@drmicha.warpmail.net>
References: <h37fga$5ie$1@ger.gmane.org> <4A575416.2090304@drmicha.warpmail.net> <h37lh2$q3s$1@ger.gmane.org> <4A57639D.4020305@drmicha.warpmail.net> <h3eqap$cov$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Graeme Geldenhuys <graemeg@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 13 13:01:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQJHx-0004aa-Bp
	for gcvg-git-2@gmane.org; Mon, 13 Jul 2009 13:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755267AbZGMLBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2009 07:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755235AbZGMLBe
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jul 2009 07:01:34 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:40502 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755168AbZGMLBd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Jul 2009 07:01:33 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id B8EEF3B041D;
	Mon, 13 Jul 2009 07:01:32 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 13 Jul 2009 07:01:32 -0400
X-Sasl-enc: oAVtzI2Let1HHxDLV2cLR6I/z0SsCtLx/+yBNagl2cmF 1247482892
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id F385111F03;
	Mon, 13 Jul 2009 07:01:31 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1pre) Gecko/20090712 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <h3eqap$cov$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123186>

Graeme Geldenhuys venit, vidit, dixit 13.07.2009 10:12:
> Michael J Gruber wrote:
>> git config remote.origin.push '+refs/remotes/*:refs/heads/*'
> 
> OK, I've done this, but I'm not 100% sure what this means. This is what 
> I think (from reading various git help and users guide). Any branches I 
> have which track remote references (from svn repository) will be pushed 
> to github as various head references (normal branches).  Is this correct?

Yes, any ref you have that matches the pattern refs/remotes/* (all your
remote branches) is pushed to a ref named refs/heads/* in the repo (i.e.
a branch). The + means that non-fast-forward pushes are OK.

> On our server, which contain the svn cloned repository and the one that 
> is only used for syncing svn -> our server -> github, I had to add a new 
> commit which represents the svn-ignore meta data to a .gitignore file. I 
> noticed I had to manually to a 'git checkout master' & 'git merge 
> remotes/trunk' to pull in new updates. I thin pushed that to github.

You didn't tell us *that* before... Exactly this is why I asked whether
you want to do own work on those branches or just push a git-svn mirror.

I'm not sure adding .gitignore in a commit is a good idea, if that is
the only change you will make to the original branches. It keeps you
from doing a simple fetch and forces you to set up merging.

Also, svn-metadata may change over time. Do you intend to keep
.gitignore up to date with those changes?

> So what is my twice hourly cron script supposed to look like? Is the 
> following still ok?
> 
> ========[ script executed by cron every 30 minutes ]============
> #!/bin/sh
> GIT="/usr/local/bin/git"
> 
> # FPC repository
> cd /mnt/samba/git/fpc.git/
> $GIT checkout master
> $GIT svn fetch
> $GIT gc --auto
> $GIT push github master
> ==============================
> 
> Or do I need to add a new line after '$GIT svn fetch' that does a merge.
> 
> ==============================
> $GIT svn fetch
> $GIT merge remotes/trunk
> ...
> push to github
> ==============================
> 
> 
> Also what do I do with the other branch I want to track. It's called 
> remotes/fixes_2_2.
> 
> I believe I need to first create a local branch.
> 
>    git branch --track fixes_2_2 remotes/fixes_2_2
> 
> What do I need to modify in my cron script to keep both the master & 
> fixes_2_2 branches in sync with SubVersion and push both to GitHub. I 
> want Github to show two branches: master & fixes_2_2

Well, the way you used push you completely ignored the suggested
refspec. You pushed master into a matching ref (master). master may have
happened to be trunk before you added .gitignore (git-svn does not
guarantee that).

So, there are two options:

- Push the git-svn converted branches as is, using the suggested refspec
(or having it in config and doing "git push github"). "git svn fetch"
will have fetched all svn refs you need.

- Set up local branches and do your merge thing. In this case you
probably also want to keep up with svn metadata changes (mind that
ignore properties may depend on the branch as well). Done right this is
nice, but of course it may be a bit more fragile.

In the first case you would need to distribute .gitignore in a different
way. You could set up a separate branch (say svnhelper) for that which
consists of .gitignore (and possibly other things) only. "git show
svnhelper:.gitignore > .git/info/excludes" will set up each user. You
can also use a tag for that (i.e. instead of a branch).

Cheers,
Michael
