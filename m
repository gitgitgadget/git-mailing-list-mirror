From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/5] diff --quiet
Date: Thu, 15 Mar 2007 17:16:15 -0700
Message-ID: <7v3b4611rk.fsf@assigned-by-dhcp.cox.net>
References: <7vwt1j8z0e.fsf@assigned-by-dhcp.cox.net>
	<7vodmv7bza.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0703141614m70f4a565qc001e06e60b0ffd5@mail.gmail.com>
	<7v8xdz5qn0.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0703150119l705eefb6h6af44b9452db83e2@mail.gmail.com>
	<Pine.LNX.4.63.0703151136470.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<81b0412b0703150655y3d2a71d3t8db6e334ecf23ca1@mail.gmail.com>
	<Pine.LNX.4.63.0703151841180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<81b0412b0703151408v5e6245f4l95fb7cc801e1b568@mail.gmail.com>
	<Pine.LNX.4.63.0703152211050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 16 01:16:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HS07T-0008Di-SU
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 01:16:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421AbXCPAQR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Mar 2007 20:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753457AbXCPAQR
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Mar 2007 20:16:17 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:46084 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421AbXCPAQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2007 20:16:16 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070316001616.PKME748.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Thu, 15 Mar 2007 20:16:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id bCGG1W0071kojtg0000000; Thu, 15 Mar 2007 20:16:16 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42303>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The point I tried to make: without "-w" or "-b", you can compare at the 
> tree level. No need for a --quiet option.

That's not true.  The --quiet option is not about comparing at
the tree level vs looking inside the blobs.  It helps to
optimize the tree level comparison as well.  The difference
Linus was happy about comes from exactly the early exit from
tree comparison.

The current --quiet will report if they are different at the
tree level and does not take filtering done at the later phases
into account at all, and that is a conscious design decision so
that we can use it for optimizing try_to_simplify_commit().  So
for example, if you have any change that a plain "git diff-*"
says there are differences, the option reports there indeed are
differences, like this:

	$ git reset --hard ;# start from the clean state
        $ touch Makefile
        $ git diff-files -p
        diff --git a/Makefile b/Makefile
        $ git diff-files --quiet; echo $?
	1

I didn't consider -w nor -b when I made the design decision that
leads to the above behaviour, but I think the filtering done at
the textual patch generation phase falls into the same category.
If you do the following, the answer would be "they are
different":

	$ sed -e 's/$/ /' <Makefile >Makefile+
        $ cat Makefile+ >Makefile
        $ rm Makefile+
        $ git update-index --refresh
        $ git diff-files -b -p
        diff --git a/Makefile b/Makefile
        index dc024d4..1c328be 100644
        $ git diff-files -b -p --quiet; echo $?
        1

Options like -w and -b are only about not showing the lines; you
still get the diff header that reports they are different.  So
in that sense the output from the last command above is correct.

I am however wondering if we want to have (and if it would be
worth the trouble to add) an option to have the command say if
there will be textual difference output without producing it.  I
do not see much value in it right now, but it might turn out to
be handy.  I do suspect that would be a rather intrusive and
error prone change, though.

A good news is that such an option needs to work at a different
level than the existing --quiet, which works in diffcore_std().
The new option would probably need to work inside diff_flush()
which is a later phase.  So no matter how you screw up, it would
hopefully not break revision traversal too much.

We might want to rename the existing one --quick and name that
new option --quiet, though, if we go that route.
