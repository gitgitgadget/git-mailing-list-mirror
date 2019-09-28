Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C61B1F463
	for <e@80x24.org>; Sat, 28 Sep 2019 03:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbfI1Dts (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Sep 2019 23:49:48 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65523 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbfI1Dts (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Sep 2019 23:49:48 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1317895F4A;
        Fri, 27 Sep 2019 23:49:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9gvgzQXZEiMcHlUkleBNg9a+Lo0=; b=St2ePu
        mLHyqNtJ5513AnPslAWLKBsRLWh2jHiHlumtWV1VM2MHG16WGt3Ew6/zov2ANCC9
        O5iTzQlUHsO+v8SjS+5rDfKF5EEf1ZwDTUX4I5OK617nVcap2SHm4WJsxvt0Lexo
        7y8Hro99+MMU2CIbe8TkEdXCR0XXwDLzzD/cg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Q/NyFf66FIrmHafzQ9njc2ayZ/o03Y/0
        M2r22wsSukhlXub0hhAdvdL9QO6vAE3yIIONHiU7c9UoyDlluEn7r5p1RkMntzd3
        m/wyAbetiego07KUL8yihTUdzOd4HpnYyEuAIv7EDtW+2Wo1gQeinflERjhn1f/D
        ceFMGo5sJJY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0ACEB95F49;
        Fri, 27 Sep 2019 23:49:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3234195F48;
        Fri, 27 Sep 2019 23:49:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     William Baker <williamtbakeremail@gmail.com>
Cc:     William Baker via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, jeffhost@microsoft.com,
        William Baker <William.Baker@microsoft.com>
Subject: Re: [PATCH v2 2/6] midx: add progress to write_midx_file Add progress to write_midx_file. Progress is displayed when the MIDX_PROGRESS flag is set.
References: <pull.337.git.gitgitgadget@gmail.com>
        <pull.337.v2.git.gitgitgadget@gmail.com>
        <3bc8677ea7655a3706914f9753c0a3b79dbf7e1f.1568998427.git.gitgitgadget@gmail.com>
        <xmqqlfuiu3sv.fsf@gitster-ct.c.googlers.com>
        <373fc8e9-2ef3-d501-b6e0-b953e047ac78@gmail.com>
Date:   Sat, 28 Sep 2019 12:49:41 +0900
In-Reply-To: <373fc8e9-2ef3-d501-b6e0-b953e047ac78@gmail.com> (William Baker's
        message of "Mon, 23 Sep 2019 14:12:54 -0700")
Message-ID: <xmqqftkhkrl6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0179EE08-E1A3-11E9-821A-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

William Baker <williamtbakeremail@gmail.com> writes:

> On 9/20/19 1:10 PM, Junio C Hamano wrote:
>>> diff --git a/midx.c b/midx.c
>>> index b2673f52e8..54e4e93b2b 100644
>>> --- a/midx.c
>>> +++ b/midx.c
>>> @@ -449,6 +449,8 @@ struct pack_list {
>>>  	uint32_t nr;
>>>  	uint32_t alloc;
>>>  	struct multi_pack_index *m;
>>> +	struct progress *progress;
>>> +	uint32_t pack_paths_checked;
>>>  };
>> 
>> What is the reason behind u32 here?  Do we want to be consistently
>> limited to 4G on all platforms?
>> 
>> I have a feeling that we do not care too deeply all that much for
>> the purpose of progress output, in which case, just an ordinary
>> "unsigned" may be much less misleading.
>
> I went with u32 here to match the data type used to track how many
> entries are in the pack_list ('nr' is a u32).

That kind of parallel is valid when you could compare nr with this
new thing (or put it differently, the existing nr and this new thing
counts the same).  Are they both about the number of packs?

> I could switch to this to an unsigned but we would run the (extremely
> unlikely) risk of having more than 65k packs on a system where
> unsigned is 16 bits.

Why?  If an arch is small enough that the natural integer size is 16-bit,
then limiting the total number of packs to 65k sound entirely
sensible.

The only reason why you'd want fixed (across platforms and
architectures) type is when you want to make sure that a file
storing the literal values taken from these fields are portable and
everybody is limited the same way.  If a platform's natural integer
is 64-bit, by artificially limiting the size of this field to u32,
you are making disservice to the platform users, and more
importantly, you are wasting developers' time by forcing them to
wonder if there is a reason behind the choice of u32 (does it really
need to be able to store up to 4G, even on a smaller machines?  Is
it necessary to refuse to store more than 4G?  What are the
reasons?), like me wondering about these questions and writing them
down here.

So, unless there is a reason why this must be of fixed type, I'd say
just an unsigned would be the most reasonable choice.
