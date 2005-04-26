From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Mercurial 0.3 vs git benchmarks
Date: Mon, 25 Apr 2005 21:00:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504252032500.18901@ppc970.osdl.org>
References: <20050426004111.GI21897@waste.org> <Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org>
 <426DA7B5.2080204@timesys.com> <Pine.LNX.4.58.0504251938210.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matt Mackall <mpm@selenic.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 05:55:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQH9s-0001LK-8z
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 05:54:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVDZD7r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 23:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVDZD7m
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 23:59:42 -0400
Received: from fire.osdl.org ([65.172.181.4]:59834 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261263AbVDZD65 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 23:58:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3Q3w7s4001207
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 25 Apr 2005 20:58:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3Q3w5mQ024919;
	Mon, 25 Apr 2005 20:58:06 -0700
To: Mike Taht <mike.taht@timesys.com>
In-Reply-To: <Pine.LNX.4.58.0504251938210.18901@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 25 Apr 2005, Linus Torvalds wrote:
> 
> The easiest test-case is Andrew's 198-patch patch-bomb on linux-kernel a 
> few weeks ago: they all apply cleanly to 2.6.12-rc2 (in order), and you 
> can use my "dotest" script to automate the test..

Oh, well. That was so trivial that I just did it:

With Z_BEST_COMPRESSION:

	torvalds@ppc970:~/git-speed-1> ./script 
	Removing old tree
	Creating new tree
	Initializing db
	defaulting to local storage area
	Doing sync
	Initial add
	
	real    0m37.526s
	user    0m33.317s
	sys     0m3.816s
	Initial commit
	Committing initial tree 0bba044c4ce775e45a88a51686b5d9f90697ea9d
	
	real    0m0.329s
	user    0m0.152s
	sys     0m0.176s
	Patchbomb
	
	real    0m50.408s
	user    0m18.933s
	sys     0m25.432s

With Z_DEFAULT_COMPRESSION:

	torvalds@ppc970:~/git-speed-1> ./script 
	Removing old tree
	Creating new tree
	Initializing db
	defaulting to local storage area
	Doing sync
	Initial add
	
	real    0m19.755s
	user    0m15.719s
	sys     0m3.756s
	Initial commit
	Committing initial tree 0bba044c4ce775e45a88a51686b5d9f90697ea9d
	
	real    0m0.337s
	user    0m0.139s
	sys     0m0.197s
	Patchbomb
	
	real    0m50.465s
	user    0m18.304s
	sys     0m25.567s

ie the "initial add" is almost twice as fast (because it spends most of
the time compressing _all_ the files), but the difference in applying 198
patches is not noticeable at all (because the costs are all elsewhere).

That's 198 patches in less than a minute even with the highest
compression. That rocks.

And don't try to make me explain why the patchbomb has any IO time at all,
it should all have fit in the cache, but I think the writeback logic
kicked in. Anyway, I tried it several times, and the real-time ends up 
fluctuating between 50-56 seconds, but the user/sys times are very stable, 
and end up being pretty much the same regardless of compression level.

Here's the script, in case anybody cares:

	#!/bin/sh
	echo Removing old tree
	rm -rf linux-2.6.12-rc2
	echo Creating new tree
	zcat < ~/v2.6/linux-2.6.12-rc2.tar.gz | tar xvf - > log
	echo Initializing db
	( cd linux-2.6.12-rc2 ; init-db )
	echo Doing sync
	sync
	echo Initial add
	time sh -c 'cd linux-2.6.12-rc2 && cat ../l | xargs update-cache --add --' >> log
	echo Initial commit
	time sh -c 'cd linux-2.6.12-rc2 && echo Initial commit | commit-tree 
	$(write-tree) > .git/HEAD' >> log
	echo Patchbomb
	time sh -c 'cd linux-2.6.12-rc2 ; dotest ~/andrews-first-patchbomb' >> log

and since the timing results were pretty much what I expected, I don't 
think this changes _my_ opinion on anything. Yes, you can speed up commits 
with Z_DEFAULT_COMPRESSION, but it's _not_ that big of a deal for my kind 
of model where you commit often, and commits are small.

It all boils down to:
 - huge commits are slowed down by compression overhead
 - I don't think huge commits really matter

I mean, if it took 2 _hours_ to do the initial commit, I'd think it 
matters. But when we're talking about less than a minute to create the 
initial commit of a whole kernel archive, does it really make any 
difference?

After all, it's something you do _once_, and never again (unless you
script it to do performance testing ;)

Anyway guys, feel free to test this on other machines. I bet there are
lots of subtle performance differences between different filesystems and
CPU architectures.. But the only hard numbers I have show that -9 isn't 
that expensive.

			Linus
