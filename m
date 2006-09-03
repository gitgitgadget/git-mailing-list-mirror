From: Junio C Hamano <junkio@cox.net>
Subject: Re: Mozilla version control requirements and git
Date: Sun, 03 Sep 2006 16:06:09 -0700
Message-ID: <7v3bb8tuse.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910609020731k25ce3a0aw7a84542f8cd516f6@mail.gmail.com>
	<46a038f90609021819v6d427f0eh69bc13b30ef6b692@mail.gmail.com>
	<9e4733910609022029q9cb9ba9m87cbc37e8d6f4ad7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 04 01:06:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GK12c-0005Bu-UG
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 01:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWICXFz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Sep 2006 19:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWICXFz
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Sep 2006 19:05:55 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:46525 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932107AbWICXFy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Sep 2006 19:05:54 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060903230554.EFXD12581.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Sun, 3 Sep 2006 19:05:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Hz5u1V00W1kojtg0000000
	Sun, 03 Sep 2006 19:05:55 -0400
To: "Jon Smirl" <jonsmirl@gmail.com>
In-Reply-To: <9e4733910609022029q9cb9ba9m87cbc37e8d6f4ad7@mail.gmail.com> (Jon
	Smirl's message of "Sat, 2 Sep 2006 23:29:23 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26392>

"Jon Smirl" <jonsmirl@gmail.com> writes:

> Partial repo pulls and an issue to. The mozilla repo has much more
> than a browser in it, it also has a large mail/news program. A partial
> repo pull may not be what is needed for git, instead git needs a
> partial repo checkout.

That does not contradict with the underlying data model of git,
and it would certainly be possible with a specialized Porcelain.

Since git tracks the entire tree, the tree object contained in
the commit you create _must_ describe the entire project tree,
but that does not necessarily mean that your working tree needs
to have the entire tree checked out.

The git corelevel is designed to be operable with sparsely
populated working tree, and the problem you are seeing is
primarily coming from the fact that some wrappers you are seeing
as "git UI" are specifically done to help workflows that _wants_
to have fully populated working tree (e.g. "git commit -a" and
"git checkout").  There are other wrappers that are designed to
work well in sparsely populated working tree, including "git-am"
and "git-merge".  They should be usable pretty much as they are.

To support "narrow checkout" workflow, some wrappers either need
to be told about the "interesting area", or a set of different
wrappers specifically designed to support "narrow checkout"
workflow can be written.  I am not sure which is more desirable.
I have a gut feeling that "git commit" can be used as is (you cd
into the area you are interested in, and say "git commit ."
instead of saying "git commit -a"), while it would be less
confusing to keep "git checkout" the whole-tree operation and
have a specialized porcelain for a narrow checkout, but this is
me saying things without thinking things through.

I imagine such a "narrow checkout" workflow Porcelain would work
like this:

 - the user tells it which parts of the whole project she is
   interested in.

 - when checking things out, the Porcelain populates the index
   in full [*1*] and then checks out only specified subtrees to
   the working tree.

 - when checking things in, the changes outside the specified
   area are ignored (well, outside there should be no files in
   working tree so ignoring them should be trivial).  write-tree
   writes from the whole index and creates the tree object and
   then commit object just as usual.  The net effect is that the
   parts outside the areas of interest stay the same as the
   previous HEAD commit, which is exactly what the user wanted
   anyway.

You could optimize the above further by populating the index
sparsely as well (i.e. *1* above is not a requirement), but you
would need to merge in the changes made to that sparse index
into the full tree read from the HEAD commit before writing the
next tree object out anyway, so I doubt it is worth it.


-- 
VGER BF report: U 0.842228
