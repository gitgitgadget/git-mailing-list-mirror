From: Junio C Hamano <junkio@cox.net>
Subject: [RFH] plumber's puzzle
Date: Sun, 22 Apr 2007 12:53:37 -0700
Message-ID: <7v647ombi6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 22 21:53:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hfi7y-0007nQ-9i
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 21:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030780AbXDVTxj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 15:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030820AbXDVTxj
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 15:53:39 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:36346 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030780AbXDVTxi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 15:53:38 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070422195337.NFDR1268.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sun, 22 Apr 2007 15:53:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id qKtd1W00g1kojtg0000000; Sun, 22 Apr 2007 15:53:38 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45271>

I know people had trouble fetching from the official git.git
repository this morning; sorry about the gotcha.

Now it has all been hopefully sorted out, here is one thing that
I have been having trouble with lately, and can use some help.

Please try this, after getting the latest 'pu':

	$ git checkout origin/pu
	$ make all test-chmtime
	$ cd t
        $ sh ./t0021-filter.sh
        $ cd trash
        $ rm -f test.t
        $ ../../git-checkout-index -f -q -a
	$ ../../git-diff

This shows the single "diff --git" header line without anything,
to show that the path is not stat-clean, but the contents are
unchanged, which is what is expected.

A bit of background.  test.t has a funny "rot13" filter set for
both smudge and clean.  So test.t file has "a b c d e...", but
the actual blob records "n o p q r...".  Since we teached git
about the filter, git-checkout-index and git-diff do the right
thing.

Now, go back to the toplevel, comment out "close(1)" in
convert.c::filter_buffer() around line 236, and rebuild.

	$ cd ../..
        $ edit convert.c ;# comment out "close(1)"
        $ make
        $ cd t/trash

We get a quite _WRONG_ diff, like this:

        $ ../../git-diff
        diff --git a/test.t b/test.t
        --- a/test.t
        +++ b/test.t
        @@ -1,3 +1,4 @@
         n o p q r s t u v w x y z
         a b c d e f g h i j k l m
         $vqrag$
        +diff --git a/test.t b/test.t

and if you disable pager like this:

	$ PAGER= ../../git-diff

then you get the expected correct result.  Also you get this if
we disable the internal pager:

        $ ../../git-diff | cat
        diff --git a/test.t b/test.t
        --- a/test.t
        +++ b/test.t
        @@ -1,3 +1,4 @@
         n o p q r s t u v w x y z
         a b c d e f g h i j k l m
         $vqrag$
        +diff --git a/test.t b/test.t

I do not want to have a "fix" that I do not understand *why* it
fixes things in the tree; I couldn't figure out why that
close(1) in that codepath matters, although I was the one who
added that line.

Insights?
