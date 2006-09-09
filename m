From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Change set based shallow clone
Date: Fri, 8 Sep 2006 19:56:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609081944060.27779@g5.osdl.org>
References: <9e4733910609071923tf1c49f6o70419e961e9eb66f@mail.gmail.com>
 <20060908184215.31789.qmail@science.horizon.com>
 <9e4733910609081413p32456768g280bdc9b232d7902@mail.gmail.com>
 <Pine.LNX.4.64.0609081600530.27779@g5.osdl.org> <17666.4936.894588.825011@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Smirl <jonsmirl@gmail.com>,
	"linux@horizon.com" <linux@horizon.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 09 04:56:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLt1A-0005xT-Ok
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 04:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWIIC4O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 22:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWIIC4O
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 22:56:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46249 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932079AbWIIC4M (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Sep 2006 22:56:12 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k892u1nW031841
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 8 Sep 2006 19:56:02 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k892u1Yj027643;
	Fri, 8 Sep 2006 19:56:01 -0700
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17666.4936.894588.825011@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=-0.53 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.146 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26731>



On Sat, 9 Sep 2006, Paul Mackerras wrote:
> 
> It might get nasty if we have laid out A and then later B, and then C
> comes along and turns out to be a child of A but a parent of B,
> meaning that both B and C have to be put above A.

Right. This is why I would suggest just recomputing the thing entirely, 
instead of trying to make it incremental. It would definitely cause 
re-organization of the tree when you find a new relationship between two 
old commits that basically creates a new orderign between them.

Trying to do that incrementally sounds really really hard. But just 
_detecting_ the situation that you are getting a new commit that has a 
parent that you have already shown (and that thus must go _before_ one of 
the things you've shown already, and implies a new line reacing it) is 
very easy. And then re-generating the graph might not be too bad.

Running "gitk" on the kernel with a hot cache and fully packed (and enough 
memory) isn't too bad, because git rev-list literally takes under a second 
for that case, so the advantage of avoiding --topo-order isn't _that_ 
noticeable. 

And the "fully packed" part is probably the most important part. A packed 
Linux historic tree takes just under six seconds cold-cache and under two 
seconds hot-cache, but that's because pack-files are _really_ good at 
mapping all the commits in just one go, and at the beginning of the 
pack-file.

But try the same thing with a fully unpacked kernel, and you'll see the 
real pain of having to traverse all of history. We're talking minutes, 
even when hot in the cache.

> Another thing I have been thinking of is that gitk probably should
> impose a time limit of say 3 months by default

I don't think time is good, because for an old project (like the Linux 
historic repo), three months is literally nothing. So it would be much 
better to go simply by numbers, but sadly, that won't help - simply 
because if we want to know the 100 first commits in --topo-order, we'll do 
the whole history and sort it _first_, and then do the "pick top 100 
commits" only after that.

(Which may not be sensible, of course, but it's what we do.. It's almost 
impossible to do it the other way, because you won't know until the point 
where you do "get_revision()" if you are _actually_ going to use a commit 
or not, so counting them before the end is fundamentally very hard).

> Together with a menu to select the time limit, I think that would be 
> quite usable and would make gitk start up *much* faster.

The menu would help, of course. But it would be even nicer if you'd be 
able to make do without the --topo-order.

		Linus
