From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] multi item packed files
Date: Fri, 22 Apr 2005 12:43:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504221230020.2344@ppc970.osdl.org>
References: <200504211113.13630.mason@suse.com> <200504212016.16729.mason@suse.com>
 <Pine.LNX.4.58.0504220916060.2344@ppc970.osdl.org> <200504221458.36300.mason@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Krzysztof Halasa <khc@pm.waw.pl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 21:37:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP3xT-0001Qy-N5
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 21:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbVDVTlb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 15:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbVDVTlb
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 15:41:31 -0400
Received: from fire.osdl.org ([65.172.181.4]:25505 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262117AbVDVTlX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 15:41:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3MJfHs4031123
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 22 Apr 2005 12:41:17 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3MJfG2r009461;
	Fri, 22 Apr 2005 12:41:16 -0700
To: Chris Mason <mason@suse.com>
In-Reply-To: <200504221458.36300.mason@suse.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 22 Apr 2005, Chris Mason wrote:
> 
> The problem I see for git is that once you have enough data, it should degrade 
> over and over again somewhat quickly.

I really doubt that.

There's a more or less constant amount of new data added all the time: the 
number of changes does _not_ grow with history. The number of changes 
grows with the amount of changes going on in the tree, and while that 
isn't exactly constant, it definitely is not something that grows very 
fast. 

Btw, this is how git is able to be so fast in the first place. Git is fast 
because it knows that the "size of the change" is a lot smaller than the 
"size of the repository", so it fundamentally at all points tries to make 
sure that it only ever bothers with stuff that has changed.

Stuff that hasn't changed, it ignores very _very_ efficiently. 

That's really the whole point of the index file: it's a way to quickly
ignore the stuff that hasn't changed - both for simple operations like
"show-diff", but also for complex operations like "merge these three
trees".

And it works exactly because the number of changes does _not_ grow at all 
linearly with the history of the project. In fact, in most projects, the 
rate of change does _down_ when the project grows, because the projects 
matures and generally gets more complicated and thus harder to change.

(The kernel _really_ is pretty special. I am willing to bet that there are
not a lot of big projects that have been able to continue to take changes
at the kind of pace that the kernel does. But we've had to work at it a
lot, including obviously using SCM tools that are very much geared towards
scaling. Why do you think the kernel puts more pressure on SCM's than
other projects? It's exactly because we're trying to scale our change
acceptance to bigger numbers).

So when you say "once you have enough data, it will degrade quickly" 
ignores the fact that the rate of change isn't (the "second derivative of 
the size of the project in time") really isn't that high. 

> I grabbed Ingo's tarball of 28,000 patches since 2.4.0 and applied them all 
> into git on ext3 (htree).  It only took ~2.5 hrs to apply.

Ok, I'd actually wish it took even less, but that's still a pretty
impressive average of three patches a second.

> Anyway, I ended up with a 2.6GB .git directory.  Then I:
> 
> rm .git/index
> umount ; mount again
> time read-tree `tree-id` (24.45s)
> time checkout-cache --prefix=../checkout/ -a -f (4m30s)
> 
> --prefix is neat ;)

That sounds pretty acceptable. Four minutes is a long time, but I assume
that the whole point of the exercise was to try to test worst-case
behaviour.  We can certainly make sure that real usage gets lower numbers
than that (in particular, my "real usage" ends up being 100% in the disk
cache ;)

			Linus
