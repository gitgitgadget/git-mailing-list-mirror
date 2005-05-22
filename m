From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] The diff-raw format updates.
Date: Sun, 22 May 2005 12:35:16 -0700
Message-ID: <7vy8a7cavf.fsf@assigned-by-dhcp.cox.net>
References: <7vwtpsdvgm.fsf@assigned-by-dhcp.cox.net>
	<7v1x80dluj.fsf@assigned-by-dhcp.cox.net>
	<7vvf5cc779.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505221108000.2307@ppc970.osdl.org>
	<20050522184237.GG18500@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0505221203410.2307@ppc970.osdl.org>
	<7v64xbdq4y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 22 21:35:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZwDW-0007Nk-43
	for gcvg-git@gmane.org; Sun, 22 May 2005 21:34:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVEVTfb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 15:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVEVTfb
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 15:35:31 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:49571 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261275AbVEVTfW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2005 15:35:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050522193520.BEXD550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 22 May 2005 15:35:20 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7v64xbdq4y.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sun, 22 May 2005 12:20:13 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JCH" == Junio C Hamano <junkio@cox.net> writes:
>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:
LT> The machine readable format has the same issue: it needs to be able to 
LT> distinguish between a "copy" (where the source remains) and a "rename" 
LT> (where the source is removed).

JCH> Why?  If the same path appears later as the left hand side then
JCH> it is a copy otherwise it is a rename.  Please see what
JCH> diffcore-rename does when assigning to dp->xfrm_msg.  

JCH> What I've been trying hard so far was to keep diff_filepair not
JCH> to be too specific to rename/copy.  What I do not like about
JCH> what is being proposed is that it would force me to introduce
JCH> this "is this a copy or a rename" flag to that structure.

Linus, another way of saying the above is this.

Think about the example in test that munge COPYING file.  What
was recorded in the two trees as the result of

    sed $munge_1 <COPYING >COPYING.1
    sed $munge_2 <COPYING COPYING.2
    rm COPYING

will be expressed as copy-edit of COPYING.1 and rename-edit of
COPYING.2 (both from COPYING).  But that is just _one_
interpretation diffcore-rename _arbitrarily_ makes.

It could have been copy-edit of COPYING.2 and rename-edit of
COPYING.1 (both from COPYING).  If you make the change you are
proposing to diff-raw format, reordering diff-raw entries stops
making sense, while the current format allows us to.  

It is similar to your argument of not _recording_ renames on
commit but _tracking_ it upon inspection.  I deliberatly chose
not to record rename/copy distinction in diff-raw --- it is to
be inferred from which entry touches the src _last_.  Everything
but the last one to touch the same path is copy, and the last
one is rename.

