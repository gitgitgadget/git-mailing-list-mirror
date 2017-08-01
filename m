Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD6EF1F991
	for <e@80x24.org>; Tue,  1 Aug 2017 01:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751747AbdHABO0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 21:14:26 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:36003 "EHLO
        coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751327AbdHABOX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 21:14:23 -0400
Received: from localhost (243.103.2.81.in-addr.arpa [81.2.103.243])
        by coral.adamspiers.org (Postfix) with ESMTPSA id B02D92E299;
        Tue,  1 Aug 2017 02:14:21 +0100 (BST)
Date:   Tue, 1 Aug 2017 02:14:21 +0100
From:   Adam Spiers <git@adamspiers.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git list <git@vger.kernel.org>
Subject: Re: [PATCH 0/1] add git-splice subcommand for non-interactive branch
 splicing
Message-ID: <20170801011421.veyuviur3mi4hjir@pacific.linksys.moosehall>
References: <cover.55495badd28b73b39c60ca4107b50aae7ee95028.1501535033.git-series.git@adamspiers.org>
 <xmqqo9s0gsia.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo9s0gsia.fsf@gitster.mtv.corp.google.com>
Received: by 10.200.40.106 with HTTP; Mon, 31 Jul 2017 17:10:16 -0700 (PDT)
User-Agent: Mutt/1.6.2 (2016-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31 July 2017 at 23:18, Junio C Hamano <gitster@pobox.com> wrote:
> Adam Spiers <git@adamspiers.org> writes:
>
> > Therefore there is a risk that each new UI for higher-level workflows
> > will end up re-implementing these mid-level operations.  This
> > undesirable situation could be avoided if git itself provided those
> > mid-level operations.
>
> Let me make sure if I get your general idea right, first.
>
> Is your aim is to give a single unified mid-layer that these other
> tools can build on instead of rolling their own "cherry-pick these
> ranges, then squash that in, and then merge the other one in, ..."
> sequencing machinery?

Pretty much, yes.  The original itch I wanted to scratch was
implementing git-explode, which aims to automatically explode a large
topic branch into a set of smaller, independent topic branches, by
harnessing my git-deps for automatically detecting inter-dependencies
between commits in the large source branch and using that dependency
tree to construct the smaller topic branches.  (Before anyone protests
at this point, yes, I am fully aware that it is not possible to
automate 100% accurate detection of these dependencies, and no, that
does not completely invalidate the approach.[0])

My initial thought was that in order to be able to automatically
decompose a branch into smaller branches, I would need a mid-layer
operation "git-transplant" somewhat analogous to mv(1), which would
let me easily move commits out of the source branch into a new target
branch.  And then I realised that, in the same way that
(simplistically speaking) mv(1) could be reimplemented as cp(1)
followed by rm(1), implementing "git-transplant" in turn would require
more primitive operations for copying commits between branches, and
removing commits from branches.  At this point I saw value in
generalising those operations; hence the idea for git-splice was born.

Consequently I implemented prototypes for splice and transplant, which
didn't take too long.  (The real work was writing comprehensive test
suites and polishing the tools until they were reliable enough to pass
100%.)

Ironically, soon after I started to implement git-explode, I realised
that the order in which I needed to walk the dependency tree
discovered by git-deps actually meant that I couldn't use
git-transplant for this particular use case, so in the end I
implemented it with pygit2.  (I still need to polish it up a bit more
before releasing.)

However, even though splice and transplant are not useful for this
particular use case, I still believe that they (or similar tools) have
the potential to serve as a useful foundation for other workflows.

> If so, I think that is a very good goal.

Glad to hear it :-)

> >     # Remove commits A..B (i.e. excluding A) from the current branch.
> >     git splice A..B
> >     # Remove commit A from the current branch.
> >     git splice A^!
> >     # Remove commits A..B from the current branch, and cherry-pick
> >     # commits C..D at the same point.
> >     git splice A..B C..D
>
> We need to make sure that the mid-layer tool offers a good set of
> primitive operations that serve all of these other tools' needs.  I
> do not know offhand if what you implemented that are illustrated by
> these examples is or isn't that "good set".

Agreed.  That's why I sent the RFC to this list last year: in the hope
that these details could be hashed out and guide my development in the
right direction.  Unfortunately I didn't get much response at the
time, which was probably my fault for not explaining my "mission
goals" clearly enough.  Although in fairness to myself, I think I
needed a year anyway to let the ideas in my head mature to the point
where I understood them well enough myself to communicate them clearly
to others :-)

