From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: combine git repo historically
Date: Sun, 11 Oct 2009 04:36:52 +0200
Message-ID: <200910110436.52653.chriscool@tuxfamily.org>
References: <20091009012254.GA3980@debian.b2j> <4ACED204.3000907@viscovery.net> <20091010140358.GA3924@debian.b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 11 04:38:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwoKB-0000lU-3n
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 04:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757212AbZJKCfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Oct 2009 22:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756011AbZJKCfs
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Oct 2009 22:35:48 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:33580 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755997AbZJKCfr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Oct 2009 22:35:47 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id D3C2981804B;
	Sun, 11 Oct 2009 04:35:04 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id A379A818054;
	Sun, 11 Oct 2009 04:35:01 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20091010140358.GA3924@debian.b2j>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129901>

On Saturday 10 October 2009, bill lam wrote:
> On Fri, 09 Oct 2009, Johannes Sixt wrote:
> > bill lam schrieb:
> > > I have two git repos, no branches.
> > >
> > > repo 1.
> > >   emptyrootcommit -- A ... M
> > >
> > > repo 2.
> > >   emptyrootcommit -- N ... Z
> > >
> > > N was evolved from M but the time gap is large, how can I combine
> > > them into one repo
> > >
> > > emptyrootcommit -- A ... M -- N ... Z
> > >
> > > so that snapshots N .. Z will not be changed.
> >
> > $ echo $(git rev-parse N) $(git rev-parse M) >> .git/info/grafts
> > $ git filter-branch --tag-name-filter cat -- --all --not M
> >
> > i.e. you graft the older history right before the younger history, then
> > you use git filter-branch to rewrite the parentship of the younger
> > commits.
>
> Thanks,  graft is new to me. I tested it works but it needs first issue
>    git fetch /path/to/repo1
> within repo2 to fetch tip M from repo1 into repo2, is it correct?
>
> If I also want to fetch also all objects from repo1, what will the
> command to do it.

Maybe you should do something like:

$ git remote add repo1 /path/to/repo1
$ git fetch repo1

The fetch command should output something like:

remote: Counting objects: 423, done.
remote: Compressing objects: 100% (149/149), done.
remote: Total 363 (delta 276), reused 298 (delta 213)
Receiving objects: 100% (363/363), 136.65 KiB, done.
Resolving deltas: 100% (276/276), completed with 29 local objects.
From /path/to/repo1
 * [new branch]      branch1       -> repo1/branch1
 * [new branch]      branch2       -> repo1/branch2

So the branches in repo1 will be available in repo2 as remote/repo1/branch1, 
remote/repo1/branch2, ...

> Christian Couder also mentioned the git-replace command, how to stitch
> with it?

First you need to create a commit that will replace commit N, let's call it 
N' and after that you can use "git replace N N'". So the complex part is to 
create N'.

You want N' to have the same content as N but to have M as parent. So you 
could do something like the following:

(We suppose that commits A to M are in branch1 and that you are in the root 
directory of your repo2 working directory.)

$ git checkout -b repo1-branch1 remote/repo1/branch1
$ git checkout N -- .
$ export GIT_AUTHOR_NAME=<author name of commit N>
$ export GIT_AUTHOR_EMAIL=<author email of commit N>
$ export GIT_AUTHOR_DATE=<date of commit N>
$ git commit -a

And then use the commit message from commit N, and maybe also say in the 
commit message that it is replacement commit made to link repo1 with repo2 
or something like that.

At this step you have created N' and you should make sure that it is exactly 
what you want. It should point to the same tree as N, it should have M as 
parent, ...

If everything is ok then you can use:

$ git replace N HEAD

And you should be done.

Regards,
Christian.
