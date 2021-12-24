Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3F3C433F5
	for <git@archiver.kernel.org>; Fri, 24 Dec 2021 04:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245594AbhLXEQb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 23:16:31 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52368 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbhLXEQb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Dec 2021 23:16:31 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3DBA610C7AB;
        Thu, 23 Dec 2021 23:16:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=JSY1CvOZmfX1czZBacrpEOYYqvlzq9G1wjc2m1Ci1zs=; b=LKQ0
        fpFe9H/27CR4m7nKfbaoidpsgMjiTwJYhykp9QTrHz4KXfwkNTjyQ7WamMng447Q
        LJZeVnQjc6zk2JQ2Svt0h7//Q/qJZTFTB4Puh89VDbZsoBfmwS0YILxzjUqiv3ew
        hdsdZoblmpVHTKQISWxVCh2eoTBmJKvRK9I0huA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 263FA10C7A9;
        Thu, 23 Dec 2021 23:16:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 75E8810C7A8;
        Thu, 23 Dec 2021 23:16:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v5 02/16] reftable: fix resource leak in block.c error path
References: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
        <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
        <9ab631a3b29addaa54415139e7f60a79a19a6edb.1640199396.git.gitgitgadget@gmail.com>
        <xmqqtuf0fe3r.fsf@gitster.g>
        <CAFQ2z_OLCzOYXgXCTXyLOwwk7EBkPzwH=KASDmuJbur=q7L1Jg@mail.gmail.com>
Date:   Thu, 23 Dec 2021 20:16:28 -0800
Message-ID: <xmqq4k6y63j7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 44CC4EB0-6470-11EC-B90A-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> Normally, block_reader_init() transfers the block to the block_reader.
> If err > 0, we skip that, so we'd be leaking the block.

Thanks.  I was about to say that 

    <reftable/block.h> wants to say more than "initializes a block
    reader."; perhaps "returns the number of blocks" or something
    needs to be added.

but I do not think the lack of the documentation was the source of
my confusion.

> At the same time, this means the "if (err)" is superfluous. In the
> success case, the block was transferred to the block_reader, so the
> reftable_block_done() call is a nop.

I agree that having the "if (err)" there is highly misleading.  "if
(err < 0 || 0 < err)" would be the more faithful expression of what
you explained, and if it were written that way, I wouldn't have been
as confused as I was.

In any case, if _done() becomes a safe and quick no-op when 0 block
was transferred, losing the conditional would be the way to make the
resulting code the most readable, I think.

>> > +     uint8_t hash1[GIT_SHA1_RAWSZ] = { 1 };
>> > +     uint8_t hash2[GIT_SHA1_RAWSZ] = { 2 };
>>
>> Will this code be exercised when compiling with SHA256 support?  If
>> not, this is perfectly fine, but otherwise, this needs to be MAX,
>> not SHA1, no?
>
> The code is parameterized in terms of hash_size, so we don't have to
> test both flavors exhaustively.

If it is safe for this function to assume that it will be called
only with hash_size of SHA1, then what you wrote is perfectly fine,
and I agree that there is no particular reason why this test must be
repeated for all available hashes.

I just don't know if we have a mechanism to prevent clueless code
churners from saying "let's test both flavors exhaustively".  For
example, I see nothing in this function, other than the size of
these two hashes, that says that this test function will be compiled
with reftable library that expects that the hash function is SHA1.
How does this function protect itself from being run in a CI job
that uses GIT_TEST_DEFAULT_HASH=sha256, for example?  It was why I
asked the question.  It wasn't that I necessarily thought we need to
test all combinations (but there is no need not to, if it takes more
engineering time to exclude it when testing Git as a whole in sha256
mode).

>> > +     char message[100] = { 0 };
>>
>> You're filling this to the sizeof(message)-1, so we can afford to
>> leave it uninitialized.
>
> At the same time, we can afford to initialize it :-)
>
> I'd rather not think about this, and always initialize everything.

I do not care too deeply in this test-only function, but as a
general principle, primarily to help less experienced developers who
may be reading from the sidelines to avoid copying such an attitude,
I have to make a note here.

If you know you will have to fill an array with, or assign to a
variable, meaningful value(s), leaving the array or variable
uninitialized at the declaration time is a much better thing to do
than initializing them with less meaningful value(s).  It will help
compilers and tools to detect a lack of proper assignment and use of
uninitialized variable (iow, you may know you will have to fill, but
in the code to do so, your implementation may be botched).  Once you
initialize at the declaration with "less meaningful" value (like
zero initialization), the tools won't be able to tell when the code
uses that variable "uninitialized" (because the assignment was
skipped by a bug), since it appears to always be initialied to them.

Helping the tools help us is what those of us, who would rather not
think about it, should be doing.
