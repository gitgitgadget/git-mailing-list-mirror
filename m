Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08596C433E0
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 19:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A488764FB7
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 19:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbhBESBF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 13:01:05 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50967 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhBER4N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 12:56:13 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8348BB1AE5;
        Fri,  5 Feb 2021 14:37:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=I06N8raC1ylpc05eqlz8xAwLV0U=; b=PMB+/B
        kfEC3cWurKw9NHbwFWS4AIqbfGKoFSC6KJ0QgjLBor7AzvZtyI1AHtj7Rj0P58zb
        XND688iTRAQQnE63KtHR+xtXgDsfwNcCLfcrg3+bXJoK+jbQMy3GF2S2wKR/5RvH
        EzCgbZRVBCG3m7BYoRjn5+MdwpruIQFbZG0J4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yBkmEvKAs06kn32sDiwxhZs6eGC+zhJu
        yO0KDqi/H5tALmoJBQsi6Ng5vCAmxABuHx2bGY920sUZ7uYXzF1KYNjVNzuQI5ot
        XD08sIghJO5N4eAacqIY8TYUgX7w/dZn+RFybtqt3L5jIFpF3jVArdts17QW3Rlp
        VJVsRfKhn1A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 78B24B1AE4;
        Fri,  5 Feb 2021 14:37:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0408CB1AE3;
        Fri,  5 Feb 2021 14:37:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, l.s.r@web.de,
        szeder.dev@gmail.com, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 12/17] chunk-format: create read chunk API
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
        <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
        <d8d8e9e2aa3faf0fdda5dc688fb92e924fec423a.1611759716.git.gitgitgadget@gmail.com>
        <xmqqczxf4d2k.fsf@gitster.c.googlers.com>
        <1278de82-417c-a6ee-a5fe-055fa0ef1903@gmail.com>
Date:   Fri, 05 Feb 2021 11:37:53 -0800
In-Reply-To: <1278de82-417c-a6ee-a5fe-055fa0ef1903@gmail.com> (Derrick
        Stolee's message of "Fri, 5 Feb 2021 07:19:52 -0500")
Message-ID: <xmqqeehu1f1q.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A3EF8314-67E9-11EB-A0F4-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>>> +	chunk_id = get_be32(table_of_contents);
>>> +	if (chunk_id) {
>>> +		error(_("final chunk has non-zero id %"PRIx32""), chunk_id);
>>> +		return -1;
>>> +	}
>> 
>> Shouldn't we be validating the size component associated with this
>> "id=0" fake chunk that appears at the end as well?

No, please disregard this comment, which was based on my incorrect
understanding of the "size" field associated with this fake ID==0
chunk (I incorrectly thought the size had something to do with the
file header plus TOC, but it is not---it is to allow discovering the
size of the last chunk by being a sentinel that records the offset
of an extra chunk at the end that does not actually exist).

> I like this, but why not just use pair_chunk_fn inside of
> the implementation of pair_chunk() so callers have an easy
> interface.

Yes, I didn't realize that earlier design iteration resulted in the
introduction of the "pair_chunk()" after discovering that it often
is necessary to just note the address where the data begins, so I
am OK to leave something like pair_chunk() as a public interface,
and implementing the pair_chunk() helper like you suggest would be a
perfectly fine way to do so.

It however is curious that the callers who use pair_chunk() do not
get the same quality of data as read_chunk() callers.

The users of pair_chunk() presumably are not ready to (or simply do
not want to) process the data immediately by using read_chunk() with
callback, but when they get ready to process the data, unlike
read_chunk callbacks, they do not get to learn how much they ought
to process---all they learn is the address of the beginning of the
chunk.  I do not see a way to write pair_chunk() users safely to
guarantee that they do not overrun at the tail end of the chunk they
are processing.

Thanks.
