Return-Path: <SRS0=+hCi=DN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93631C46466
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 04:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C04A208B6
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 04:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uhc15lda"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgJFEtt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Oct 2020 00:49:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61357 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgJFEtt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Oct 2020 00:49:49 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C7B247E37A;
        Tue,  6 Oct 2020 00:49:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WGcpha3UphZf9thzkV3/q4B3KAg=; b=uhc15l
        daBY8hnRDChodeXOWLKCPrFOcvmsBGpcNsCVxiNL1pd83OUbHt1Ksq7d4GeIonXP
        Gv+PTC1hPzS1Nm8xnJN8vtI0Tnz70Q3rTrMoqXKNk+63TSmPK6ELVQ8FbLpUegJ+
        0L4EIMDLS8zsr9mXy4mPmyQjp+QEqotc3sEC4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TKU3PMQUjhtH5drkHuEqzLggSgwUo+FU
        2jaJLG6u21WVxWXE7xrcLaNvIiuaKLTpSH5SlF7IYMVKzpISPivt8SOtl0Wwsu/W
        wAYFmCtDQWmMWF56j7LAjV7g15puLIG3KWaum0JmGHvU4wSfW5hCeEFOjCvEwVuv
        sXPeBGvXVZI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B18587E379;
        Tue,  6 Oct 2020 00:49:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 279407E378;
        Tue,  6 Oct 2020 00:49:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 5/9] parse-options: parse into strvec
References: <20200909004939.1942347-1-emilyshaffer@google.com>
        <20200909004939.1942347-6-emilyshaffer@google.com>
        <20201005233016.GC1393696@google.com>
Date:   Mon, 05 Oct 2020 21:49:45 -0700
In-Reply-To: <20201005233016.GC1393696@google.com> (Jonathan Nieder's message
        of "Mon, 5 Oct 2020 16:30:16 -0700")
Message-ID: <xmqq362s6jrq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B80864C-078F-11EB-8ED0-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Emily Shaffer wrote:
>
>> This is useful if collecting generic arguments to pass through to
>> another command, for example, 'git hook run --arg "--quiet" --arg
>> "--format=pretty" some-hook'. The resulting strvec would contain
>> { "--quiet", "--format=pretty" }.
>
> An alternative is to use OPT_STRING_LIST and then convert in the
> caller.  One advantage of that is that it would guarantee the behavior
> with --no-arg etc is going to match exactly.
>
> I prefer this OPT_STRVEC approach nonetheless.  Can the
> parse_opt_strvec and parse_opt_string_list functions get comments
> pointing to each other as an alternative way to encourage that kind of
> consistency?
>
> [...]
>> --- a/Documentation/technical/api-parse-options.txt
>> +++ b/Documentation/technical/api-parse-options.txt
>> @@ -173,6 +173,11 @@ There are some macros to easily define options:
>>  	The string argument is stored as an element in `string_list`.
>>  	Use of `--no-option` will clear the list of preceding values.
>>  
>> +`OPT_ARGV_ARRAY(short, long, &struct argv_array, arg_str, description)`::
>
> nit: this should be OPT_STRVEC

Sigh.  I thought I caught all of these with a SQUASH fix-up patch
the last round.  Thanks for being extra careful.
