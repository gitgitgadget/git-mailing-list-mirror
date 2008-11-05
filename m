From: "Carlos R. Mafra" <crmafra2@gmail.com>
Subject: Re: git pull regression?
Date: Wed, 5 Nov 2008 09:38:10 +0100
Message-ID: <20081105083810.GA22318@localhost.aei.mpg.de>
References: <20081104222749.GA9296@localhost.aei.mpg.de> <7vtzanoyg0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 05 09:39:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kxdum-0006xK-KU
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 09:39:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753963AbYKEIhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 03:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753759AbYKEIhq
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 03:37:46 -0500
Received: from ox1.aei.mpg.de ([194.94.224.6]:35797 "EHLO ox1.aei.mpg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750754AbYKEIhp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 03:37:45 -0500
Received: from localhost.aei.mpg.de (unknown [172.18.254.253])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ox1.aei.mpg.de (Postfix) with ESMTP id E25CD8805A74A;
	Wed,  5 Nov 2008 09:37:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vtzanoyg0.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100150>

On Tue  4.Nov'08 at 15:37:03 -0800, Junio C Hamano wrote:
> "Carlos R. Mafra" <crmafra2@gmail.com> writes:
> 
> > It looks like a regression to me. I can finish
> > the bisection if people in the list say that
> > I am not making a mistake somewhere :-)
> 
> Interesting, and _sounds_ like a regression, but I do not think anybody
> can tell if it is without looking at what .git/config and exact command
> sequence you are using for this "git pull" and where you are starting
> from.

Ok, I am sorry for the lack of details, which I provide now.

It happened again with the git repo itself (Linus hasn't 
updated his yet).

[mafra@localhost:git]$ cat .git/config
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[remote "origin"]
        url = git://git.kernel.org/pub/scm/git/git.git
        fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
        remote = origin
        merge = refs/heads/master
	
And the commands were these (ok, I made a mistake that
I pulled without being first in the master branch,
but the problem I am describing here also happened
before, when I was already in the master branch)

[mafra@localhost:git]$ git --version
git version 1.6.0.3
[mafra@localhost:git]$ git log
[mafra@localhost:git]$ git pull
remote: Counting objects: 245, done.
remote: Compressing objects: 100% (49/49), done.
remote: Total 131 (delta 100), reused 109 (delta 82)
Receiving objects: 100% (131/131), 33.91 KiB, done.
Resolving deltas: 100% (100/100), completed with 43 local objects.
From git://git.kernel.org/pub/scm/git/git
   aa17c7c..826ea6f  html       -> origin/html
   a5a323f..16088d8  maint      -> origin/maint
   1655dcb..1e98488  man        -> origin/man
   9f8f132..5508064  master     -> origin/master
   58edc95..494ccbd  next       -> origin/next
 + fe6aa64...a5f8d19 pu         -> origin/pu  (forced update)
You asked me to pull without telling me which branch you
want to merge with, and 'branch..merge' in
your configuration file does not tell me either.  Please
name which branch you want to merge on the command line and
try again (e.g. 'git pull <repository> <refspec>').
See git-pull(1) for details on the refspec.

If you often merge with the same branch, you may want to
configure the following variables in your configuration
file:

    branch..remote = <nickname>
    branch..merge = <remote-ref>
    remote.<nickname>.url = <url>
    remote.<nickname>.fetch = <refspec>

See git-config(1) for details.
[mafra@localhost:git]$ git branch
* (no branch)
  master
[mafra@localhost:git]$ git checkout master
Previous HEAD position was 031e6c8... GIT 1.6.0.3
Switched to branch "master"
Your branch is behind 'origin/master' by 5 commits, and can be fast-forwarded.
[mafra@localhost:git]$ git pull
[mafra@localhost:git]$ git status
# On branch master
# Your branch is behind 'origin/master' by 5 commits, and can be fast-forwarded.
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       git-help--browse
#       git-merge-stupid
#       test-absolute-path
nothing added to commit but untracked files present (use "git add" to track)
[mafra@localhost:git]$ git pull
[mafra@localhost:git]$

Notice how "git pull" doesn't say "Already up-to-date" anymore.

And now 'git log' shows me the last commit being 
9f8f132621faedd instead of the really last one 550806439402

These are the same issues that I described in the first email
when I updated Linus' tree, so they are not due to the mistake
of not being in master branch.

And now if I go back to v1.6.0 I get this

[mafra@localhost:git]$ git checkout master
Switched to branch "master"
Your branch is behind 'origin/master' by 5 commits, and can be fast-forwarded.
[mafra@localhost:git]$ git pull
Updating 9f8f132..5508064
Fast forward
 Documentation/Makefile             |    8 ++++-
 Documentation/git-format-patch.txt |    3 +-
 INSTALL                            |    5 ++-
 Makefile                           |    6 ++++
 contrib/hooks/post-receive-email   |   57 ++++++++++++++++++++++++++++++------
 5 files changed, 65 insertions(+), 14 deletions(-)
[mafra@localhost:git]$

and everything is ok again.

Anything else I can do to help or is bisection the last resort? :-)

Thanks,
Carlos
