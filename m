From: Junio C Hamano <junkio@cox.net>
Subject: On recording renames
Date: Fri, 03 Mar 2006 20:03:32 -0800
Message-ID: <7vfylyx3e3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paul@hibernia.jakma.org
X-From: git-owner@vger.kernel.org Sat Mar 04 05:05:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFO0p-0008NU-8D
	for gcvg-git@gmane.org; Sat, 04 Mar 2006 05:04:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776AbWCDEDf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Mar 2006 23:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbWCDEDf
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Mar 2006 23:03:35 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:49843 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751776AbWCDEDe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Mar 2006 23:03:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060304040338.RJPD25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 3 Mar 2006 23:03:38 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17168>

Recently some people said "I want to tell git that I renamed
fileA to fileB" on the list and #git channel, and I made some
vague comments on the issue that might have confused people.
This message is to clarify where I stand.

First of all, I understand some people "want to tell git", but
at the same time, I know very well that "git does not even want
to hear".  It does not care about names -- it only tracks
contents [*1*].

Having said that, there are at least two cases that renamed
files matter in practice from the end user's point of view.
Diff and merge.

For diff, it is often __very__ frustrating when you know you
renamed hello.c to world.c and then edited just a bit and "git
diff -M hello.c world.c" does not notice.  You can do one of two
things to help:

 (1) figure out why git (diffcore-rename) does not think they
     are similar enough, and improve its similarity estimator.
     Some of you who are paying attention to what is in my
     "next" branch might have noticed that I have been working
     in this area recently.

 (2) add a way to tell git-diff-files to compare hello.c in the
     index with working tree file world.c:

     	$ git-diff-files -p 'hello.c->world.c'

And people who "want to tell git" are after the second way.
Although this can probably be implemented as an extension to
diffcore-rename [*2*], I have to say that is kludging around the
real problem.  Only as a workaround for pathological cases it
may be OK, but I am really reluctant to accept such a change
without trying avenue (1) first.

About merge.  Currently recursive merge strategy claims to
handle renames and I've seen it handle renames well in some
cases.  However, it only uses three trees.  The rename between
merge base and one head, and the rename between merge base and
the other head are computed, compared and usual three-way merge
rules are applied (e.g. if you kept it there while she moved it
to somewhere else, result is to move it to somewhere else).  If
two development tracks forked long time ago are being merged,
and corresponding files deviated from each other beyond
recognition, there is no way for any heuristics to figure out
one is a rename-edit of the other only by looking at these three
trees:

       a1--a2--a3--a4--a5--A
      /                     \
  ---O---b1--b2--b3--b4--B---* 

    O has hello.c
    a1 renames file hello.c to world.c and a2-a5-A modifies world.c
    b1-b4-B modifies hello.c 
    we are about to merge A and B

    comparing O and A may not notice O's hello.c and A's world.c
    are similar!

But you are allowed to write a new merge strategy that is more
careful about renames.  There is no reason you can only look at
three trees.  Such a merge strategy, when given commit A and B,
would walk the history back, running "diff-tree -M" for each
commit along the way, and difference between O's hello.c and
a1's world.c would be hopefully *much* smaller than O's hello.c
and A's world.c -- even the current similarity estimator may
recognize it is a rename.

That is the first thing I'd like to see.  I do not want to even
think about recording renames in commit objects before anybody
explores that avenue.

Even with that, if O's hello.c and a1's world.c are _so_
different that if the changes are beyond recognition, you
_might_ want to "tell git" about the rename, or even record such
a rename in the commit object a1.  But I personally doubt it
would help anything in practice.  After such a huge rewrite
between O->a1, merging between A and B will be very hard anyway,
and you would need some off-line method to extract the intention
of the developer who originally did a1 commit while merging A
and B.  And when you inspect that change yourself, you may
decide O's hello.c correspond to a1's world.c yourself.  At that
point you will be hand merging the mess, so your being able to tell
git about it would not help you much.


[Footnotes]

*1* This is by design, and I am not going to debate if that is a
good design or not here.  There is a "Linus once said 'you say
users know better but users cannot be trusted -- trust me'"
factor involved.  I am a trusting kind and somebody needs to
convince me not to trust Linus.

*2* You would supply "in what you are comparing, the source path
hello.c and destination path world.c are similar with similarity
index 80% -- do not bother to estimate yourself, I am telling
you their similarity index so trust me".

	$ git-diff-files -p -M --similarity='hello.c world.c 80%'
