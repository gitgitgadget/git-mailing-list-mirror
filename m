From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git rebase chokes on directory -> symlink -> directory
Date: Fri, 11 May 2007 08:56:24 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705110835230.3986@woody.linux-foundation.org>
References: <463FCD7C.4020009@zytor.com> <20070508215009.GA2670@steel.home>
 <46413565.3090503@zytor.com> <81b0412b0705090050i644a18c2g12c74462ab88163a@mail.gmail.com>
 <4641FDAF.3090608@zytor.com> <20070509213902.GA2593@steel.home>
 <46424ECC.6030907@zytor.com> <7vmz0dmb2u.fsf@assigned-by-dhcp.cox.net>
 <20070510220418.GK3141@spearce.org>
 <7v8xbvew16.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 11 17:56:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmXU1-0004gQ-Ju
	for gcvg-git@gmane.org; Fri, 11 May 2007 17:56:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759096AbXEKP4f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 11:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759079AbXEKP4f
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 11:56:35 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:40892 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758902AbXEKP4e (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 May 2007 11:56:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l4BFuPvf023976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 May 2007 08:56:27 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l4BFuPn2020306;
	Fri, 11 May 2007 08:56:25 -0700
In-Reply-To: <7v8xbvew16.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.982 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46961>



On Thu, 10 May 2007, Junio C Hamano wrote:
> 
> And what is wrong in this case is that the unpack-trees tree
> merging code, which is used everywhere in git to do branch
> switching and merges, is way too inefficient.

Yes, it certainly could be speeded up, but on the other hand:

 - it's certainly not really "horribly bad" in most normal operations.

   In merging, it tends to be fast enough, and in checkouts the real 
   expense is checking out the tree, and the unpack-trees part really 
   isn't a big deal.

 - the only case it shows up is really just when you script things, and 
   compare it to just applying a patch, which is fundamnetally easier.

So I think the reason smarter tree merging hasn't gotten the love and 
attention to make it really a *lot* faster is simply that it's already 
quite fast enough for most people, and the "rebase using proper merges" is 
probably the only case where you can really see the difference.

I'd certainly love for the tree unpacking to handle all the "hey, whole 
sub-tree is identical" cases, but I can also see why it's not getting a 
lot of traction. It just hasn't been painful enough, and we're already too 
damn fast. 

Fixing the tree unpacking to do the trees in parallel (so that you don't 
have to shuffle the arrays and take a huge performance hit there) was 
enough to basically make all normal issues go away. 

That said, wouldn't it potentially be quite easy in "unpack_trees_rec()" 
to just notice when all the trees are identical, and just not recurse at 
all in that case (or - alternatively - recurse, but on entry, just exit 
quickly?)

		Linus
