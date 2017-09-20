Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD3DF2047F
	for <e@80x24.org>; Wed, 20 Sep 2017 01:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751605AbdITBpJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 21:45:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51554 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750895AbdITBpI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 21:45:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2AF33A9071;
        Tue, 19 Sep 2017 21:45:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CQkczcFn3KyxUxDKPn1g77wnDpo=; b=IEwNxS
        ySM4lpmT9sEhlAz3eA2CLLb881Q+2jLK9ykqmkQ5cfRN3zCQVhBMN2TP++CB1jIz
        0yB4d7Ul4DHss/DnX6/vK7p4IT5uN7ypqUCAyuC77fyYXedtae4o9xxGWWc2rLOW
        IrKfb/p7atwNv7bJJ/+0veNR+pFELr1ISxfhg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZudfAYtQQzzTOP9sdRblelt05F6MzREo
        sZg8QDNPWpMcAyO3Qg3KD/h3oXmQ7mfQjboDS4Ukoe+f1XxtAdLSYFrp0ETkn8iW
        oUCTki02OL3Z1XsTKUsIy2Arl9e1d5gBS6E0dTUR49xeC02QnRrrjcW63/0aYn0b
        hM+VvouX2jY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 219C9A9070;
        Tue, 19 Sep 2017 21:45:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4B31CA906F;
        Tue, 19 Sep 2017 21:45:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2 10/10] add UNLEAK annotation for reducing leak false positives
References: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
        <20170908063841.wb23ibs2ancdct2v@sigill.intra.peff.net>
        <20170919134552.7845f021@twelve2.svl.corp.google.com>
        <20170919210300.cbrdjqor6xuwd7bs@sigill.intra.peff.net>
Date:   Wed, 20 Sep 2017 10:45:05 +0900
In-Reply-To: <20170919210300.cbrdjqor6xuwd7bs@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 19 Sep 2017 17:03:01 -0400")
Message-ID: <xmqqzi9qp2hq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 54ADBA1C-9DA5-11E7-B770-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Sep 19, 2017 at 01:45:52PM -0700, Jonathan Tan wrote:
>
>> The following comments are assuming that we're going to standardize on
>> UNLEAK(var); (with the semicolon).
>
> Yeah, I assumed we would. We don't have to, since this really is sort-of
> magical, but I think the code looks better with it.
>
>> On Fri, 8 Sep 2017 02:38:41 -0400
>> Jeff King <peff@peff.net> wrote:
>> 
>> > +#ifdef SUPPRESS_ANNOTATED_LEAKS
>> > +extern void unleak_memory(const void *ptr, size_t len);
>> > +#define UNLEAK(var) unleak_memory(&(var), sizeof(var));
>> 
>> I would feel better if the semicolon was omitted. I don't think it
>> matters in this particular case, though.
>
> You end up with a double semi-colon. Some linters might complain.

Yeah, and it makes

	if (some condition)
		UNLEAK(var);
	else
		do_something_else_to(var);

a syntax error.

Should have spotted during the review; sorry.

>
>> > +#else
>> > +#define UNLEAK(var)
>> 
>> I think this should be defined to be something (for example, "do {}
>> while (0)"), at least so that we have compiler errors when UNLEAK(var)
>> is used incorrectly (for example, without the semicolon) when
>> SUPPRESS_ANNOTATED_LEAKS is not defined.
>
> Seems reasonable.

Hmph, I am not so sure about this one.  But I agree that the
semicolon must go.


>
> I think both are worth doing, but the patch is already in next so we
> need to do it on top. Do you want to prepare a patch?
>
> -Peff
