From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: repack behaves unexpectedly if called in a bare _subrepo_
Date: Sun, 17 Jun 2007 21:27:26 +0200
Message-ID: <20070617192726.GC2763@steel.home>
References: <20070617153810.GB2763@steel.home> <7vir9mzeao.fsf@assigned-by-dhcp.pobox.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 17 21:27:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I00PN-0002xb-Jm
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 21:27:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759871AbXFQT1a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jun 2007 15:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759800AbXFQT13
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jun 2007 15:27:29 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:14085 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759787AbXFQT13 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2007 15:27:29 -0400
Received: from tigra.home (Fcaba.f.strato-dslnet.de [195.4.202.186])
	by post.webmailer.de (klopstock mo53) (RZmta 7.3)
	with ESMTP id 201434j5HFptFv ; Sun, 17 Jun 2007 21:27:27 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 3176D277BD;
	Sun, 17 Jun 2007 21:27:27 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id B1B60C164; Sun, 17 Jun 2007 21:27:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vir9mzeao.fsf@assigned-by-dhcp.pobox.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTv+Fmk=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50367>

Junio C Hamano, Sun, Jun 17, 2007 19:22:39 +0200:
> > Just a heads-up. This took me by surprise. And I suppose it will be
> > the same even if the subrepo is a real subproject.
> >
> > To illustrate:
> >
> > (
> >     mkdir super && cd super
> >     git init
> >     echo 0 > a; git add a; git commit -m0
> >     echo 2 >> a; git commit -a -m1
> >     echo 3 >> a; git commit -a -m2
> >     cp -a .git sub
> >     cd sub
> >     git --bare config --bool core.bare true
> >     git repack -a -d
> > )
> 
> I think what is happening is that in that bare repository 'sub',
> the sequence we find where a git repository is is defined so
> that the current directory is checked way after "one of my
> parents with .git/ subdirectory" check.

Yes, that's what I found. Couldn't convince myself it could be wrong,
feels right to me.

> If super (a directory) has a subproject sub as its subproject,
> then you would be copying .git to sub/.git, not sub/, wouldn't
> you?

Yes, very likely. But it is not a super project in subproject sense,
and why? Is there a reason I can't have a bare subproject?

> What are you trying to achieve?

I mirror some projects I am interested in. There is a directory where
all the mirrors are: ~/src. It contains the git/git-svn/git-cvs
repositories _and_ the scripts which do the mirroring:

$ ls -a
./                  gitk/          motion.gitsvn/  uclibc.gitsvn/
../                 gnulib.git/    moto4lin/       udev/
busybox.gitsvn/     gpsbabel.git/  mutt/           udhcp.gitsvn/
coreutils.git/      historic/      rt2500/         update-gits*
count-git-objects*  .htaccess      sparse/         use-src/
dclock/             iproute2.git/  sunset/         wireless-2.6.git/
git/                klibc/         tig/
.git/               linux.git/     torsmo/
.gitignore          mimesplit3/    tuner/

The super in my example is this ~/src, and it keeps track of changes
to the scripts (some mirrors can be complicated, so I wanted to be
prepared). Felt kind of natural to do it this way. Until I tried to
repack the mirrored repos, and it didn't work as I expected. The repos
are not tracked as subprojects (in fact, they're .gitignored).
There is no point for me to have working directories for the mirrors:
it is my home server, if I do something, I do it elsewhere.

It is not exactly a "problem", and anyway there is a couple of
solutions (pass --bare, create <mirror>/.git, for instance), I just
fall into it and though it'd be a good idea to let others know.
