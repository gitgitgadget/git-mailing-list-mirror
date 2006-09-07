From: Junio C Hamano <junkio@cox.net>
Subject: Re: Change set based shallow clone
Date: Thu, 07 Sep 2006 15:07:07 -0700
Message-ID: <7vpse7tjp0.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910609071252ree73effwb06358e9a22ba965@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 08 00:07:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLS1a-0000x8-Qx
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 00:07:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbWIGWHA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 18:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751904AbWIGWHA
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 18:07:00 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:42881 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751901AbWIGWG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 18:06:57 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060907220657.NHKB2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Thu, 7 Sep 2006 18:06:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Ka6n1V00t1kojtg0000000
	Thu, 07 Sep 2006 18:06:50 -0400
To: "Jon Smirl" <jonsmirl@gmail.com>
In-Reply-To: <9e4733910609071252ree73effwb06358e9a22ba965@mail.gmail.com> (Jon
	Smirl's message of "Thu, 7 Sep 2006 15:52:59 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26661>

I've been postponing thinking about shallow clones with a plan
to do so when I have absolutely nothing else to do for a solid
few days.  Since my time is booked pretty much full with day job
and the ongoing pack-file topics these days, I will most likely
stick to that plan after I finish this message.

Not because I think it is an insignificant problem at the fringe
(I did not say "when I have nothing better to do"), but because
I feel this is something important (and hard) that requires
"think about it and only about it straight through for a few
days, dropping everything else" kind of thinking.

When you have a ref under .git/refs/ pointing at an object, you
are making this assertion:

        The object store associated with this repository
        (usually, .git/objects and alternates pointed at by
        .git/objects/info/alternates) holds _all_ objects that
        are recursively reachable from this object by following
        tag reference, commit ancestry chain, commit to its
        tree, and tree to its subtrees and blobs.

So by definition, a shallow clone is a broken/incomplete
repository.  Unless we fix the breakage in some way.

One way to do so which has often been talked about is to use the
grafts facility.  You cut off the history at some commit, and
cauterize the commit ancestry chain at that point by telling git
to pretend that the commit does not have any parent.  While this
would work after setting it up, in the sense that "git log"
would stop at the commit and "git fsck-objects" would say
nothing is missing, it is cumbersome to set up, we do not have
an easy way to fetch (or clone -- but clone is a special case of
fetch where the downstream starts out from emptiness) from such
a repository, unplugging to get histories further back with
a later fetch is quite involved, and it is not clear what it
means to further fetch from such a shallow clone.

Where does the difficulty in fetching come from?  Mostly because
the upload side and download side needs to agree on the altered
history.

Let's say the download side is empty and somehow tells the
upload side that it wants the latest 5-commit worth of stuff
starting from the tip:

 - The upload side runs

        rev-list --objects HEAD~5..HEAD | pack-objects --stdout

   to give you the needed data.  This is almost [*1*] doable by
   telling it that you have HEAD~5.

 - Also the upload side can say "pretend that this commit HEAD~4
   has no parent, although cat-file on it would say otherwise".

 - The downloader creates a suitable grafts file to cauterize
   commit HEAD~4.

Is this enough?  Hardly.

Consider:

 o---o---o---o---o---*---*---*---*---*
          \      ^              /    ^ 
           \   HEAD~5          /    HEAD
            \                 /
             o---o---*---*---*
                 ^           ^
             HEAD^^2~3     HEAD^^2

5-commit request should apply to send '*' commits, so the
original "HEAD~5..HEAD" was bogus to begin with.  You have to
say "HEAD --not HEAD~5 HEAD^^2~3" to get the above.

Coming up with this restriction needs to be done on the upload
side.  Doing so on the download side means it needs to retrieve
the recent "real" history to do that computation to come up with
where to cut things off, which is crazy.

However, it may be that the above graph is not what the usual
downloader wants.  If the upload side is _the_ official
repository of some sort that merges in subsystem branches, and
if you are mostly interested in the official repository's
history, you might have meant to ask this with your 5-commit
request instead:

 o---o---o---o---o---*---*---*---*---*
          \      ^              /    ^ 
           \   HEAD~5          /    HEAD
            \                 /
             o---o---o---o---o
                             ^
                           HEAD^^2

That is, you would want to cauterize the side branch.  The pack
needs to be built with "HEAD --not HEAD~5 HEAD^^2", and the
cauterize instructions would say "HEAD~4 has no parent, HEAD^
has only one parent that is HEAD~2", instead of saying just
"HEAD~4 has no parent."

So whoever is computing this cauterization point has a policy
decision to make, because the meaning of "5-commits away" or
"recent 10 days" are very fuzzy when merges are involved.

It obviously is easy to declare that the policy decision is
solely made on the uploader side, from the implementation point
of view, but I do not offhand know what the ramification of that
decision is.

Oh, about "recent 10 days".

The side branch might be an very old development that were
merged recently into the mainline.  From mainline's point of
view, everything that happened on the side branch is something
new to him (think of Linus pulled from Jeff who has been cooking
his stuff for quite some time).  Looking at each individual
commit on the side branch, however, they have older commit and
author timestamps.  If you pick "I want mainline's point of
view", that means you need to compute (in the above picture):

  - notice commit timestamp of HEAD^ (the merge) is within the
    recent 10-day window.

  - using HEAD^^1 (supposedly the state of the mainline before
    the merge happened [*2*]) and HEAD^^2 (side branch),
    compute:

        rev-list HEAD^^1..HEAD^^2

    the results are the "new" ones that appeared when the merge
    was made, so they are within the recent 10-day window from
    the mainline's point of view.  Include them.

What that means is, assuming that HEAD~5 is also the 10-day
cut-off point on the mainline, and HEAD^ is recent, we would
send this:


 o---o---o---o---o---*---*---*---*---*
          \      ^              /    ^ 
           \   HEAD~5          /    HEAD
            \                 /
             *---*---*---*---*
                             ^
                           HEAD^^2

I'll leave it as an exercise to the readers to Come up with the
pack generation specification and cauterizing instructions to
give to the downloader, but you see how quickly this becomes
very complex, and we still haven't talked about the above when
multiple merge bases are involved.

Thinking about it a bit more, maybe "from mainline's point of
view" policy would include the same entire side branch when
limiting by depth of commits.  After all the whole side branch
was something new when HEAD^ merge was created.  But that is
another policy decision.  And the downloader side cannot make
that decision before seeing what the true ancestry graph looks
like.

Let's say we somehow managed to make a shallow clone.  The
downloader has '*' commits:

 o---o---o---o---o---*---*---*---*---*
          \      ^              /    ^ 
           \   HEAD~5          /    HEAD
            \                 /
             o---o---*---*---*
                 ^           ^
             HEAD^^2~3     HEAD^^2

In the meantime, the uploader side made some more commits:

                 x---x---x---x---x---x
                /                     \
               /                       \
              /                         \
 o---o---o---F---o---*---*---*---*---H---x---X
          \                     /
           \                   /
            \                 /
             o---o---*---*---*

Now the downloader wants to update.  How does that go?

 - The uploader says the tip is at X

 - The downloader says it has old HEAD (H), H^, ...

 - Suppose the development on the new side branch recently
   merged did not touch most of the files since it forked from
   the mainline at F, but the mainline made lot of changes that
   were not touched by commits 'x', which is now part of the
   downloader's history.  The uploader, if it did not know the
   downloader has altered history, would take "have H" from the
   downloader to mean "the other side has everything reachable
   from H", so it would compute X..H (commits that are not in H
   but in X and trees and blobs needed to complete them).  But
   that can leave out the trees and blobs that existed in F (and
   was part of commits on the new side branch).

 - So the uploader side needs to know how the history on the
   downloader's side is altered from reality when interpreting
   "have H".  It does not mean "H and all the history behind it"
   to the uploader anymore.

