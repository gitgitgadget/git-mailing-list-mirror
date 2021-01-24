Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B887C433DB
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 05:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C07722C9C
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 05:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbhAXFd4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 00:33:56 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64792 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbhAXFdz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 00:33:55 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3B1EA11ABAE;
        Sun, 24 Jan 2021 00:33:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=lMxd1WSf9f0S
        Z1oIT2tU54iAaSw=; b=qaemHnIO+BSkuy/J7vhvbILEgOnUl8l+bEv5KuD8OMdj
        Wznsex33K2has8o65i7ZPt7pjcG+HZTbIyTYdn1JV21F/w9soWIJRVwng5hbT3UX
        hWeaQneAZXypXSxjVkw3vXXlne24nyKE//HCaAwbQ1ztycSN+pnqaRm7IEqJKds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=DdSkJf
        diinUrlLhNHWGWREhiLxkVk/SVVP/wW7a9hT1Cp7rzypoITo1QSK2v8c8bw7dZ5O
        9tRCnXDNVl9e55Nlogay6oB6xsPU+6dpduqkWxDuIVPNpFwcKzmZAGALitKB85RX
        0jqpMCK+L8LGQzm8KcV3+vNQBpdXc0VKvYU0o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 33C8111ABAA;
        Sun, 24 Jan 2021 00:33:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7ED0211AB67;
        Sun, 24 Jan 2021 00:33:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v3 2/4] grep/pcre2: simplify boolean spaghetti
References: <20190726150818.6373-9-avarab@gmail.com>
        <20210124021229.25987-3-avarab@gmail.com>
Date:   Sat, 23 Jan 2021 21:33:08 -0800
In-Reply-To: <20210124021229.25987-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sun, 24 Jan 2021 03:12:27 +0100")
Message-ID: <xmqqim7m292j.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A541D886-5E05-11EB-BE4A-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

>     NOT(A && B) is Equivalent to (NOT(A) OR NOT(B))

At this level, however, the left one looks much simpler than the
right one ;-)


>  	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->patte=
rn) &&
> -	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
> +	    (opt->ignore_case || !(p->fixed || p->is_fixed)))
>  		options |=3D PCRE2_UTF;

In the context of this expression, well, I guess the rewritten one
is probably simpler but can we explain the whole condition in fewer
than three lines?  With or without the rewrite, it still looks too
complicated to me.


