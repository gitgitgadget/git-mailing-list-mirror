Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 645BB203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 16:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985AbcGYQyB (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 12:54:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58882 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752143AbcGYQx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 12:53:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 825A4308A1;
	Mon, 25 Jul 2016 12:53:58 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rGfLWS8YhIj72oJVbfIp22rjjTg=; b=abLzXC
	lgSW/wvUyzEZvWytEIkQ5egKg9HII8bgWM16Nw8xOjxV4w7pgnB1p8mLyUFCUI5U
	mrnL/xoq5t0+kdLnTzRAMtTWoaS4ZVG/K6MoJAc49A9CI+DcOjtFQr8GyTk15Q8h
	/AlhgJbSGStJpvpHar5KvUNqjiiBCW/VP8Tko=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bCQd29phYOrlFgowgFVVRzyQJl5WB1Pg
	0PrvN0pTWR0cWQHifKC3XMjs8L73LkGGzrbdXaHitlYqLwZZRkTSAqRVEJIB6pRN
	4b3MPVo+on82EEHkAiAZDPYJdYNRywYzuWfEdMS8cjijD3dGDZkTvCRFqmrYGlUu
	0XMjXq/OfEA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B3C6308A0;
	Mon, 25 Jul 2016 12:53:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 043EE3089F;
	Mon, 25 Jul 2016 12:53:57 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Pranit Bauva <pranit.bauva@gmail.com>
Cc:	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH v10 12/12] bisect--helper: `get_terms` & `bisect_terms` shell function in C
References: <010201560a4781be-e8418d6a-5996-45cd-b11b-ca25894ad7f2-000000@eu-west-1.amazonses.com>
	<010201560a4782ce-8d6545f1-2454-492b-a2c6-6e0f2ac824d4-000000@eu-west-1.amazonses.com>
	<7a408f75-74d9-7e59-35d6-3a931414a7f9@web.de>
	<CAFZEwPOH+V+Nfq1KoOBBdVgeFD7YCG5c1PJrUHB50O1DkMg39Q@mail.gmail.com>
Date:	Mon, 25 Jul 2016 09:53:55 -0700
In-Reply-To: <CAFZEwPOH+V+Nfq1KoOBBdVgeFD7YCG5c1PJrUHB50O1DkMg39Q@mail.gmail.com>
	(Pranit Bauva's message of "Fri, 22 Jul 2016 19:37:35 +0530")
Message-ID: <xmqqh9bd7j6k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6125E0EE-5288-11E6-A5BC-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

>>> +enum terms_defined {
>>> +       TERM_BAD = 1,
>>> +       TERM_GOOD = 2,
>>> +       TERM_NEW = 4,
>>> +       TERM_OLD = 8
>>> +};
>>> +
>>
>> What does TERM stand for  ?

The terms (words) used to denote the newer and the older parts of
the history.  Traditionally, as a regression-hunting tool (i.e. it
used to work, where did I break it?), we called older parts of the
history "good" and newer one "bad", but as people gained experience
with the tool, it was found that the pair of words was error-prone
to use for an opposite use case "I do not recall fixing it, but it
seems to have been fixed magically, when did that happen?", and a
more explicit "new" and "old" were introduced.

>> And why are the defines 1,2,4,8 ?
>> It looks as if a #define bitmap may be a better choice here ?
>> How do we do these kind of bit-wise opions otherwise ?

We might want to ask if these should even be bitwise option.  A word
with individually controllable bits (i.e. "flag word") makes sense
only when the bits within it are largely independent.  But the code
does this pretty much upfront:

>>> +       if (term_defined != 0 && term_defined != TERM_BAD &&
>>> +           term_defined != TERM_GOOD && term_defined != TERM_NEW &&
>>> +           term_defined != TERM_OLD)
>>> +               die(_("only one option among --term-bad, --term-good, "
>>> +                     "--term-new and --term-old can be used."));

which is a very strong indication that these bits are not.

I suspect that OPTION_CMDMODE would be a better choice to group
these four options and mark them mutually incompatible automatically
than OPT_BIT?
