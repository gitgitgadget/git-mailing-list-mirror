From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 6/5 v2] Add tests for RevWalk and its supporting
	code
Date: Mon, 16 Mar 2009 07:33:59 -0700
Message-ID: <20090316143359.GM22920@spearce.org>
References: <1236910062-18476-1-git-send-email-spearce@spearce.org> <20090314001345.GI22920@spearce.org> <20090314005617.GK22920@spearce.org> <200903151234.36812.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 15:36:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjDuw-00081A-93
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 15:35:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759830AbZCPOeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 10:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758460AbZCPOeD
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 10:34:03 -0400
Received: from george.spearce.org ([209.20.77.23]:39529 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757743AbZCPOeB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 10:34:01 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8E4C538211; Mon, 16 Mar 2009 14:33:59 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200903151234.36812.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113328>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> 
> A few /09 interesting/ places in StartGenerator are not covered by the tests.
> 
> 		if (q instanceof DateRevQueue)
> 			pending = (DateRevQueue)q;
> 		else
> -->			pending = new DateRevQueue(q);

This one is difficult to test.  Near as I can tell from the code
in the revwalk package, it never happens.  But if we did get here
with a non date rev queue, DateRevQueue()'s constructor can copy
the data from q over to one with no risk.

Perhaps just test this constructor in isolation?

> and
> 
> 		if (tf != TreeFilter.ALL) {
> -->			rf = AndRevFilter.create(rf, new RewriteTreeFilter(w, tf));
> -->			pendingOutputType |= HAS_REWRITE | NEEDS_REWRITE;
> 		}

That says we have no tests on the path filter code.  Adding one is
likely to identify at least one bug.  Clearly we need additional
tests on the path filter sections.  And it isn't just for this one
little conditional; the entire RewriteTreeFilter and RewriteGenerator
are untested right now.

I can work on adding more test coverage here, but its not in the
critical path for me at day-job right now.  The other problems I
tried to address in this series were.  So its lower in my queue
so-to-speak.  But I'll see what I can do in the near future to
write additional tests for this area of the revwalk package.
 
> PendingGenerator
> 						if (n != null && n.commitTime >= last.commitTime) {
> 							// This is too close to call. The next commit we
> 							// would pop is dated after the last one produced.
> 							// We have to keep going to ensure that we carry
> 							// flags as much as necessary.
> 							//
> -->							overScan = OVER_SCAN;

*sigh*  We never get here in the test suite? I missed that.  I'll try to
work out a test case today and send an additional patch to get coverage
here.  I thought RevWalkCullTest testProperlyCullAllAncestors1() would
be hitting here.  It doesn't.
 
> I'll merge it anyway since this is still a huge improvement compared to the previous
> state.

Thanks.

A co-worker and I are also currently trying to track down a deadlock
between C git-fetch and JGit upload-pack.  Both get stuck waiting
for the other to answer.  Clearly its JGit's fault.

-- 
Shawn.
