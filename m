From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] filter-branch: subdirectory filter needs --full-history
Date: Tue, 12 Jun 2007 23:58:53 -0700
Message-ID: <7vps40fihe.fsf@assigned-by-dhcp.pobox.com>
References: <200706082328.50923.johannes.sixt@telecom.at>
	<alpine.LFD.0.98.0706081822500.4205@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 13 08:58:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyMoj-0003us-3C
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 08:58:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755499AbXFMG64 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 02:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754306AbXFMG64
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 02:58:56 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:63715 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009AbXFMG6z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 02:58:55 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070613065855.ZIUW3133.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Wed, 13 Jun 2007 02:58:55 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Auyt1X0071kojtg0000000; Wed, 13 Jun 2007 02:58:54 -0400
In-Reply-To: <alpine.LFD.0.98.0706081822500.4205@woody.linux-foundation.org>
	(Linus Torvalds's message of "Fri, 8 Jun 2007 19:40:46 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50022>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> ... There was no actual developmet on branch 
> "another", so all the commits went away, but it left the merge (because 
> that's how --full-history works), which has now become pointless.
>
> So you should do a "merge cleanup" phase after running --full-history.

In short, you will end up with something like this:

             .---. (side branch)
            /     \
	---A---B---C (merge)

The "merge clean-up" would conceptually be a simple operation.
Whenever you see a merge C, you look at its parents A and B, and
cull the ones that are reachable from other parents.  You notice
that A is an ancestor of B, drop A from the parents of C, and
simplify the above down to:

	---A---B---C (not-a-merge)

However, I suspect that this is impossible without making
--full-history with "merge clean-up" imply "limited".

In the case of filter-branch, it needs to use topo-order in
order to guarantee that all its parents commits have been
rewritten before rewriting a commit, so the traversal is already
limited.  

It might be simpler for filter-branch to remove parents that are
ancestor of other parents ("git show-branch --independent" would
work well for this, I think), before feeding the list of mapped
parents to the parent-filter.
