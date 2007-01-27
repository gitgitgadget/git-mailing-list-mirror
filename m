From: Junio C Hamano <junkio@cox.net>
Subject: Re: More precise tag following
Date: Sat, 27 Jan 2007 00:41:54 -0800
Message-ID: <7vbqkklv3h.fsf@assigned-by-dhcp.cox.net>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net>
	<20070127080126.GC9966@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jan 27 09:42:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAj8L-0003w7-2H
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 09:42:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203AbXA0Il4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 03:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752211AbXA0Il4
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 03:41:56 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:52414 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbXA0Ilz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 03:41:55 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070127084154.QUJX2628.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Sat, 27 Jan 2007 03:41:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id G8gw1W00Q1kojtg0000000; Sat, 27 Jan 2007 03:40:57 -0500
In-Reply-To: <20070127080126.GC9966@spearce.org> (Shawn O. Pearce's message of
	"Sat, 27 Jan 2007 03:01:26 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37933>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Based on some (limited) profiling with Shark it seems we spend about
> 50% of our CPU time doing zlib decompression of objects and almost
> another 14% parsing the tree objects to apply the path limiter.

I once tried to use zlib compression level 0 for tree objects
and did not see much difference -- maybe I should dig it up and
find out why.

> One idea Simon and I were talking about was to store a reverse
> file/tree-level DAG in the header of each tree/blob object in the
> pack file.
> ...
> Thoughts?

Anything you would do, storing that in tree is wrong.  Tree
object only represents just the contents of a single state and
in itself there should not be any information that describes its
relation with other trees [*1*].

And of course making it pack-only is doubly wrong.


*1* That's why my thinking-aloud talked about "N list of changed
paths recorded in a commit object with N parents".  A commit is
to talk about one particular state (i.e. tree) and its relation
to other commits (and by indirection, other trees), so logically
the information could belong there --- that is merely a "could",
since that is strictly caching for performance.  After finding
where the bottleneck is, obviously finding a way to optimize the
tree pathlimiting with the currently available data without
having such redundant data is more preferable.
