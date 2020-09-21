Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8174C4346E
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 18:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 613A920888
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 18:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="m3YeCwOH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbgIUSse (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 14:48:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61084 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgIUSse (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 14:48:34 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 84A18856C7;
        Mon, 21 Sep 2020 14:48:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=r2SDicmzUO6e82QnbKW5t05lXq0=; b=m3YeCw
        OH0s2CD5fVzUWepdq3t3CWaWDMVndWZcyejRHxCzldZwfgOmFq6qKbNniea5iWuM
        LARaaXbCf25zW52J9dWUMAm/ysc8NFYGouA367O9kqqPBLKEmq1fgu9CGK1BB4B9
        u335GVqpgPcjn3tPdZ4JMbhATYqFJZ6rclAZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=J8e5IdFMo5p0Uqiu4dDrRYwamWHxkm7u
        Fg2LLBAFbQ2NDup0PXIvlqa+UpXNKmxKwhcEncHzXvUBF0pPlro8RTGpWKIdcFT3
        AzrNc2O5ZS5H0iV1AzTZ6Jjdt0QEI0Zn3iwGASlMe4ZD/xRLAumhjFKP+aqriW7n
        JW9dF6TLfmA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C51C856C5;
        Mon, 21 Sep 2020 14:48:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F3957856C3;
        Mon, 21 Sep 2020 14:48:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 1/3] push: add reflog check for "--force-if-includes"
References: <20200912150459.8282-1-shrinidhi.kaushik@gmail.com>
        <20200919170316.5310-1-shrinidhi.kaushik@gmail.com>
        <20200919170316.5310-2-shrinidhi.kaushik@gmail.com>
        <xmqqft7djzz0.fsf@gitster.c.googlers.com>
        <20200921084231.GA64896@mail.clickyotomy.dev>
Date:   Mon, 21 Sep 2020 11:48:29 -0700
In-Reply-To: <20200921084231.GA64896@mail.clickyotomy.dev> (Srinidhi Kaushik's
        message of "Mon, 21 Sep 2020 14:12:31 +0530")
Message-ID: <xmqqimc7ezk2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0AA5B8FA-FC3B-11EA-8A24-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:

>> If we were talking about older parts of the history, optional
>> generation numbers could change the equation somewhat, but the
>> common case for the workflow this series is trying to help is that
>> these local commits ane the remote tip are relatively new and it is
>> not unlikely that the generation numbers have not been computed for
>> them, which is why I suspect that in_merges_many may be a win.
>
> Nice! We can definitely try batching commits from the reflog and
> pass it along to "in_merge_bases_many()". As for being faster than
> calling "in_merge_bases()" for each commit entry in the reflog --
> I am not familiar with how the former works. Do we still keep the
> "reflog_entry_exists()" part? It might still be faster to go through
> the entries once to check with "oideq()" in the first run.

That is what I meant.  You go through local reflog entries until you
find one that is older than the timestamp of the reflog entry of the
remote-tracking branch, check with oideq() to see if the tip was ever
directly checked out.  Then, using these same local reflog entries,
you can make in_merge_bases_many() tranversal to see if any of them
reach the tip.  I suspect that the number of local reflog entries you
need to examine would not be too many, so if you can put them all in
a single array of "struct commit *" pointers in the first "oideq()"
phase, you may be able to do just a single in_merge_bases_many() batch
to check for the reachability.

> Also, I was wondering if it is worth considering this:
>   - check if the reflog of the HEAD has the remote ref

It would help the workflow I had in mind, but it would raise the
risk of false positives according to Dscho and I tend to agree, so
I do not know if it is overall a good idea.

>   - check if the reflog of the local branch has the remote ref

Isn't that the oideq() test?

>   - check if the remote ref is reachable from any of the local ref's
>     "reflog" entries using "in_merge_bases_many()" in batches as
>     suggested here.

I think it amounts to the same as "does any reflog entry of HEAD
reach it?" and shares the same issues with false positives as the
first one.

>> > +		deletion:1,
>> > +		if_includes:1, /* If "--force-with-includes" was specified. */
>> 
>> The description needs to be tightened.
>> 
>> > +		unreachable:1; /* For "if_includes"; unreachable in reflog. */
>
> OK, you're right. Perhaps, we could rename it to something like
> "if_includes_for_tracking" and update the comment description
> with saying something along the lines of:

That is overlong.  Let me try:

		/* need to check if local reflog reaches the remote tip */
		check_reachable:1,

		/* local reflog does not reach the remote tip */
		unreachable:1;

Thans.
