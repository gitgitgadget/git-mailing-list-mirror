Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B480C433DF
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 18:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABA9721527
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 18:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zd9HDIGw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390913AbgJPSEE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 14:04:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50483 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390746AbgJPSEE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 14:04:04 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 81430807EC;
        Fri, 16 Oct 2020 14:04:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ouyKCLUGzmSnFUWYcdVcLFmnUAs=; b=Zd9HDI
        GwGrKLKWmPOCAZcltyuqTPr7JhOcbraVUHgmUwZqTKjDHorXkhdSzyPTYUZidNHZ
        fd7Vw5LwpStQDKhc6LfnHNRxBxpI4O/YrorgW2rGPpAcv7BkirZXe8JhvcbnxCyS
        Q3bfRjD7fyNmXt2mIxp0VN/YZSkSvGR343szU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fkuu1n1AId3eTMwkDObQcdI2s6oqc9a2
        htFXN/3r7LTKksAsMzoLY7BRsCe8PiafMzqSqfipASJw+1EdL1ZCbS49X8qyEULl
        TkcLN0trfmd7mQS0StT0VCgj6UuXOnsNN/Z96fh+PrnzfatvJgtRIlAhYEQK9P62
        IhLL+iIqCQM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7167C807EA;
        Fri, 16 Oct 2020 14:04:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E06A4807E9;
        Fri, 16 Oct 2020 14:04:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] diff: add -I<regex> that ignores matching changes
References: <20201012091751.19594-1-michal@isc.org>
        <20201015072406.4506-1-michal@isc.org>
        <20201015072406.4506-3-michal@isc.org>
        <afd3b1cf-b883-6df5-bea5-28f8e06d8702@gmail.com>
Date:   Fri, 16 Oct 2020 11:04:02 -0700
In-Reply-To: <afd3b1cf-b883-6df5-bea5-28f8e06d8702@gmail.com> (Phillip Wood's
        message of "Fri, 16 Oct 2020 16:32:47 +0100")
Message-ID: <xmqqeelycajx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F9466660-0FD9-11EB-868A-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> @@ -6405,6 +6428,11 @@ void diff_flush(struct diff_options *options)
>>   	DIFF_QUEUE_CLEAR(q);
>>   	if (options->close_file)
>>   		fclose(options->file);
>> +	for (i = 0; i < options->ignore_regex_nr; i++) {
>> +		regfree(options->ignore_regex[i]);
>> +		free(options->ignore_regex[i]);
>> +	}
>> +	free(options->ignore_regex);
>
> If I run `git log -p -I foo` then the address sanitizer reports
>
> AddressSanitizer: heap-use-after-free xdiff/xdiffi.c:1027 in
> record_matches_regex
>
> after it has printed the diff for the first commit. I think freeing
> the regex here is the cause of the problem.

Yes, this is a good location to clear the diff_queue, which is
per-invocation.  But diff_options->ignore_regex[] can and should be
shared across multiple invocations of the diff machinery, as we are
parsing upfront in the command line option parser just once to be
used throughout the life of the program.  It is wrong to free them
early like this.

I really hate to suggest this, one common API call made into the
diff machinery from various consumers, when they are absolutely done
with diff_options, is probably diff_result_code().  Its purpose is
to collect bits computed to participate in the overall result into
the final result code and anybody who ran one or more diff and wants
to learn the outcome must call it, so it is unlikely that callers
that matter are missing a call to finalize their uses of the diff
machinery.  So if freeing .ignore_regex[] is really necessary, it
could be used to tell us where to do so [*1*].

Unlike per-invocation resources that MUST be freed for repeated
invocations of the diff machinery made in "git log" family,
resources held for and repeatedly used during the entire session
like this may not have to be freed, to be honest, though.

Thanks.


[Footnote]

*1* Adding calls to free() in diff_result_code() directly is
    probably not a good idea.  Some callers may not even need result
    code (e.g.  "blame") and do not call it at all, but we may want
    to free the resource in diff_options that is not per-invocation.
    So if we were to do this, we probably need a new API function,
    perhaps diff_options_clear() or something, and call that from
    diff_result_code(), and then find callers that do not care about
    the result code and call diff_options_clear() directly from
    them.

    If a caller does a single diff_setup_done(), makes repeated
    calls to the diff machinery, and calls diff_result_code() once
    per each iteration (e.g. imagine "git log -p" that detects the
    status for each commit), then having the diff_options_clear()
    call in diff_result_code() will break the machinery, so if we
    were to follow the outline given in the previous paragraph, we
    need to make sure there is no such caller.  But I see that
    diff_result_code() does not clear the fields it looks at in the
    diff_options fields after it uses them, so the second and
    subsequent calls into the diff machinery by such a caller may
    already be broken (not in the "resource leakage" sense, but in
    the correctness sense).
    
