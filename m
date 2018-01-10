Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A732C1F404
	for <e@80x24.org>; Wed, 10 Jan 2018 21:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752485AbeAJVO1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 16:14:27 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58520 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751366AbeAJVOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 16:14:25 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 15A79D29B2;
        Wed, 10 Jan 2018 16:14:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=g4lucjREzvK4/RdR+d+5Jx8o1gM=; b=MzI4oJ
        U7uCy4/rOl8tgxwYlVyv5RtcaPpDY+GN4PGmPN2kgwG55wVSQ7dGBwAWlqiLTcU+
        gwrNtUNw98JluViDsmK0QcgaDTZvkPOnBhBkSefEKSprVifPbj7oJbI3NZefGd1D
        yf6c7+qoBJ6lgSEVjztY8aV9fP33fbGaR42Tg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aHIMwvsCdCkprdyedSAPyM1WZdnTqAjD
        9MxxQq/L5GG5D+w1ByN/i6toknr45yY/lyq1RbFO5gERERCYNcZAIPY0ndoC8WnL
        LjjEedg0pGEicFNB97B3OH4wVkBbv1+6v2j7UEAiyvoE42A80lv+qKEhFWH+R5zp
        1RqA6HqrHOM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 07BE0D29B1;
        Wed, 10 Jan 2018 16:14:25 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 72625D29B0;
        Wed, 10 Jan 2018 16:14:24 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: prepare-commit-msg hook no longer run for cherry-pick?
References: <CAKdAkRQuj1hfKeckjuR2oP+8C1i+ZR36O-+aRYif4ufaS_zs+w@mail.gmail.com>
        <CAKdAkRTK=0Kafc-nhvJTu+9m-pp=BV3Oc-gu6ssjZZQm95pC_Q@mail.gmail.com>
        <xmqq1siy30zd.fsf@gitster.mtv.corp.google.com>
        <CAKdAkRSuNhEri+3eUbX8iVjr0JUyADSJBtgL==VjNwgKwe3Xqw@mail.gmail.com>
Date:   Wed, 10 Jan 2018 13:14:23 -0800
In-Reply-To: <CAKdAkRSuNhEri+3eUbX8iVjr0JUyADSJBtgL==VjNwgKwe3Xqw@mail.gmail.com>
        (Dmitry Torokhov's message of "Wed, 10 Jan 2018 11:25:59 -0800")
Message-ID: <xmqq373d1knk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3BD4DCE2-F64B-11E7-9F13-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:

> Right, so it looks like the master works well, it is next(?) branch
> that is troublesome (apparently we pack experimental internally?).
>
> I bisected it down to:
>
> commit 356ee4659bb551cd9464b317d691827276752c2d (refs/bisect/bad)
> Author: Phillip Wood <phillip.wood@dunelm.org.uk>
> Date:   Fri Nov 24 11:07:57 2017 +0000
>
>    sequencer: try to commit without forking 'git commit'
> ...
>
> With this commit the hook is not being run unless I specify '-e' flag
> to cherry-pick.

Thanks.

