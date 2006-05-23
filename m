From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] cvsimport: introduce -L<imit> option to workaround memory
 leaks
Date: Tue, 23 May 2006 09:05:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605230848060.5623@g5.osdl.org>
References: <11482978883713-git-send-email-martin@catalyst.net.nz>
 <Pine.LNX.4.64.0605221926270.3697@g5.osdl.org> <20060523153636.GA21506@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin@catalyst.net.nz>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, Johannes.Schindelin@gmx.de,
	spyderous@gentoo.org, smurf@smurf.noris.de
X-From: git-owner@vger.kernel.org Tue May 23 18:07:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiZPK-0000Oy-GE
	for gcvg-git@gmane.org; Tue, 23 May 2006 18:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWEWQGv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 12:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWEWQGv
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 12:06:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4275 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750811AbWEWQGu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 12:06:50 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4NG5ctH012779
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 23 May 2006 09:05:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4NG5a4q010516;
	Tue, 23 May 2006 09:05:37 -0700
To: Theodore Tso <tytso@mit.edu>
In-Reply-To: <20060523153636.GA21506@thunk.org>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20610>



On Tue, 23 May 2006, Theodore Tso wrote:
> On Mon, May 22, 2006 at 07:28:37PM -0700, Linus Torvalds wrote:
> > 
> > I actually think that I found a real ext3 performance bug from trying to 
> > determine why git sometimes slows down ridiculously when the tree has been 
> > allowed to go too long without a repack.
> 
> Do you have dir_index (the hashed btree) feature enabled by any chance?

No, and I know I probably should, since it would hopefully help git usage.

But my problem actually happens even with moderately sized directories: 
they were just 40kB or so in size, and the problem isn't high system CPU 
usage, but tons of extra IO. I ran things on a machine with 2GB of RAM, 
and as far as I could tell, the working set _should_ have fit into memory, 
but CPU utilization was consistently in the 1% range.

Now, it's possible that I'm just wrong, and it really didn't fit in 
memory, but I I _suspect_ that the issue is that ext3 directory handling 
still uses the "buffer_head" thing rather than the page cache, and that we 
simply don't LRU the memory appropriately so we don't let the memory 
pressure expand the buffer cache.

Now, using buffer cache in this day and age is insane and horrible 
(there's a reason I suspect the LRU doesn't work that well: the buffer 
heads aren't supposed to be used as a cache, and people are supposed to 
use the page cache for it these days), but Andrew tells me that the whole 
JBD thing basically requires it. Whatever.

Now, repacking obviously hides it entirely (because then the load becomes 
entirely a page-cache load, and the kernel does _that_ beautifully), but 
I'm a bit bummed that I think I hit an ext3 braindamage.

So an unpacked git archive on ext3 (but not ext2, I believe: ext2 should 
use the page cache for directories) ends up being very buffer-cache 
intensive. And the buffer cache is basically deprecated..

		Linus

PS. I'll see if I can figure out the problem, and maybe the good news is 
that I'll be able to just fix a real kernel performance issue. Still, 
there's a _reason_ we tried to get away from the buffer heads as a caching 
entity..
