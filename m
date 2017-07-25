Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6288C1F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 20:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753037AbdGYU0j (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 16:26:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57551 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751141AbdGYU0h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 16:26:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A72416D3F4;
        Tue, 25 Jul 2017 16:26:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=66FcoYC3srHQKDq2KeG2lwZZLqo=; b=j2vDPi
        ZS9PWNBkBFpLIHZwB0vel/oA+EChtGOGdXIF5Cqqrio+EG+knhHassq6UDl2eS2e
        +04p4GKd7CXYvSikq1pZPH2SsCQXjUsUHQ8h1+XPmW6V/VIBqnKSIMscCUZnYvX7
        H9sLmKuiTDX81CoJ7PGv+AQ8i3hNa35yY3P1A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bMIdy6hmT3GZUlKV5RmFeIKMVx+x2oR2
        W0WiHQLFT1b1bEaS7OfCm5enUHfFFtj9Rv0Gs0IdTu977ckQJJNVWV6Sru09A0r9
        0fpv/TX2QsmsvsHYG1lyQdd+4J9plaJaTi2rL4QIEgrQw092pSRCWwlTZYxb+fE3
        v2nkIWfh19w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9F63C6D3F3;
        Tue, 25 Jul 2017 16:26:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 01D8A6D3F2;
        Tue, 25 Jul 2017 16:26:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Raman Gupta <rocketraman@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC] Git rerere and non-conflicting changes during conflict resolution
References: <17c46229-3b64-34f1-30fa-d40b77e1c054@gmail.com>
        <20170725175202.ar4ykqoadbihwb2w@sigill.intra.peff.net>
Date:   Tue, 25 Jul 2017 13:26:34 -0700
In-Reply-To: <20170725175202.ar4ykqoadbihwb2w@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 25 Jul 2017 13:52:02 -0400")
Message-ID: <xmqqo9s8uuth.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8E479D06-7177-11E7-836E-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> 1) Is this a known limitation or is there a reason rerere works in
>> this manner?
>
> Yes, it's known. Rerere works by storing a mapping of conflicted hunks
> to their resolutions. If there's no conflicted hunk, I'm not sure how
> we'd decide what to feed into the mapping to see if there is some
> content to be replaced.

Correct.  

This is not even a limitation but is outside the scope of rerere.
Let's understand that first.

A semantic conflict that requires an evil merge that touches a file
that is not involved in any textual conflict during a merge will
happen even if there is *NO* textual merge conflict.  

Imagine that there is a global variable 'xyzzy' used in many places
in the code, and then a side branch forks from the mainline.  The
mainline renames the variable to 'frotz' in the entire codebase,
while the side branch adds one more place that the variable is used
under its original name.  Then you merge these two branches.  This
will textually merge cleanly if the place the side branch adds a new
mention of 'xyzzy' is textually far from any block of text in the
common ancestor that has been updated on the mainline while these
two branches diverged.

"git checkout mainline && git merge side" will cleanly automerge,
yet the result is not correct.  The new mention of 'xyzzy' added by
the merge needs to be corrected to 'frotz'.

Now we take that as the baseline and further imagine that during the
time these two branches diverged, the mainline also updated some
documentation of something totally unrelated to 'xyzzy' vs 'frotz'
variable.  Perhaps README was updated, or something.  The side
branch also updated the same file in a different way.  This time,
the changes to this same file may result in textual conflict.

"git checkout mainline && git merge side" will result in a conflict,
whose resolution may be recorded by rerere for that file.  It should
be crystal clear that this conflict does *not* have anything to do
with the semantic conflict between 'xyzzy' vs 'frotz'.  

The realization we must draw from the above observation is that what
the "merge-fix" machinery in the Reintegrate script you cited in
your message tries to help, which is the semantic conflict,
fundamentally cannot be tied to any textual merge conflict that may
(or may not) happen.  That is what makes the issue outside the scope
of rerere.

The above is not to say that the need to record and replay such evil
merges to solve semantic conflict does not exist.  Far from it.  It
is just clarifying that it is a wrong approach to try to "teach"
rerere to somehow handle that case as well.

If we wanted to port the "merge-fix" logic, and I do wish it would
happen some day, the update belongs to "git merge".

You were too kind to call the "merge-fix" logic in Reintegrate "the
state of the art", but I am not happy about its limitation.  Here
are the things I wish to have in an ideal version of the "merge-fix"
logic, which does not exist yet:

 * There is a database of "to be cherry-picked" commits, keyed by a
   pair of branch names.  That is, given branches A and B, the
   database will return 0 or more commits that can be cherry-picked.
   The order of branch names in the pair is immaterial, i.e. asking
   the database for cherry-pickable commits keyed by <A, B> and
   keyed by <B, A> will yield the identical set of commits.

 * When merging commit X to commit Y, "git merge" in the ideal world
   does the following:

   - It first does what it currently does, i.e. three-way merge with
     the merge strategy and applying rerere for re-application of an
     earlier resolution of textual conflicts.

   - Then, it looks up the database to find the keys <A, B> where
     A is in X but not in Y, and B is not in X but in Y.
     These commits are cherry-picked and squashed into the result of
     the above.

The intent is that a pair <A, B> represents the mainline and side
branch in the above example, where A renamed 'xyzzy' to 'frotz' and
B added new reference to 'xyzzy'.  And the cherry-pickable commit
found in the database is to tweak the 'xyzzy' B adds into 'frotz'.

I said A and B in the above are branch names, but in the ideal
world, they can be commit object names (possibly in the middle of a
branch), as long as we can reliable update the database's keys every
time "git rebase" etc. rewrites commits.

To populate the database, we'd need a reverse.

 * When merging branch B into branch A (or the other way around) for
   the first time, "git merge" would do what it currently does.

 * The user then concludes the merge to resolve *ONLY* the textual
   conflict, and commit the result.  It is important that no
   additional evil merge to correct for semantic conflicts is done
   in this step.  Note that if the auto-merge cleanly succeeds, this
   step may not even exist.

 * Then the user makes another commit to correct for semantic
   conflicts (aka "merge-fix").

 * Then the user tells Git that semantic conflicts were resolved and
   need to be recorded (just like running "git rerere" manually,
   before "git commit" automatically does it for them these days).
   This will result in the following:

   - The database is updated so that key <A, B> yields the
     "merge-fix" commit;

   - The head is detached at the tip of branch A before the merge;

   - "git merge B" is done again, which _should_ reproduce the state
     immediately after the user committed the "merge-fix";

   - The tip of branch A is reset to the result of the above.

The merge-fix logic in Reintegrate is a poor-man's emulation of the
above ideal.  A value its database yields is not a set of commits,
but a single commit, and instead of getting keyed by a pair of
branch names, the database is keyed by a single branch name
(i.e. recording "I had trouble when merging this branch" without
saying "... to the integration branch that already had this other
branch"), so the look-up does not have to do "A is in X but not in
Y, and B is not in X but in Y".  

It is still usable but the database need to be reorganized every
time the order of topics merged to 'pu' is changed.


