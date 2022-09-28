Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E709EC04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 21:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbiI1V0K (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 17:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233601AbiI1V0J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 17:26:09 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E4766138
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 14:26:07 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 876B31474E6;
        Wed, 28 Sep 2022 17:26:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=neo/4jVCwt0Uu0Gnj25rOeCEF
        +0TELmbYcDWoMJwv9Y=; b=dJOB4ENaZx/FJVGdpVSOQXjq8lPKjowt+K/TRK3fN
        5C8ZuJBiLTFVe5NZmjNtdIYyMmrWOdzMm9sHOcVzI8JiaaSJd90tZMaSjabIz93L
        h+yiwYBAcYsRJz0vNinwwB006y97qT8wD2RJx8iNyEtT0VFUds6yfZdofhg7P88N
        mo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D8581474E1;
        Wed, 28 Sep 2022 17:26:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BAE371474E0;
        Wed, 28 Sep 2022 17:26:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Stefan Xenos via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Christophe Poucet <christophe.poucet@gmail.com>
Subject: Re: [PATCH 01/10] technical doc: add a design doc for the evolve
 command
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
        <a0cf68f8ba2adefae4fceeab0d438d05e355e695.1663959324.git.gitgitgadget@gmail.com>
Date:   Wed, 28 Sep 2022 14:26:04 -0700
Message-ID: <xmqqsfkbqjgz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 292B3FCE-3F74-11ED-B86F-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Stefan Xenos via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Stefan Xenos <sxenos@google.com>

[the above address should bounce, and has been removed from cc: list]

> +Background
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Imagine you have three sequential changes up for review and you receiv=
e feedback
> +that requires editing all three changes. We'll define the word "change=
"
> +formally later, but for the moment let's say that a change is a work-i=
n-progress
> +whose final version will be submitted as a commit in the future.
> +
> +While you're editing one change, more feedback arrives on one of the o=
thers.
> +What do you do?
> +
> +The evolve command is a convenient way to work with chains of commits =
that are
> +under review. Whenever you rebase or amend a commit, the repository re=
members
> +that the old commit is obsolete and has been replaced by the new one. =
Then, at
> +some point in the future, you can run "git evolve" and the correct seq=
uence of
> +rebases will occur in the correct order such that no commit has an obs=
olete
> +parent.
> +
> +Part of making the "evolve" command work involves tracking the edits t=
o a commit
> +over time, which is why we need an change graph. However, the change
> +graph will also bring other benefits:

It would be assuring to hear that "change graph" will also be
defined and explained formally later, just like "change" will in the
previous paragraph.  We will later see mention of "metacommits" and
"meta-commits" in this document, and I am guessing both of them are
quasi-synonyms to "change graph". If that is true, it is better to
stick to a single terminology.

> +Goals
> +-----
> +Legend: Goals marked with P0 are required. Goals marked with Pn should=
 be
> +attempted unless they interfere with goals marked with Pn-1.
> +
> +P0. All commands that modify commits (such as the normal commit --amen=
d or
> +    rebase command) should mark the old commit as being obsolete and r=
eplaced by
> +    the new one. No additional commands should be required to keep the
> +    change graph up-to-date.
> +P0. Any commit that may be involved in a future evolve command should =
not be
> +    garbage collected. Specifically:
> +    - Commits that obsolete another should not be garbage collected un=
til
> +      user-specified conditions have occurred and the change has expir=
ed from
> +      the reflog. User specified conditions for removing changes inclu=
de:
> +      - The user explicitly deleted the change.
> +      - The change was merged into a specific branch.
> +    - Commits that have been obsoleted by another should not be garbag=
e
> +      collected if any of their replacements are still being retained.
> +P0. A commit can be obsoleted by more than one replacement (called div=
ergence).
> +P0. Users must be able to resolve divergence (convergence).

P0: a single parent commit should keep only one parent. IOW, the
"change graph" implementation should not contaminate the end-result
commit in the regular part of the history, which is the product of
the final iteration of a "change"

IOW ...

> +P2. It should be possible to discard part or all of the change graph
> +    without discarding the commits themselves that are already present=
 in
> +    branches and the reflog.

... this item should be P0.

> +Overview
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +We introduce the notion of =E2=80=9Cmeta-commits=E2=80=9D which descri=
be how one commit was

Random appearance of smart quotes are annoying.  We'll be formatting
the doc via AsciiDoc, so let's stick to vanilla double or single quotes.

> +created from other commits. A branch of meta-commits is known as a cha=
nge.
> +Changes are created and updated automatically whenever a user runs a c=
ommand
> +that creates a commit. They are used for locating obsolete commits, pr=
oviding a
> +list of a user=E2=80=99s unsubmitted work in progress, and providing a=
 stable name for
> +each unsubmitted change.

Can "change graph" also be defined and explained here, too?  Or if
it is pretty much a synonym to "a branch of meta-commits", then
perhaps the document does not have to introduce the term "change
graph" and still stay understandable?

> +Detailed design
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Obsolescence information is stored as a graph of meta-commits. A meta-=
commit is
> +a specially-formatted merge commit that describes how one commit was c=
reated
> +from others.
> +
> +Meta-commits look like this:
> +
> +$ git cat-file -p <example_meta_commit>
> +tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
> +parent aa7ce55545bf2c14bef48db91af1a74e2347539a
> +parent d64309ee51d0af12723b6cb027fc9f195b15a5e9
> +parent 7e1bbcd3a0fa854a7a9eac9bf1eea6465de98136
> +author Stefan Xenos <sxenos@gmail.com> 1540841596 -0700
> +committer Stefan Xenos <sxenos@gmail.com> 1540841596 -0700
> +parent-type c r o
> +
> +This says =E2=80=9Ccommit aa7ce555 makes commit d64309ee obsolete. It =
was created by
> +cherry-picking commit 7e1bbcd3=E2=80=9D.
> +
> +The tree for meta-commits is always the empty tree, but future version=
s of git
> +may attach other trees here. For forward-compatibility fsck should ign=
ore such
> +trees if found on future repository versions. This will allow future v=
ersions of
> +git to add metadata to the meta-commit tree without breaking forwards
> +compatibility.

Not clear why "trees" need to be ignored only by fsck but not others
like fetch/push, and I'd strongly advise against making such a
special case.  If they are missing, they are missing and should be
reported as corruptoin, and if you do not like it, do not add a
missing tree.

> +Parent-type
> +-----------
> +The =E2=80=9Cparent-type=E2=80=9D field in the commit header identifie=
s a commit as a
> +meta-commit and indicates the meaning for each of its parents. It is n=
ever
> +present for normal commits. It contains a space-deliminated list of en=
um values
> +whose order matches the order of the parents. Possible parent types ar=
e:

> +- c: (content) the content parent identifies the commit that this meta=
-commit is
> +  describing.
> +- r: (replaced) indicates that this parent is made obsolete by the con=
tent
> +  parent.
> +- o: (origin) indicates that the content parent was generated by cherr=
y-picking
> +  this parent.
> +- a: (abandoned) used in place of a content parent for abandoned chang=
es. Points
> +  to the final content commit for the change at the time it was abando=
ned.

Don't be cute with parent-type using single letters. You'll thank me
later when you need two types that share the first letter.

> +A meta-commit can have zero or more origin parents. A cherry-pick crea=
tes a
> +single origin parent. Certain types of squash merge will create multip=
le origin
> +parents. Origin parents don't directly cause their origin to become ob=
solete,
> +but are used when computing blame or locating a merge base. The sectio=
n
> +on obsolescence over cherry-picks describes how the evolve command use=
s
> +origin parents.

Should it make a difference among doing these operations?

 - running "commit --amend" after "cherry-pick --no-commit" possibly with=
 editing

 - running "commit --amend" after manually editing the same way, and

 - running "commit --amend" after "cherry-pick", possibly with editing?

It seems that the first two will not be captured while the last one
leaves 'origin'.  What should happen after running "commit --amend"
after "apply --index" possibly with editing?

What's the point of giving 'origin' only for "cherry-pick" and
squash merge?  I am wondering if we want to record contributions
sourced from an e-mailed patch from elsewhere (currently people use
external services like patchwork to do this)?

For the purpose of discussing "evolve", should "rebase" (with or
without "-i") be treated pretty much the same as a series of
"cherry-pick" mixed with "commit --amend" (possibly preceded with a
manual edit), followed by finally replacing the tip of the branch?
In the end result, the replaced commits after a "rebase" become
accessible only from reflog, but other than that, these two bulk
transplanting operations shouldn't be all that different.

> +The parent-type field needs to go after the committer field since git'=
s rules
> +for forwards-compatibility require that new fields to be at the end of=
 the
> +header. Putting a new field in the middle of the header would break fs=
ck.

You can do without introducing a new header to avoid compatibility
issue by recording the information in the body of the commit object,
which would be even cleaner.

> +Change deletion
> +---------------
> +Changes are normally only interesting to a user while a commit is stil=
l in
> +development and under review. Once the commit has submitted wherever i=
t is
> +going, its change can be discarded.
> +
> +The normal way of deleting changes makes this easy to do - changes are=
 deleted
> +by the evolve command when it detects that the change is present in an=
 upstream
> +branch. It does this in two ways: if the latest commit in a change eit=
her shows
> +up in the branch history or the change becomes empty after a rebase, i=
t is
> +considered merged and the change is discarded. In this context, an =E2=
=80=9Cupstream
> +branch=E2=80=9D is any branch passed in as the upstream argument of th=
e evolve command.
> +
> +In case this sometimes deletes a useful change, such automatic deletio=
ns are
> +recorded in the reflog allowing them to be easily recovered.

Deleting a useful change is recorded in the reflog?  Isn't a change
recorded as a ref in metas/ hierarchy? Doesn't the removal of such a
ref remove its reflog as well?

I guess the above silly questions come from the fact that the
document does not make it clear reflog of what ref it is recorded.

> +Modify commands
> +---------------
> +Modification commands (commit --amend, rebase) will mark the old commi=
t as
> +obsolete by creating a new meta-commit that references the old one as =
a
> +replaced parent. In the event that multiple changes point to the same =
commit,
> +this is done independently for every such change.
> +
> +More specifically, modifications work like this:
> +
> +1. Locate all existing changes for which the old commit is the content=
 for the
> +   head of the change branch. If no such branch exists, create one tha=
t points
> +   to the old commit. Changes that include this commit in their histor=
y but not
> +   at their head are explicitly not included.
> +2. For every such change, create a new meta-commit that references the=
 new
> +   commit as its content and references the old head of the change as =
a
> +   replaced parent.
> +3. Move the change branch forward to point to the new meta-commit.
> +
> +Copy commands
> +-------------
> +Copy commands (cherry-pick, merge --squash) create a new meta-commit t=
hat
> +references the old commits as origin parents. Besides the fact that th=
e new
> +parents are tagged differently, copy commands work the same way as mod=
ify
> +commands.

It is unclear what benefit we will get by separating "Copy" commands
from "Modify" commands.  "checkout A && cherry-pick B" may make a
new copy of the edit the commit at the tip of branch B wanted to
make at the tip of branch A, but "commit --amend" is the same, in
that it makes a new copy of the edit the commit at the tip of the
current branch wanted to make, and the original copy is available in
both cases. It is just that the original of "cherry-pick B" is
slightly easier to access (i.e. it is still at the tip of branch B,
until the branch gains new commits on top of it) than the original
of "commit --amend" (i.e. the user needs to know that @{1} is the
previous state). Shouldn't all commands that create a new commit
object using some existing material (i.e. not from scratch) be
treated equally, without splitting them into two camps?

IOW, the above explains that the new parents are tagged differently,
but it does not explain why it is a good idea to do so.
