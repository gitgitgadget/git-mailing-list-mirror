From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Beginner question on "Pull is mostly evil"
Date: Wed, 07 May 2014 13:15:39 -0700
Message-ID: <xmqq4n119wgk.fsf@gitster.dls.corp.google.com>
References: <0C723FEB5B4E5642B25B451BA57E2730751C2642@S1P5DAG3C.EXCHPROD.USA.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Jim Garrison <jim.garrison@nwea.org>
X-From: git-owner@vger.kernel.org Wed May 07 22:15:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi8Fp-0003nj-0e
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 22:15:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbaEGUPp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 16:15:45 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57920 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750892AbaEGUPo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 16:15:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D8084168C9;
	Wed,  7 May 2014 16:15:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ssn3P1NaJIe90vRTWdD/WERRLDs=; b=FnD/Pj
	8pX14LULY9OPIaCC5jJv9Vkzia+Rhyi8LbwX0f7+aEu7B19n5OKiZGoP9QmQ/n/x
	fPOeu9sYK9lVG3BPQ+OTvO/1UmCgfACdJ5SgNg/E6w/cB/+rN7P7xZ4yXmLHDIrh
	LvKnekQxlH7IFVEwHopD6i0dcwLuIZASe5sN0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qMtsPSihDr4PRY0ONHCzmVpObiOgxkbP
	gxsZQ2KzQDCNsdImZaP1g2wlGm+DTegPoAzObSbLWbQHEw9ewA0nylltW5oPleWf
	0fjq9iNtM3+6ttpW+qYmbme6ENorhy8wqRHoSHa5DaMJrvMtgGViFJrUlKRpdbl0
	/kPB8tOeL20=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CCBDA168C8;
	Wed,  7 May 2014 16:15:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 63206168C2;
	Wed,  7 May 2014 16:15:41 -0400 (EDT)
