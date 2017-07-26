Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5462B20899
	for <e@80x24.org>; Wed, 26 Jul 2017 07:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750971AbdGZHOV (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 03:14:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57308 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750918AbdGZHOU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 03:14:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 889088ABB1;
        Wed, 26 Jul 2017 03:14:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nCCbptQoNxpdZIwVbhjSBORhGHE=; b=SggUOo
        yl0F3rfShOT45Q3M3XNL2GHPHtj4fBN7KYG0xE2pG6hOdxe8az48mYFPA6tIi6wn
        5NCCMp0+A7yfWEBta1qGk5+wVT/iq0Ddwqd+tUX2HYOEadYWwtR9/4SKOfuzFdBj
        jNjfvoVMMs2XS9of4cfAViq9R7ZjbaGYOlFFM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UeOH6LtfOL4Q1HNQZuXtRjILC/JzFJTd
        Gyu+5ObXVLKYqxltY9TDlj4X5zW8nNEoRM/RZW/XI4oprofF5oU9AKT6+Aw/kq4g
        vI9hXgeJC9fh1e29S2w6d2br22pafNjCnAXv5pS2X6OnsR3xCsMlOdm8gI3gcYcA
        MMsPCVibqKE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7FEB88ABB0;
        Wed, 26 Jul 2017 03:14:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E3E768ABAF;
        Wed, 26 Jul 2017 03:14:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Raman Gupta <rocketraman@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC] Git rerere and non-conflicting changes during conflict resolution
References: <17c46229-3b64-34f1-30fa-d40b77e1c054@gmail.com>
        <20170725175202.ar4ykqoadbihwb2w@sigill.intra.peff.net>
        <xmqqo9s8uuth.fsf@gitster.mtv.corp.google.com>
        <20170725205843.bi6kyqjlzyodmxuq@sigill.intra.peff.net>
Date:   Wed, 26 Jul 2017 00:14:10 -0700
In-Reply-To: <20170725205843.bi6kyqjlzyodmxuq@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 25 Jul 2017 16:58:43 -0400")
Message-ID: <xmqqeft3u0u5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 06379CDA-71D2-11E7-9461-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> From the user's perspective, calling X "rerere" would probably be OK[1].
> But from an implementation perspective (and to keep the existing
> plumbing available and unchanged), it probably makes sense to call it
> something else, and have it run both rerere and a new plumbing command
> to do the merge-fix work (or call it nothing, and assume that users will
> either touch the plumbing directly or will use "git merge" to trigger
> both).
> ...
> I think it should be its own plumbing tool that merge calls alongside
> rerere. ;)

As long as we use the database keyed with <A,B> and take the merge
base into account, "git am" and "git cherry-pick" would not be able
to use the merge-fix machinery, so in that sense, calling X "rerere"
would not be OK, but I agree with your general sentiment about the
UI visible to the end users.  Just like "rerere" started with a
small step to avoid automating things too much and then later became
almost invisible for normal cases because we managed to automate it
reasonably well and integrate it into mergy operations, we may be
able to do the same for merge-fix machinery.  My "this belongs to
'merge'" is primarily coming from it---it might be reusable in other
mergy operations with some fundamental changes, but I envision that
the primarly and only user of that X would initially be 'merge'.

> Not having thought too hard about it yet, this containing relationship
> seems like the right direction. I guess you'd do the lookup by computing
> the merge-base M of <X,Y> (which we already know anyway), walking M..X
> and looking for any entries which mention those commits (in either A or
> B slots of the entry), and then similarly narrowing it according to
> M..Y.

Yes, every time I look at the Reintegrate script, I try to think of
an efficient implementation but do not find anything better than the
left-right walk over X...Y range, so that is my conclusion after
having thought about it very hard as well ;-)

> What if instead of commit hashes we used patch ids?

Now you may be onto something.  While we aim at the ultimately automated
ideal that would catch the maximal cases, for the earlier 'xyzzy
turns into frotz' example, the minimal cue to identify one side of
the pair that keys the "change this new instance of xyzzy into
frotz, too" merge-fix is a hunk like this:

    -const char *xyzzy;
    +const char *frotz;

It does not matter what other changes also appear in the same
commit, and my original "branch name" is way too broad, and my
previous "ideal" which is "a single problematic commit" is still
broader than necessary.  Well, patch-id identifies the entire change
contained in a single commit, so it is still too broad, but if we
can narrow it down to a single hunk like that, perhaps we can use it
as one side of the key.

And the other side of the key is naturally a hunk like this:

    +	printf("%s\n", xyzzy);

i.e. a new use of xyzzy appears where it didn't exist before.  And
when we merge two branches, one of which has one half of the key
(i.e. "const char *xyzzy;" turned into "const char *frotz"), and the
other has the other half of the key (i.e. "printf xyzzy" is added),
then we'd apply a patch that tells us to do this:

    -	printf("%s\n", xyzzy);
    +	printf("%s\n", frotz);

i.e. that patch would be the value in the database keyed by the pair
of two previous hunks.

> I think it's asking a lot for users to handle the textual conflicts and
> semantic ones separately. It would be nice if we could tell them apart
> automatically (and I think we can based on what isn't part of the
> conflict resolution).

After thinking about this a bit more, I realized that it is possible
to mechanically sift a human generated resolution that has both
textual conflict resolution (which will be handled by "rerere") and
semantic one (which needs the merge-fix machinery) into two, without
requiring the user to make two separate commits.

The key trick is that "rerere" is capable of recording and replaying
semantic conflict resolution made to a file that happens to have
textual conflict just fine.  Because rerere database records the
preimage (i.e. with conflict markers) and postimage (i.e. the final
resolution for the file) as an entire file contents, it can do 3-way
merge for parts of the same file that is away from any conflicted
region.

If you tell contrib/rerere-train.sh to learn from "pu^{/^Merge
branch 'bp/fsmonitor' into pu}", you'll see what I mean.

  $ git show "pu^{/^Merge branch 'bp/fsmonitor' into pu}" compat/bswap.h

shows the result of such resolution.  Early part of the combined
diff shown by the above command comes from textual conflict
resolution, but there is a new implementation of inline version of
get_be64 that has become necessary but did not exist in either of
the branches getting merged, which is shown as an evil merge.

So the way to automatically sift an existing merge into textual
conflict resolution (i.e. automatable with "rerere") and semantic
evil merge-fix is to first try to recreate the merge and enumerate
the paths that get conflicts.  Then resolve these paths by grabbing
the resolved result for these paths that get textual conflicts out
of the original merge.  That gives us the textual part (we can run
"git rerere" at this point to store the resolution away to the
rerere database---which is essentially what contrib/rerere-train
does).

There will be difference between the result of the above and the
original merge commit.  The paths that are different are all outside
these conflicted paths, and they are what we want in the second
commit, i.e. the semantic evil merge-fix, which will be the value
for the merge-fix database.

So that part is easily automatable.  

It is much harder to come up with a way to index into the merge-fix
database.  We can "punt" and use the same index scheme as the
Reintegrate script (i.e. key it with the name of the branch being
merged, which can be read from the original merge) as the initial
approximation, and that would already be much better than what
Reintegrate script currently does, in that the recording part is
much more automated (in the workflow I use the Reintegrate script,
the side that records a merge-fix initially is entirely manual).