> Assuming that there is such a "good set of primitives" surfaced at
> the UI level so that these other tools can express what they want to
> perform with, I'd personally prefer to see a solution that extends
> and uses the common "sequencer" machinery we have been using to
> drive cherry-picks, reverts and interactive rebases that work on
> multiple commits.  IOW, it would be nice to see that the only thing
> "git splice A..B" does is to prepare a series of instructions in a
> file, e.g. .git/sequencer/todo, just like "git cherry-pick A..B"
> would, and let the sequencer machinery to handle the sequencing.
>
> E.g. In a history like
>
>     ---o---A---o---B---X---Y---Z   HEAD
>
> "git splice A..B" command would write something like this:
>
>     reset to A
>     pick X
>     pick Y
>     pick Z
>
> to the todo file and drive the sequencer.

That sounds great to me!  At this point sadly I'm currently a bit
ignorant of the intricacies of the sequencer, otherwise I might have
adopted this approach from day 0.  But I'm pleased to be able to say
that under the hood, the way I implemented splice and transplant isn't
too dissimilar to this: they both write "todo" files, under
.git/splice and .git/transplant respectively, and then execute the
instructions in those files.  So hopefully it wouldn't be much work to
bring them closer to the kind of format you describe above, and then
feed that to the sequencer instead of have them process the tasks
themselves.

> As you notice, you would
> need to extend the vocabulary of the sequencer a bit to allow
> various things that the current users of the sequencer machinery do
> not need, like resetting the HEAD to a specific commit, merging a
> side branch, remembering the result of an operation, and referring
> to such a commit in later operation.  For example, if you tell "git
> splice" to expunge A from this sample history (I am not sure how you
> express that operation in your UI):
>
>          B---C---D
>         /         \
>     ---o---A---E---F---G   HEAD

Currently splice explicitly avoids editing history with merge commits,
although this example has made me realise that there's a bug with the
way it currently does that: it only checks that the removal and
insertion ranges are all non-merge commits before starting execution,
whereas it actually needs to check all the descendant commits too.
Fortunately that's easy to fix :-)

> it might create a "todo" list like this to rebuild the history:
>
>     reset to A^
>     pick B
>     pick C
>     pick D
>     mark :1
>     reset to A^
>     pick E
>     merge :1 using F's log message and conflict resolution as reference
>     pick G
>
> to result in:
>
>          B---C---D
>         /         \
>     ---o-------E---F---G   HEAD
>
> Do not pay too much attention to how the hypothetical "extended todo
> instruction set" is spelled in the above illustration (e.g. I am not
> advocating for multi-word command like "reset to"); these are only
> to illustrate what kind of features would be needed for the job.  In
> the final shape of the system, "merge" in the illustration above may
> be a more succinct "merge F :1", for example (i.e. the first
> parameter would name an existing merge to use as reference, the
> remainder is a list of commits to be merged to the current HEAD),
> just like "pick X" is a succinct way to say "cherry-pick the change
> introduced by existing commit X to HEAD, reusing X's log message
> and author information".

Yep, that all makes perfect sense.  It seems to me that there would be
three main strands of work required here:

     (0) gather use cases for automated higher-level workflows
         from users, so we're clear what kinds of problems are
         most worth solving

     (1) automate generation of instruction sequences which
         reflect those workflows (or parts thereof)

     (2) extend the sequencer as/when required by (1)

> Something like that may have a place in the git-core, I would think.

OK, good to know.

> I am not sure if a bash script that calls rebase/cherry-pick/commit
> manually can serve as a good "universal mid-layer" or just adding
> another random command to the set of existing third-party commands
> for "higher-level workflows".

I'm not sure either.  It might or might not be, but I think a debate
on that topic would be worthwhile and something in which I'd be very
interested in taking part.

My first hunch is that if we were to attempt to design this
"mid-layer" of operations, it would make sense to start with the more
primitive operations in that layer, and then build the more
sophisticated ones later - on top of the primitives, if that made
sense.

For example first we could focus on sequences which achieve simple
things like removing a range of commits from a branch where the
descendants of that range are all non-merge commits, and inserting a
range of commits into a branch which satisfies the same "no merge
commits" constraint.  This would achieve parity with git-splice.

Next we could add support for the same operations with the "no merge
commits" constraint dropped, so that your example scenario above could
be handled correctly.

Then we could add support for more complicated operations such as
transplants, and removing / transplanting a whole range of commits
which can form an arbitrarily complex commit graph.  This last one
sounds pretty hairy, which reinforces the value of starting simple.

Also, implementing the more primitive operations first would allow us
to extend the sequencer's capabilities in a more incremental and
risk-averse manner.

Thanks a lot for the reply!  What would you recommend as the next
steps?


[0] This has been discussed before, e.g.
     https://public-inbox.org/git/20160528112417.GD11256@pacific.linksys.moosehall/
