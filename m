Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69A3B1F859
	for <e@80x24.org>; Fri, 12 Aug 2016 16:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596AbcHLQMb (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 12:12:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62621 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752575AbcHLQMa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 12:12:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3965D34C0E;
	Fri, 12 Aug 2016 12:12:29 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1ma03IOi7faP8izrcg8+KHmzxEc=; b=aw2hFC
	uVGcasGriqvjFVkKD3WFA9x0bJ+pU2se2tWtVYxR3SB7uCi61gpgx8bKtAaa4JPR
	vCCB7JmCv/6goohWDXtSUhVT0IeKr/RR4Mj+U7+x1blx/m24/kHGskJAyXw6u5U3
	WSTHZwOkFQ2DGgShqRlUrzmJ72m5Sp++q0CP8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IhROl70VoMhk5NWQK0S/M2r+lD2HfHqI
	OX9dGf7LxGSfcznQ7oePpr7+hBCW4MvN/J24NHYAP9AzhnBsv7An33O3469KEj9m
	uGC7jzP+azcywM8dcrO2Hp4C6k8Li+0PckLMD2JqTrDPYW79uPc3YawKuKfjhneO
	J7dzVc8pHKU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 30C2034C0D;
	Fri, 12 Aug 2016 12:12:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A6D2534C0C;
	Fri, 12 Aug 2016 12:12:28 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	jrnieder@gmail.com, git@vger.kernel.org,
	remi.galan-alfonso@ensimag.grenoble-inp.fr
Subject: Re: [PATCHv3] checkout: do not mention detach advice for explicit --detach option
References: <20160812153744.15045-1-sbeller@google.com>
Date:	Fri, 12 Aug 2016 09:12:26 -0700
In-Reply-To: <20160812153744.15045-1-sbeller@google.com> (Stefan Beller's
	message of "Fri, 12 Aug 2016 08:37:44 -0700")
Message-ID: <xmqqmvkix8yd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 90D32626-60A7-11E6-8369-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> When a user asked for a detached HEAD specifically with `--detach`,
> we do not need to give advice on what a detached HEAD state entails as
> we can assume they know what they're getting into as they asked for it.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> Thanks for the review!
>
>> Is there a reason for not unsetting `advice.detachedHead` at the
>> end of the test?
>
> done
>
> I did not consider to clean up after myself... what a selfish world!

;-)

Using test_config instead of "git config" would help.

> +test_expect_success 'no advice given for explicit detached head state' '
> +	git config advice.detachedHead false &&
> +	git checkout child &&
> +	git checkout --detach HEAD >expect &&
> +	git config advice.detachedHead true &&
> +	git checkout child &&
> +	git checkout --detach HEAD >actual &&
> +	test_cmp expect actual &&

The above is meant to see explicit "--detach" gives the same message
whether advice.detachedHead is set to true or false, which is good.
It however does not make sure these messages do not caution about
detaching.

> +	git checkout child &&
> +	git checkout HEAD >actual &&

This goes to "child" branch and then does a no-op "checkout HEAD"
that does not even detach.

> +	! test_cmp expect actual &&

And then it compares the message from a no-op "checkout" and
the previously obtained message from a detaching "checkout".

Another thing that this is not checking is that a detaching
"checkout" without an explicit "--detach" still gives the advice
when advice.detachedHead is set to true (or left to default, for
that matter).

Perhaps you would want to do it a bit differently.  How does this
look?

    # baseline
    test_config advice.detachedHead true &&
    git checkout child && git checkout HEAD^0 >expect.advice &&
    test_config advice.detachedHead false &&
    git checkout child && git checkout HEAD^0 >expect.no-advice &&
    test_unconfig advice.detachedHead &&
    # without configuration, the advice.* variables default to true
    git checkout child && git checkout HEAD^0 >actual &&
    test_cmp expect.advice actual &&

    # with explicit --detach
    # no configuration
    test_unconfig advice.detachedHead &&
    git checkout child && git checkout --detach HEAD >actual &&
    test_cmp expect.no-advice actual &&

    # explicitly ask advice
    test_config advice.detachedHead true &&
    git checkout child && git checkout --detach HEAD >actual &&
    test_cmp expect.no-advice actual &&

    # explicitly decline advice
    test_config advice.detachedHead false &&
    git checkout child && git checkout --detach HEAD >actual &&
    test_cmp expect.no-advice actual

It might be controversial how the second from the last case should
behave, though.
