From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: Revert-style merge/Working tree-only checkout?
Date: Tue, 14 Dec 2010 08:46:04 +0300
Message-ID: <20101214054604.GI3264@localhost.localdomain>
References: <AANLkTi=ioX25aqXg-yWDA0oXBTATkFe+J25g-dB7-psS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Yuriy Romanenko <groman@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 14 06:46:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSNiK-0000JT-04
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 06:46:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964Ab0LNFqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 00:46:10 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:43130 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389Ab0LNFqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 00:46:09 -0500
Received: from proxysrv.domain007.com ([10.8.0.42])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id oBE5k5M1020760;
	Tue, 14 Dec 2010 08:46:06 +0300
Received: by proxysrv.domain007.com (Postfix, from userid 1000)
	id E5E0FB2009A; Tue, 14 Dec 2010 08:46:04 +0300 (MSK)
Content-Disposition: inline
In-Reply-To: <AANLkTi=ioX25aqXg-yWDA0oXBTATkFe+J25g-dB7-psS@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Scanned-By: MIMEDefang 2.51 (www.roaringpenguin.com/mimedefang) on 192.168.2.20
X-Antivirus: Dr.Web (R) for Mail Servers on proxysrv host
X-Antivirus-Code: 100000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163628>

On Mon, Dec 13, 2010 at 03:30:00PM -0800, Yuriy Romanenko wrote:

> I am somewhat new to Git and I keep running into having to accomplish
> a certain task and reading through the documentation I can't seem to
> find any way of doing this easily.
> 
> The problem is when branches diverge and I want to sync a branch to
> another branch with full overwrite, but maintain history and maintain
> separate branches.
> 
> For example, say there is a branch "master" and I create a branch "b1"
> from master at some point. After this, there are 5 commits
> (C1,C2,C3,C4,C5) to master and
> 17 commits to b1 (let's call them cb1, cb2, cb3, ..., cb17). Say I
> want to create an 18-th commit to "b1" that makes it identical to the
> C5 (current) state of master. Essentially a single commit wipe of
> changes cb1 -> cb17 as well as application of C1->C5. So far I have
> found one way of accomplishing this, but it is difficult, error prone,
> slow and I just plain don't like it. I feel like there should be an
> easier way.
> 
> What I currently do:
> 
> $ rm -rf *
> $ git checkout -f master
> $ tar -cvzf /tmp/master.tar.gz *
> $ git checkout b1
> $ rm -rf *
> $ tar -xvzf /tmp/master.tar.gz
> $ git add
> $ git commit -a
> $ git merge master

I think this method would work better instead:

    $ git checkout b1
(2) $ git read-tree --reset master
(3) $ git checkout-index --all --force
    $ git commit -m "Bring b1 to the state of master"
(4) $ git merge --no-ff master

In this sequence, (2) makes the index contain the same state as
the tip of the master branch (you can also use more direct name,
master^{tree}, if you like), then (3) throws away any changes appeared
in the work tree after resetting the index. As the last step, you record
explicit merge to indicate that you converged histories back.

> I've considered doing something like the following
> 
> $ git checkout b1
> $ git revert b1~17..b1
> $ git merge master
> 
> but it also seems wrong, and requires me to count the submits by hand,
To not count commits by hand, you could use `git merge-base HEAD master`
to find the last commit b1 and master shared just before diverging.

> which seems silly --> I'm not actually reverting anything. I don't
> know if this would even work.
This is questionable -- like any VCS, Git was supposedly designed to
track evolving history, and you want to somehow make it track
"devolving" history at times. So, if we would opt not to play powerful
tricks with Git but rather go a "normal" VCS way, you would naturally
have to revert your changes to explicitly bring b1 to master.
