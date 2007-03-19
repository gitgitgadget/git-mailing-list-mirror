From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Limit the size of the new delta_base_cache
Date: Mon, 19 Mar 2007 10:17:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703191008400.6730@woody.linux-foundation.org>
References: <20070319051437.GA22494@spearce.org>
 <Pine.LNX.4.64.0703190906320.6730@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703191218190.18328@xanadu.home>
 <Pine.LNX.4.64.0703191004560.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Mar 19 18:18:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTLUu-0007in-5x
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 18:18:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966035AbXCSRSL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 13:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966039AbXCSRSK
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 13:18:10 -0400
Received: from smtp.osdl.org ([65.172.181.24]:42280 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966035AbXCSRSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 13:18:09 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2JHHpcD031900
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Mar 2007 10:17:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2JHHo5h012120;
	Mon, 19 Mar 2007 09:17:51 -0800
In-Reply-To: <Pine.LNX.4.64.0703191004560.6730@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.479 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42646>



On Mon, 19 Mar 2007, Linus Torvalds wrote:
> 
> Which totally throws your argument out of the window. It's simply not true 
> any more: the cache will *not* be more effective the larger the objects 
> are, because you are ignoring the fact that adding a large object will 
> *remove* many small ones.

And btw, if you are adding a delta-base object that is bigger than 10%-20% 
(those particular numbers taken out of where the sun don't shine, but they 
are reasonable) of your cache size, you are pretty much *guaranteed* to be 
removing many small ones.

Why? 

The whole *point* of the delta-base cache is that it wants to avoid the 
O(n**2) costs of the long cache-chains. So a delta-base object on its own 
is almost not interesting for the cache: the cache comes into its own only 
if you have a *chain* of delta-base objects.

So rather than thinking about "one big object", you need to think about "a 
chain of objects", and realize that if one of them is big, then the others 
will be too (otherwise they'd not have generated a delta-chain in the 
first place).

So at an object size of 10-20% of the total allowed cache size, and a 
total cache _index_ of 256 entries, if you start adding big objects, you 
can pretty much be guaranteed that either

 (a) the delta-base cache won't be effective for the big object anyway, 
     since there's just one or two of them (and the cache size limit isn't 
     triggered)
OR
 (b) you start probing the cache size limit, and you'll be throwing out 
     many small object.

Finally, since the delta-chain cache is likely not as useful for blobs 
anyway (you don't tend to use tons of big related blobs anyway, and if you 
do, the real costs are likely the xdl diff generation between them rather 
than the object creation itself!), you're also likely optimizing the wrong 
case, since big delta-base objects are almost certainly goign to be blobs.

And no, I don't have any "hard numbers" to back this up, but if you want 
another argument, realize that delta chains are limited to a depth of ten, 
and if a *single* chain can overflow the delta-chain cache, then the cache 
ends up being 100% *in*effective. And do the math: if the object size is 
10-20% of the total allowed cache size, how many objects in the chain are 
you going to fit in the cache?

So there are multiple different reasons to think that big objects are 
actually *bad* for caching when you have a total size limit, not good.

		Linus
