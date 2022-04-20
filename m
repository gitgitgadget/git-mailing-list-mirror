Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955E5C433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 05:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343495AbiDTFqO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 01:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiDTFqM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 01:46:12 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761921DA5E
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 22:43:27 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F6B412840D;
        Wed, 20 Apr 2022 01:43:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=PioVj6sMEbETBkBPItZYiVkbQDXwuS7evaZM6Lr+IVM=; b=ElqZ
        rbLYEhwQ0hLOOlzm9HmSjS2XZB39vZJw+RbQNAUgzElgx3HWkgG3gnk6UlRoSuRT
        Xi2//eeIWK38V8sp6r/AByP4+ECGYPuDx4yMJsgdHwAueXbxxOcUQA/0jzeqx39H
        UYZJylDY2mqc3LqFfyCnYPVZyCrV15Bx8eHtfKk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 17E94128409;
        Wed, 20 Apr 2022 01:43:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7A64E128408;
        Wed, 20 Apr 2022 01:43:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin von Zweigbergk <martinvonz@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Tao Klerks <tao@klerks.biz>, git <git@vger.kernel.org>
Subject: Re: Current state / standard advice for rebasing merges without
 information loss/re-entry?
References: <CAPMMpojjs4sjKdN6DAJFSwERdjq9XQgi35CcqkXu7HijadHa1Q@mail.gmail.com>
        <f87a549f-540e-d0f3-470c-178c2fa141a5@iee.email>
        <xmqqczhe1jgp.fsf@gitster.g>
        <ba1ea459-5981-5972-36e6-913eb19c34b4@iee.email>
        <xmqq35iaz6n3.fsf@gitster.g>
        <CANiSa6hEJMWPyfZ_KqgHcKXhMdT7doTnxkK7GZzf-QBh6DhATg@mail.gmail.com>
Date:   Tue, 19 Apr 2022 22:43:24 -0700
Message-ID: <xmqqsfq8s41v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CC1E98CA-C06C-11EC-B6E5-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> On Tue, Apr 19, 2022 at 6:57 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Philip Oakley <philipoakley@iee.email> writes:
>>
>> > So, essentially, it's talking a small part of the rerere-train at each
>> > step in the replay, so that it's more focussed.
>>
>> That reminds me of one topic.
>
> And it reminds me of a discussion about first-class conflicts vs
> rerere I had recently [1] (Philip's email hasn't been delivered to me
> yet). As I wrote there, I think most of rerere's use cases can be
> fulfilled by first-class conflicts. I understand that it would be a
> huge project (much more than appropriate for GSoC :)) to add such
> support to Git. I just want to make sure the project is aware of the
> idea.
>
> [1] https://github.com/martinvonz/jj/issues/175#issuecomment-1079831788

I saw that before, but neither of these two "use cases" solve a
problem relevant to what I have to do often.  It may be a case where
you have a hammer while rerere is a screwdriver, perhaps?  Each is
useful in its own ways and is good at different applications.

Rebuilding of 'seen' multiple times every day may superficially be
similar to "test merge" case you mention there, but the desired end
result from keeping multiple topics in master..seen chain, and have
selected ones (not necessarily in the order in 'master..seen')
graduate while keeping others and rebuilding 'seen' with them never
involves artificially linearlized history in the end, and that is an
explicit goal---to avoid the last-minute rebasing to the upstream,
which can introduce unnecessary bugs.

When I merge topics from 'seen' to 'next', I first reorder the
topics so that these topics that are planned to be merged to 'next'
come directly on top of the tree that matches 'next' in the
'master..seen' chain, so that the exact state planned to be in
'next' in the next iteration appears in 'seen' and be tested.  The
merge of these topics to 'next' happens in the next integration
iteration after this preparatory step passes.  It is the same way
when topics that have been cooking in 'next' are (first planned to
and then actually) merged to 'master'.  There is no "final last
minute" rebase involved.

Another thing that I didn't quite see in your "I see rebase as
replaying the change between parent and child" is how different
order of merging is handled.  It often happens that topic A and
topic B have funny interactions, and the resolution rerere records
when I first merge topic A to 'seen' and then topic B (at which time
the conflict we are interested in happens) is later cleanly reused
if topic B turns out to go first long before topic C graduates.
When such a reordering happens, topic B will be merged first
(without causing the conflict between topics A and B), then topic A
is merged.  Dealing with such a reordering of topics was an explicit
goal of 'rerere' and it works reasonably well, but it is no clear
how [1] you cited above handles such a use case.

The most importantly, at the philosophical level, in order to allow
earlier mistakes to be corrected later, Git tries to avoid casting
heuristic decisions in immutable objects when possible.

Not recording "in this commit, parent and child trees rename path A
to B, combine some contents of path C and D to create a new path E"
and instead computing renames when we actually compare these two
trees, is an example of the application of the philosophy.  It
allows rename detection heuristics at the runtime to improve over
time and a commit you made 5 years ago will be shown better with the
improved rename detection logic.  We do avoid recomputing the same
information over and over again by having long lived cache data
structure like commit-graph, but they are left out of the central
data structure and can be reproducible.

Keeping the rerere database outside the commit object is another
application of the same philosophy.  There needs a clear way to nuke
an earlier recorded resolution that was faulty without having to
rewrite the history, and having it outside the commit object is a
must, and having database in .git/rr-cache/ is one possible
implementation to achieve that goal.

Thanks.