One way to do so is to send grafts information from downloader
to uploader.  If the uploader _knows_ that the altered history
ends at the leftmost '*' commit on the mainline, then it can 
take it into account the fact that the downloader does not have
commit 'F'.  That, however, introduces another problem.  Where
should it stop?  Obviously X needs to be sent, so is X^, but
how do we know which 'x' commit to stop at?  Do we record the
initial cut-off criteria (remember, we started the clone with
5-commit cutoff) somewhere in the downloader's repository and
send that to the uploader so that the uploader can apply the
same rule to include only 5 commits from the new side branch?
What happens if there are less than 5 commits on that new side
branch?  Would we end up including 'F', which the downloader
specifically did not want when making this shallow clone
initially?

I won't go into the details, but when you think about what needs
to happen when fetching _from_ a shallow clone (i.e. the
uploader side is incomplete), your head will explode ;-).  It is
solvable in the same sense that you can solve the previous
"fetching to update" problem by trying to define a reasonable
semantics to the operation by answering the questions I posed in
the above paragraph (which obviously is no way an exhaustive
set), but the result will be quite complex.  It would involve
sending graft information both from uploader and downloader
(after all the downloader side can also be shallow but with
different cut-off points from the uploader) and somehow coming
up with the intersection of both to arrive at a shared view of
altered history before starting the traversal to find what to
send.

Also often people would want to deepen history (i.e. fetching
older history than initially fetched) after "checking out only
the tip".  It is a reasonable request, and is somewhat easier
problem to solve than the initial shallow clone problem.  If you
have a working initial shallow clone, essentially you can:

 - Find the earlier cut off points by looking at your own grafts
   file;

 - Ask the uploader to clone shallowly from the parents missing
   from your repository.

and update the resulting grafts information.

Anyway, it is a useful feature, an important operation, and
it involves a lot of thinking (and hard work, obviously).

I will not think about this anymore, until I have absolutely
nothing else to do for a solid few days, but you probably
haven't read this far ;-).

        -jc

*1* Currently there is no way to find out what HEAD~10 is during
the initial protocol handshake, but this message is mostly about
potential protocol update needs.

*2* First parent of a merge is _usually_ what the repository
owner saw, i.e. the mainline merging side branch into it, but
that is not universally true when fast forwards are involved.