In-Reply-To: <0C723FEB5B4E5642B25B451BA57E2730751C2642@S1P5DAG3C.EXCHPROD.USA.NET>
	(Jim Garrison's message of "Wed, 7 May 2014 15:40:28 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5CBACE12-D624-11E3-BB5D-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248356>

Jim Garrison <jim.garrison@nwea.org> writes:

> During my initial self-education I came across the maxim "don't
> pull, fetch+merge instead" and have been doing that.  I think I
> followed most of the "pull is (mostly) evil" discussion but one
> facet still puzzles me: the idea that pull will do a merge "in the
> wrong direction" sometimes.

[administrivia: wrap your lines to reasonable length like ~70 cols,
please]

> Do I understand correctly that this occurs only in the presence of
> multiple remotes?

No.  This is most often true for people who use a single repository
as a place for everybody to meet, in the same way as SVN.

Suppose that that central repository has this history:

    ---o---o---A

which ends at commit A (time flows from left to right and each node
in the graph is a commit, lines between them indicating parent-child
relationship).

Then you clone it and work on your own commits, which leads you to
have this in *your* repository:

    ---o---o---A---B---C

Imagine your coworker did the same and built on top of A in *his*
repository this history in the meantime, and then pushed it to the
central repository:

    ---o---o---A---X---Y---Z

Now, if you "git push" at this point, beause your history that leads
to C lack X, Y and Z, it will fail.  You need to somehow make the
tip of your history a descendant of Z.

One way that "mostly evil" thread discusses is to "pull", which is
"fetch and then merge" (note that I am saying "don't pull, instead
fetch and merge" is not an advice to solve "pull is mostly evil"
issue at all).  If you fetch, your repository will have a history
like this:

    ---o---o---A---B---C
                \
                 X---Y---Z

And then if you did merge after that, while still on *your* branch,
i.e. C, you will create a merge M and make the history look like
this:

    ---o---o---A---B---C---M
                \         /
                 X---Y---Z

M is a descendant of Z, so you can push to update the central
repository.  Such a merge M does not lose any commit in both
histories, so in that sense it may not be wrong, but when people
would want to talk about "the authoritative canonical history that
is shared among the project participants", i.e. "the trunk", the way
they often use is to do:

    $ git log --first-parent

For all other people who observed the central repository after your
coworker pushed Z but before you pushed M, the commit on the trunk
used to be "o-o-A-X-Y-Z".  But because you made M while you were on
C, M's first parent is C, so by pushing M to advance the central
repository, you made X-Y-Z a side branch, not on the trunk.

You would rather want to have a history of this shape:

    ---o---o---A---X---Y---Z---M'
                \             / 
                 B-----------C

so that in the first-parent chain, it is clear that the project
first did X and then Y and then Z and merged a change that consists
of two commits B and C that achieves a single goal.  You may have
worked on fixing the bug #12345 with these two patches, and the
merge M' with swapped parents can say in its log message "Merge
'fix-bug-12345'".

Note that I said "achieves a single goal" above, because this is
important.  "swapping the merge order" only covers a special case
where the project does not care too much about having unrelated
things done on a single merge but cares a lot about first-parent
chain.

There are multiple schools of thought about the "trunk" management.

 1. Some projects want to keep a completely linear history without
    any merges.  Obviously, swapping the merge order would not help
    their taste.  You would need to flatten your history on top of
    the updated upstream to result in a history of this shape
    instead:

    ---o---o---A---X---Y---Z---B---C

    with "git pull --rebase" or something.

 2. Some projects tolerate merges in their history, but do not worry
    too much about the first-parent order, and allows fast-forward
    merges.  To them, swapping the merge order does not hurt, but
    it is unnecessary.

 3. Some projects want each commit on the "trunk" to do one single
    thing.  The output of "git log --first-parent" in such a project
    would show either a merge of a side branch that completes a
    single theme, or a single commit that completes a single theme
    by itself.  If your two commits B and C (or they may even be two
    groups of commits) were solving two independent issues, then the
    merge M' we made in the earlier example by swapping the merge
    order is still not up to the project standard.  It merges two
    unrelated efforts B and C at the same time.

For projects in the last category (git itself is one of them),
individual developers would want to prepare a history more like
this:

                 C0--C1--C2     topic-c
                /
    ---o---o---A                master
                \
                 B0--B1--B2     topic-b

That is, keeping separate topics on separate branches, perhaps like
so:

    $ git clone $URL work && cd work
    $ git checkout -b topic-b master
    $ ... work to create B0, B1 and B2 to complete one theme
    $ git checkout -b topic-c master
    $ ... same for the theme of topic-c

And then

    $ git checkout master
    $ git pull --ff-only

would grab X, Y and Z from the upstream and advance your master
branch:

                 C0--C1--C2
                /
    ---o---o---A---X---Y---Z
                \
                 B0--B1--B2

And then you would merge these two branches separately:

    $ git merge topic-b
    $ git merge topic-c

to result in

                 C0--C1---------C2
                /                 \
    ---o---o---A---X---Y---Z---M---N
                \             /   
                 B0--B1-----B2

and push it back to the central repository.

It is very much possible that while you are merging topic-b and
topic-c, somebody again advanced the history in the central
repository to put W on top of Z, and make your "git push" fail.

In such a case, you would rewind to discard M and N, update the tip
of your 'master' again and redo the two merges:

    $ git reset --hard origin/master
    $ git pull --ff-only
    $ git merge topic-b
    $ git merge topic-c

                 C0--C1--------------C2
                /                     \
    ---o---o---A---X---Y---Z---W---M'--N
                \                 /
                 B0--B1---------B2


So one part of the solution to "pull is mostly evil" has to involve
making this "recreating your work on top of the updated upstream"
easier for users.  Otherwise, even if people *know* that rewinding
and rebuilding is the right thing to do, they will find it too
cumbersome and end up pushing merges in random order.

For another way to put this, see

    http://git-blame.blogspot.com/2012/03/fun-with-first-parent.html

HTH.
