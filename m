From: Junio C Hamano <junkio@cox.net>
Subject: Re: Comments on recursive merge..
Date: Wed, 09 Nov 2005 14:56:27 -0800
Message-ID: <7virv1a0ro.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
	<20051107225807.GA10937@c165.ib.student.liu.se>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 00:00:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZysi-0003mF-FX
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 23:57:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161059AbVKIW4b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 17:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161060AbVKIW4a
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 17:56:30 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:5626 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1161059AbVKIW43 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2005 17:56:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051109225526.JVXD2059.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 9 Nov 2005 17:55:26 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511091348530.4627@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 9 Nov 2005 13:58:33 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11429>

Linus Torvalds <torvalds@osdl.org> writes:

>> 
>>                  H
>>                 / \
>>            G   A   \
>>            |\ /     \ 
>>            | B       \
>>            |  \       \
>>             \  C       F
>>              \  \     / 
>>               \  D   /   
>>                \ |  /
>>                 \| /
>> 		   E
>> 
> So I think from a correctness standpoint, the only thing that matters is 
> "git-merge-base --all", and anything that doesn't know to return both E 
> and B looks potentially buggy.

But the point of well-poisoning you did in merge-base was to
detect that E is an ancestor of B and exclude it in the first
place.  If it matters what F does, it means checking ancestry
among B C D E and declare that B is a better ancestor than C, D,
E does not help or is sometimes harmful.  No question that B is
always superiour ancestor than C and D, but arguably the
presence of F _might_ change situation for B vs E.

I however do not see merge-base trying to take that into account
and treat E differently from C and D in any way.  Only because F
and E had newer timestamp than C and D, we ended up finding E
first and did not poison E through B, and that's why you got
both B and E.  I think it was just an accident.  If F were older
than B, I suspect the result would have been very different.

> Now, this case obviously depends on history being almost maximally insane 
> (ie pretty much _all_ the dates are wrong). So in practice we probably 
> don't care.

I agree.  The above example was to answer my own question in
this message:

	http://marc.theaimsgroup.com/?l=git&m=112382448222823

> ... personally I'd much rather always do a 
> "git-merge-base --all", and only do the fast index merge if we only have 
> one potential parent.
>
> That way there would never any question about what the "quick merge" does.

I agree we should try to stay away from "heuristic" and make
things safer, but after seeing the above, I'd need a bit more
time to convince myself that what 'git-merge-base --all' does is
*the* safe approach.  Right now, it looks to me that both are
heuristic that work most of the time (merge-base --all 99.99999%
of the time, show-branch 99% of the time, or something like
that).
