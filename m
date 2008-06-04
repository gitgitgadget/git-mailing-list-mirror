From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] http clone does not checkout working tree
Date: Wed, 4 Jun 2008 11:59:10 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806041145170.3473@woody.linux-foundation.org>
References: <20080604183858.GA7095@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 04 21:00:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3yDe-0001ZW-7F
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 21:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101AbYFDS73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 14:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbYFDS73
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 14:59:29 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52476 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751130AbYFDS72 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jun 2008 14:59:28 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m54IxBsN013013
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 4 Jun 2008 11:59:12 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m54IxAnd003952;
	Wed, 4 Jun 2008 11:59:11 -0700
In-Reply-To: <20080604183858.GA7095@sigill.intra.peff.net>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.887 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83808>



On Wed, 4 Jun 2008, Jeff King wrote:
> 
> The following patch fixes it for me, but I really have no idea if there
> isn't something more subtle at work. Sending to Linus, since "git blame"
> points the surrounding code to you, and to Daniel, since the new clone
> and the commit walker are your areas.

Ack. This is correct.

That said, a *lot* of code does this pattern (freeing the tree buffer 
after use, without marking the tree non-parsed), and I suspect the only 
reason I'm blamed is because this got copied from some other use of that 
same model. 

Normally it's fine, because the whole object use is temporary, but as you 
point out, doing things in the same process will re-use old object info. 
It's one of the subtler implications of doing built-ins without fork/exec.

It is possible that we should clean this up by adding some kind of

	static void forget_tree(struct tree *tree)
	{
		free(tree->buffer);
		tree->buffer = NULL;
		tree->size = 0;
		tree->parsed = 0;
	}

to make this more robust and obvious. That said, a lot of the users are 
basically the type

	if (parse_tree(tree) < 0)
		die(..);
	init_tree_desc(&desc, tree->buffer, tree->size);
	while (tree_entry(&desc, &entry)) {
		...
	}
	forget_tree();

and quite frankly, it's rather possible that we should get rid of the 
"void *buffer" and "unsigned long size" in the tree *entirely*, because 
the above would likely be better written as

	buffer = read_tree_desc(&desc);
	while (tree_entry(&desc, &entry)) {
		...
	}
	free(buffer);

and make "struct tree" smaller, and not ever need parsing at all!

I think that realisitcially, all tree users are of that format, and nobody 
really wants to save the buffer (because buffer re-use is fairly unlikely, 
an re-generating it isn't all that expensive).

But that would be a much bigger patch. And maybe I'm wrong, and some uses 
really do want the longer-term caching because they end up re-using the 
tree a lot. So it would need more thinking about.

		Linus
