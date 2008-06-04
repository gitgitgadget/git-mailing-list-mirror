From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] http clone does not checkout working tree
Date: Wed, 4 Jun 2008 16:10:08 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806041559390.19665@iabervon.org>
References: <20080604183858.GA7095@sigill.intra.peff.net> <alpine.LFD.1.10.0806041145170.3473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 04 22:11:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3zKA-0005C0-6F
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 22:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754109AbYFDUKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 16:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753900AbYFDUKL
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 16:10:11 -0400
Received: from iabervon.org ([66.92.72.58]:33563 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756972AbYFDUKK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 16:10:10 -0400
Received: (qmail 5607 invoked by uid 1000); 4 Jun 2008 20:10:08 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Jun 2008 20:10:08 -0000
In-Reply-To: <alpine.LFD.1.10.0806041145170.3473@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83823>

On Wed, 4 Jun 2008, Linus Torvalds wrote:

> On Wed, 4 Jun 2008, Jeff King wrote:
> > 
> > The following patch fixes it for me, but I really have no idea if there
> > isn't something more subtle at work. Sending to Linus, since "git blame"
> > points the surrounding code to you, and to Daniel, since the new clone
> > and the commit walker are your areas.
> 
> Ack. This is correct.
> 
> That said, a *lot* of code does this pattern (freeing the tree buffer 
> after use, without marking the tree non-parsed), and I suspect the only 
> reason I'm blamed is because this got copied from some other use of that 
> same model. 
> 
> Normally it's fine, because the whole object use is temporary, but as you 
> point out, doing things in the same process will re-use old object info. 
> It's one of the subtler implications of doing built-ins without fork/exec.
> 
> It is possible that we should clean this up by adding some kind of
> 
> 	static void forget_tree(struct tree *tree)
> 	{
> 		free(tree->buffer);
> 		tree->buffer = NULL;
> 		tree->size = 0;
> 		tree->parsed = 0;
> 	}
> 
> to make this more robust and obvious. That said, a lot of the users are 
> basically the type
> 
> 	if (parse_tree(tree) < 0)
> 		die(..);
> 	init_tree_desc(&desc, tree->buffer, tree->size);
> 	while (tree_entry(&desc, &entry)) {
> 		...
> 	}
> 	forget_tree();
> 
> and quite frankly, it's rather possible that we should get rid of the 
> "void *buffer" and "unsigned long size" in the tree *entirely*, because 
> the above would likely be better written as
> 
> 	buffer = read_tree_desc(&desc);

read_tree_desc(&desc, tree), which would use the hash in the tree object, 
which wouldn't need to be parse, I assume.

> 	while (tree_entry(&desc, &entry)) {
> 		...
> 	}
> 	free(buffer);
> 
> and make "struct tree" smaller, and not ever need parsing at all!
> 
> I think that realisitcially, all tree users are of that format, and nobody 
> really wants to save the buffer (because buffer re-use is fairly unlikely, 
> an re-generating it isn't all that expensive).
>
> But that would be a much bigger patch. And maybe I'm wrong, and some uses 
> really do want the longer-term caching because they end up re-using the 
> tree a lot. So it would need more thinking about.

I think that your current unpack_trees() benefits from the fact that, if 
some but not all of the trees are the same, you only uncompress the tree 
objects once and store one copy of the resulting buffer. So, I don't think 
long-term caching is worthwhile, but sharing between concurrent users 
might be.

	-Daniel
*This .sig left intentionally blank*
