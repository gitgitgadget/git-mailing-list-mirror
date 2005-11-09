From: Junio C Hamano <junkio@cox.net>
Subject: Re: Comments on recursive merge..
Date: Wed, 09 Nov 2005 12:13:56 -0800
Message-ID: <7virv1efzv.fsf@assigned-by-dhcp.cox.net>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 21:14:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZwKm-0005e6-IL
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 21:14:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161217AbVKIUON (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 15:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161219AbVKIUON
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 15:14:13 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:27026 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1161217AbVKIUON (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2005 15:14:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051109201413.CYTL9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 9 Nov 2005 15:14:13 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11410>

Linus Torvalds <torvalds@osdl.org> writes:

> That "extra" check only helps once. If we ever hit the "extra--", it's 
> gone.

I think you are right here, but while digging into this I found
an interesting case.

The current show-branch code does the same as merge-base in the
pathological example depicted in merge-base.c, but they seem to
do different things to this picture (commit grows from bottom to
top, time flows alphabetically; find base between G and H).

                 H
                / \
           G   A   \
           |\ /     \ 
           | B       \
           |  \       \
            \  C       F
             \  \     / 
              \  D   /   
               \ |  /
                \| /
		 E

"git-merge-base --all" says the merge bases are B and E, while
"show-branch --merge-base" mentions only B.  In this case the
latter is probably the better answer.  Actually git-merge-base
without --all only mentions E.  This is because we give up when
we find the list elements are all uninteresting.  And this is
very expensive to fix (I recall mentioning "horizon effect" last
time we worked on this --- around August 12th).

G gets bit 1 and H gets bit 2.  Here is what happens in each
iteration:

	List			A B C D E F G H		Result
	G1 H2			- - - - - - 1 2
	H2 E1 B1		- 1 - - 1 - 1 2
	F2 E1 B1 A2		2 1 - - 1 2 1 2
	E3 B1 A2		2 1 - - 3 2 1 2		E3
	B1 A2			2 1 - - 3 2 1 2		E3
	C1 A2			2 1 1 - 3 2 1 2		E3
	D1 A2			2 1 1 1 3 2 1 2		E3
	A2			2 1 1 1 3 2 1 2		E3
	B3			2 3 1 1 3 2 1 2		E3 B3
	C7			2 3 7 1 3 2 1 2		E3 B3

We popped B with flag 3, and started contaminating the well by
reinjecting its parent C with flag 7.  That is all good, but
"while (interesting(list))" check stops us from going further.
Ideally the following two steps would have found out that E is
also uninteresting.

	D7			2 3 7 7 3 2 1 2
	E7			2 3 7 7 7 2 1 2

But that is expensive -- we would not know when to stop.

A reproduction recipe is attached here, primarily so I do not
have to worry about losing it from /var/tmp/.

-- >8 -- cut here -- >8 --
#!/bin/sh

rm -fr .git && git-init-db
T=$(git-write-tree)

M=1130000000
Z=+0000

export GIT_COMMITTER_EMAIL=git@comm.iter.xz
export GIT_COMMITTER_NAME='C O Mmiter'
export GIT_AUTHOR_NAME='A U Thor'
export GIT_AUTHOR_EMAIL=git@au.thor.xz

doit() {
	OFFSET=$1; shift
	NAME=$1; shift
	PARENTS=
	for P
	do
		PARENTS="${PARENTS}-p $P "
	done
	GIT_COMMITTER_DATE="$(($M + $OFFSET)) $Z"
	GIT_AUTHOR_DATE=$GIT_COMMITTER_DATE
	export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
	commit=$(echo $NAME | git-commit-tree $T $PARENTS)
	echo $commit >.git/refs/tags/$NAME
	echo $commit
}

checkit() {
    echo MB
    git-merge-base --all "$@" | xargs git-name-rev
    echo SB
    git-show-branch --merge-base "$@" | xargs git-name-rev
    git-show-branch --sha1-name --more=99 "$@"
}

E=$(doit 5 E)
D=$(doit 4 D $E)
F=$(doit 6 F $E)
C=$(doit 3 C $D)
B=$(doit 2 B $C)
A=$(doit 1 A $B)
G=$(doit 7 G $B $E)
H=$(doit 8 H $A $F)

checkit $G $H

exit
