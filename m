Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 067C620899
	for <e@80x24.org>; Sat, 12 Aug 2017 00:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751783AbdHLAtG (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 20:49:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55263 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751439AbdHLAtG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 20:49:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 826E390A4F;
        Fri, 11 Aug 2017 20:48:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=P23KkQXpR8/pxheQSeXHEUEb0Qw=; b=OxSPSI
        JWUZX1etK5ATd5tB+NiRu4XYO5sSandaS7AxOubJR/eYHsFDMu3QhAxUedqrpSZm
        VeolgB35f9m94/eSQIYjLThun9bh0kaDuVB0RaEOdky+jwI4iQcuoJk7PRRbmD/G
        7bQOStPZpEc5sqzNucBbymW0nOo6eJ5Kq2rLU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AXS+oGIY0rJ1B+vZh537IqhGe3EIieQn
        sb/WVQyQIemn7MiNe1ScSpCvF7w//N2Ui8lyXgz9/iD4nXdDolS21Q4jQ6nzxHPg
        FLqjR9vB33LyZJ950507lP7JLGI/vUlqZQXJQClo6/S1cT/pk3boHupt9prQIdxF
        DFgrMlYhNKI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 799C590A4E;
        Fri, 11 Aug 2017 20:48:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DB1AB90A49;
        Fri, 11 Aug 2017 20:48:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCHv5 1/2] clone: respect additional configured fetch refspecs during initial fetch
References: <CAM0VKjmxtqB2zrWOW8T9O1ReWNPTZA7V3-Dei7GecB3nxVh2Dg@mail.gmail.com>
        <20170616173849.8071-1-szeder.dev@gmail.com>
        <20170616173849.8071-2-szeder.dev@gmail.com>
        <20170617112228.vugswym4o4owf6wj@sigill.intra.peff.net>
        <xmqqmv8zhdap.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 11 Aug 2017 17:48:57 -0700
In-Reply-To: <xmqqmv8zhdap.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 22 Jun 2017 15:23:42 -0700")
Message-ID: <xmqqbmnly5ja.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 06CC432A-7EF8-11E7-9DA8-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> I'd still prefer this to have:
>>
>>   if (!remote->fetch && remote->fetch_refspec_nr)
>> 	BUG("attempt to add refspec to uninitialized list");
>>
>> at the top, as otherwise this case writes garbage into remote->fetch[0].
>>
>> I see you have another series dealing with the lazy parsing, but I
>> haven't looked at it yet (hopefully this danger would just go away after
>> that).
>>
>> Other than that, the patch looks fine to me.
>
> SZEDER?  As long as the end result together with two series are
> safe, I do not have a strong preference, but given that the other
> one is a lot more invasive change [*1*], I think it is nicer to have
> this two-patch series already safe without the other one.
>
> What's your take on Peff's point?
>
> [Footnote]
>
> *1* Especially the other branch does not merge cleanly into 'pu' and
>     I haven't managed to include it in my tree yet.

After infinite amount of time has passed, I no longer even remember
what "the other" topic was X-<.  I'll tentatively eject these two
patches from my tree in preparation for starting the cycle after Git
2.14 early next week, but hopefully you can find time and energy to
resurrect it.

Or somebody else may be interested to take the topic over--which is
also fine by me, too.

Thanks.
