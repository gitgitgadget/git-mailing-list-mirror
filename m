From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: allow dcommit to retain local merge information
Date: Wed, 20 Jun 2007 00:04:42 -0700
Message-ID: <20070620070442.GB25010@muzzle>
References: <466C8B35.3020207@midwinter.com> <003401c7abba$c7574300$0e67a8c0@Jocke> <20070611042509.GA19866@muzzle> <7vir9vox5l.fsf@assigned-by-dhcp.cox.net> <20070612072035.GA29385@muzzle> <7v1wghlj7j.fsf@assigned-by-dhcp.pobox.com> <20070612083910.GA28369@muzzle> <20070613092328.GA30318@muzzle> <1181754781.30670.323.camel@gentoo-jocke.transmode.se> <1181776659.30670.340.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
X-From: git-owner@vger.kernel.org Wed Jun 20 09:04:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0uFB-0007eG-Rg
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 09:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758734AbXFTHEo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 03:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757379AbXFTHEo
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 03:04:44 -0400
Received: from hand.yhbt.net ([66.150.188.102]:38141 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758519AbXFTHEn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 03:04:43 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 3F3438D4027;
	Wed, 20 Jun 2007 00:04:42 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 20 Jun 2007 00:04:42 -0700
Content-Disposition: inline
In-Reply-To: <1181776659.30670.340.camel@gentoo-jocke.transmode.se>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50543>

Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> On Wed, 2007-06-13 at 19:13 +0200, Joakim Tjernlund wrote:
> > On Wed, 2007-06-13 at 02:23 -0700, Eric Wong wrote:
> > > dcommit will still rewrite the HEAD commit and the history of the first
> > > parents of each HEAD~1, HEAD~2, HEAD~3 as it always has.
> > > 
> > > However, any merge parents (HEAD^2, HEAD^^2, HEAD~2^2) will now be
> > > preserved when the new HEAD and HEAD~[0-9]+ commits are rewritten to SVN
> > > with dcommit.  Commits written to SVN will still not have any merge
> > > information besides anything in the commit message.
> > > 
> > > Thanks to Joakim Tjernlund, Junio C Hamano and Steven Grimm
> > > for explanations, feedback, examples and test case.
> > > 
> > > Signed-off-by: Eric Wong <normalperson@yhbt.net>
> > > ---
> > > 
> > >  This is a better patch that replaces the previous one.
> > > 
> > >  Junio:
> > >    This one is a big change and should probably sit in pu or next
> > >    for a bit.  Double-checking the logic in linearize_history()
> > >    would be greatly appreciated, too.
> > >    
> > >    I don't think there are any regressions for the
> > >    already-linear-history case besides slightly reduced performance for
> > >    new calls to cat-file.
> > > 
> > >  Joakim/Steven:
> > >    Any further testing and test cases would be appreciated.  Be very
> > >    careful with real-world repositories, and run dcommit with the
> > >    '-n' flag before actually committing to verify the diffs are sane.
> > > 
> > >   Thanks
> > > 
> > 
> > Did a little testing and so far it looks good :)
> > 
> > Sidenote:
> > Doing this 
> >   git-svn init -t tags -T trunk -b branches  file:///usr/local/src/tst-git-svn/svn-uboot-repo
> >   git-svn fetch --quiet
> > makes git svn fetch stop for rather long periods in do_update:
> >   Found possible branch point: file:///usr/local/src/tst-git-svn/svn-uboot-repo/trunk => file:///usr/local/src/tst-git-svn/svn-uboot-repo/tags/snap-uboot-1.1.4, 2
> >   Found branch parent: (tags/snap-uboot-1.1.4) 81eef14963597cc99ba375f52e6d0b3bc09e25f8
> >   Following parent with do_update
> >   Successfully followed parent
> > 
> > Is it possible to speed up do_update?
> > 
> > 
> > Lastly, when adding the above u-boot svn repo into a fresh u-boot clone from WD,
> > can I attach the svn tree to git u-boot tree without using a graft?
> > 
> > I want to be able to recreate my own git repo by cloning the orginal u-boot
> > repo and the svn repo.
> > 
> >  Jocke
> 
> Tried using --no-metadata(git svn clone --no-metadata) in my little test
> script I sent earlier and got
>   "Unable to determine upstream SVN information from HEAD history"
> when dcommiting, -i trunk didn't help either.
> 
> It is not entierly clear to me what --no-metadata means to me.
> Does git-svn still rewrite commits?

--no-metadata is really only useful for people doing one-shot imports
and abandoning SVN.  It leaves out the git-svn-id: lines at the bottom
of commit messages, but still sets the committer/author names/email/date
to what is in the SVN repository.

> I can't rebuild rev_db file, if lost, but I guess I could still
> do a new git-svn clone and restore my repo? I guess I lose something
> if I do that but what?

If you lose your rev_db file with no-metadata, you'll have to redo the
git-svn clone

> Also don't really understand why git-svn log doesn't work, can't it get
> that info from the svn repo?

Getting git-svn log working with --no-metadata would require radically
different code.  dcommit would be very different, too.  So yes, they
don't work because I'm lazy.

-- 
Eric Wong
