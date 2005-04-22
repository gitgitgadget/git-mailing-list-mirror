From: Chris Mason <mason@suse.com>
Subject: Re: [PATCH] multi item packed files
Date: Fri, 22 Apr 2005 16:32:24 -0400
Message-ID: <200504221632.26278.mason@suse.com>
References: <200504211113.13630.mason@suse.com> <200504221458.36300.mason@suse.com> <Pine.LNX.4.58.0504221230020.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Krzysztof Halasa <khc@pm.waw.pl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 22:28:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP4kp-0001Yi-Iz
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 22:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbVDVUcf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 16:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbVDVUcf
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 16:32:35 -0400
Received: from cantor2.suse.de ([195.135.220.15]:31918 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262123AbVDVUca convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 16:32:30 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id DC68C941A;
	Fri, 22 Apr 2005 22:32:29 +0200 (CEST)
Received: from watt.suse.com (cpe-66-66-175-36.rochester.res.rr.com [66.66.175.36])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by extimap.suse.de (Postfix) with ESMTP
	id 5738214D616; Fri, 22 Apr 2005 22:32:29 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.8
In-Reply-To: <Pine.LNX.4.58.0504221230020.2344@ppc970.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Friday 22 April 2005 15:43, Linus Torvalds wrote:
> On Fri, 22 Apr 2005, Chris Mason wrote:
> > The problem I see for git is that once you have enough data, it should
> > degrade over and over again somewhat quickly.
>
> I really doubt that.
>
> There's a more or less constant amount of new data added all the time: the
> number of changes does _not_ grow with history. The number of changes
> grows with the amount of changes going on in the tree, and while that
> isn't exactly constant, it definitely is not something that grows very
> fast.

>From a filesystem point of view, it's not the number of changes that matters, 
it's the distance between them.  The amount of new data is constant, but the 
speed of accessing the new data is affected by the bulk of old data on disk.

Even with defragging you hopefully end up with a big chunk of the disk where 
everything is in order.  Then you add a new file and it goes either somewhere 
behind that big chunk or in front of it.  The next new file might go 
somewhere behind or in front etc etc.  Having a big chunk just means the new 
files are likely to be farther apart making reads of the new data very seeky.

>
> Btw, this is how git is able to be so fast in the first place. Git is fast
> because it knows that the "size of the change" is a lot smaller than the
> "size of the repository", so it fundamentally at all points tries to make
> sure that it only ever bothers with stuff that has changed.
>
> Stuff that hasn't changed, it ignores very _very_ efficiently.
>
git as a write engine is very fast, and we definitely write more then we read.

> > I grabbed Ingo's tarball of 28,000 patches since 2.4.0 and applied them
> > all into git on ext3 (htree).  It only took ~2.5 hrs to apply.
>
> Ok, I'd actually wish it took even less, but that's still a pretty
> impressive average of three patches a second.

Yeah, and this was a relatively old machine with slowish drives.  One run to 
apply into my packed tree is finished and only took 2 hours.  But, I had 
'tuned' it to make bigger packed files, and the end result is 2MB compressed 
objects.    Great for compression rate, but my dumb format doesn't hold up 
well for reading it back.

If I pack every 64k (uncompressed), the checkout-tree time goes down to 3m14s.  
That's a very big difference considering how stupid my code is  .git was only 
20% smaller with 64k chunks.  I should be able to do better...I'll do one 
more run.

>
> > Anyway, I ended up with a 2.6GB .git directory.  Then I:
> >
> > rm .git/index
> > umount ; mount again
> > time read-tree `tree-id` (24.45s)
> > time checkout-cache --prefix=../checkout/ -a -f (4m30s)
> >
> > --prefix is neat ;)
>
> That sounds pretty acceptable. Four minutes is a long time, but I assume
> that the whole point of the exercise was to try to test worst-case
> behaviour.  We can certainly make sure that real usage gets lower numbers
> than that (in particular, my "real usage" ends up being 100% in the disk
> cache ;)

I had a tree with 28,000 patches.  If we pretend that one bk changeset will 
equal one git changeset, we'd have 64,000 patches (57k without empty 
mergesets), and it probably wouldn't fit into ram anymore ;)  Our bk cset 
rate was about 24k/year, so we'll have to trim very aggressively to have 
reasonable performance.

For a working tree that's fine, but we need some fast central place to pull 
the working .git trees from, and we're really going to feel the random io 
there.

-chris
