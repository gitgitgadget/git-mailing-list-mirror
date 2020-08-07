Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E535AC433E0
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 04:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C34DB22CF7
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 04:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DKTcRo7j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgHGEJl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 00:09:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50038 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgHGEJl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 00:09:41 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BAF081EAE;
        Fri,  7 Aug 2020 00:09:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BOs0r04HqPeXkscuuCnmnS74pV8=; b=DKTcRo
        7jzH4yS6YMpsGnI/xVEwWHv+5ClYFUP4fnsC1wT91Tz0lTOsu6ZUD+EEfWfV6/YJ
        ZEASo0LKP5dj1evZkS9xxzQCropYEH6jc5y5tajNmqcZWGcEu9FsiIHYVElioGR3
        1BpA0Px9BzfayzTzWrIlZJf5qgPwx78492hmU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aR690EgNcxmN9gdl9vd3sH+30jQxJeKN
        eYMzA+Wf4Kax4/GNo965s+jfGoGryyfBrNa5UWCruKu4oeA4FZ5nbEUmOMz1e1bX
        jEjUBOeRvcuIzTmuTkp5W1DE6rxurN4wpOBRMEG8q0gSMRTBpGZqyrvz1HKg2RMN
        uwN9GPVHij4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 63ED081EAD;
        Fri,  7 Aug 2020 00:09:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D927581EAC;
        Fri,  7 Aug 2020 00:09:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: "#define precompose_argv(c,v) /* empty */" is evil
References: <xmqqy2mribft.fsf@gitster.c.googlers.com>
        <20200807000126.GC8085@camp.crustytoothpaste.net>
        <xmqqpn83i9sk.fsf@gitster.c.googlers.com>
        <20200807032723.GA15119@coredump.intra.peff.net>
Date:   Thu, 06 Aug 2020 21:09:38 -0700
In-Reply-To: <20200807032723.GA15119@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 6 Aug 2020 23:27:23 -0400")
Message-ID: <xmqqh7tfhzb1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CFDEDB02-D863-11EA-A2A9-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> But this one for example:
>
>> -#define flockfile(fh)
>> -#define funlockfile(fh)
>> +static inline void flockfile(FILE *fh)
>> +{
>> +	; /* nothing */
>> +}
>> +static inline void funlockfile(FILE *fh)
>> +{
>> +	; /* nothing */
>> +}
>
> is re-defining a name that's usually reserved for the system (at least
> on POSIX systems). For most systems that define it, we'd actually use
> the system version (and not compile this code at all).

> But there may be
> systems where we choose not to (either the system version is deficient,
> or we're testing the fallback code on a more-capable system, or our
> #ifndef check isn't sufficient on that system for some reason).

Hmph, perhaps.  We'll cross that bridge when we need to port to such
a system, and until then, doing this will more easily catch the need
to cross that bridge, I would imagine.

> If the system defines it as a macro, we'd probably get a garbled
> compiler error as the macro is expanded here. Adding #undef flockfile,
> etc beforehand would help. I'm not sure if the current code might give
> us a macro redefinition warning on such a system.
>
> If the system defines it as a function, we'd probably get redefinition
> warnings.
>
> So...I dunno. Those are all theoretical complaints. But I also think
> what it's buying is not very big:
>
>   - unlike precompose_argv(), modern POSIX-compliant systems (which we
>     all tend to develop on) don't hit this fallback code. So your
>     average developer is likely to see any problems here.

That's OK.  I am not particularly interested in systems that has to
ifdef out flockfile() and funlockfile().  I did these two primarily
to reduce the number of instances of the bad pattern to implement a
no-op replacement as C-preprocessor macro that can be copied by less
experienced developers.

>   - this is really the tip of the portability iceberg anyway. In the
>     example that motivated this thread, you were catching failures to
>     adjust to strvec. But in code like this:
>
>       #ifdef FOO
>       void some_func(int x, const char *y)
>       {
>               struct argv_array whatever = ARGV_ARRAY_INIT;
> 	      ...
>       }
>       #else
>       void some_func(int x, const char *y)
>       {
>               /* do nothing */
>       }
>       #endif

Yes, of course, but as I wrote in my response to Brian, the whole
point of using these replacement implementation macros is so that we
do not have to sprinkle the main code with such #ifdef/#endif, so
I think the code like that is what needs to be corrected ;-)

>> @@ -270,7 +272,9 @@ struct itimerval {
>>  #endif
>>  
>>  #ifdef NO_SETITIMER
>> -#define setitimer(which,value,ovalue)
>> +static inline int setitimer(int which, const struct itimerval *value, struct itimerval *newvalue) {
>> +	; /* nothing */
>> +}
>>  #endif
>
> Same reasoning applies to this one, plus the added bonus that we'd need
> that struct type defined. brian mentioned using "void *".

See my message to Brian.
