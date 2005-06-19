From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: git-rev-list: "--bisect" flag
Date: Mon, 20 Jun 2005 00:41:41 +1000
Message-ID: <2cfc40320506190741409f3a5@mail.gmail.com>
References: <Pine.LNX.4.58.0506172306210.2268@ppc970.osdl.org>
	 <2cfc403205061817181e4d6d5e@mail.gmail.com>
	 <Pine.LNX.4.58.0506182022130.2268@ppc970.osdl.org>
	 <Pine.LNX.4.58.0506182141400.2268@ppc970.osdl.org>
	 <2cfc403205061903155a6090db@mail.gmail.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sun Jun 19 16:36:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dk0uX-0000f7-9b
	for gcvg-git@gmane.org; Sun, 19 Jun 2005 16:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262209AbVFSOl5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Jun 2005 10:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262233AbVFSOl5
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jun 2005 10:41:57 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:34367 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262209AbVFSOlo convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2005 10:41:44 -0400
Received: by rproxy.gmail.com with SMTP id i8so430840rne
        for <git@vger.kernel.org>; Sun, 19 Jun 2005 07:41:42 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Av3juZH1YL1WkmN6ydITBgq1oU3QatvTPNriNrMrlmeDBMPwwIbtxzQjQvxApDPX7c9T37m72LQxEueZnYPEX9DIdE4t5rLhNnTocVXPmGF2l/3RMeKuAhNbLqjasWXC83BKxmV5+0hJ1seNVSe39T1zqJiAFfl0WhGQYkWOIW4=
Received: by 10.38.88.14 with SMTP id l14mr1835986rnb;
        Sun, 19 Jun 2005 07:41:41 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Sun, 19 Jun 2005 07:41:41 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <2cfc403205061903155a6090db@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus,

Would I be correct in stating that an intuitive  reason why your
algorithm is better than selecting the linear middle is the following:

If you concentrate on testing merges, rather than non-merges, the
chances are you are going to eliminate N-times as many possible good
commits as if you pick a random commit, where N is the average fan-out
of the commit graph.

With the linear middle algorithm, it doesn't really matter if you pick
a child of a merge - that is almost as good as picking the merge
itself. But if you happen to pick a parent of merge, then if it is
good and the parent is also good, you have wasted the opportunity to
clean up the peer branches of the parent you chose.

So the heuristic should be:

- focus on branches until there are no  branches left, then keep
bisecting the list that remains.

Building on this insight, though, I'd like to point out that if you
want to eliminate things on a large scale, the things to focus on
first are epoch boundaries. Epoch boundaries are defined in such a way
that if an epoch boundary is good then everything reachable from an
epoch boundary is also good [ assuming exactly one fault ].

If you happen to choose a child of an epoch boundary, that's ok on
one-level, but on another level it's not ok. In particular, you
haven't eliminated everything beyond the epoch boundary so the open
list will be longer than it strictly needs to be.

So, I propose a modification to my "linear middle" bisection algorithm
 as follows:

If there is more than one epoch boundary in the interesting graph,
choose the literal middle epoch boundary, otherwise, if there is more
than one merge in the interesting graph, chose the literal middle
merge, otherwise if there are no merges in the interesting graph,
choose the literal middle of the remaining list.

I am going to build a version of my linear middle code that
demonstrates this algorithm and then test it against the Linux 2.6
kernel.

FWIW: my measurements of your algorithm thus far show that if the bug
exists in the first 1070 of the 2119 commits between HEAD and
v2.6.12-rc2 it consistently (very consistently) takes between 11 and
13 iterations of git-bug-blatt-script to find the bug.

Specifically: average (12.10), median (12), stdev(0.412), max(13), min(11).

This compares with my naive literal middle algorithm (measurements
only for the first 619 commits):

average(21), median(16), stdev(10.6), max(49), min(8).

The number of commits is 2118, the number with a fanout > 1 is 173.
The average fanout of those with fanout is 2. My average is currently
2 times worse than yours and my worst case is 4-5 times worse than
yours.

So, you will be pleased to know that your intuition about the
correctness of your own algorithm has been objectively verified.

My intuition at this point is that my revised algorithm won't
significantly differ from your algorithm. I am thinking it will
require ~ 3 epoch boundary tests to identify the relevant epoch, 5
merge tests to identify the relevant segment and 4 bisections of a
linear segment to identify the correct merge which ends up being 12
iterations of the bug-blatt algorithm which really is no different to
yours. I suspect my algorithm might be better for really, really, big
repositories,  with long histories, but I judge that the chance an
interesting bug will be deep in the long history is somewhat remote.

Both algorithms will benefit, however, if the intuition that most bugs
are recent is correct. git-bug-blatt-script could be modified to test
the first epoch boundary before recursively bisecting things. This
will make the typical bug search ~ 9 iterations long (since the
average epoch appears to be less than 512 commits  and more than 256
commits big).

jon.
