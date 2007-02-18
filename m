From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Teach name-rev to identify revisions containing a certain blob
Date: Sun, 18 Feb 2007 00:34:15 -0800
Message-ID: <7vmz3bj248.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702171838510.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Mike Coleman <tutufan@gmail.com>,
	junkio@cox.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 18 09:34:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIhUz-0006W3-8l
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 09:34:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161147AbXBRIeT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Feb 2007 03:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161149AbXBRIeT
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Feb 2007 03:34:19 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:45623 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161147AbXBRIeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Feb 2007 03:34:16 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070218083415.LKIQ21704.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sun, 18 Feb 2007 03:34:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id QwaF1W00W1kojtg0000000; Sun, 18 Feb 2007 03:34:16 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40061>

Having said what I said in the comments on [PATCH 1/2], I think
you are either solving a wrong problem, or even if you are
solving the right problem, you are solving in a wrong way in
this patch.

I do not think Mike wants a way to deal with what he gets in his
mailbox from an end user who did this:

	$ cat a-file-whose-name-was-not-told-to-mike >junk
	$ mailx mike.coleman <junk

It's more like he learns the contents _and_ the path from an
end-user who is having trouble with a tarball of unknown
vintage, and wants to identify which snapshot had that contents
at that path [*1*].

So I do not think it is solving the right problem to run around
all over the tree without knowing the path, looking for a
particular object name.  It certainly makes the solution much
more expensive.

Even if that were Mike's problem, there is a problem that the
same object can appear at different places in different trees.
Keeping a single pathname registered in object_hash would mean
the answer is "whatever happens to be found first", regardless
of the path.

To make "whatever happens to be found first" semantics useful, I
think you would need to make the traversal more controllable by
the user of name-rev.  For example, Mike may know what he gave
the end user was from maintenance series of 1.4.4 software, in
which case you would want to let him say "traverse from the tip
of 1.4.4 maintenance branch down, do not worry about other
branches such as 1.5.0 series or 1.4.3 maintenance series".

Your earlier --ref-filter patch would certainly help it, but a
solution based on grep over "rev-list | ls-tree --stdin" (which
currently does not exist) might be more appropriate and
flexible?  I dunno.

[Footnote]

*1* To find a revision that had a particular object at a known
path, you should be able to do:

	git rev-list <starting refs> |
        git diff-tree --stdin --raw -r -Z |
	grep -z that-object-name

but an earlier commit abd4e222 needs to be further enhanced to
add -Z option that means "output fields are not NUL terminated,
output records are", which did not happen.
