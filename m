From: Junio C Hamano <junkio@cox.net>
Subject: Re: Comments on recursive merge..
Date: Tue, 08 Nov 2005 22:10:30 -0800
Message-ID: <7v7jbinyg9.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
	<20051107225807.GA10937@c165.ib.student.liu.se>
	<7vll00ov2l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511071629270.3247@g5.osdl.org>
	<Pine.LNX.4.63.0511081254520.2649@wbgn013.biozentrum.uni-wuerzburg.de>
	<20051108210211.GA23265@c165.ib.student.liu.se>
	<Pine.LNX.4.64.0511081351020.3247@g5.osdl.org>
	<20051108223609.GA4805@c165.ib.student.liu.se>
	<Pine.LNX.4.64.0511081450080.3247@g5.osdl.org>
	<Pine.LNX.4.63.0511090017370.28256@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0511081614140.3247@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 07:11:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZjAM-0002Dr-SL
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 07:10:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030398AbVKIGKe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 01:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030410AbVKIGKe
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 01:10:34 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:20974 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1030398AbVKIGKc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2005 01:10:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051109061005.NAJH4527.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 9 Nov 2005 01:10:05 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511081614140.3247@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 8 Nov 2005 16:18:53 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11386>

Linus Torvalds <torvalds@osdl.org> writes:

> In general, you need to keep track of one bit per ref, and since we have 
> a 32-bit "flags" word and need a couple of bits for other maintenance 
> info, pretty much anything that figures out common heads will be limited 
> some way. 
>
> This is only a limit for the "and" logic - the "or" logic (if we implement 
> it) will just share the same status bit for all the refs that are "ored 
> together" and thus has no limits. 
>
> Oh, and the "and" logic can be extended by running the program multiple 
> times, so it's not a "hard" limit, it's just an issue of convenience.
>
> That said, anybody who ever does an octopus of more than just a few heads 
> deserves to be shot, so I don't think the limit should matter. The 
> recursive strategy should only add the "or" kind of refs, and it 
> shouldn't be a problem (apart from just how to describe them).

Come to think of it, git-merge-octopus does AND.  If I am
merging topic branches 1, 2, 3,... N into my master, internally
it does an equivalent of merging 1 into master, then 2 into the
result, then C into that result,..., and it uses merge-base of
all the heads merged so far and the original master to pivot on.

And I think this is *wrong*.  The merge base of each step when
merging head N does not have to be older than merge base of the
original master and head N, but currently that is not what it
does.  I should be ORing them ideally, but even if I do not, I
should be able to just use the merge base of head N and original
master.
