Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A54EC2B9F7
	for <git@archiver.kernel.org>; Tue, 25 May 2021 01:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79082613F6
	for <git@archiver.kernel.org>; Tue, 25 May 2021 01:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhEYBFV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 21:05:21 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59260 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhEYBFU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 21:05:20 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BC08113FE27;
        Mon, 24 May 2021 21:03:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=mIzPspj813mx
        L/bHs3O2ky7ZjqtKKuVG5iV0E7MA3Rc=; b=qRZhc+gEPHnAuEmcHYkgPC2Cdj7k
        ugRTBTPKwRtZnPA/62RtwEhVKQPI11usNSs6Td5M2oit+UgqCjKWHiLu5Np2TN6V
        /MOkugt2x3OmOvHimlUEC3J0EZG4HznZYMJVe0Ge4FmCMXdFxOqbkF/ANzfc/Q1g
        K1VMKAfXdnHJyNU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A7FCB13FE26;
        Mon, 24 May 2021 21:03:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DB73013FE25;
        Mon, 24 May 2021 21:03:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Robert Foss <robert.foss@linaro.org>
Subject: Re: [PATCH 2/2] send-email: don't needlessly abs_path() the
 core.hooksPath
References: <bb30fe2b-cd75-4782-24a6-08bb002a0367@kdbg.org>
        <cover-0.2-00000000000-20210524T231047Z-avarab@gmail.com>
        <patch-2.2-d097e7b0b81-20210524T231047Z-avarab@gmail.com>
Date:   Tue, 25 May 2021 10:03:47 +0900
In-Reply-To: <patch-2.2-d097e7b0b81-20210524T231047Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 25 May
 2021 01:14:25 +0200")
Message-ID: <xmqqh7iripzg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 102A6340-BCF5-11EB-A372-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> In c8243933c74 (git-send-email: Respect core.hooksPath setting,
> 2021-03-23) we started supporting core.hooksPath in "send-email". It's
> been reported that on Windows[1] doing this by calling abs_path()
> results in different canonicalizations of the absolute path.

I see the author of that patch CC'ed; the change in question
explains why we switched from "the hooks directory immediately under
$repo->repo_path()" to "ask 'rev-parse --git-path hooks'", but it
does not say why we call abs_path() on the result.  I guess that is
because $repo->repo_path() has always been a result of applying the
abs_path() function to something, so it was to safeguard the callers
that expect an absolute path coming back from hooks_path?

And that makes this change dubious, especially as a band-aid for a
breakage immediately before the final release, doesn't it?  Are we
convinced that the callers are OK with seeing sometimes relative
paths?  Certainly the cases the tests J6t fixed are not negatively
affected, but is that sufficient?  To what directory is the
configuration variable supposed to be relative to, and are we sure
that the user will always invoke "git send-email" from that
directory?

Puzzled.

