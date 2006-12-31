From: Junio C Hamano <junkio@cox.net>
Subject: Re: RFC: working with sparse work-copy: where to start?
Date: Sun, 31 Dec 2006 11:56:46 -0800
Message-ID: <7vodpjdekh.fsf@assigned-by-dhcp.cox.net>
References: <20061231104217.GE26552@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 20:56:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H16nb-0002PO-Au
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 20:56:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933206AbWLaT4s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 14:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933207AbWLaT4s
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 14:56:48 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:39518 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933206AbWLaT4s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 14:56:48 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061231195647.GVO7494.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Sun, 31 Dec 2006 14:56:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 5Xw01W00G1kojtg0000000; Sun, 31 Dec 2006 14:56:01 -0500
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
In-Reply-To: <20061231104217.GE26552@mellanox.co.il> (Michael S. Tsirkin's
	message of "Sun, 31 Dec 2006 12:42:17 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35707>

"Michael S. Tsirkin" <mst@mellanox.co.il> writes:

> Hi!
> I've been thinking about working in a sparsely-populated work copy.
> E.g. svn will let you do a checkout of a specific sub-directory
> and do all your development there assuming you only care about
> changes in that directory. Ideally, it would be possible to specify
> a set of directories that I care about.
> ...
> What other commands need to be fixed for this to work?

Pretty much everything needs to be changed, I suspect.

The point of git is to track the whole tree, and that is
ingrained to the design of the tool everywhere.  You need to
bend backwards to operate in the way you propose; I am not
saying it is impossible but I suspect it will be very hard or
inefficient or both.

Your commits, although your working tree will only have selected
subtrees in "wrong" places, should have the same "directory
structure" as everybody else.  This is an absolute requirement
for the result of your work in your repository to be usable by
others.

One design level thing you need to worry about is what to do
with merges, if you are pulling from more than one people and
they start their work in different version of "the whole tree".
You may not be interested in what happens in "other parts" of
the whole tree you are not checking out.  For your merge result
to be any useful for other people you later want to merge from
you, you still have to come up with and record the sensible
result when these "other parts" have conflicts.

This means the tree objects you will create as the final product
has to have the same directory structure as other people, while
your working tree will have only selected things, and in "wrong"
(from the tree's perspective) places.

One decision you need to make early is which side you place your
index on.

One approach would be to have the same directory structure in
the index.  The other possibility is to match the directory
structure recorded in the index with the structure of your
working tree.  I am not sure pros-and-cons offhand.

Regardless of which avenue you pursue, you need to have a way to
tell your version of git which subtree your repository is
interested in, and where in your working tree you want to check
them out.  And you would need to change affected commands to
take this new information into account when do their work.

The former approach means you do not have to touch write-tree
and read-tree, but your diff-index, diff-tree (when you want it
to work sensibly inside subdirectories), checkout-index and
update-index need to know about this.  The latter means you do
not have to touch diff-files, update-index and checkout-index,
but read-tree will be affected.  Any command that deals with
both tree and working directory at the same time (diff-index,
read-tree -u, merge-recursive, etc.) or works from a
subdirectory (pretty much all Porcelain commands -- think of
'git add .' in a subdirectory) will need to change regardless of
which approach is taken.

I think it would be a lot simpler if you do not mind deep
directory structure but still support a sparse checkout,
though.
