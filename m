From: Yves Orton <yves.orton@booking.com>
Subject: Re: [PATCH] git rev-parse: Fix --show-cdup inside symlinked
	directory
Date: Tue, 15 Jul 2008 18:41:40 +0200
Message-ID: <1216140100.19334.189.camel@gemini>
References: <1216131208.19334.171.camel@gemini>
	 <20080715145920.13529.25603.stgit@localhost>
	 <alpine.DEB.1.00.0807151614510.8950@racer>
	 <20080715154036.GR10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	gitster@pobox.com, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Jul 15 18:43:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KInbz-00011z-Vh
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 18:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804AbYGOQlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 12:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752847AbYGOQlr
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 12:41:47 -0400
Received: from msx1.activehotels.net ([62.190.24.9]:40635 "EHLO
	mx1.activehotels.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750967AbYGOQlq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 12:41:46 -0400
Received: from p5098d9db.dip0.t-ipconnect.de ([80.152.217.219] helo=[192.168.250.20])
	by mx1.activehotels.net with esmtpsa (SSLv3:AES256-SHA:256)
	(Exim 4.50)
	id 1KInax-0001DU-3Y; Tue, 15 Jul 2008 17:41:43 +0100
In-Reply-To: <20080715154036.GR10151@machine.or.cz>
X-Mailer: Evolution 2.22.3.1 
X-AH-Spam-Helo: [192.168.250.20]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88577>

On Tue, 2008-07-15 at 17:40 +0200, Petr Baudis wrote:
>   no, no, this is for the scenario other way around: you have a normal
> subdirectory in the working tree, and point a symlink _at_ it from
> $somewhere_else. Then you try to work in $somewhere_else/symlink.

Yes correct. We have a number of different repositories like so:

banana.git/apps
banana.git/lib
orange.git/config
kiwi.git/refdata

and its convenient for many of our existing apps to be able to symlink
them all together into a common tree

joined/apps -> banana.git/apps
joined/lib -> banana.git/lib
joined/config -> orange.git/config
joined/refdata -> kiwi.git/refdata

this way for instance we can swap bits around easily on the fly and say,
restart a webserver or whatever.

Currently we can do this and all our other stuff works, and you
can /mostly/ work with git from the "joined" tree, with the exception of
git pull --rebase and apparently anything else that relies on
--show-cdup

> > > This patch changes --show-cdup to always show absolute workdir path
> > > instead. I think this should hopefully cause no compatibility problems;
> > > the testsuite is passing fine, at least.
> > 
> > See the thread where I proposed a change like this, back with the infamous 
> > worktree desaster, and Junio NACKed; or the thread where Linus rightfully 
> > insists that git_dir should be relative if possible, for performance 
> > reasons.
> 
>   I see, <7vk5sly3h9.fsf@assigned-by-dhcp.cox.net>. But noone was aware
> of this possible user case. Performance reasons sound reasonable, though
> I'm not really sure if for cdup in particular this ever matters.

Would it be so bad to detect if the show-cdup actually resolves to the
right place, and if it doesnt go absolute?

> 
>   P.S.: Either way, there is a possible workaround to tell git about the
> working directory manually using git --work-tree=... that I missed to
> mention on IRC, Yves.

Hmm, am i using it wrong then?

[dmq@somewhere apps]$ git-rev-parse --git-dir
/home/dmq/git_tree/main/.git
[dmq@somewhere apps]$ git --work-tree="$(git-rev-parse --git-dir)" pull
--rebase
/usr/bin/git-sh-setup: line 139: cd: .git: No such file or directory
Unable to determine absolute path of git directory

cheers,
yves
ps: not on list, please cc me on replies (sorry for the hassle)
