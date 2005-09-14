From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: dumb transports not being welcomed..
Date: Wed, 14 Sep 2005 08:07:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509140759030.26803@g5.osdl.org>
References: <7vek7s1xsh.fsf@assigned-by-dhcp.cox.net> <20050913211444.GA27029@mars.ravnborg.org>
 <7vacig1wrb.fsf@assigned-by-dhcp.cox.net> <7vpsrcwrc1.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0509131525250.26803@g5.osdl.org>
 <Pine.LNX.4.63.0509140152160.24606@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0509131742240.26803@g5.osdl.org>
 <Pine.LNX.4.63.0509141014580.30708@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Sam Ravnborg <sam@ravnborg.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 17:11:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFYrW-0003zH-A6
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 17:07:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965238AbVINPHj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 11:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965239AbVINPHi
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 11:07:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30128 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965238AbVINPHh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2005 11:07:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8EF7PBo024838
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 14 Sep 2005 08:07:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8EF7OtI006206;
	Wed, 14 Sep 2005 08:07:25 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0509141014580.30708@wgmdd8.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8529>



On Wed, 14 Sep 2005, Johannes Schindelin wrote:
> 
> What I see when fetching all heads (thanks to Junio, this is one call to 
> git-fetch now), where all but origin are up to date, is that it takes a 
> very long time. Swapping kicks in, and top tells me that 26.6% of the 
> memory is occupied by git-rev-list (The server has 128M, with 1G swap, and 
> I am unfortunately not the only user of this machine).

Ok. As mentioned, I've not looked at memory usage. The machines I play 
with tend to have 2GB or more, simply because bk needed at least 1GB to be 
nice and cached on the kernel ;)

Git has needed less than bk, so I've not cared ;)

> I fail to see why it should need those amounts of memory. (I tested this 
> over the ssh protocol, which should essentially do the same as git-daemon, 
> right?) After all, the merge point between the branches should be marked 
> uninteresting after one single step from each of my private branches.

One of the issues is that git-rev-list will (for example) keep track of 
the commit messages too for every commit. That in itself can be a lot of 
stuff, depending on how active the tree is and how large the messages are.

Now, that should be easy enough to fix (parse_commit() normally saves the 
buffer it parses into "commit->buffer", so we'd just need to do something 
like

	if (!verbose_header && commit->buffer) {
		free(commit->buffer);
		commit->buffer = NULL;
	}

for each commit.

But for --objects, the bigger memory pressure is that it needs to track 
the "struct object" for every single object when it generates the 
reference tracking. And THAT tends to be expensive. The object lists are 
also not very space-efficient (ie one small allocation for each list 
entry).

We could probably make objects/lists more space-efficient.

> I also see other strange things like packing 0 objects, and packing >0 
> objects after just having fetched from that repository. Hopefully I will 
> have time to look into that (and understand the code to begin with).

Well, the "packing 0 objects" should be normal. I'm surprised at the ">0" 
case after a fetch: the packign is _not_ guaranteed to be exact, but if 
you have the exact same state as (or a superset of) the other end, you 
should always see a zero.

		Linus
