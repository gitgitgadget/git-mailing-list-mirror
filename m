From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/5] merge-recursive: handle D/F conflict case more carefully.
Date: Mon, 09 Apr 2007 12:53:43 -0700
Message-ID: <7vk5wlz5mg.fsf@assigned-by-dhcp.cox.net>
References: <7v6488ckk0.fsf@assigned-by-dhcp.cox.net>
	<20070409185809.GA13212@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 00:31:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hazvx-0001nq-90
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 21:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490AbXDITxq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 15:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753492AbXDITxq
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 15:53:46 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:35258 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490AbXDITxp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 15:53:45 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070409195346.WAUS24385.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Mon, 9 Apr 2007 15:53:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id l7tk1W0091kojtg0000000; Mon, 09 Apr 2007 15:53:44 -0400
In-Reply-To: <20070409185809.GA13212@steel.home> (Alex Riesen's message of
	"Mon, 9 Apr 2007 20:58:09 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44071>

Alex Riesen <raa.lkml@gmail.com> writes:

> Junio C Hamano, Sat, Apr 07, 2007 16:42:55 +0200:
>> +			if (unlink(path)) {
>> +				if (errno == EISDIR) {
>> +					/* something else exists */
>> +					error(msg, path, ": perhaps a D/F conflict?");
>
> isn't this one an F/D conflict?

Yes, as I said in a separate message, the current D/F detector
code in merge-recursive does not catch this case in t3030 test
and comes to this codepath to write it out:

   From: Junio C Hamano <junkio@cox.net>
   Subject: Re: [PATCH 5/5] t3030: merge-recursive backend test.
   Date: Sat, 07 Apr 2007 22:17:25 -0700
   Message-ID: <7vmz1ja1i2.fsf@assigned-by-dhcp.cox.net>

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

The part you quoted is merely working this problem around.
