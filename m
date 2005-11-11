From: Junio C Hamano <junkio@cox.net>
Subject: Re: merge-base: fully contaminate the well.
Date: Fri, 11 Nov 2005 00:28:56 -0800
Message-ID: <7v8xvvr3jr.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
	<7vll00ov2l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511071629270.3247@g5.osdl.org>
	<Pine.LNX.4.63.0511081254520.2649@wbgn013.biozentrum.uni-wuerzburg.de>
	<20051108210211.GA23265@c165.ib.student.liu.se>
	<Pine.LNX.4.64.0511081351020.3247@g5.osdl.org>
	<20051108223609.GA4805@c165.ib.student.liu.se>
	<Pine.LNX.4.64.0511081450080.3247@g5.osdl.org>
	<20051109003236.GA30496@pasky.or.cz>
	<Pine.LNX.4.64.0511081646160.3247@g5.osdl.org>
	<7vlkzyd4aq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511081716450.3247@g5.osdl.org>
	<7v8xvyd2bh.fsf@assigned-by-dhcp.cox.net>
	<7v4q6mgm1l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511090800330.3247@g5.osdl.org>
	<7virv1efzv.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511091348530.4627@g5.osdl.org>
	<7virv1a0ro.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511091518370.4627@g5.os
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 09:30:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaUHm-0000WN-Pj
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 09:29:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbVKKI3R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 03:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbVKKI3Q
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 03:29:16 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:143 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932220AbVKKI26 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 03:28:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051111082830.ICKC4527.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 11 Nov 2005 03:28:30 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511102125510.4627@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 10 Nov 2005 21:36:03 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11574>

Linus Torvalds <torvalds@osdl.org> writes:

> Btw, I don't think your contamination logic is necessarily complete. We 
> may not even have parsed some of the commits that end up being on that 
> strange corner case....

You are right.  And the situation seems really bad.

The full-contaminator is not full at all, and fails miserably in
not so pathlogical case.  If we have something like this:

	1	2	List		A B C D E F G
	F	E	F1 E2		- - - - 2 1 -
        |\     /|	G1 E2 D1 C1	- - 1 1 2 1 1
        \ \   / |	E2 D1 C1	- - 1 1 2 1 1
        |\  D  /|	G3 D3 C3	- - 3 3 2 1 3
        | \ | / |	D3 C3		- - 3 3 2 1 3
        |   C   |	C7		- - 7 3 2 1 3
        |   |   |
        |   B   |
        |   |   /
         \  A  /
          \ | /
            G

we would end up finding D and G and stop there, without ever
seeing A or B.  B _might_ be touched when we look at C at the
last round, but there is no way for us to find G is reachable
from D (or C) without parsing more than what we parsed in the
main loop.

The worst part of this is that you can indefinitely extend C-B-A
chain trivially, and all it takes is the one, initial commit G,
that has a screwed-up timestamp.  All the other commits in this
example are in the right time order.  Very sad.
