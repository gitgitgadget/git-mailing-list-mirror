From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [ANNOUNCE] GIT 1.4.3
Date: Sat, 21 Oct 2006 03:12:35 +0100
Message-ID: <20061021021235.GA29920@ftp.linux.org.uk>
References: <7vejt5xjt9.fsf@assigned-by-dhcp.cox.net> <7v4ptylfvw.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0610201709430.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 04:12:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb6Lu-0005NL-UH
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 04:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030377AbWJUCMk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 22:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030378AbWJUCMk
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 22:12:40 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:61606 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030377AbWJUCMj
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 22:12:39 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1Gb6Lj-0003Li-5z; Sat, 21 Oct 2006 03:12:35 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610201709430.3962@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29576>

On Fri, Oct 20, 2006 at 05:14:39PM -0700, Linus Torvalds wrote:
> 
> 
> On Fri, 20 Oct 2006, Junio C Hamano wrote:
> > 
> > I am considering the following to address irritation some people
> > (including me, actually) are experiencing with this change when
> > viewing a small (or no) diff.  Any objections?
> 
> Not from me. I use "git diff" just to check that the tree is empty, and 
> the fact that it now throws me into an empty pager is irritating.

Speaking of irritations...  There is a major (and AFAICS fixable)
suckitude in git-cherry.  Basically, what it does is
	* use git-rev-list to find commits on our branches
	* do git-diff-tree -p for each commit
	* do git-patch-id on each delta
	* compare sets.
For one thing, there are better ways to do set comparison than creating
a file for each element in one set and going through another checking
if corresponding files exist (join(1) and sort(1) or just use perl hashes).
That one is annoying on journalling filesystems (a lot of files being
created, read and removed - fsckloads of disk traffic), but it's actually
not the worst problem.

Far more annoying is that we keep recalculating git-diff-tree -p | git-patch-id
again and again; try to do git cherry on a dozen short branches forked at
2.6.18 and you'll see the damn thing recalculated a dozen of times for
each commit from 2.6.18 to current.  It's not cheap, to put it mildly.

git-rev-list ^v2.6.18 HEAD|while read i; do git-diff-tree -p $i; done |git-patch-id >/dev/null

out of hot cache on 2GHz amd64 box (Athlon 64 3400+) takes 3 minutes of
wall time.  Repeat that for each branch and it's starting to get old very
fast.

Note that we are calculating a function of commit; it _never_ changes.
Even if we don't just calculate and memorize it at commit time, a cache
somewhere under .git would speed the things up a lot...
