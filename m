From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: dumb transports not being welcomed..
Date: Wed, 14 Sep 2005 10:38:58 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0509141014580.30708@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <7vek7s1xsh.fsf@assigned-by-dhcp.cox.net> <20050913211444.GA27029@mars.ravnborg.org>
 <7vacig1wrb.fsf@assigned-by-dhcp.cox.net> <7vpsrcwrc1.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0509131525250.26803@g5.osdl.org>
 <Pine.LNX.4.63.0509140152160.24606@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0509131742240.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Sam Ravnborg <sam@ravnborg.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 10:40:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFSnf-0005WA-0w
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 10:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965064AbVINIjB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 04:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbVINIjB
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 04:39:01 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:25802 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965064AbVINIjA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2005 04:39:00 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 62DFB13973D; Wed, 14 Sep 2005 10:38:59 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3A9769D740; Wed, 14 Sep 2005 10:38:59 +0200 (CEST)
Received: from wrzx35.rz.uni-wuerzburg.de (wrzx35.rz.uni-wuerzburg.de [132.187.3.35])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1970E9CDBA; Wed, 14 Sep 2005 10:38:59 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx35.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8FCFDDD164; Wed, 14 Sep 2005 10:38:58 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509131742240.26803@g5.osdl.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8512>

Hi,

On Tue, 13 Sep 2005, Linus Torvalds wrote:
> 
> On Wed, 14 Sep 2005, Johannes Schindelin wrote:
> > 
> > IMHO the culprit is git-rev-list, which takes ages and ages for big 
> > repositories (beware: this could be my Darwin client which might be 
> > incapable to stop the rev enumeration in time; but if that can be done 
> > unintentionally, this can be intentionally, too!).
> 
> Packed too?

Yes. Almost all of it.

> git-rev-list will take a long time if the tree is unpacked and not in the 
> cache. It's all disk seeks. That's _especially_ true of a full clone 
> (which will walk the whole way down).

That could be the case, but my test case is a CVS project I track on one 
side, and I fetch on the other side. Therefore, your diagram from your 
other mail does not really apply. My history looks more or less like this:

a b c d origin
          |
          |
          |
          |
\ \ \ \   |
 ---------|

So, the origin is a linear CVS project. With many, many, many commits. At 
one stage I broke off new git branches. I kept tracking the CVS project, 
though.

What I see when fetching all heads (thanks to Junio, this is one call to 
git-fetch now), where all but origin are up to date, is that it takes a 
very long time. Swapping kicks in, and top tells me that 26.6% of the 
memory is occupied by git-rev-list (The server has 128M, with 1G swap, and 
I am unfortunately not the only user of this machine).

I fail to see why it should need those amounts of memory. (I tested this 
over the ssh protocol, which should essentially do the same as git-daemon, 
right?) After all, the merge point between the branches should be marked 
uninteresting after one single step from each of my private branches.

> But I have tons of memory in my machines, and I haven't looked at how 
> badly it does if you don't have that. I know that master.kernel.org is 
> certainly not having any trouble at all with me pulling from lots of 
> trees.. Maybe git-rev-list uses up lots of your memory.

That certainly is the case.

As for master.kernel.org: Unfortunately, you will not be the only puller. 
And if your process needs just 5% of the RAM, then 21 pullers will be too 
many.

> That said, I do think that --objects handling is _very_ CPU-hungry.

In my experience, before the swapping started, the process did not get 
more than 20% CPU.

Nevertheless, I still think that it would be a good idea to reuse the 
files created for the dumb transport for the intelligent transport. 
Especially for a project which is more often fetched than uploaded.

I also see other strange things like packing 0 objects, and packing >0 
objects after just having fetched from that repository. Hopefully I will 
have time to look into that (and understand the code to begin with).

Ciao,
Dscho
