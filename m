From: Junio C Hamano <gitster@pobox.com>
Subject: Re: who's on first? - following first parent and merge-management
Date: Wed, 07 Mar 2012 22:13:46 -0800
Message-ID: <7vty1zfwmd.fsf@alter.siamese.dyndns.org>
References: <jj6s47$m98$1@dough.gmane.org>
 <7vwr6woo8p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 07:14:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5Wbr-0001d1-LG
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 07:13:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753012Ab2CHGNu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 01:13:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65048 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751607Ab2CHGNt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 01:13:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B07177F6;
	Thu,  8 Mar 2012 01:13:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=ORQvunH4EyrrbLdPYUS748UL4V0=; b=iu7sIHVMJnOEtmnaKFSa
	OXAt/PedG1+JnKOJiOzFAqwT48+Kts5jn+Y7t/SdnkVlBtRLeQZBbEJ4pNcDIWct
	GsjGAEgLU9N/lcRqxwsJwvThs4+iHe+yYPI1BfVnerbtZW7oBa0I1pep+KWaPOj+
	mDzypCoyLMHFs58F9DoaSVA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=PAV+rVuMVO1j0hbLR/UBPvyFX1TKhzyZE9jU4IKftVrH87
	dLM7DtxxfQX4ETcWfDqIn0unF2DDU4PAnQX6hIBO3LxtdjL691ROD22N3I1RxdGn
	HqTI/ShEeL+v5XdyFCkFHsFT9RvMRGaCHc/OgJyEfd3xSSxycpUrHP6+lXc58=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81FEC77F5;
	Thu,  8 Mar 2012 01:13:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B476977F4; Thu,  8 Mar 2012
 01:13:47 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DDE687FA-68E5-11E1-B815-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192523>

Junio C Hamano <gitster@pobox.com> writes:

