Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A7EC433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 19:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5681260EDF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 19:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbhJLTRo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 15:17:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59657 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhJLTRn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 15:17:43 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 64138100E02;
        Tue, 12 Oct 2021 15:15:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=DGN0XfLxBrHh/EnuunK04WWjtKE5yMhttxnSk17Eabs=; b=Pgt+
        XEX48dl3P2Z8k/shS53n/KyRF+qu+2VsMEmrw19T4sHfKVZ/D7xj0wZD40HlvXVC
        I45wTobhGN/JnXWXa+ZwBoButbXPrRB9tuSk8Kkx1wU1CrEIiPX+wGjLD4gp76II
        8D14sDDv2pcJ7WKbaiaaIWh9ATn5NNb39Aqgn5Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5AC48100E01;
        Tue, 12 Oct 2021 15:15:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BAE28100E00;
        Tue, 12 Oct 2021 15:15:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] archive: add test testing MIME for created archive
 through compression filter
References: <20211011112712.475306-1-bagasdotme@gmail.com>
        <xmqqlf2zd0d4.fsf@gitster.g>
        <fab92b70-8004-5765-1b8a-2cf1d12abb63@gmail.com>
Date:   Tue, 12 Oct 2021 12:15:39 -0700
Message-ID: <xmqq35p63vhg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CA1D226A-2B90-11EC-8F9D-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 11/10/21 22.53, Junio C Hamano wrote:
>> I think a lot more portable and robust way to test the feature is to
>> configure git config tar.tar.test.command (or come up with a name for
>> a suffix to be used in the test), point it at a script created in this
>> test script and run git archive with output filename that would trigger
>> the command.  Then, arrange the test to notice if the "test" script was
>> called with expected command line arguments and standard input.
>> That way, you do not need to rely on prereqs and you do not have to
>> resort to un-portable use of the "file" command.  After all, you are
>> *not* testing if "bzip2 -c" the user happens to have on their $PATH
>> produces output their "find" recognises as bzip2 compressed.
>> 
>
> The intent of this test is to ensure `git archive -o
> something.tar.<format>` produces proper compressed tar archive that
> can be decompressed with the corresponding decompression tool (such as 
> gunzip for gz files), and not just with `tar xvf`.

Yes, that is why relying on "file -i" is not the right thing to do.

We'd want to use the matching decompressor, or better yet, trust
that the compressor-decompressor pair the system offers do work
correctly (after all, it's not our test suite's job to debug the
system software the tester uses) and validate that

 (1) the specified compressor is spawned with the right parameters
     taken from the configuration file, and that

 (2) the compressor is fed the correct input stream.

Using a script prepared by the test itself as the "compressor" would
be one good way to validate (1); it can record how it was invoked,
so that the test can check its correctness.  Using a reversible
transformation in the script as a fake compressor and comparing the
reversed output with the output without any compression filter, may
be one way to validate (2), like Peff mentioned.

But asking "file -i" validates neither.

The code that reads the configuration and spawns the compressor with
specified parameters may be broken and may not pass the right
parameters, or the archive stream may not be passed to the
compressor intact.  But the compressor may still produce a header
block that is looking correct enough for the "file" command to say
"ah, that uses X compressor", and the tests in the patch under
discussion does not even see if the payload was passed correctly
without corruption to the compressor at all.
