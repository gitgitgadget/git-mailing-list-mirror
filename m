Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9CDD20958
	for <e@80x24.org>; Thu, 23 Mar 2017 20:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754588AbdCWUFz (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 16:05:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56832 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751355AbdCWUFy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 16:05:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 84EE6678B1;
        Thu, 23 Mar 2017 16:05:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=n4CfJOCO/qLZ
        jglEl6VRebyNfis=; b=m2SPqa4BiPNfYhr7d3SZT+eA79TIbw5ETqWnMcKbJ3nW
        9ZiywpMKhjus7o9tFnnkxMJIXBomcVJmr32esatMr2Rl0aCXNkQPI4BnlVEiTlkI
        UyUvan0/yMVQeTanp5LrIKa9S0ZJ9uOpF8ihMuDQgFFK9h6JNJiaphumPYuX7Ew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=j38M9N
        JyHIGWHV8NqjXZ64ry/q4yebIh2aEZlzbbeEdMn1GHUaW5VyZKBy6Z1fRxJVdN56
        avFqyWASFAvSsccYIqGsGP1pRxJ1e5/bTB0j422l+f14nbv9boYkgCQQ1mLlELgl
        npVXR5140RW58Rro/OJBv3i4SnXjiL637o/2E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D08B678AF;
        Thu, 23 Mar 2017 16:05:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CAA0C678AE;
        Thu, 23 Mar 2017 16:05:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] refs.c: use skip_prefix() in prettify_refname()
References: <20170323155012.6148-1-szeder.dev@gmail.com>
        <4382e211-63f6-811f-6f33-1cf5d2c087a8@web.de>
        <20170323192313.ytr56pjpnillnh63@sigill.intra.peff.net>
        <xmqqvaqzbxfx.fsf@gitster.mtv.corp.google.com>
        <20170323193919.twwfwdoulo2hjz24@sigill.intra.peff.net>
Date:   Thu, 23 Mar 2017 13:05:24 -0700
In-Reply-To: <20170323193919.twwfwdoulo2hjz24@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 23 Mar 2017 15:39:19 -0400")
Message-ID: <xmqqmvcbbvy3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0E039368-1004-11E7-B359-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Mar 23, 2017 at 12:33:06PM -0700, Junio C Hamano wrote:
>
>> >> Nice, but why add the "if" when it's doing nothing?
>> >
>> > It's short-circuiting in the conditional.
>>=20
>> I think Ren=C3=A9 meant this:
>>=20
>>      /* just for side effects */
>>      skip_prefix(name, "refs/heads/", &name) ||
>>      skip_prefix(name, "refs/tags/", &name) ||
>>      skip_prefix(name, "refs/remotes/", &name);
>>=20
>>      return name;
>>=20
>> which still short-sircuits, even though I do think it looks
>> strange; "correct but strange".
>
> And it causes the compiler to complain that the value is not used.

Ahh.  OK.

In any case, I've queued the original with "if", which shouldn't
have that problem ;-)
