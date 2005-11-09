From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Comments on recursive merge..
Date: Wed, 9 Nov 2005 15:34:49 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511091518370.4627@g5.osdl.org>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
 <20051107225807.GA10937@c165.ib.student.liu.se> <7vll00ov2l.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0511071629270.3247@g5.osdl.org>
 <Pine.LNX.4.63.0511081254520.2649@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051108210211.GA23265@c165.ib.student.liu.se> <Pine.LNX.4.64.0511081351020.3247@g5.osdl.org>
 <20051108223609.GA4805@c165.ib.student.liu.se> <Pine.LNX.4.64.0511081450080.3247@g5.osdl.org>
 <20051109003236.GA30496@pasky.or.cz> <Pine.LNX.4.64.0511081646160.3247@g5.osdl.org>
 <7vlkzyd4aq.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511081716450.3247@g5.osdl.org>
 <7v8xvyd2bh.fsf@assigned-by-dhcp.cox.net> <7v4q6mgm1l.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0511090800330.3247@g5.osdl.org> <7virv1efzv.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0511091348530.4627@g5.osdl.org> <7virv1a0ro.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 00:36:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZzT3-0003AF-2N
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 00:35:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbVKIXe5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 18:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751585AbVKIXe5
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 18:34:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64384 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751030AbVKIXe4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Nov 2005 18:34:56 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jA9NYpnO004535
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 9 Nov 2005 15:34:52 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jA9NYnFM022073;
	Wed, 9 Nov 2005 15:34:50 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virv1a0ro.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11440>



On Wed, 9 Nov 2005, Junio C Hamano wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
> >> 
> >>                  H
> >>                 / \
> >>            G   A   \
> >>            |\ /     \ 
> >>            | B       \
> >>            |  \       \
> >>             \  C       F
> >>              \  \     / 
> >>               \  D   /   
> >>                \ |  /
> >>                 \| /
> >> 		   E
> >> 
> > So I think from a correctness standpoint, the only thing that matters is 
> > "git-merge-base --all", and anything that doesn't know to return both E 
> > and B looks potentially buggy.
> 
> But the point of well-poisoning you did in merge-base was to
> detect that E is an ancestor of B and exclude it in the first
> place.

Ahh, you're right, and I'm wrong. That "E" is not a real merge-base, since 
there _is_ a valid merge-base that is a direct descendant of it and thus 
objectively better.

And as to why git-merge-base returns E in the first place: it really 
shouldn't, but when it sees B, it can decide that C is uninteresting, and 
so there are no interesting commits left. So it never continues to walk D 
and thus never notices that D covers E and E is _also_ uninteresting.

So it thinks both E and B are interesting, and since E has a more recent 
date, it will select that one when only showing one (and then show both 
when asked to).

> I however do not see merge-base trying to take that into account
> and treat E differently from C and D in any way.

It doesn't. git-merge-base simply walks the chain in as close to date 
order as it can, and when it decides that the rest of the chain is 
provably uninteresting, it stops.

Which means that sometimes it can stop with too _many_ merge heads, just 
because it hasn't realized that they are reachable through a chain that is 
otherwise provably uninteresting.

This is because we define "uninteresting" as meaning "cannot reach any 
more _new_ merge-heads". Which is true. The fact that such a chain could 
reach some heads we found earlier and mark them as being pointless never 
enters the picture ;)

> I agree we should try to stay away from "heuristic" and make
> things safer, but after seeing the above, I'd need a bit more
> time to convince myself that what 'git-merge-base --all' does is
> *the* safe approach.

Well, "git-merge-base --all" will be "safer" in the sense that it's 
guaranteed to give a superset of the merge-heads (which itself is "safe" 
in that it flags potentially interesting cases early).

Then, the recursive merge strategy could notice (in fact, _will_ notice, 
if it tries to merge the merge-heads) that the merge of such a pair of 
merge-heads is one of the heads itself (just a fast-forward), and thus the 
recursive strategy should correctly have chosen "B" as the merge-head.

So yes, "git-merge-base --all" really is safe. Sometimes (under fairly odd 
circumstances) a bit unnecessarily conservative, but always safe.

> Right now, it looks to me that both are heuristic that work most of the 
> time (merge-base --all 99.99999% of the time, show-branch 99% of the 
> time, or something like that).

The thing is, I don't see what guarantees that the show-branch brhaviour 
is safe or conservative. It happened to pick B in this case, which was the 
right choice, but I don't see how that was anything but just luck and 
happenstance.

IOW, I can see that "git-merge-base --all" can return some unnecessary 
heads, but I can also argue for how that becomes safe and fixes itself. 
With git-show-branch --merge-base, I don't know what that argument is, 
because I can't see how it _guarantees_ that it would always pick B over 
E.

			Linus
