From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] git-float
Date: Thu, 17 May 2007 17:31:30 -0700
Message-ID: <7v3b1v7z19.fsf@assigned-by-dhcp.cox.net>
References: <20070517211805.GA29259@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Fri May 18 02:31:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoqNf-0003yC-LN
	for gcvg-git@gmane.org; Fri, 18 May 2007 02:31:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754522AbXERAbc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 20:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754646AbXERAbc
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 20:31:32 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:54845 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754522AbXERAbb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 20:31:31 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070518003131.GZXI2758.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Thu, 17 May 2007 20:31:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 0QXW1X00G1kojtg0000000; Thu, 17 May 2007 20:31:30 -0400
In-Reply-To: <20070517211805.GA29259@mellanox.co.il> (Michael S. Tsirkin's
	message of "Fri, 18 May 2007 00:18:05 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47566>

"Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:

> Here's a simple script I use to float a commit up the history -
> similiar to what stg float does if I understand it correctly.
>
> Is this a good way to implement it?

> git-rebase --onto $ref~1 $ref && git-cherry-pick $ref

Because git-rebase or git-cherry-pick can be interrupted with a
conflict, this is not a good _implementation_.  The whole script
needs to have the sequencing and continue logic similar to the
one git-rebase has.

> Would it make sense to have something like this in git tree?

Incidentally, this is closely related to something that people
have wanted to have for a long time, which is to cherry-pick
series of commits.

One step of rebase and cherry-pick can be thought of as a
"rotate a commit" operation.  When you cherry-pick a commit C on
top of where you are, the resulting tree is computed by applying
the commit C's effect to the current tree via 3-way merge.

	git-merge-recursive C^ HEAD C

git-rebase without -m does the equivalent of the above "rotate a
commit" operation using patch + apply (and fall back to merge if
the patch does not cleanly apply) for performance reasons, but
the principle is the same.  And the commit message for the
result is taken from C itself.

git-rebase can be decomposed into three stages:

 (1) find the sequence of commits to reapply;

 (2) find the commit to start rebuilding onto and reset to it;

 (3) one by one, rotate the commits you found in (1), with
     the sequencing support (--abort, --skip and --continue).

There is no reason, other than the fact that there is no other
commit rotator in git suite that needs sequencing, that these
three needs to be in a single program git-rebase.

The only difference with the above outline and your float is
that after you finish step (1), you record "this commit also
needs to be replayed at the end" information to the sequence.

The implementation of cherry-pick that takes commit range is
also obvious; instead of the computation git-rebase does for
step (1) above, we would allow arbitrary series of commits to be
specified from the command line (most likely using the revision
list notation A..B) to be replayed with the sequencing
machinery.
