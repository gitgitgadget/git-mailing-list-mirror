From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] Implement a simple delta_base cache
Date: Sat, 17 Mar 2007 16:09:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703171557360.4964@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151941090.4998@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703151955440.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151955150.4998@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703160913361.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703160920030.13402@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703160934070.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703161216510.13732@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703161636520.3910@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703161722360.3910@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703162257560.18328@xanadu.home>
 <Pine.LNX.4.64.0703171044550.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171232180.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171242180.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171420420.4964@woody.linux-foundation.org>
 <7vfy83qyxh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 18 00:10:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSi2Y-0007BK-99
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 00:10:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752284AbXCQXKU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 19:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752311AbXCQXKT
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 19:10:19 -0400
Received: from smtp.osdl.org ([65.172.181.24]:48830 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752284AbXCQXKS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 19:10:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2HN9wcD014099
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 17 Mar 2007 16:10:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2HN9vah011501;
	Sat, 17 Mar 2007 15:09:57 -0800
In-Reply-To: <7vfy83qyxh.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.978 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42457>



On Sat, 17 Mar 2007, Junio C Hamano wrote:
> 
> When unpacking a depth-3 deltified object A, the code finds the
> target object A (which is a delta), ask for its base B and put B
> in the cache after using it to reconstitute A.  While doing so,
> the first-generation base B is also a delta so its base C (which
> is a non-delta) is found and placed in the cache.  When A is
> returned, the cache has B and C.  If you ask for B at this
> point, we read the delta, pick up its base C from the cache,
> apply, and return while putting C back in the cache.  If you ask
> for A after that, we do not read from the cache, although it is
> available.

Yes.

I debated that a bit with myself, but decided that:

 (a) it probably doesn't really matter a lot (but I don't have the 
     numbers)

 (b) trying to *also* fill non-delta-base queries from the delta-base 
     cache actually complicates things a lot. Surprisingly much so (the 
     current logic of removing the entry from the cache only to re-insert 
     it after being used made the memory management totally trivial, as 
     you noticed)

 (c) and regardless, we could decide to do a more extensive caching layer 
     later if we really wanted to, and at that point it probably makes 
     more sense to integrate it with the delta-base cache.

     Most git objects are use-once, which is why we really *just* save the 
     flag bits and the SHA1 hash name itself in "struct object", but doing 
     a generic caching layer for object content would likely obviate the 
     need for the current logic to do "save_commit_buffer".

That (c) in particular was what made me think that it's better to keep it 
simple and obvious for now, since even the simple thing largely fixes the 
performance issue.  Almost three seconds I felt bad about, while just over 
a second for something as complex as "git log drivers/usb/" I just cannot 
make myself worry about.

> In any way, your code makes a deeply delitified packfiles a lot
> more practical.  As long as the working set of delta chains fits
> in the cache, after unpacking the longuest delta, the objects on
> the chain can be had by one lookup and one delta application.

Yeah. I think it would be good to probably (separately and as "further 
tweaks"):

 - have somebody actually look at hit-rates for different repositories and 
   hash sizes.

 - possibly allow people to set the hash size as a config option, if it 
   turns out that certain repository layouts or usage scenarios end up 
   preferring bigger caches.

   For example, it may be that for historical archives you might want to 
   have deeper delta queues to make the repository smaller, and if they 
   are big anyway maybe they would prefer to have a larger-than-normal 
   cache as a result. On the other hand, if you are memory-constrained, 
   maybe you'd prefer to re-generate the objects and waste a bit of CPU 
   rather than cache the results.

But neither of the above is really an argument against the patch, just a 
"there's certainly room for more work here if anybody cares".

> Very good job.

I'm pretty happy with the results myself. Partly because the patches just 
ended up looking so *nice*.

		Linus
