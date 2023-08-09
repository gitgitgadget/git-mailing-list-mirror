Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBD1C001B0
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 01:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjHIBnq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 21:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjHIBno (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 21:43:44 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1BC1BCD
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 18:43:43 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C1DE91B23C8;
        Tue,  8 Aug 2023 21:43:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=MzddV+jwle0Q
        yW5UjKowd9qeC9k4/fnQSlTYwFARC6c=; b=qcQhwUy4QWTCTN+UzWXetme/lDoZ
        NGhTaAHrRnGfizDq5URCny0aZdKenp+zx0rPWNz8biL5TupaiXWIS//T5QkG3CGH
        cruxF8bJBd76jdjpa5z4JyGH3KAThL0ZCFwEL+0phJjTEQX5gs6qiA38exLIb/vR
        acv5pR1Hb07Ifts=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B8E391B23C7;
        Tue,  8 Aug 2023 21:43:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 29CF31B23C6;
        Tue,  8 Aug 2023 21:43:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] describe: fix --no-exact-match
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
        <xmqqo7k9fa5x.fsf@gitster.g>
        <4eea7e15-6594-93e2-27b5-3d6e3c0baac6@web.de>
        <20230808212720.GA760752@coredump.intra.peff.net>
Date:   Tue, 08 Aug 2023 18:43:41 -0700
In-Reply-To: <20230808212720.GA760752@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 8 Aug 2023 17:27:20 -0400")
Message-ID: <xmqqzg3156sy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2B9D2A90-3656-11EE-B0B3-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Jul 21, 2023 at 03:41:33PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> +static int option_parse_exact_match(const struct option *opt, const c=
har *arg,
>> +				    int unset)
>> +{
>> +	BUG_ON_OPT_ARG(arg);
>> +
>> +	max_candidates =3D unset ? DEFAULT_CANDIDATES : 0;
>> +	return 0;
>> +}
>
> I wanted to call out a style question here. The "opt" parameter is
> unused, since it manipulates the "max_candidates" global directly. I ca=
n
> add an UNUSED annotation to satisfy -Wunused-parameter, but in such
> cases I've usually been modifying them like:
>
>   int *value =3D opt->value;
>   ...
>   *value =3D unset ? DEFAULT_CANDIDATES : 0;
>
> so that the callback operates on the value passed in the options list.

Yeah, I wasn't paying attention to that particular detail, but I
tend to think that using opt->value to point at the variable would
make sense here.  That approach matches what is internally done by
OPT_STRING_LIST() and OPT_STRVEC(), the built-in types that are
implemented via the same OPTION_CALLBACK mechanism.

One good thing about it is that it makes it clear, without looking
at the implementation of the callback function, which variables are
affected only by looking at what OPT_CALLBACK() says.

> So before I sent a patch (either to switch to using opt->value, or to
> add an UNUSED annotation), I wanted to see what you (or others) thought
> between the two. I.e., should we have a rule of "try not to operate on
> global data via option callbacks" or is that just being too pedantic fo=
r
> one-off callbacks like this?

So, that was my preference, but I may be missing some obvious
downsides.  I am interested in hearing from Ren=C3=A9, who often shows
better taste than I do in these cases ;-)

Thanks.
