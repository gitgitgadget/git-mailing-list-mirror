From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git and larger trees, not so fast?
Date: Thu, 9 Aug 2007 10:38:53 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708091015500.25146@woody.linux-foundation.org>
References: <20070809163026.GD568@mbox.bz>
 <alpine.LFD.0.999.0708090948250.25146@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: moe <moe-git@mbox.bz>
X-From: git-owner@vger.kernel.org Thu Aug 09 19:39:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJBzD-0001wN-1F
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 19:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763410AbXHIRjf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 13:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757232AbXHIRjf
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 13:39:35 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:48231 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759638AbXHIRje (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Aug 2007 13:39:34 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l79HcxHH010293
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 9 Aug 2007 10:39:00 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l79HcrUt010881;
	Thu, 9 Aug 2007 10:38:54 -0700
In-Reply-To: <alpine.LFD.0.999.0708090948250.25146@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.724 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.20__
X-MIMEDefang-Filter: lf$Revision: 1.184 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55462>



On Thu, 9 Aug 2007, Linus Torvalds wrote:
> 
> Doing an ltrace on it shows tons and tons of:
> 
> 	...
> 	strlen("35")
> 	strlen("349")
> 	calloc(1, 72)
> 	memcpy(0x73034e, "10/", 3)
> 	memcpy(0x730351, "349", 4)
> 	memmove(0x2ab637f41e80, 0x2ab637f41e78, 781768)
> 	...
> 
> but I haven't looked at where they come from yet.

Ouch. It's the diffing between HEAD and the index, and it's all from 
"add_index_entry()", which sorts the index array using an insertion sort. 
So when the index array gets large, that sort spends all its time in huge 
memmove() calls.

The silly thing, of course, is that we don't even "need" to do that: both 
the index and the trees are really sorted already, so we could just 
interleave them. But since we read them separately, the thing just sucks.

We've fixed other similar cases of this we had (diffing trees against each 
other) by walking the trees together, but the "index vs tree" diff (and 
merge) is the one remaining place where we still use the original stupid 
algorithm. So you'll see this performance problem for 

 - diff tree against index ("git diff HEAD"
 - merge tree into index ("git read-tree -m HEAD")

which both do the stupid index/tree filling.

So this is all O(n**2), which is why we haven't reacted very much - it 
doesn't show up nearly as much with the kernel. Also, with a smaller set 
of files, it would tends to fit in the L2 cache of most competent CPU's. 
So not only is it n**2, you get the cache trashing behaviour too, and 
that, I think, is what really causes it to fall off the cliff edge!

Gaah. This shouldn't be *that* hard to fix, but I'm not entirely sure I'll 
have time today.

Diffing the index against the tree *should* be instantaneous. It should be 
no more costly than reading the tree itself (which is 0.191 seconds for 
me: test "git read-tree -m HEAD" vs "git read-tree HEAD") and reading the 
index (which is almost instantaneous - the only way I can test it is by 
doing something like "git update-index --refresh", and that's 0.131 
seconds, but that includes all the 100,000 "lstat()" calls).

So basically, we're spending several seconds just doing stupid 
make-believe work and moving the index array around. Ouch.

Anyway, the good news is that this is by no means fundamental. It's a 
small and stupid detail. The only thing that makes it at all painful is 
that this is in some low-level crud that we haven't touched in *ages*, so 
I've long since swapped out all my recollection of how we do it.

(We basically do:

	read_cache();

followed by

	unpack_trees();

and each of those *on*its*own* is pretty cheap, but when we unpack trees 
into an already populated index, the end result is ugly.

			Linus
