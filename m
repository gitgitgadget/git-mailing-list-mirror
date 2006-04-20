From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 1.3.0 creating bigger packs than 1.2.3
Date: Thu, 20 Apr 2006 15:59:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604201545190.3701@g5.osdl.org>
References: <Pine.LNX.4.64.0604200745550.3701@g5.osdl.org>
 <20060420150315.GB31198@spearce.org> <Pine.LNX.4.64.0604200857460.3701@g5.osdl.org>
 <20060420164351.GB31738@spearce.org> <Pine.LNX.4.64.0604200954440.3701@g5.osdl.org>
 <20060420175554.GH31738@spearce.org> <Pine.LNX.4.64.0604201414490.2215@localhost.localdomain>
 <7v8xq0yteb.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604201630320.2215@localhost.localdomain>
 <7vfyk8vscl.fsf@assigned-by-dhcp.cox.net> <20060420220240.GB32748@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 21 00:59:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWi7d-0003Rp-2y
	for gcvg-git@gmane.org; Fri, 21 Apr 2006 00:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWDTW7e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 18:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWDTW7e
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 18:59:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35500 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932114AbWDTW7d (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Apr 2006 18:59:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3KMx2tH004345
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 20 Apr 2006 15:59:02 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3KMx1XF012174;
	Thu, 20 Apr 2006 15:59:01 -0700
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060420220240.GB32748@spearce.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19006>



On Thu, 20 Apr 2006, Shawn Pearce wrote:

> Junio C Hamano <junkio@cox.net> wrote:
> > 
> > This _might_ improve things:
> > 
> > diff --git a/pack-objects.c b/pack-objects.c
> > index 09f4f2c..0c6abe9 100644
> > --- a/pack-objects.c
> > +++ b/pack-objects.c
> > @@ -1037,7 +1039,7 @@ static int try_delta(struct unpacked *cu
> >  	sizediff = oldsize > size ? oldsize - size : size - oldsize;
> >  
> >  	if (size < 50)
> > -		return -1;
> > +		return 0;
> >  	if (old_entry->depth >= max_depth)
> >  		return 0;
> >  
> > @@ -1052,7 +1054,7 @@ static int try_delta(struct unpacked *cu
> >  	if (cur_entry->delta)
> >  		max_size = cur_entry->delta_size-1;
> >  	if (sizediff >= max_size)
> > -		return -1;
> > +		return 0;
> >  	delta_buf = diff_delta(old->data, oldsize,
> >  			       cur->data, size, &delta_size, max_size);
> >  	if (!delta_buf)
> 
> Holy cow, it did:
> 
>   Total 46391, written 46391 (delta 8391), reused 37774 (delta 0)
>    46M pack-7f766f5af5547554bacb28c0294bd562589dc5e7.pack
> 
> That's the smallest packing I've seen yet.  And it doesn't have a
> negative affect on repacking GIT either.

I think I know what's going on, and why your bisection claimed it was the 
re-hashing change that was the problem, even though it really wasn't.

That

	if (sizediff >= max_size)
		return -1;

check is actually fairly _old_. It's from June 2005, ie it's from pretty 
much the first two days of that packing thing existing in the first place.

(The initial repacking was done June 25th, with a lot of tweaking over the 
next few days. That sizediff thing was part of the fairly early tweaking).

The thing is, that check made sense back then. Why? Because we sorted 
things in decreasing size order back then (I think this was before we even 
did any name-based heuristic sorting at all), so that when we tried the 
delta algorithm, and the size diff was bigger than the last delta size, we 
pretty much _knew_ the new delta would be bigger still, and there was no 
point in continuing with try_delta.

HOWEVER. We have since changed the sorting to sort according to name 
before it sorts according to size, so that old heuristic that depended on 
the size being monotonically increasing simply doesn't make any sense any 
more.

So I think at that second "return -1" really _should_ be changed to a 
"return 0", and not just because it helps your particular case. It's 
literally a bug these days, because the assumptions that caused it to 
return -1 simply aren't true any more.

(It wasn't _strictly_ true even originally: even if the sizediff is huge, 
the _delta_ may not be huge, since we can delete data with a small delta. 
So it's quite likely that we should compare the "old is bigger than new" 
and "new is bigger than old" separately and have different heuristics for 
them. Again, that was simply not much of an issue back when we sorted just 
by size).

So even the "return 0" might not be completely right. We might actually 
want to look at how big the delta is, and return only once that fails.

			Linus
