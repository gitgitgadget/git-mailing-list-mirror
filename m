Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E3BD1FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 21:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753926AbcLSVBw (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 16:01:52 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56194 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754087AbcLSVBv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 16:01:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BC7759B04;
        Mon, 19 Dec 2016 16:01:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PzqqPPPE1pivDoWNvF1v8edhOlM=; b=Bzv3LX
        EH7mPL301cm3+iS7+31sv0D9NegngnKi9pfbfdmboshY9WwB3JrkXtgZ43lpJ8UI
        wzmZJtVjojHgZVjftT0qiWxO2JkXcokr3Op7hMh+6OnW+2nviifo3Id8TNN0EeYd
        YYlC5cDAdSKeIi68Ea65PufUwdIpGg6UH/Rm8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MP3yUTGVLFOslch9/E0eqr58653B4QTn
        6segL3rdjybJnvvvvjCVPp53ys1l6fvtZ13I5VfGjCi/RVGEuw0Xu8FmBUyxHA2H
        od5EPMoaTjff9hK/+5fxrKq7QDOeb7jfbcWsQFv0tM4ZSyln4KRSuYzqX652b7Hx
        m/R/1yNyG1E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 63CFD59B03;
        Mon, 19 Dec 2016 16:01:50 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D574659B02;
        Mon, 19 Dec 2016 16:01:49 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     "Kyle J. McKay" <mackyle@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] mailinfo.c: move side-effects outside of assert
References: <900a55073f78a9f19daca67e468d334@3c843fe6ba8f3c586a21345a2783aa0>
        <20161219200259.nqqyvk6c72bcoaui@sigill.intra.peff.net>
        <A916CED6-C49D-41D8-A7EE-A5FEDA641F4A@gmail.com>
        <d5690ac7-ff62-99b9-7e7e-929bd7f0433b@google.com>
Date:   Mon, 19 Dec 2016 13:01:48 -0800
In-Reply-To: <d5690ac7-ff62-99b9-7e7e-929bd7f0433b@google.com> (Jonathan Tan's
        message of "Mon, 19 Dec 2016 12:54:15 -0800")
Message-ID: <xmqqbmw7ocoz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C3B2DFE-C62E-11E6-B841-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>>> This is obviously an improvement, but it makes me wonder if we should be
>>> doing:
>>>
>>>  if (!check_header(mi, &mi->inbody_header_accum, mi->s_hdr_data))
>>>     die("BUG: some explanation of why this can never happen");
>>>
>>> which perhaps documents the intended assumptions more clearly. A comment
>>> regarding the side effects might also be helpful.
>>
>> I wondered exactly the same thing myself.  I was hoping Jonathan would
>> pipe in here with some analysis about whether this is:
>>
>>   a) a super paranoid, just-in-case, can't really ever fail because by
>> the time we get to this code we've already effectively validated
>> everything that could cause check_header to return false in this case
>> ...
> The answer is "a". The only time that mi->inbody_header_accum is
> appended to is in check_inbody_header, and appending onto a blank
> mi->inbody_header_accum always happens when is_inbody_header is true
> (which guarantees a prefix that causes check_header to always return
> true).
>
> Peff's suggestion sounds reasonable to me, maybe with an error message
> like "BUG: inbody_header_accum, if not empty, must always contain a
> valid in-body header".

OK.  So we do not expect it to fail, but we still do want the side
effect of that function (i.e. accmulation into the field).

Somebody care to send a final "agreed-upon" version?
