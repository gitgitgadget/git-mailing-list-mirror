From: Junio C Hamano <junkio@cox.net>
Subject: Re: Notes on supporting Git operations in/on partial Working Directories
Date: Thu, 14 Sep 2006 12:50:31 -0700
Message-ID: <7vu03a2po8.fsf@assigned-by-dhcp.cox.net>
References: <4509A7EC.9090805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 14 21:51:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNxEJ-0002tH-Vy
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 21:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWINTud (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 15:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWINTud
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 15:50:33 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:28053 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751100AbWINTuc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 15:50:32 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060914195031.XQEB26416.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Thu, 14 Sep 2006 15:50:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id NKqL1V00D1kojtg0000000
	Thu, 14 Sep 2006 15:50:21 -0400
To: gitzilla@gmail.com
In-Reply-To: <4509A7EC.9090805@gmail.com> (A. Large Angry's message of "Thu,
	14 Sep 2006 12:05:16 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27033>

A Large Angry SCM <gitzilla@gmail.com> writes:

> The minimum required changes[*1*][*2*][*3*] to the index file to support
> partial checkouts are:
>
> 1) the addition of WD_Prefix string to hold the common path prefix of
> all objects in the working directory. For a full checkout, the WD_Prefix
> string would be empty.
>
> 2) A (new) flag for each entry in the index indicating whether or not
> the object is in the partial checkout.
>
> The contents of the index file still reflect the full tree but flag each
> object (file or symlink) separately as part of the checkout or not. The
> WD_Prefix string is so that a partial checkout consisting of only
> objects somewhere in the a/b/c/d/ tree can be found in the working
> directory without the a/b/c/d/ prefix to the path of the object.
>
> All the Git commands that use the index file will need to be changed to
> support this but the transfer protocols do not need to change.

While this may be a good start, you need a lot more than this if
you want to do (1) and (2):

The tree object contained by a commit is by definition a full
tree snapshot, so if you want to do a WD_Prefix, you somehow
need a way to come up with the final tree that is a combination
of what write-tree would write out from such a partial index
(i.e. an index that describes only a subdirectory) and the rest
of the tree from the current HEAD.  I think you can more or less
do this change to Porcelain using today's git core.  The
sequence to emulate it with the today's git would be:

 (1) write-tree (of the WD_Prefix part of the subtree),
 (2) read-tree HEAD (to populate the index fully),
 (3) piping a massaged output from git-ls-files WD_prefix to
     update-index --index-info, followed by read-tree
     --prefix=WD_prefix to swap the partial tree in to
     WD_prefix,
 (4) write-tree (to get the final result).

If you want to do per-path-inside-directory checkout (your 2),
this combining step would need to be even more complex.  You can
do that by hand (reading ls-tree and ls-files and driving
update-index --index-info yourself) but it certainly would be
more involved.  But it's just a matter of Porcelain programming
;-) [*1*].

But a good news is that today's git core lets you work in a
sparsely checked out repository without any of the above
crap^Wcomplexity, if you drop the WD_Prefix and per
path-inside-directory checkout "expectations".  Just staying
within the directory you are working in, and saying "commit ."
when you are tempted to say "commit -a", would be more or less
what are needed.

Note.  The "git checkout" Porcelain would want to check-out
everythingd, so a tool to prepare such a sparsely checked out
tree needs to be written if somebody wants to try this, since
the above "good news" is only about "working in" a sparsely
checked out tree.


[*1*] Obviously you would also need to worry about activities
other than making your own changes and committing.  When you are
always pulling from a single upstream that never rewinds the
head, the problem becomes simpler, but for other cases (read:
anything that makes distributed version control more interesting
and useful) you would need to worry about merges too.  What
happens when the upstream you based your changes on and the
repository you are pulling from today had conflicting changes
outside of your area of interest?  Without resolving the
conflicts, you cannot sanely claim you merged the two branches,
and even if you wanted to resolve them yourself, an non-empty
WD_prefix would get in your way.
