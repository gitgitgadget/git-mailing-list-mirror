From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: More gitweb queries..
Date: Mon, 30 May 2005 10:36:53 +0200
Message-ID: <20050530083653.GL12290@cip.informatik.uni-erlangen.de>
References: <7vu0kowho9.fsf@assigned-by-dhcp.cox.net> <20050527203227.GA11139@cip.informatik.uni-erlangen.de> <20050529230240.GB12290@cip.informatik.uni-erlangen.de> <20050529231053.GD12290@cip.informatik.uni-erlangen.de> <20050529231621.GE12290@cip.informatik.uni-erlangen.de> <20050529234606.GF12290@cip.informatik.uni-erlangen.de> <20050529235630.GG12290@cip.informatik.uni-erlangen.de> <7vsm05bkps.fsf@assigned-by-dhcp.cox.net> <20050530013056.GH12290@cip.informatik.uni-erlangen.de> <7vmzqd4041.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 10:35:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dcfjc-0002PV-Kj
	for gcvg-git@gmane.org; Mon, 30 May 2005 10:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVE3IhW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 04:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbVE3IhW
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 04:37:22 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:37884 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261563AbVE3IhD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2005 04:37:03 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4U8arS8006038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 30 May 2005 08:36:54 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4U8arae006036;
	Mon, 30 May 2005 10:36:53 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmzqd4041.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

[ => Skip till next ']' if you want because my approach doesn't work out
for all cases in the optimal way.

> "An empty tree (no HEAD)"?  Is your definition of "an empty
> tree" the same as "empty" directory after you do "mkdir empty &&
> cd empty && git-init-db", followed by bunch of git-*-pull to get
> the objects and commits from other reposititories being involved
> in the merge but without touching .git/HEAD?

Yep. In practice it isn't anything else than just using the first
'remote' HEAD as 'local' HEAD if there is no 'local' HEAD. But for merge
this doesn't really matter.

> If so, why cannot I do the git-*-pull from multiple repositories and
> merge them together?  Why "there is only one head in this array that
> is remote_head"?  Oh, I guess I am missing your definition of
> "remote_head".  Puzzled...

My intention by writing this note was to clear things up. That it also
works for cases where you do the 'initial clone' for one and multiple
remotes.

> Anyhow I presume that if your ${GIT-.git}/HEAD exists, you
> include it as the first element of MERGE_HEADS.

Affirmative.

> TG> I have a function merge which gets a sorted array of heads. Heads can be
> TG> unlimited at the time because some of the heads can be included into
> TG> other heads (they're a subset) and so they don't show up in the commit
> TG> object. I call this array MERGE_HEADS.

Here is a typo: MERGE_HEADS is *not* sorted. But it is 'ordered'.

> Sorry I am not very good at this "thinking" thing, and I need to
> draw pictures.  Please bear with me.

Of course, I do.

>     (line of dev C)-------------C    We are here, trying to merge
>     (line of dev B)---(merge)---B    these three lines of devs:
>     (line of dev A)---A/             A, B and C

>     MERGE_HEADS = (A B C)
>     A is actually a "subset" of B

> Is this what you mean by "subset"?  Are these "subset" HEAD the
> only thing that causes fast forwards?

Exactly, but it has not to be a merge it also can be a linear
development. What matters that A is referenced in any way in the history
of B.

In this case where A is referenced in the history of B, we just discard
HEAD A, because it is already merged. So A will never show up in
git-commit-tree in one of its "-p" options. But I mention it in the
commit-text as 'there was nothing todo'.

If we take now your example and switch the order A and B we have

MERGE_HEADS = (B A C) and A is still in the history of B:

We do exactly the same here only that in the above scenario we have to
kick out the previous COMMIT_HEAD when processing B while we drop the
current COMMIT_HEAD when processing A in this scenario. So to clear
things up:

The HEAD we are working on is surrouned by '*'s.

MERGE_HEADS = (*B* A C) => COMMIT_HEADS = (B)
MERGE_HEADS = (B *A* C) => COMMIT_HEADS = (B) /* note: A never did it in COMMIT_HEADS because it was referenced in history of B */
MERGE_HEADS = (B A *C*) => COMMIT_HEADS = (B C)

while in the above example with your initial order it is:

MERGE_HEADS = (*A* B C) => COMMIT_HEADS = (A)
MERGE_HEADS = (A *B* C) => COMMIT_HEADS = (B) /* note: A is kicked out of COMMIT_HEADS ... see above */
MERGE_HEADS = (A B *C*) => COMMIT_HEADS = (B C) 

]

> My gut feeling without thinking much is that it might be easier
> to first cull such fast forward heads by using N-way rev-tree
> before you do anything else.  If only one head survives after
> that, then that head would be your new head and you do not have
> to go through any merges.  Otherwise you merge those independent
> heads without worrying about fast forwards.  How does that
> sound?

You're right. Because this would work out bad (unneccessary
automatic/threeway/manual merge) if we twist MERGE_HEADS again:

MERGE_HEADS = (*C* A B) => COMMIT_HEADS (C)
MERGE_HEADS = (C *A* B) => COMMIT_HEADS (C A) /* A stays in because it is not in the history of C; -> unneccessary merge */
MERGE_HEADS = (C A *B*) => COMMIT_HEADS (C A B)

Okay, so I have to elminate all fast forward conditions in the first
place? How do I do this:

foreach CURRENT_HEAD (@MERGE_HEADS) {
	foreach COMPARE_HEAD (@MERGE_HEADS) {
		if (COMPARE_HEAD != CURRENT_HEAD
		&&  COMPARE_HEAD is_included_into_history_of CURRENT_HEAD) {
			@WIPE_HEADS += COMPARE_HEAD;
		}
	}
}

foreach (@WIPE_HEADS) {
	grep -v @WIPE_HEADS @MERGE_HEADS;
}

	Thomas
