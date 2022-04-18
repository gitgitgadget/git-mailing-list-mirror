Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF3CC433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347167AbiDRRqL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346846AbiDRRqK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:46:10 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC71C30579
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:43:29 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1D375196168;
        Mon, 18 Apr 2022 13:43:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=ZrSfKurkdbXXVgBT97RPrEXpWk7F1ijM07DtAsE/s7I=; b=WkGU
        AIfjKibH16hOW2SG24vji8B9BWj2k6S2c/jTh42v5X1mCac0BxNKl307BKBRSE5V
        oL9hAh7ltlzFQrKlyX/CQ2xjXkbDXOPflNwA9fERtjF2vA8EJ5ueQ0Z1mMgYfM/+
        Sebi2UPdZderQt/Y6p3Y5bHxWMNnkJbbURXh6wA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 169E5196167;
        Mon, 18 Apr 2022 13:43:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9462A196166;
        Mon, 18 Apr 2022 13:43:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     scs@eskimo.com (Steve Summit)
Cc:     git@vger.kernel.org
Subject: Re: suggestion for git glossary: "ort"
References: <2022Apr16.1107.scs.0007@quinine2.home>
        <xmqq5yn84pm2.fsf@gitster.g> <2022Apr18.0616.scs.0001@quinine2.home>
Date:   Mon, 18 Apr 2022 10:43:24 -0700
Message-ID: <xmqqlew2xp6r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0C8F79E4-BF3F-11EC-B6AC-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

scs@eskimo.com (Steve Summit) writes:

>> ...I doubt it would help all that much to add a new entry to the
>> glossary, especially if they do not think of first taking a look at
>> "git merge --help", which has its own large section on "ort".
>
> Call me stupid :-),

I see a smiley, but FWIW I didn't (and I wouldn't).

What I meant is that the most effective place to give additional
information may not be another end-user facing documentation page
(i.e. git help glossary) when a newcomer is puzzled about a word in
the source and another end-user facing documentation page already
explains the word.  After all, not all the words we see in the
documentation sources are necessarily end-user facing.

The implication is that we need to look elsewhere to find a more
effective place, if glossary isn't the place.

If we use "ort" (or "recursive" for that matter) in our sources in a
context where it is not obvious that we refer to one of our merge
strategies, we can be a bit more helpful by saying "ort strategy" or
"recursive strategy".  There shouldn't be too many places that refer
to these words outside the files that _are_ about these strategies
where they should not need repeated explanations (for example, the
big comment that starts merge-ort.c file should suffice for mentions
of "ort" in four merge-ort* files).

    $ git grep -l -E -e '(^|[^a-z])ort([^a-z])' -i \*.[ch]
    builtin/merge.c
    builtin/rebase.c
    log-tree.c
    merge-ort-wrappers.c
    merge-ort-wrappers.h
    merge-ort.c
    merge-ort.h
    merge-recursive.c
    sequencer.c
    t/helper/test-fast-rebase.c


On the other hand, if the source to a "mergy" subcommand whose name
is NOT "merge" refers to "ort" out of context, and it is not clear
that the word refers to one of the merge strategies, the reader
definitely deserves help.  It is understandable that without
familiarity of the architecture of Git, it would not be obvious that
mergy operations like cherry-pick, revert and rebase heavily depend
on the merge strategy backends.  We should update the mention of
"ort" in these source files to make it more clear that it is one of
the "merge strategies", at which point "git merge --help" would be
an obvious next step, because that is where the strategies are
listed and explained.

The mention of "ort" in builtin/rebase.c looks like this:

		if (!options.strategy)
			options.strategy = "ort";

The name of the member getting assigned to, .strategy, makes it
already clear that this refers to rebase_options.strategy so perhaps

	/* choice of merge strategy, e.g. "ort" */
	char *strategy, *strategy_opts;

in the definition of the rebase_options structure might help.

The only reference in merge-recursive.c is

	/* Not supported; option specific to merge-ort */

which would be enough for readers to notice merge-ort.c is next door,
which has this at the top,

        /*
         * "Ostensibly Recursive's Twin" merge strategy, or "ort" for short.  Meant
         * as a drop-in replacement for the "recursive" merge strategy, allowing one
         * to replace ...

so I do not think there is anything to add there.

Some mentions in sequencer.c can probably use improvements.
