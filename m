Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B95BE1F731
	for <e@80x24.org>; Mon,  5 Aug 2019 21:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbfHEVxq (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 17:53:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58946 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbfHEVxq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 17:53:46 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 55B4E160279;
        Mon,  5 Aug 2019 17:53:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8DsDYlOkAAt8jQd4TkyChRWuG7I=; b=ZP/NOf
        lo79Gu0RS+yaqRwh0AXWj9hwY5Hdj7PvoxlcXPpHrztFyxjh0j2x3OGPOybMhNDP
        I8kfS09wuDTi8oWR0wJFO7SEsPTh/uKbM9f7NRCwdEs5A1Y2lUT9tqmipQojRBWs
        rzGUPRNXMGXwZeVnBFfH3thaWb/aYXjnz+VCk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tVx9htlW6aHzoM9sRZZSQFofLo2NqME5
        7R0Ilge+riq1f12cvIkjT+IuhCHDOVHzsoQAy4Qc72/headUr+LrIgyvvAWRrDTD
        7aC+CTFco10xBO8ssiY7bjqspVAEW7AcqZh85Xny0N39wH1JpT09XEdyJYt3u4Vc
        j/9d+9G0R6M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C1FA160278;
        Mon,  5 Aug 2019 17:53:42 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AF4D6160277;
        Mon,  5 Aug 2019 17:53:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] pcre2: allow overriding the system allocator
References: <pull.306.git.gitgitgadget@gmail.com>
        <3397e6797f872aedd18c6d795f4976e1c579514b.1565005867.git.gitgitgadget@gmail.com>
        <CAPUEspgH1v1zo7smzQWCV4rX9pKVKLV84gDSfCPdT7LffQxUWw@mail.gmail.com>
Date:   Mon, 05 Aug 2019 14:53:40 -0700
In-Reply-To: <CAPUEspgH1v1zo7smzQWCV4rX9pKVKLV84gDSfCPdT7LffQxUWw@mail.gmail.com>
        (Carlo Arenas's message of "Mon, 5 Aug 2019 09:19:24 -0700")
Message-ID: <xmqq36ifmg7v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7D24EA0A-B7CB-11E9-B6F7-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> LGTM except from the suggestion below that might make the code more "standard"
> and probably be a good base for a similar PCRE1 fix
>>
>> +static pcre2_general_context *get_pcre2_context(void)
>> +{
>> +       static pcre2_general_context *context;
>> +
>> +       if (!context)
>> +               context = pcre2_general_context_create(pcre2_malloc,
>> +                                                      pcre2_free, NULL);
>> +
>> +       return context;
>> +}
>
> instead of using a static variable inside this helper function it
> might be better to use
> one extra field inside the (struct grep_pat *p), where all other
> variables are kept
>
> Additionally to being more consistent will avoid creating the global

"standard" and "more consistent" are good things, but I am not sure
I should agree with the argument without knowing what you are
comparing your suggested improvement with.  Whose standard practice
are we trying to be consistent with?  Keeping dynamic resources hooked
to "struct grep_pat" so that (1) different patterns could use different
settings when they desire and (2) the resources are not hidden behind
a function-scope static and can be discarded when we are done with
the pattern, which is the standard in our "grep" subsystem?

I think general context probably corresponds to a bit higher level
than individual grep_pat.  E.g. when running "grep -e foo -e bar",
do we expect resources needed by patterns "foo" and "bar" would want
to be allocated and freed by potentially separate <alloc,free>
function pairs?

> context for the
> most common case (when the locale is either C/POSIX or UTF-8) and therefore
> have a smaller impact on performance.

I am not sure about the impact on performance, but if it helps us
keep the subsystem reusable by avoiding function-scope static that
we cannot clear, that would be a good thing.  But "struct grep_pat"
may be a bit too fine-grained to control general context.

