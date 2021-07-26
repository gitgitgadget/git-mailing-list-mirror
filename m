Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1494CC4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 17:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E491960F8F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 17:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbhGZRQV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 13:16:21 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63515 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbhGZRQU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 13:16:20 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 106011534A3;
        Mon, 26 Jul 2021 13:56:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PJbVXRUNjLh9FUvRnkndQLO58yTsNbCBZFcEJC
        UNyY4=; b=Mz/gStKWRk3Hl9F9kSCpOfu20gswLJEFFa2L5emrFoR6Fs405Mqhfg
        aiXJ1N0OBUEWYYxERwx1pDs0XdpuftaqPPgnyCwi0GJapxAQi28YGtMLyhWficBI
        2zPaWeri1ALySI1/s+LoeCpFBAAUwgELIt6NFSy91SkfOlGIc2CGA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 07FF41534A2;
        Mon, 26 Jul 2021 13:56:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4EC5A153484;
        Mon, 26 Jul 2021 13:56:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Duy Nguyen <pclouds@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 0/5] mingw: handle absolute paths in expand_user_path()
References: <pull.66.v2.git.1625155388.gitgitgadget@gmail.com>
        <pull.66.v3.git.1627164413.gitgitgadget@gmail.com>
Date:   Mon, 26 Jul 2021 10:56:44 -0700
In-Reply-To: <pull.66.v3.git.1627164413.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Sat, 24 Jul 2021 22:06:48
        +0000")
Message-ID: <xmqqk0ldj6w3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D7F20420-EE3A-11EB-8E9F-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

>  * Since our convention of %(...) interpolation does not involve uppercase
>    keywords, I now use a lowercase one.

Makes sense.

>  * Since this keyword is interpolated to the compiled-in prefix if built
>    without runtime prefix support, I dropped the runtime part of the
>    keyword.

I have this nagging feeling that %(prefix) may be (mistakenly)
expected to interporate to $(git rev-parse --show-prefix).  Of
course, nobody would expect that in paths in the configuration
files, but because we are borrowing %(token) convention from
elsewhere, it is not outragous to imagine that either "for-each-ref"
family or "log" family of placeholders may want to use %(prefix)"
for such purpose (for that matter, they may also be helped to have
the runtime-prefix information available).

Perhaps %(installPrefix) or something may have less chance of making
us regret later.  I am just raising this as a possible problem; I
personally would not be confused if we settled on the %(prefix).

>  * Renamed the expand_user_path() to interpolate_path(), to remove the
>    distraction as to the implementation detail which things get to be
>    interpolated (because we extend it to interpolate more than just a home
>    directory, which might well be unclear from the former name, anyway).

Great.

>  * Adjusted the code comment above the interpolate_path() to remove a stale
>    part, clarify another part, and to extend it to talk about the prefix
>    expansion, too.

These looked good, too.

Thanks.
