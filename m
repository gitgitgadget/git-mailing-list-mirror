From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-blame not tracking copies
Date: Sat, 05 May 2007 23:02:30 -0700
Message-ID: <7vfy6aij61.fsf@assigned-by-dhcp.cox.net>
References: <200705022033.25885.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 06 08:02:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkZpR-00006e-LP
	for gcvg-git@gmane.org; Sun, 06 May 2007 08:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754411AbXEFGCc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 02:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754597AbXEFGCc
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 02:02:32 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:57687 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754411AbXEFGCb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 02:02:31 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070506060231.TAAF6556.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sun, 6 May 2007 02:02:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id vi2W1W00U1kojtg0000000; Sun, 06 May 2007 02:02:31 -0400
In-Reply-To: <200705022033.25885.andyparkins@gmail.com> (Andy Parkins's
	message of "Wed, 2 May 2007 20:33:23 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46296>

Andy Parkins <andyparkins@gmail.com> writes:

> The issues are
>
>  - Blame2 says all the lines come from commit 4, when actually they
>    come from commits 1, 2 and 3.  It was pointed out that this is
>    particularly annoying because the file is an exact copy and so the
>    copy has the same hash as the original so should be easy to spot
>
>  - The output isn't stable, even if blame2 had a good reason for not
>    assigning lines 1 and 2 to their correct commits, why isn't the same
>    true in blame3?
>
>  - Blame3 incorrectly ascribes line 4 to commit 4, when it should have
>    remained as it was in blame1 - to commit 3.

This turns out to be a simple and stupid boundary error.

The algorithm passes the blame by (ab)using diff to find the
common section.  We run an equivalent of "diff -u0", notice the
lines that come out of it -- the lines that do not appear are
common ones.  Simply put, if we have this hunk at the beginning:

	@@ -4,1 +4,2 @@
        -a
        +A
        +B

the only information we are interested in this hunk are (1) that
the hunk begins at line 4 in the postimage, so lines 1,2,3 in
the postimage are the same as the preimage; and (2) that the
different part ends just before line 6 (the hunk has two lines
in the postimage which we know do not match the preimage).  So
if the next hunk from the diff look like this...

	@@ -6,1 +8,1 @@
        -e
        +E

then we know lines 6 and 7 in the postimage are the same as the
preimage.

We need to use the information (2) from the last hunk in the
patch and blame all the remaining lines to the parent.

When we are assigning blame from one file in the "current"
commit down to one (possibly different) file in its parent
commit in pass_blame_to_parent() function, we grab patch between
the two, and we have the final "the rest are the same" call to
blame_chunk().  However, the code to assign blame for only part
of a file to unrelated file in its parent (i.e. -M/-C), the
corresponding code in find_copy_in_blob() to use the diff output
was missing this "the rest are the same" handling.

A 3-patch series follows.
