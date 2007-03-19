From: Junio C Hamano <junkio@cox.net>
Subject: Re: Why are ref_lists sorted?
Date: Sun, 18 Mar 2007 21:50:16 -0700
Message-ID: <7vodmpltvb.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0703190321370.28570@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Mon Mar 19 05:50:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT9p6-0003w3-73
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 05:50:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922AbXCSEuT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 00:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753290AbXCSEuT
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 00:50:19 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:36011 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752922AbXCSEuR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 00:50:17 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070319045017.FYVQ24587.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Mon, 19 Mar 2007 00:50:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id cUqG1W00l1kojtg0000000; Mon, 19 Mar 2007 00:50:17 -0400
In-Reply-To: <Pine.LNX.4.64.0703190321370.28570@beast.quantumfyre.co.uk>
	(Julian Phillips's message of "Mon, 19 Mar 2007 03:38:03 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42587>

Julian Phillips <julian@quantumfyre.co.uk> writes:

> So my questions are:
>
> 1) what have I broken by removing the sort?

See do_for_each_ref().  We walk packed and loose refs in
parallel, preferring loose ref if exists (so that after packing,
updating a ref does not have to remove entry from packed-refs
file).

> 2) is it worth trying to optimise the sort?

If you have 9,000 entries, it probably is worth doing.  Also you
might want to use an expanding array of pointers instead of
linked list.

Currently add_ref() is shared between packed and loose refs, and
the order loose refs are discovered depends on readdir() order,
so we cannot do without sorting on that side.  But I suspect
reading them in in the order they are discovered and then
sorting at the end just once might be a good thing to do.

If we write packed refs _after_ sorting, we should be able to
optimize on the side that reads packed-refs even better.  As you
read one new line from the file, you make sure that it sorts
later than the last entry you saw, and append to the end of
list; if you find an unorderd entry, remember that the list is
not sorted, and sort at the very end after reading all the refs.

Or something like that...
