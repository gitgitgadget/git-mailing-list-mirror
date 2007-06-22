From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Subject: RE: [PATCH] git-svn: allow dcommit to retain local merge information
Date: Fri, 22 Jun 2007 13:55:15 +0200
Message-ID: <006001c7b4c4$32e38630$0e67a8c0@Jocke>
References: <4670E0A2.9060103@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
To: "'Steven Grimm'" <koreth@midwinter.com>,
	"'Eric Wong'" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Jun 22 13:55:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1hjb-00020s-10
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 13:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754195AbXFVLzZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 07:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752925AbXFVLzZ
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 07:55:25 -0400
Received: from mail.transmode.se ([83.241.175.147]:51501 "EHLO
	tmnt04.transmode.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754164AbXFVLzY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2007 07:55:24 -0400
Received: from Jocke ([84.217.10.122]) by tmnt04.transmode.se with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 22 Jun 2007 13:55:20 +0200
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <4670E0A2.9060103@midwinter.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Thread-Index: AceuTY6CGj8csMBVQ8yWNUXXI3DLfwGdcLSw
X-OriginalArrivalTime: 22 Jun 2007 11:55:20.0322 (UTC) FILETIME=[353E6620:01C7B4C4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50692>

> -----Original Message-----
> From: Steven Grimm [mailto:koreth@midwinter.com] 
> Sent: den 14 juni 2007 08:31
> To: Eric Wong
> Cc: Junio C Hamano; Joakim Tjernlund; git@vger.kernel.org
> Subject: Re: [PATCH] git-svn: allow dcommit to retain local 
> merge information
> 
> Eric Wong wrote:
> >  Joakim/Steven:
> >    Any further testing and test cases would be appreciated.  Be very
> >    careful with real-world repositories, and run dcommit with the
> >    '-n' flag before actually committing to verify the diffs 
> are sane.
> >   
> 
> I poked at this some tonight with an eye toward the use case of using 
> git to merge svn branches. I ran into one inconvenience and one bug. 
> I'll try playing with the "use lots of git branches to develop on one 
> svn branch" use case some too, but for now, here are the 
> notes I took, 
> along with the commands if anyone wants to reproduce what I did. 
> Hopefully this won't be too annoying to read. The bug is near 
> the bottom.
> 
> svn repo with a trunk and a branch, each with changes (no 
> conflicts at 
> first, keep it simple to start)
> 
> $ svnadmin create svnrepo
> $ svn co file://`pwd`/svnrepo svnclient
> $ cd svnclient
> $ mkdir trunk tags branches
> $ echo test file number 1 > trunk/testfile1
> $ echo test file number 2 > trunk/testfile2
> $ svn add *
> $ svn commit -m "initial commit"
> $ echo trunk change 1 >> trunk/testfile1
> $ svn commit -m "trunk change 1"
> $ echo trunk change 2 >> trunk/testfile2
> $ svn commit -m "trunk change 2"
> $ svn cp trunk branches/mybranch
> $ svn commit -m "make a branch"
> $ echo trunk change 3 >> trunk/testfile1
> $ svn commit -m "post-branch change in trunk"
> $ echo branch change 1 >> branches/mybranch/testfile2
> $ svn commit -m "change in branch"
> 
> git-svn clone of this dinky repo
> 
> $ cd ..
> $ git-svn clone --trunk=trunk --branches=branches --tags=tags 
> file://`pwd`/svnrepo gitclone
> $ cd gitclone
> 
> Try to merge trunk change into branch using git
> 
> $ git reset --hard mybranch
> $ git merge trunk
> 
> Conflicts! what's going on?
> 
> $ gitk --all
> 
> Aha, looks like git-svn guessed wrong about where I made the 
> branch; it 
> thinks the branch comes from the initial rev. Easy enough to hack 
> around, but might be nice to be able to do this using 
> git-svn's history 
> rewriting rather than a grafts file.

Yes, that would be nice indeed.

> 
> $ echo `git-svn find-rev r4` `git-svn find-rev r3 trunk` > 
> .git/info/grafts
> $ git reset --hard mybranch
> $ git merge trunk
> 
> No conflicts now. Let's see what git-svn thinks it should do
> 
> $ git-svn dcommit -n
> 
> Looks like the right diff
> 
> $ git-svn dcommit
> 
> Refresh gitk display. Looks good, the new revision is a merge 
> with the 
> right parents. Let's check it out in svn land
> 
> $ cd ../svnclient
> $ svn up
> $ cat branches/mybranch/testfile1
> 
> Yep, the trunk change is there, nice! Now for a couple more 
> revs with a 
> conflict.
> 
> $ echo post-merge trunk change >> trunk/testfile1
> $ svn commit -m "trunk change after merge"
> $ echo post-merge conflicting change >> trunk/testfile2
> $ svn commit -m "trunk change with conflict"
> $ cd ../gitclone
> $ git-svn fetch
> $ git merge -m "change with conflict" trunk
> 
> Conflict, as expected
> 
> $ vi testfile2
> $ git add testfile2
> $ git commit
> $ git-svn dcommit
> Transaction is out of date: Out of date: '/trunk/testfile1' in 
> transaction '9-1' at /Users/koreth/git/git-svn line 398

Maybe this can help?
http://svn.haxx.se/subusers/archive-2005-02/0096.shtml
http://subclipse.tigris.org/faq.html#out-of-date

> 
> Hmm, this merge was in mybranch, not in trunk
> 
> $ git log --first-parent
> 
> Yes, the most recent commit with a git-svn-id line has a 
> mybranch URL. 
> So why is it complaining about a trunk file being out of date?
> 
> My experimentation pretty much ended there (I tried a few things to 
> clear the error up, but none of them helped.)
> 
> This machine is an OS X laptop. Subversion is 1.4.3 (r23084) from 
> MacPorts. I used the git-svn from the "pu" branch since it had this 
> patch and all the recent fixes.
> 
> Let me know if you need more details. Hope this is helpful.
> 
> -Steve
> 
> 
