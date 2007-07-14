From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-reset: allow --soft in a bare repo
Date: Sat, 14 Jul 2007 01:33:31 -0700
Message-ID: <7v7ip3jsf8.fsf@assigned-by-dhcp.cox.net>
References: <20070714044916.GA24911@coredump.intra.peff.net>
	<7vir8nmujo.fsf@assigned-by-dhcp.cox.net>
	<20070714052405.GA26107@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 14 10:33:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9d4K-0006jC-ND
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 10:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752351AbXGNIde (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 04:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752286AbXGNIde
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 04:33:34 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:51346 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152AbXGNIdc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 04:33:32 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070714083332.FSC1349.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sat, 14 Jul 2007 04:33:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PLZX1X00C1kojtg0000000; Sat, 14 Jul 2007 04:33:32 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52456>

Jeff King <peff@peff.net> writes:

> Ah, I hadn't thought of that. It seems a bit of a contortion, though,
> since git-branch is usually used for _making_ a branch, whereas
> git-reset is usually used for _changing_ a branch. But maybe that's just
> me.

"branch -f" is very often used to "reset the branch tip".  My
git day typically begins with "branch -f pu next".

> At any rate, it might still be worth applying the patch. It should be
> harmless to loosen the restriction, and even if there are several ways
> to accomplish the same thing, why punish people who try git-reset first?
> On the other hand, this is the first time I've seen it come up, so maybe
> this isn't confusing people.

Actually, after thinking about this a bit more, I have become
somewhat reluctant, as this might confuse new users by giving
them a wrong mental model of what "reset" is about.

To my mind, as an old time git user, reset (any variant) has
always been about reshaping the relationship among the HEAD, the
index and the working tree; if there is no index nor the working
tree (iow, a bare repository), there can be no "relationship"
among them.

We initially had only --mixed and --hard (and the former was not
even called --mixed as there were only two kinds).  Then --soft
was invented as a stop-gap measure before "commit --amend" came.

In all cases, the user is saying "I want to make the next commit
I'll make on top of that commit (which may or may not be
different from the HEAD), and I'd want to start working towards
that goal, starting from such and such index and working tree
state".  And that "such and such state" is different among three
variants:

 * "reset --mixed" means "I like what I have in the working
   tree, but I'd want to discard the index and start from what
   is in (possibly updated) HEAD instead";

 * "reset --hard" means "I want to restart both index and
   working tree from scratch, starting from (possibly updated)
   HEAD";

 * "reset --soft" means "I like what I have in the index and
   also I like what I have in the working tree -- do not touch
   them -- I want the next commit to go on top of that commit".

"reset --soft" happens to be a variant of reset that does not
touch index nor working tree, but conceptually, "not touching"
and "not having either is Ok" are two quite different things.
