From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] Make clear_commit_marks() clean harder
Date: Mon, 03 Jul 2006 02:32:32 -0700
Message-ID: <7vejx3rq33.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org>
	<7vy7vedntn.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606302046230.12404@g5.osdl.org>
	<20060701150926.GA25800@lsrfire.ath.cx>
	<7vfyhldvd2.fsf@assigned-by-dhcp.cox.net>
	<44A6CD1D.2000600@lsrfire.ath.cx>
	<Pine.LNX.4.64.0607011301480.12404@g5.osdl.org>
	<7vveqhccnk.fsf@assigned-by-dhcp.cox.net>
	<7vpsgpccak.fsf@assigned-by-dhcp.cox.net>
	<20060701232958.GC2513@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon Jul 03 11:32:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxKnF-0000yP-Qu
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 11:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbWGCJcf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 05:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbWGCJcf
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 05:32:35 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:38580 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750911AbWGCJce (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jul 2006 05:32:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060703093234.JAJQ19057.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 3 Jul 2006 05:32:34 -0400
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <20060701232958.GC2513@lsrfire.ath.cx> (Rene Scharfe's message of
	"Sun, 2 Jul 2006 01:29:58 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23168>

Rene Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Don't care if objects have been parsed or not and don't stop when we
> reach a commit that is already clean -- its parents could be dirty.

There is something quite wrong with this patch.  When you are
dealing with complex commit ancestry, this ends up traversing
the same parent over and over again.

I tried to do a merge in linux-2.6 history with these two
commits:

	v2.6.17-g29454dd
	v2.6.17-gd6b0c53

The former is Linus's head at this writing, and the latter is
James Bottomley's scsi-misc head.

	git describe 29454dd d6b0c53

from the "master" branch returns immediately (the use there can
assume that the mark is set and contiguous, I think) while the
one with this patch takes forever.

Another example is to try changing get_merge_bases() to always
clean-up as Johannes had originally and try computing the merge
base between the two.  Just before it starts to clean-up, it has
only seen 5983 objects (object.c::nr_objs) and it definitely
would be faster to clean flags from all these objects than to
wait for the two calls to clear_commit_marks() to complete,
which seems to also take forever.
