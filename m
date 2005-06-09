From: Junio C Hamano <junkio@cox.net>
Subject: Re: Handling merge conflicts a bit more gracefully..
Date: Wed, 08 Jun 2005 21:35:28 -0700
Message-ID: <7vfyvsuoz3.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0506081336080.2286@ppc970.osdl.org>
	<7vis0o30sc.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506081629370.2286@ppc970.osdl.org>
	<7voeag1j9y.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506081757170.2286@ppc970.osdl.org>
	<7vll5kxolo.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506081936370.2286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 06:33:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgEiB-0006eg-1D
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 06:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbVFIEfu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 00:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262264AbVFIEfu
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 00:35:50 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:57021 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S262261AbVFIEfb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2005 00:35:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050609043530.NNWK26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Jun 2005 00:35:30 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506081936370.2286@ppc970.osdl.org> (Linus
 Torvalds's message of "Wed, 8 Jun 2005 19:48:45 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Yeah, ok, so the fact that we allow missing things in the
LT> index (which was debatable to start with) makes for
LT> exceptions.

Not just that.  Another big difference is that we allow _extra_
things in the index in two-tree case (i.e. local additions).
But I do not think these exceptions are necessarily bad.

And you are right that two-tree is _very_ different from
three-way merge.

LT> We could certainly be stricter about the index contents, and
LT> require that they match the branch we're merging from
LT> exactly, rather than be a subset.

I guess great minds do not always think alike.  I was going in
quite the opposite direction.  I vaguely recall saying this
before on this list ;-)

With the current three-way code, if I rewrite two-way merge
using the three-way "read-tree -m H I-mixed-with-H M" (emulated
two-tree fast forward, where "I" denotes "tree that would have
resulted from the original cache"), it would give quite
different results from the "carry forward" two-way code we have.
So in that sense, three-way and two-way are quite different.

I have, however, not convinced myself that this difference is
coming from some fundamental difference between two-tree fast
forward and three-way merge.  If desirable results fall out
naturally for the "emulated two-way" case by handling three-way
case more carefully (e.g. not having stricter index requirements
than necessary), that would be wonderful.  I think, for example,
there are places where we have too strict index requirements in
three-way merge (grep for '(ALT)' in t/t1000*.sh test file).

I probably am dreaming, though.

LT> I think the case that is more important (and more likely to
LT> hit people) is when they have something in their working
LT> tree that conflicts with the merge, and then what you want
LT> is really that the current "update" code do the three-way
LT> merge in the working directory, not that it's done on the
LT> index file contents.

LT> ..., but I don't think the index file is the most important
LT> case. The more important case is the one that the three-way
LT> merge doesn't handle either!

I agree with all of the above.  Their working tree has changes
from H, and merging M into H conflicts with those changes.  That
means, although they did not actually make a formal commit, what
they have is essentially this:

         cache contents
         is here
         v
      ---I---
     /       ^work tree contents is here
  --H
     \
      ----------M

which means we are exactly in the same situation as "merge I and
M pivoting on H" three-way merge, with a dirty work tree.  Any
solution and help we would give to the end-user for the
three-way case would automatically help this two-way case,
wouldn't it?

I do not think index file is important either; maybe I am not
really understanding your argument.  I fully accept the new
world order with today's merge-one-file-script changes, that the
merge result will be left in the work tree for the user to
verify and sort out.  What I am trying to do in the above
picture is to help the end-user forward-porting differences in I
since H (along with the work tree changes since I) when doing a
fast-forward from H to M happens, using the files in the work
tree.

