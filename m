From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: allow dcommit to retain local merge information
Date: Tue, 19 Jun 2007 23:56:00 -0700
Message-ID: <20070620065600.GA25010@muzzle>
References: <466C8B35.3020207@midwinter.com> <003401c7abba$c7574300$0e67a8c0@Jocke> <20070611042509.GA19866@muzzle> <7vir9vox5l.fsf@assigned-by-dhcp.cox.net> <20070612072035.GA29385@muzzle> <7v1wghlj7j.fsf@assigned-by-dhcp.pobox.com> <20070612083910.GA28369@muzzle> <20070613092328.GA30318@muzzle> <1181754781.30670.323.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
X-From: git-owner@vger.kernel.org Wed Jun 20 08:56:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0u6v-0006Fe-88
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 08:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756122AbXFTG4F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 02:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756894AbXFTG4E
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 02:56:04 -0400
Received: from hand.yhbt.net ([66.150.188.102]:38117 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755808AbXFTG4D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 02:56:03 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 7C9308D4027;
	Tue, 19 Jun 2007 23:56:00 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 19 Jun 2007 23:56:00 -0700
Content-Disposition: inline
In-Reply-To: <1181754781.30670.323.camel@gentoo-jocke.transmode.se>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50541>

Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> On Wed, 2007-06-13 at 02:23 -0700, Eric Wong wrote:
> > dcommit will still rewrite the HEAD commit and the history of the first
> > parents of each HEAD~1, HEAD~2, HEAD~3 as it always has.
> > 
> > However, any merge parents (HEAD^2, HEAD^^2, HEAD~2^2) will now be
> > preserved when the new HEAD and HEAD~[0-9]+ commits are rewritten to SVN
> > with dcommit.  Commits written to SVN will still not have any merge
> > information besides anything in the commit message.
> > 
> > Thanks to Joakim Tjernlund, Junio C Hamano and Steven Grimm
> > for explanations, feedback, examples and test case.
> > 
> > Signed-off-by: Eric Wong <normalperson@yhbt.net>
> > ---
> > 
> >  This is a better patch that replaces the previous one.
> > 
> >  Junio:
> >    This one is a big change and should probably sit in pu or next
> >    for a bit.  Double-checking the logic in linearize_history()
> >    would be greatly appreciated, too.
> >    
> >    I don't think there are any regressions for the
> >    already-linear-history case besides slightly reduced performance for
> >    new calls to cat-file.
> > 
> >  Joakim/Steven:
> >    Any further testing and test cases would be appreciated.  Be very
> >    careful with real-world repositories, and run dcommit with the
> >    '-n' flag before actually committing to verify the diffs are sane.
> > 
> >   Thanks
> > 
> 
> Did a little testing and so far it looks good :)
> 
> Sidenote:
> Doing this 
>   git-svn init -t tags -T trunk -b branches  file:///usr/local/src/tst-git-svn/svn-uboot-repo
>   git-svn fetch --quiet
> makes git svn fetch stop for rather long periods in do_update:
>   Found possible branch point: file:///usr/local/src/tst-git-svn/svn-uboot-repo/trunk => file:///usr/local/src/tst-git-svn/svn-uboot-repo/tags/snap-uboot-1.1.4, 2
>   Found branch parent: (tags/snap-uboot-1.1.4) 81eef14963597cc99ba375f52e6d0b3bc09e25f8
>   Following parent with do_update
>   Successfully followed parent
> 
> Is it possible to speed up do_update?

Use a do_switch()-enabled SVN to avoid do_update().  do_update will
redownload everything.  I have patched 1.4.3 debian packages with source
and a diff here: http://git-svn.bogomips.org/svn.  SVN 1.4.4 claims to
have fixed the bindings, but 1.4.3 claimed the same thing, too...
Confirmation of it working in SVN 1.4.4 would be nice.

> Lastly, when adding the above u-boot svn repo into a fresh u-boot
> clone from WD, can I attach the svn tree to git u-boot tree without
> using a graft?

Not with the current version.  The 1.5.0 (or previous, I forget) allowed
forced-parenting with: "git-svn fetch <rev>=<commit>" but I figured
nobody was using it, and it would be difficult to get working since
fetch can now works on multiple trees and the same revision numbers can
appear in multiple trees.

> I want to be able to recreate my own git repo by cloning the orginal
> u-boot repo and the svn repo.

-- 
Eric Wong
