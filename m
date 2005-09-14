From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: dumb transports not being welcomed..
Date: Tue, 13 Sep 2005 17:57:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509131742240.26803@g5.osdl.org>
References: <7vek7s1xsh.fsf@assigned-by-dhcp.cox.net> <20050913211444.GA27029@mars.ravnborg.org>
 <7vacig1wrb.fsf@assigned-by-dhcp.cox.net> <7vpsrcwrc1.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0509131525250.26803@g5.osdl.org>
 <Pine.LNX.4.63.0509140152160.24606@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Sam Ravnborg <sam@ravnborg.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 02:58:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFLao-0004mF-AW
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 02:57:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbVINA5j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Sep 2005 20:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbVINA5j
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Sep 2005 20:57:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32720 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932511AbVINA5j (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Sep 2005 20:57:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8E0vNBo004418
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 13 Sep 2005 17:57:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8E0vM2T005518;
	Tue, 13 Sep 2005 17:57:23 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0509140152160.24606@wgmdd8.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8506>



On Wed, 14 Sep 2005, Johannes Schindelin wrote:
> 
> IMHO the culprit is git-rev-list, which takes ages and ages for big 
> repositories (beware: this could be my Darwin client which might be 
> incapable to stop the rev enumeration in time; but if that can be done 
> unintentionally, this can be intentionally, too!).

Packed too?

git-rev-list will take a long time if the tree is unpacked and not in the 
cache. It's all disk seeks. That's _especially_ true of a full clone 
(which will walk the whole way down).

But I have tons of memory in my machines, and I haven't looked at how 
badly it does if you don't have that. I know that master.kernel.org is 
certainly not having any trouble at all with me pulling from lots of 
trees.. Maybe git-rev-list uses up lots of your memory.

I'm seeing 14 seconds of CPU-time for a _full_ kernel history, with
"--objects". Yes, it's not exactly cheap, and maybe I should optimize it
(it's all in the "--objects" handling and probably a large portion of it
is because trees actually pack very well indeed, so it's actually
unpacking a lot of trees), but considering that that is preparing the
metadata for pulling down a hundred megs of stuff..

That said, I do think that --objects handling is _very_ CPU-hungry. The 
offender is this old commit of mine:

	4311d328fee11fbd80862e3c5de06a26a0e80046
	Author: Linus Torvalds <torvalds@g5.osdl.org>
	Date:   Sat Jul 23 10:01:49 2005 -0700

	    Be more aggressive about marking trees uninteresting
	...

which is much better about avoiding objects in old trees, but it does so 
at the expense of being _horribly_ CPU-inefficient. It will walk through 
every tree of every commit that we decided was uninteresting.

You can try to just undo that one commit - it will make pack-files have a 
few extraneous objects, but I think it will make a huge difference in the 
CPU cost of "small pulls" (it won't matter at all for the "git clone" 
case: for that case we just always have to walk the whole object tree).

		Linus
