Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00464C433DB
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 20:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C84066023B
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 20:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbhBJUbW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 15:31:22 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58151 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbhBJUbO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 15:31:14 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 23D45115852;
        Wed, 10 Feb 2021 15:30:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mo6TXE8SgZzSFxTwpom1btSN//Y=; b=bDgpYp
        5kGkzsSwqBztFaRjlwu/KSRMzs63N3d0U5rvwLHGKvH7NIi/993mF5pwOpJrqFx7
        JJJ2/Q9AcWgmfDRG7qmqSzXxTz0ZXqvIwPB4VIEWXkrkP53kITwXrhHBsQtORWkO
        xLNd8p0MsGShMr3vjZg8uKVnWdaeiclFZoeko=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YKqMxRjnWItc6OtANA94mD8BxgKBrRh9
        XM14kGyWEcVcx+Ziyh7zkpHUtMfjUO7F7w2BK00/D/hGfqZI52PVYmE+pXtjswKq
        TuGqFySX5lwSKV0BUKr4chmHVZCnSi2QdVY3e6HPatXfK337P/j2+amg+KnPc9so
        UMQoQWOhTR0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1CA48115851;
        Wed, 10 Feb 2021 15:30:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8C15B115850;
        Wed, 10 Feb 2021 15:30:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] reflog expire --stale-fix: be generous about missing
 objects
References: <pull.873.git.1612973499110.gitgitgadget@gmail.com>
Date:   Wed, 10 Feb 2021 12:30:27 -0800
In-Reply-To: <pull.873.git.1612973499110.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Wed, 10 Feb 2021 16:11:38
        +0000")
Message-ID: <xmqqy2fv1x98.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D0DB608E-6BDE-11EB-B279-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Whenever a user runs `git reflog expire --stale-fix`, the most likely
> reason is that their repository is at least _somewhat_ corrupt. Which
> means that it is more than just possible that some objects are missing.
>
> If that is the case, that can currently let the command abort through
> the phase where it tries to mark all reachable objects.
>
> Instead of adding insult to injury, let's be gentle and continue as best
> as we can in such a scenario, simply by ignoring the missing objects and
> moving on.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

I am of two minds.

I appreciate an effort of making it looser and less likely to get in
trouble when running in a corrupt repository, but --stale-fix is a
bit special and should probably be removed.

The only reason the option was added was because we needed to have
an easy way to recover from a specific kind of reflog corruption
that would have resulted by a (then known) bug in "git reflog" in
the released version of Git that came immediately before the version
of Git that added the "fix" option, while the root cause of the
corruption got fixed.  

Back when 1389d9dd (reflog expire --fix-stale, 2007-01-06) was
written, it was very useful to have a way to recover from the
corruption likely to have happened with the version of Git that came
before it.  But it no longer is relevant after this many years.
There may be other ways to break the reflog entries, but --stale-fix
was never designed to deal with anything but a specific way the
reflog gets corrupted (namely, by the old version of Git that
corrupted reflog in a specific way), so keeping it would not be very
useful.


