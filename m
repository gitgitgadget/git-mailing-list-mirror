From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 5/5] t3030: merge-recursive backend test.
Date: Sat, 07 Apr 2007 22:17:25 -0700
Message-ID: <7vmz1ja1i2.fsf@assigned-by-dhcp.cox.net>
References: <7v4pnsckju.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 08 07:17:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaPmY-0003G0-NJ
	for gcvg-git@gmane.org; Sun, 08 Apr 2007 07:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbXDHFR1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Apr 2007 01:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751821AbXDHFR1
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Apr 2007 01:17:27 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:41507 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbXDHFR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2007 01:17:26 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070408051726.YEBW373.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sun, 8 Apr 2007 01:17:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id kVHR1W0031kojtg0000000; Sun, 08 Apr 2007 01:17:25 -0400
In-Reply-To: <7v4pnsckju.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 07 Apr 2007 07:43:01 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43997>

Junio C Hamano <junkio@cox.net> writes:

> +test_expect_success 'merge-recursive d/f conflict result' '
> +
> +	git ls-files -s >actual &&
> +	(
> +		echo "100644 $o0 0	A"
> +		echo "100644 $o0 1	a"
> +		echo "100644 $o1 2	a"
> +		echo "100644 $o4 0	a/c"
> +		echo "100644 $o0 0	b"
> +		echo "100644 $o1 0	d/e"
> +	) >expected &&
> +	git diff -u expected actual
> +
> +'

The expected result of this test is what I find very iffy.  The
input trees are:

 * Ancestor has a file "a"
 * Our tree has a file "a", which was modified from the
   ancestor's
 * The other tree has a file "a/c"

merge-recursive.c::git_merge_trees() calls unpack_trees() using
the threeway_merge function and what it gets back are stage 1
and 2 entries for "a", and stage 3 entry for "a/c" (you can see
it by running "git-read-tree -m $c0 $c1 $c4" instead).  But the
output from merge-recursive has "a/c" resolved down to stage 0.

The problem is that process_entry() finds that there is only
stage 3 entry for that path and decides to resolve it.  I think
it should do the D/F check and leave "a/c" in stage 3.

Looking at the D/F conflict detection code in merge-recursive.c
makes my head hurt, and I do not quite follow the logic there,
but it seems to be doing the following to me.

 * current_directory_set is initialized to be union of all
   directories that appear in our tree and the other tree (I am
   not sure if that set is updated and if so how);

 * when a path is about to be resolved to a blob, this set is
   consulted, and if there is a directory there, declare D/F
   conflict and blob is added under a name that does not
   conflict with the directory;

 * otherwise the path is resolved down to stage 0.

However, in this case, there is no such directory "a/c" but the
code forgets that adding a blob at "a/c" requires that there is
no file "a" at all.  I am not sure if this is deliberate or just
a simple oversight.

Also I suspect this can be done more easily with just checking
the index.  We know blob "a" is in the index, unresolved, when
we try to resolve path "a/c".
 
