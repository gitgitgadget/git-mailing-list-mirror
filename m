From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 0/2] History replay support
Date: Sun, 4 Nov 2007 11:32:02 +1100
Message-ID: <18221.4866.623031.306945@cargo.ozlabs.ibm.com>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com>
	<alpine.LFD.0.999.0710272229430.30120@woody.linux-foundation.org>
	<18212.13862.637991.30536@cargo.ozlabs.ibm.com>
	<alpine.LFD.0.999.0710280943090.30120@woody.linux-foundation.org>
	<18217.41899.54812.227152@cargo.ozlabs.ibm.com>
	<alpine.LFD.0.999.0711010815320.3342@woody.linux-foundation.org>
	<18218.63946.772767.179841@cargo.ozlabs.ibm.com>
	<e5bfff550711020544h1e9a648apfd268eb549645ccc@mail.gmail.com>
	<alpine.LFD.0.999.0711020828440.3342@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711021114390.3342@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711021301200.3342@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711021809060.3342@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Marco Costalba <mcostalba@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Nov 04 01:32:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoTPm-0000D8-4n
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 01:32:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755634AbXKDAcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 20:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756343AbXKDAcS
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 20:32:18 -0400
Received: from ozlabs.org ([203.10.76.45]:43227 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755622AbXKDAcR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 20:32:17 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 2BD9DDDEBD; Sun,  4 Nov 2007 11:32:16 +1100 (EST)
In-Reply-To: <alpine.LFD.0.999.0711021809060.3342@woody.linux-foundation.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63328>

Linus Torvalds writes:

> It's disgusting. But it avoids the unnecessary data transfer - except for 
> just the first 100 commits that get sent twice. And it gets what *I* look 
> for, namely that "immediate" feel to the initial pop-up of the history.

Yes.  And it avoids the need for gitk to have to do any re-ordering of
the commits that it gets from git log.  In the case where the first
commits come out in a different order in the final list, gitk can just
truncate its list at the point of difference and re-read from there,
which is a lot less time-consuming than having to make a decision
for every commit about where it should go in the list.

I have actually been trying to come up with a decent way to generate
the list incrementally without using --topo-order for months now.  One
of the problems is that while Tcl can append things to the end of a
long list efficiently, and can index long lists efficiently, inserting
things into the middle of a long list is slow.  That makes any
insertion-sort type of algorithm unbearably slow.  And it's not just
when we get parents before children that I have to insert into the
middle of the list -- reordering a date-order list into one where we
see the string of commits that were merged immediately after a merge
commit requires a lot of insertions.

I do have an approach that I'm thinking about that builds up the list
as a series of "arcs", each of which is a string of commits with
exactly one parent and one child.  Each new commit from git log
(without --topo-order) then either gets appended to an arc (there can
be several arcs that are still growing at any given point), or it is a
merge or a branch point, which means it terminates some arc(s) and/or
starts new arc(s).  The final list of commits is then composed by
concatenating the arcs in a suitable order.  That avoids doing
insertions but does make things more complex for the consumers of the
list (the layout algorithm and the search function), and it
potentially makes it much slower to go from a row number to the commit
displayed on that row.

However, for now I think that using --early-output is a good
compromise solution that makes the startup much faster (or at least
*appear* to be much faster :) without adding much complexity.

Regards,
Paul.
