From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Subject: RE: [PATCH] git-svn: allow dcommit to retain local merge information
Date: Thu, 21 Jun 2007 18:54:25 +0200
Message-ID: <042701c7b424$d31bdf30$0e67a8c0@Jocke>
References: <20070620065600.GA25010@muzzle>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: "'Junio C Hamano'" <gitster@pobox.com>,
	"'Steven Grimm'" <koreth@midwinter.com>, <git@vger.kernel.org>
To: "'Eric Wong'" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Jun 21 18:54:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1Pvb-00047a-2A
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 18:54:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757937AbXFUQye (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 12:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757943AbXFUQye
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 12:54:34 -0400
Received: from mail.transmode.se ([83.241.175.147]:59019 "EHLO
	tmnt04.transmode.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757937AbXFUQyd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 12:54:33 -0400
Received: from Jocke ([84.217.10.122]) by tmnt04.transmode.se with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 21 Jun 2007 18:54:28 +0200
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20070620065600.GA25010@muzzle>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Thread-Index: AcezCBI2L5cUWuamSzmudB6n/TZs/QBG5XMA
X-OriginalArrivalTime: 21 Jun 2007 16:54:28.0819 (UTC) FILETIME=[D4F7F230:01C7B424]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50643>

 

> -----Original Message-----
> From: Eric Wong [mailto:normalperson@yhbt.net] 
> Sent: den 20 juni 2007 08:56
> To: Joakim Tjernlund
> Cc: Junio C Hamano; Steven Grimm; git@vger.kernel.org
> Subject: Re: [PATCH] git-svn: allow dcommit to retain local 
> merge information
> 
> Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> > On Wed, 2007-06-13 at 02:23 -0700, Eric Wong wrote:
> > > dcommit will still rewrite the HEAD commit and the 
> history of the first
> > > parents of each HEAD~1, HEAD~2, HEAD~3 as it always has.
> > > 
> > > However, any merge parents (HEAD^2, HEAD^^2, HEAD~2^2) will now be
> > > preserved when the new HEAD and HEAD~[0-9]+ commits are 
> rewritten to SVN
> > > with dcommit.  Commits written to SVN will still not have 
> any merge
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
> > >    already-linear-history case besides slightly reduced 
> performance for
> > >    new calls to cat-file.
> > > 
> > >  Joakim/Steven:
> > >    Any further testing and test cases would be 
> appreciated.  Be very
> > >    careful with real-world repositories, and run dcommit with the
> > >    '-n' flag before actually committing to verify the 
> diffs are sane.
> > > 
> > >   Thanks
> > > 
> > 
> > Did a little testing and so far it looks good :)
> > 
> > Sidenote:
> > Doing this 
> >   git-svn init -t tags -T trunk -b branches  
> file:///usr/local/src/tst-git-svn/svn-uboot-repo
> >   git-svn fetch --quiet
> > makes git svn fetch stop for rather long periods in do_update:
> >   Found possible branch point: 
> file:///usr/local/src/tst-git-svn/svn-uboot-repo/trunk => 
> file:///usr/local/src/tst-git-svn/svn-uboot-repo/tags/snap-ubo
> ot-1.1.4, 2
> >   Found branch parent: (tags/snap-uboot-1.1.4) 
> 81eef14963597cc99ba375f52e6d0b3bc09e25f8
> >   Following parent with do_update
> >   Successfully followed parent
> > 
> > Is it possible to speed up do_update?
> 
> Use a do_switch()-enabled SVN to avoid do_update().  do_update will
> redownload everything.  I have patched 1.4.3 debian packages 
> with source
> and a diff here: http://git-svn.bogomips.org/svn.  SVN 1.4.4 claims to
> have fixed the bindings, but 1.4.3 claimed the same thing, too...
> Confirmation of it working in SVN 1.4.4 would be nice.

Confirmed as requested, I installed 1.4.4(Gentoo) an ran the
same test case. Now I see "Following parent with do_switch"
instead and it is almost instant. It felt though that
git-svn was somewhat slower importing large diffs.

 Jocke

> 
> > Lastly, when adding the above u-boot svn repo into a fresh u-boot
> > clone from WD, can I attach the svn tree to git u-boot tree without
> > using a graft?
> 
> Not with the current version.  The 1.5.0 (or previous, I 
> forget) allowed
> forced-parenting with: "git-svn fetch <rev>=<commit>" but I figured
> nobody was using it, and it would be difficult to get working since
> fetch can now works on multiple trees and the same revision 
> numbers can
> appear in multiple trees.

If you reconsider this, please let me know.

 Jocke