> The mechanical definition of "first parent" is that:
>
>  - A merge is a commit with more than one parent.
>
>  - When you run "merge", you are on one commit, HEAD, taking changes
>    made by "other branches" you are merging into "your history"
>    (whose definition is "the commit-dag leading to your HEAD
>    commit"), and record the resulting tree as a new commit.
>
>  - This new commit records all its parents, one of them being your
>    old "HEAD" and the rest being "other branches" you merged into
>    "your history".  They are recorded in that order in the resulting
>    commit ("git cat-file commit HEAD" after a merge to see them).
>
> Hence, the first parent of a merge is the HEAD the committer was at
> when s/he ran "git merge".

Given the above definition, the first thing to realize is that "the
first parent" is primarily a local concept.  If you are looking at
one commit on a run of "a single strand of pearls", it only has one
parent (i.e. its first parent), and it is the state the committer
was on when he made the commit.  If you are looking at a merge, its
first parent is the commit the person who made that merge was on.

Because of this local nature of first-parenthood, depending on the
way how your project works, following the first parent chain all the
way down to the root, i.e. "git log --first-parent", may or may not
give an output that makes sense.  "git show HEAD~250" has the same
issue.

An extreme example is where Git is used merely as a better CVS,
where everybody works on his own "master", e.g.

    $ git clone $central mine && cd mine
    ... begin repeating from here ...
    $ git pull ;# this may get "already up-to-date" or create a merge
    $ work; work; work; git commit
    $ work; work; work; git commit
    $ git pull ;# this may create a merge or get "already up-to-date"
    ... optionally ...
    $ git push
    ... go back and repeat ...

Imagine many people are doing the above simultaneously against the
same shared central repository.

Because everybody can create a "merge" when he is on his latest
commit that may not even yet be ready for other's use, the first
parent of a merge has no significance in the history of the overall
project. The first parents of merges in such a project are "points
at which random members of the project happened to be immediately
before s/he pulled from the shared central repository".  When you
want a birds-eye view of changes between two versions of a project,
"git log --first-parent v1.0..v2.0" gives no useful information in
such a project.  "git log --no-merges" or even "git shortlog" over
the same range would generally work better.

Insisting on "git pull --no-ff" in such a workflow makes things even
worse for "first-parent summary".  If everybody else were active
while you were sleeping, and if you were up-to-date before going to
bed, "git pull --no-ff" you do as the first thing in the morning
from a habit will record a useless merge commit, and the _only_ two
things such a commit records are (1) where the tip of the shared
central repository was before you went to bed, and (2) where the tip
of the shared central repository was when you came back to work.
Neither is worth recording as part of the overall project history,
obviously.

There is the other end of extreme that first-parent summary works
well. When there is a clear pecking order among project members,
i.e. there is the central integrator "My history is the official
one, yours are forks of it and I may merge them back to my history
from time to time".  Unless there is a fast-forward merge, in such a
setting, "git log --first-parent" going all the way down to the root
shows the way the history grew from the integrator's point of view,
and use of "git pull --no-ff" by the integrator is one way to make
sure that all merge commits yield this consistent view.  He may have
made individual commits (i.e. a single strand of pearls) on the
mainline of the history, and they are shown as individual commits.
He may have merged from a branch of his own or somebody else into
the mainline of the history, and such a merge is shown as a single
event that pulls all the commits from the side branch (and this is
where "git merge --summary" becomes useful).

It is no accident that we encourage users to focus the work made on
a single branch (either his own or a remote) to a single topic---by
doing so, it makes more sense to treat a merge of such a branch into
the mainline as a single event that adds a feature (or fixes a bug,
or whatever the topic of the branch wanted to achieve), relative to
the state of the project immediately before the merge (i.e. "the
first parent" of the merge).  And "log --first-parent" is a way to
summarize the history by culling the details of "side branches" and
letting only the merge commits talk about what these side branches
did to the history.

It also is not an accident that "--first-parent" is a much later
invention than "log" and "shortlog".  Only after people got used to
working with Git, they discovered the usefulness of the topic branch
workflow, which is the key ingredient for any history that the first
parenthood can giving a birds-eye view.

Even if your project is using a central shared repository, you can
take advantage of "first parent" summary by making sure you merge
your work into the shared history, not the other way around like the
workflow illustrated earlier in this message (or your "Flip-flop").

You would work like this:

    $ git clone $central mine && cd mine
    $ git checkout -b mywork
    ... begin repeating from here ...
    $ git checkout work ;# make sure you do not work on 'master'
    $ work; work; work; git commit
    $ work; work; work; git commit
    ... when you are done working on one logical topic ...
    $ git checkout master
    $ git pull --ff-only ;# the tip of shared history
    $ git merge mywork ;# note the first parent is the shared history
    $ test
    $ git push
    ... go back and repeat ...

The resulting history may look like this:

                  \
    ---A---B---C---D---M
        \             /
         O---O---O---O      mywork

where A, B, C, D are the commits others made and published to the
central shared repository (i.e. the shared project history).  A is
where the 'master' of the shared central repository was when you
cloned and forked your "mywork" branch at.  O are commits you made
on your "side branch".

By checking out your "master" and runnig "pull --ff-only", you would
be checking out D to your working tree, and merging your work on the
side branch to record M, which is what you publish and what becomes
the tip of the shared history.  By following the first parent chain
starting at M, you can see that a single unit of your work (the goal
you wanted to achieve on your "mywork" branch), which consists of 4
commits, was merged into the shared history at M, and before that,
somebody else integrated his work at D, and so on.

Note that the last push may race with other people and fail due to
non fast-forward.  In such a case, you have two possibilities.  An
easier way that violates the "first parent" principle for a short
while is to do this:

    $ git pull ;# may conflict and need resolution
    $ test
    $ git push

The resulting history may look like this:

                     E---F
                  \ /     \
    ---A---B---C---D---M---X
        \             /
         O---O---O---O      mywork

where E and F happened at the shared central repository while you
were resolving merge M and testing the result.  You pulled these
changes and integrated into your history to create X, so the first
parent of X becomes M and you would end up treating E and F as if
they happened on a side branch, even though they are what people may
consider the "mainline" of the the shared project history.

If you are a purist, you could instead do this when "git push" is
rejected in the original sequence:

    $ git reset --hard HEAD^ ;# cancel the merge of mywork
    $ git pull --ff-only ;# get the updated tip of shared history
    $ git merge mywork
    $ test
    $ git push

which will result in a history like this:

                     E---F---M'
                  \ /       /
    ---A---B---C---D---M   /
        \             /   / 
         O---O---O---O---   mywork

You abandon merge M ("reset --hard HEAD^" would take you back to D),
update from the central repository again to be at F, and then merge
your work (the same O--O--O--O) into it to create a new merge M',
and make that the tip of the shared history by pushing it.  Again,
following the first parent chain starting from M', the history can
be summarized as a series of merges of completed topics into the
shared history.  It is a judgement call if this is worth it (I
personally do not think it is, but others may disagree).
