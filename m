Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B814C433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 02:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9356230FE
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 02:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbhAGCaV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 21:30:21 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56521 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbhAGCaV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 21:30:21 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1013A113C46;
        Wed,  6 Jan 2021 21:29:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/6rQe+duU6bv2e/k/rcjD7OWBQA=; b=Aj8VV+
        29lboo+lVyFJailmfvVOQi+Dr6+yHmJeRTFED6FcuhLsC8zKj6OYg+cvPIPPSf/v
        mme0vmffB39fSlQ96n2PC41SblXv05Cea2y1kktPJKQATaTdtxiptU63nUhZEdSR
        I80+lIZgTjIeV5dyP89hoB7vZfOqVjvSwNhqw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RIO5p19/sVSa0f2gYHvsIBo8TwgacJk4
        LMw4jemaIY7L8c6+krRJkn5scGmJlWYLoBl0OqVnzAkS5upY3s6VaKVvuuIIIDem
        qmnUcjA+rKMtf20bF4h/DjLtsuCQrrmnRvRtSwn6LlfVCFlrS/Sng6i0d/8OtwKc
        VrAnsjwYgKs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EF154113C45;
        Wed,  6 Jan 2021 21:29:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 37954113C42;
        Wed,  6 Jan 2021 21:29:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] revision: trace topo-walk statistics
References: <pull.828.git.1609302714183.gitgitgadget@gmail.com>
        <xmqqh7nto7ck.fsf@gitster.c.googlers.com>
        <cbc17f1b-57fc-497f-f1ab-baa8cc84620d@gmail.com>
Date:   Wed, 06 Jan 2021 18:29:36 -0800
In-Reply-To: <cbc17f1b-57fc-497f-f1ab-baa8cc84620d@gmail.com> (Derrick
        Stolee's message of "Wed, 6 Jan 2021 21:04:21 -0500")
Message-ID: <xmqq7dopo4xb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 30664FA6-5090-11EB-A303-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 1/6/2021 8:37 PM, Junio C Hamano wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> 
>>> diff --git a/revision.c b/revision.c
>>> index 9dff845bed6..1bb590ece78 100644
>>> --- a/revision.c
>>> +++ b/revision.c
>>> @@ -3308,6 +3308,26 @@ struct topo_walk_info {
>>>  	struct author_date_slab author_date;
>>>  };
>>>  
>>> +static int topo_walk_atexit_registered;
>>> +static unsigned int count_explore_walked;
>>> +static unsigned int count_indegree_walked;
>>> +static unsigned int count_topo_walked;
>> 
>> The revision walk machinery is designed to be callable more than
>> once during the lifetime of a process.  These make readers wonder
>> if they should be defined in "struct rev_info" to allow stats
>> collected per traversal.
>
> That's possible, but the use of an at-exit method means we only
> report one set of statistics and the 'struct rev_info' might
> be defunct.

Ah, sorry for the noise.  Even after making multiple traversal we
want to report the aggregate.

> It does limit how useful the statistics can be when there are
> multiple 'struct rev_info's in use, but we also cannot trust
> that the rev_infos are being cleaned up properly at the end
> of the process to trigger the stats logging.
>
> Of course, maybe that _is_ something we could guarantee, or
> rather _should_ guarantee by patching any leaks. Seems like
> a lot of work when these aggregate statistics will be
> effective enough. But maybe I'm judging the potential work
> too harshly?

But different subsystems would have different "per-invocation"
structure (e.g. "diff" uses "struct diff_options") and some may not
even have an appropriate structure to hang these stats on.  We may
want to design a more general mechanism that can be used to annotate
the subsystems uniformly.  While that could be a worthy longer term
goal, it certainly does not have to be part of this single-patch
topic, I would think.
