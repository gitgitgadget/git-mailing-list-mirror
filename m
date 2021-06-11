Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76988C4743D
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 07:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57586613B3
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 07:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhFKIBa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 04:01:30 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58771 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhFKIB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 04:01:27 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0C8D714A06C;
        Fri, 11 Jun 2021 03:59:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sJo4a03ObETlbLIY/KvlIiIh1PnIszp5pW5RTT
        6A2GY=; b=FcOJlbQK05S5Da6lTyWXyW9BzJu1nk4YDSFohnJVLKTlJYb/4zcVXw
        VecZ6EYFi8MVvTbbPKeW6qqMAiLPRtwDU4UZMTfQAIbKiBnO0/9myq9gEgyvJ24s
        W7uXrAr3JrOjJHY/eyP7JWa93n4AsU9ltBfGmnY74US2rQuwC78l8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0427014A06B;
        Fri, 11 Jun 2021 03:59:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 34FD414A06A;
        Fri, 11 Jun 2021 03:59:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH v3 1/2] submodule--helper: introduce add-clone subcommand
References: <20210608095655.47324-1-raykar.ath@gmail.com>
        <20210610083916.96243-1-raykar.ath@gmail.com>
        <20210610083916.96243-2-raykar.ath@gmail.com>
        <xmqqim2l3p92.fsf@gitster.g>
        <EAB5ABE4-B032-41AE-B39D-44D0D0A40D52@gmail.com>
Date:   Fri, 11 Jun 2021 16:59:23 +0900
In-Reply-To: <EAB5ABE4-B032-41AE-B39D-44D0D0A40D52@gmail.com> (Atharva
        Raykar's message of "Fri, 11 Jun 2021 13:02:57 +0530")
Message-ID: <xmqqk0n03k84.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F06471A6-CA8A-11EB-A8BD-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atharva Raykar <raykar.ath@gmail.com> writes:

> I think the larger concern I have to balance here is what level of
> "faithfulness" should I be having with this conversion. My current
> thoughts on this are:
>
>  - Functionality and behaviour should be as similar as possible.
>
>  - If there is an *obvious* bug that can be fixed in translation,
>    then I should fix it.
>
>  - If there are error messages that can be made more clear and
>    consistent with the rest of the Porcelain, then I'll make the
>    required change.

I have been assuming that we would draw the line between the second
one and the third one, that is, as little end-user visible behaviour
changes as possible, unless the behaviour being changed is a clear
bugfix, during the conversion.  Polishing the results into an even
better shape can and should be done after the initial conversion is
completed.  Switching from die() to fprintf() with error return would
be very desirable in the end result, but that would be a bit distracting
to read during the review of the initial conversion.

Thanks.

