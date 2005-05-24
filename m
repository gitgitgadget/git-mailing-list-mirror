From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] Diff overhaul, adding the other half...
Date: Mon, 23 May 2005 22:37:46 -0700
Message-ID: <7vbr71xjyt.fsf@assigned-by-dhcp.cox.net>
References: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org>
	<7vzmuokjhg.fsf@assigned-by-dhcp.cox.net>
	<7vfywgkj90.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505211016140.2206@ppc970.osdl.org>
	<7vzmuoh2ma.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505211124440.2206@ppc970.osdl.org>
	<Pine.LNX.4.58.0505211128570.2206@ppc970.osdl.org>
	<Pine.LNX.4.58.0505211137250.2206@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 07:37:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaS60-0007zj-5H
	for gcvg-git@gmane.org; Tue, 24 May 2005 07:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVEXFiA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 01:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbVEXFh7
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 01:37:59 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:58310 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261302AbVEXFhs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 01:37:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050524053747.IQRM26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 24 May 2005 01:37:47 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505211137250.2206@ppc970.osdl.org> (Linus
 Torvalds's message of "Sat, 21 May 2005 11:45:30 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Hmm.. It's not working well. Not only does it take a lot of CPU time (do 
LT> an fsck first to make sure you're not seekign the disk all over the 
LT> place), but it "finds" lots of things like this:

The "finds logs of funny things" problem should have been fixed
by now, and I am fixing a big screwup now as I reported. I have
two ideas on speeding up diff-tree -C I want to run by you.

I have not measured things yet, but I think the big CPU waste is
coming from either expanding all the blobs and/or running the
diff-delta on many file pairs.  If that is indeed the cause,
then helping the upfront check in the similarity estimator that
refuses to consider a file pair whose file size change is too
big may be a good way to resolve this problem.

One approach, which I think is an unacceptable change at this
stage (but I would seriously consider if this _were_ a week and
half old project), is to record the blob size as part of the
object ID.  We say object size is "unsigned long" everywhere, so
I am talking about making the object ID from 20-byte SHA1 to
24-byte SHA1 plus 4-byte integer in the network byte order.

Since I think the above is inpractical, the second best approach
would be to piggy-back on the optimization used in uncached
diff-cache, which avoids blob expansion if cache says what we
have in the work tree already matches the object we are
interested in.

When -C is in effect, we would make diff-tree read the current
cache first, so that diff_populate_filespec() can borrow from
the current work tree when a path in the tree we are looking at
has not changed.  This would obviously be effective only when we
are talking about recent history.

Thoughts?


