From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links
Date: Mon, 24 Apr 2006 22:16:08 -0700
Message-ID: <7vwtde2q1z.fsf@assigned-by-dhcp.cox.net>
References: <20060425035421.18382.51677.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 25 07:16:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYFuW-0005uK-5b
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 07:16:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWDYFQQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 01:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWDYFQQ
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 01:16:16 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:25851 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751397AbWDYFQL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Apr 2006 01:16:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060425051610.GOSV27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 25 Apr 2006 01:16:10 -0400
To: Sam Vilain <sam.vilain@catalyst.net.nz>
In-Reply-To: <20060425035421.18382.51677.stgit@localhost.localdomain> (Sam
	Vilain's message of "Tue, 25 Apr 2006 15:54:21 +1200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19128>

Sam Vilain <sam.vilain@catalyst.net.nz> writes:

> Examples of use cases this helps:

My reaction to this patch series is that you try to cover quite
different and unrelated things, without thinking things through,
and end up covering nothing usefully.  What is missing in these
"use cases" is a coherent semantics.

What the "prior" means to humans and tools.  And my *guess* of
what they mean suggests you are trying to make it mean many
unrelated concepts.

>  1. heads that represent topic branch merges
>
>     This is the "pu" branch case, where the head is a merge of several
>     topic branches that is continually moved forward.

For usage like "pu", the previous "pu" head could be recorded as
one of the parents; you do not need anything special.

The reason I do not include the previous head when I reconstruct
"pu" is because I explicitly *want* to drop history -- not
having to carry forward a failed experiment is what is desired
there.  Otherwise I would manage "pu" just like I currently do
"next" and "master".  So this is not a justification to add
something new.

>  2. revising published commits / re-basing
>
>     This is what "stg" et al do.  The tools allow you to commit,
>     rewind, revise, recommit, fast forward, etc.

stg wants to have a link to the fork-point commit.  I do not
know if it is absolutely necessary (you might be able to figure
it out using merge-base, I dunno).

>     In this case, the "prior" link would point to the last revision of
>     a patch.  Tools would probably

Probably what...???

>  3. sub-projects
>
>     In this case, the commit on the "main" commit line would have a
>     "prior" link to the commit on the sub-project.  The sub-project
>     would effectively be its own head with copied commits objects on
>     the main head.

You say you can have only one "prior" per commit, which makes
this unsuitable to bind multiple subprojects into a larger
project (the earlier "bind" proposal allows zero or more).

When you, a human, see a "prior" link in "git cat-file commit"
output, what does that tell you?  Is it "the previous commit
this thing replaces?"  Or is it a commit in a different line of
development which is its subproject?  Or is it a commit that was
cherry-picked from a different line?  How would you tell?  And
assuming you _could_ somehow tell, how would it help you to know
it?

When the Plumbing and the Porcelain sees a "prior" link, what
should they do?  It hugely depends on what that link means.  You
have a patch to merge-base to include the prior commit of the
commit in question in the ancestry chain, but that is probably
valid only for case 1. and perhaps 2. If the link points at a
commit of otherwise unrelated subproject head, you would _never_
want to include that in the merge-base computation.  Neither the
"this commit was taken out of context from otherwise unrelated
branch" link you envision to use for 4.  I think including
"prior" to ancestry list for case 1. and 2. makes some sense in
the merge-base example only because (1) it does not have to be any
different from an ordinary "parent" to begin with for case 1.,
and (2) it points at fork-point which is sort of a merge-base
already.

There may be some narrower concrete use case for which you can
devise coherent semantics, and teach tools and humans how to
interpret such inter-commit relationship that are _not_
parent-child ancestry.  For example, if you have one special
link to point at a "cherry-picked" commit, rebasing _could_ take
advantage of it.  When your side branch tip is at D, and commit
D has "this was cherry-picked from commit E" note, and if you
are rebasing your work on top of F:

        A---B---C---D
       /
  o---o---E---F

the tool can notice that F can reach E and carry forward only A,
B, and C on top of F, omitting D.  So having such a link might
be useful.  But if that is what you are going to do, I do not
think you would want to conflate that with other inter-commit
relationships, such as "previous hydra cap".

Oh, and you would need an update to rev-list --objects and
fsck-objects if you are to add any new link to commit objects.
Otherwise fetch/push would not get the related commits prior
points at, and prune will happily discard them.  But before even
bothering it, you need to come up with a semantics first.
