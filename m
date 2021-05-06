Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7CEC433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 01:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF49C61159
	for <git@archiver.kernel.org>; Thu,  6 May 2021 01:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhEFBGV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 21:06:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61715 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhEFBGT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 21:06:19 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B2606D35F9;
        Wed,  5 May 2021 21:05:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DmdEXczNzb2Dwobkmg+m1uBda1kzbsbdA33drb
        C1Wr8=; b=tnqu/2XMI+QEYgR/zBn4h1s+FvA5p00Tdw1aJ9cSnBIyml/nu0xg5B
        Z9dZvO6uDglIa3X+QWTOQmyWsYP7gRzpb+zmC5F2HZjdZwjmPlvHszqeF1cbX5M2
        XymCrnuxZUJ7/6wCkRRwVehHwJwnF6/BoaB20aDp/5BTt1A7sur9M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AA73AD35F7;
        Wed,  5 May 2021 21:05:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 246AFD35F6;
        Wed,  5 May 2021 21:05:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/4] Makefile: don't re-define PERL_DEFINES
References: <cover-0.4-00000000000-20210505T121857Z-avarab@gmail.com>
        <patch-1.4-ed2005a2fbf-20210505T121857Z-avarab@gmail.com>
        <YJKm0dnwHBwQuTi+@coredump.intra.peff.net>
Date:   Thu, 06 May 2021 10:05:20 +0900
In-Reply-To: <YJKm0dnwHBwQuTi+@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 5 May 2021 10:08:17 -0400")
Message-ID: <xmqq4kfg3c4v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 214DC4A2-AE07-11EB-8602-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I did have one question:
>
>> diff --git a/Makefile b/Makefile
>> index 93664d67146..1d4c02e59d9 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -2270,9 +2270,10 @@ perl_localedir_SQ = $(localedir_SQ)
>>  
>>  ifndef NO_PERL
>>  PERL_HEADER_TEMPLATE = perl/header_templates/fixed_prefix.template.pl
>> -PERL_DEFINES = $(PERL_PATH_SQ):$(PERLLIB_EXTRA_SQ):$(perllibdir_SQ)
>> -
>> -PERL_DEFINES := $(PERL_PATH_SQ) $(PERLLIB_EXTRA_SQ) $(perllibdir_SQ)
>> +PERL_DEFINES :=
>> +PERL_DEFINES += $(PERL_PATH_SQ)
>> +PERL_DEFINES += $(PERLLIB_EXTRA_SQ)
>> +PERL_DEFINES += $(perllibdir_SQ)
>>  PERL_DEFINES += $(RUNTIME_PREFIX)
>
> I don't think we generally use simply-expanded variables in our Makefile
> unless there's a reason. Do we actually need it here? Obviously not new
> in your patch, but just a curiosity I noticed while reading it.

Splitting the appending into multiple lines does make sense, and is
in line with what 07d90ead (Makefile: add Perl runtime prefix
support, 2018-04-10) introduced the "first create a space separated
list and then redefine that same variable with spaces replaced with
colons" strategy to reach the final value (i.e. colon separated
tokens that lets us notice when build options changed) for.

As to the simply-expanded vs recursively-expanded variable, there is
aneed to use former, which comes from what the original commit
07d90ead did outside the context of this patch, which is:

    PERL_DEFINES := $(subst $(space),:,$(PERL_DEFINES))
    GIT-PERL-DEFINES: FORCE
            @FLAGS='$(PERL_DEFINES)'; \
                if test x"$$FLAGS" != x"`cat $@ 2>/dev/null`" ; then \
                    echo >&2 "    * new perl-specific parameters"; \
                    echo "$$FLAGS" >$@; \
                fi

That is, up to this point PERL_DEFINES accumulate various build-time
settings with += (i.e. space separated tokens), and at this point
finally it is turned into a colon separated tokens, which cannot be
written with a recursively expanded variable.

But I tend to agree that you do not have to := clear the list in
this patch.
