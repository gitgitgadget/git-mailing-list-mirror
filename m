Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955ABC433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 05:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77F30611CB
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 05:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhJUF5P (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 01:57:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51556 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhJUF5O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 01:57:14 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E5C5E662F;
        Thu, 21 Oct 2021 01:54:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Rxbw3jJp6FjdWcxsNPwk0CCvWs+Nd4fej1zqyH
        V9Eqs=; b=C4bUG4j4YRr040KQNaGWtHWc9K7lh2GcJ1FVR+mUXlNZYKhsdO/pyu
        UMYWrSpXZaws4tCODN1SNjUiR38Jf8PIbWmznOkNXcliwo77KXagM3XdHkdiTnMm
        ntDp+w1vfhF73fD0/BPEaax8D4TrYx/qtP9d0RYssNbA9BfH+0pyk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 42AD9E662E;
        Thu, 21 Oct 2021 01:54:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9227CE662D;
        Thu, 21 Oct 2021 01:54:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 02/11] midx.c: don't leak MIDX from verify_midx_file
References: <cover.1634787555.git.me@ttaylorr.com>
        <b0c79904ab7bdaee7a1bc7a55b0fb26b1f2cf8d3.1634787555.git.me@ttaylorr.com>
        <CAPig+cSnrrT_wELSLbk=Shfu_e_6YM9LpMw2X75-oN0QqOAY3Q@mail.gmail.com>
Date:   Wed, 20 Oct 2021 22:54:56 -0700
In-Reply-To: <CAPig+cSnrrT_wELSLbk=Shfu_e_6YM9LpMw2X75-oN0QqOAY3Q@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 21 Oct 2021 01:00:45 -0400")
Message-ID: <xmqqbl3iorbj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6BDF651A-3233-11EC-91B5-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Oct 20, 2021 at 11:39 PM Taylor Blau <me@ttaylorr.com> wrote:
>> The function midx.c:verify_midx_file() allocate a MIDX struct by calling
>> load_multi_pack_index(). But when cleaning up, it calls free() without
>> freeing any resources associated with the MIDX.
>
> s/allocate/allocates/
>
>> Call the more appropriate close_midx() which does free those resources,
>> which causes t5319.3 to pass when Git is compiled with SANITIZE=leak.
>>
>> Signed-off-by: Taylor Blau <me@ttaylorr.com>
>> ---
>> diff --git a/midx.c b/midx.c
>> @@ -1611,7 +1611,7 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
>> -               return verify_midx_error;
>> +               goto cleanup;
>>         }
>> @@ -1689,7 +1689,9 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
>>         stop_progress(&progress);
>>
>> +cleanup:
>>         free(pairs);
>> +       close_midx(m);
>>
>>         return verify_midx_error;
>>  }
>
> Using the `goto` idiom to ensure cleanup makes perfect sense. For a
> few reasons[*], I did spend a some moments wondering if the cognitive
> load might be a bit lower by instead adding two close_midx() calls --
> one at the early return and one just before the normal return --
> rather than using a `goto`, but it's so subjective that it's not worth
> worrying about.
>
> FOOTNOTES
>
> [*] First, unlike most cases in which the `goto` jumps over relatively
> short blocks of code, the distance in this case between `goto` and the
> new label is significant and it's not easy to see at a glance what is
> being skipped and how important it might be. Second, `pairs` is still
> NULL at the point of the `goto`; I spent extra time checking and
> double-checking what free(pairs) was doing in this instance. Finally,
> there are enough start/stop-progress calls in this function that it
> requires extra mental effort to determine that this `goto` is indeed
> safe (at least for the present).

Carefully reading the patch is very good, but at least in a patch
like this, it is immediately obvious that the patch is not making
any of the things the footnote worries about any worse than the
original, by replacing "return" (which by definition will skip all
the things the goto did jump over) with a "goto" to the bottom, no?

Thanks.
