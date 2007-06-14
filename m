From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH] git-svn: allow dcommit to retain local merge information
Date: Wed, 13 Jun 2007 23:30:58 -0700
Message-ID: <4670E0A2.9060103@midwinter.com>
References: <466C8B35.3020207@midwinter.com> <003401c7abba$c7574300$0e67a8c0@Jocke> <20070611042509.GA19866@muzzle> <7vir9vox5l.fsf@assigned-by-dhcp.cox.net> <20070612072035.GA29385@muzzle> <7v1wghlj7j.fsf@assigned-by-dhcp.pobox.com> <20070612083910.GA28369@muzzle> <20070613092328.GA30318@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Joakim Tjernlund <joakim.tjernlund@transmode.se>,
	git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Jun 14 08:30:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hyiqn-000637-5z
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 08:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbXFNGac (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 02:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbXFNGab
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 02:30:31 -0400
Received: from 91.86.32.216.static.reverse.layeredtech.com ([216.32.86.91]:36154
	"HELO midwinter.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1750930AbXFNGab (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 02:30:31 -0400
Received: (qmail 9360 invoked from network); 14 Jun 2007 06:30:29 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO pinklady.local) (koreth@76.21.17.123)
  by tater.midwinter.com with SMTP; 14 Jun 2007 06:30:29 -0000
User-Agent: Thunderbird 2.0.0.0 (Macintosh/20070326)
In-Reply-To: <20070613092328.GA30318@muzzle>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50171>

Eric Wong wrote:
>  Joakim/Steven:
>    Any further testing and test cases would be appreciated.  Be very
>    careful with real-world repositories, and run dcommit with the
>    '-n' flag before actually committing to verify the diffs are sane.
>   

I poked at this some tonight with an eye toward the use case of using 
git to merge svn branches. I ran into one inconvenience and one bug. 
I'll try playing with the "use lots of git branches to develop on one 
svn branch" use case some too, but for now, here are the notes I took, 
along with the commands if anyone wants to reproduce what I did. 
Hopefully this won't be too annoying to read. The bug is near the bottom.

svn repo with a trunk and a branch, each with changes (no conflicts at 
first, keep it simple to start)

$ svnadmin create svnrepo
$ svn co file://`pwd`/svnrepo svnclient
$ cd svnclient
$ mkdir trunk tags branches
$ echo test file number 1 > trunk/testfile1
$ echo test file number 2 > trunk/testfile2
$ svn add *
$ svn commit -m "initial commit"
$ echo trunk change 1 >> trunk/testfile1
$ svn commit -m "trunk change 1"
$ echo trunk change 2 >> trunk/testfile2
$ svn commit -m "trunk change 2"
$ svn cp trunk branches/mybranch
$ svn commit -m "make a branch"
$ echo trunk change 3 >> trunk/testfile1
$ svn commit -m "post-branch change in trunk"
$ echo branch change 1 >> branches/mybranch/testfile2
$ svn commit -m "change in branch"

git-svn clone of this dinky repo

$ cd ..
$ git-svn clone --trunk=trunk --branches=branches --tags=tags 
file://`pwd`/svnrepo gitclone
$ cd gitclone

Try to merge trunk change into branch using git

$ git reset --hard mybranch
$ git merge trunk

Conflicts! what's going on?

$ gitk --all

Aha, looks like git-svn guessed wrong about where I made the branch; it 
thinks the branch comes from the initial rev. Easy enough to hack 
around, but might be nice to be able to do this using git-svn's history 
rewriting rather than a grafts file.

$ echo `git-svn find-rev r4` `git-svn find-rev r3 trunk` > .git/info/grafts
$ git reset --hard mybranch
$ git merge trunk

No conflicts now. Let's see what git-svn thinks it should do

$ git-svn dcommit -n

Looks like the right diff

$ git-svn dcommit

Refresh gitk display. Looks good, the new revision is a merge with the 
right parents. Let's check it out in svn land

$ cd ../svnclient
$ svn up
$ cat branches/mybranch/testfile1

Yep, the trunk change is there, nice! Now for a couple more revs with a 
conflict.

$ echo post-merge trunk change >> trunk/testfile1
$ svn commit -m "trunk change after merge"
$ echo post-merge conflicting change >> trunk/testfile2
$ svn commit -m "trunk change with conflict"
$ cd ../gitclone
$ git-svn fetch
$ git merge -m "change with conflict" trunk

Conflict, as expected

$ vi testfile2
$ git add testfile2
$ git commit
$ git-svn dcommit
Transaction is out of date: Out of date: '/trunk/testfile1' in 
transaction '9-1' at /Users/koreth/git/git-svn line 398

Hmm, this merge was in mybranch, not in trunk

$ git log --first-parent

Yes, the most recent commit with a git-svn-id line has a mybranch URL. 
So why is it complaining about a trunk file being out of date?

My experimentation pretty much ended there (I tried a few things to 
clear the error up, but none of them helped.)

This machine is an OS X laptop. Subversion is 1.4.3 (r23084) from 
MacPorts. I used the git-svn from the "pu" branch since it had this 
patch and all the recent fixes.

Let me know if you need more details. Hope this is helpful.

-Steve
