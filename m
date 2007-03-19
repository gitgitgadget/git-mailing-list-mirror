From: Junio C Hamano <junkio@cox.net>
Subject: Re: [wishlist] git branch -d -r remotename
Date: Sun, 18 Mar 2007 23:40:19 -0700
Message-ID: <7v4pohka7g.fsf@assigned-by-dhcp.cox.net>
References: <45FD0804.6010401@vilain.net>
	<20070318110507.5701413A382@magnus.utsl.gen.nz>
	<20070318113210.5843E13A382@magnus.utsl.gen.nz>
	<7vvegyl4nt.fsf@assigned-by-dhcp.cox.net> <45FDB322.10904@vilain.net>
	<7v8xdtkb7p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Mon Mar 19 07:40:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTBXg-00078n-Hy
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 07:40:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965707AbXCSGkW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 02:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965715AbXCSGkW
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 02:40:22 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:58727 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965707AbXCSGkV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 02:40:21 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070319064021.LWXQ748.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Mon, 19 Mar 2007 02:40:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id cWgL1W0081kojtg0000000; Mon, 19 Mar 2007 02:40:21 -0400
In-Reply-To: <7v8xdtkb7p.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 18 Mar 2007 23:18:34 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42595>

Junio C Hamano <junkio@cox.net> writes:

> The standard way to check if commit A is included in (i.e. is an
> ancestor of) commit B, without traversing the ancestry chain of
> B all the way down to the root commit, is to run:
>
> 	git merge-base --all A B
>
> and see if A appears in its output (if so, then A is an ancestor
> of B, otherwise it is not).  This is a pair-wise check, and for
> your purpose the check would become N*M operation (Yuck).
>
> The same check can be done in parallel with:
>
> 	git show-branch --independent A B C D...
>
> whose output would include A if the commit is not included in
> any of the other commits B C D...  This parallel traversal has a
> limit --- you can only check 25 branches at a time.

Well, I was silly.  If you want to see if A is an ancestor of
any of B C D..., the standard and most efficient way to do so is
with rev-list.

	git rev-list A --not B C D...

will show _nothing_ only when A is an ancestor of one (or more)
of B C D..., so you invoke it and upon getting the first line of
output you declare A cannot be removed without reading the
remainder of the output.

show-branch --independent is an overkill for your purpose as it
does not treat A any more special from others (iow, it checks if
B is contained in A C D..., C is contained in A B D... all in
parallel), and you are not interested in finding out how remote
refs are related with each other.
