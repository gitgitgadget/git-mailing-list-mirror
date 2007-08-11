From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/2] Optimize the two-way merge of git-read-tree too
Date: Sat, 11 Aug 2007 10:27:10 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708111014210.30176@woody.linux-foundation.org>
References: <alpine.LFD.0.999.0708101213560.30176@woody.linux-foundation.or
 g> <alpine.LFD.0.999.0708101216000.30176@woody.linux-foundation.org>
 <alpine.LFD.0.999.0708101224110.30176@woody.linux-foundation.org>
 <alpine.LFD.0.999.0708101240200.30176@woody.linux-foundation.org>
 <7vtzr6mnvw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 11 19:27:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJukK-0006Hi-6W
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 19:27:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753667AbXHKR1W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 13:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753637AbXHKR1W
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 13:27:22 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:37770 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753089AbXHKR1V (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Aug 2007 13:27:21 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7BHRFap009740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 11 Aug 2007 10:27:16 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7BHRAS3018144;
	Sat, 11 Aug 2007 10:27:10 -0700
In-Reply-To: <7vtzr6mnvw.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3.224 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.24__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55615>



On Sat, 11 Aug 2007, Junio C Hamano wrote:
> 
> Then, the new 3-way read-tree (or unpack_trees) would go like
> this.
> 
> First, we scan the index and find locally modified paths;
> invalidate cache-tree by calling cache_tree_invalidate_path()
> for such paths.  The expectation is that you will still have
> largely usable cache-tree after this step.
> 
> The main part of the merge will be done by using tree_desc based
> traversal that walks over three (ancestor, mine and theirs)
> trees, instead of the current unpack_trees() that iterates
> mainly over the index entries.
> 
> (A) The three trees all may have a subtree at the same path, or
>     the one that does not have a tree where others have does not
>     have a blob at the path either (i.e. the subtree is missing
>     from the tree without a D/F conflict).  If the usual 3-way
>     tree level merge rule (one side changes while the other side
>     does not do anything, or both sides change to the same) can
>     be applied, and if the cache tree entry for that subtree is
>     valid and matches our tree, then...
> 
>     - we know the working tree for that entire subdirectory is
>       also clean because of the earlier invalidation;
> 
>     - we can simply follow the tree level merge without ever
>       looking at individual paths contained in the subtree.
> 
> (B) If the precondition of (A) does not hold, we recurse into
>     the subtree, and perform per-path 3-way merge, like the
>     current unpack_trees() does.

I'd love to see this, because it would likely speed up merging of really 
big trees by a huge amount, and because I think it's fundamentally the 
"right thing(tm)" to do.

That said, right now we do so well that it's almost not interesting. The 
kernel tree is so small as to merge in basically zero time even when you 
do per-file merges, and generatign the diffstat is almost always the 
biggest component of the merge by far.

But yes, for bigger trees, and just because it's the right thing to do 
considering the data structures we have, we really should plan on doing 
that some day. I think that with the current optimizations (and at least 
with current hardware - old hw might change the equation), based on my 
timings on the "bummer" tree, are fine at _least_ to 100,000 files. But if 
we're talking about slower hardware, or many more files than that, we 
should _definitely_ eventually do the tree-based optimizations.

> Another optimization I was hoping to do was "git diff --cached",
> which is unrelated to the recent change to use read_tree().

Yeah. "git diff" is just about the most performance-critical one. That 
said, the "--cached" case is likely the least used one, and any time you 
don't use that, you end up having to lstat() the files anyway, so you 
cannot do the tree-based optimizations ;^p

But it would help "git status", I think (which needs to do both --cached 
and the normal one).

		Linus
