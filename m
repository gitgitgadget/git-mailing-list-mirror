Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2204C282DD
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 15:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A492072A
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 15:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SjwjdlGR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgAHPlr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 10:41:47 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56020 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgAHPlr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 10:41:47 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2AF1BA0127;
        Wed,  8 Jan 2020 10:41:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1Xm5clkJwoK+ak8Bb/lMzE9BdnU=; b=Sjwjdl
        GR/tlGQAiZ/UHPqwboxvQYm7tX0H4dVwqhOLWXXutFYRA5vjjcAv22QJpCu/RAEq
        UThplS+DJ+lBGCz2Kubn1oJ7NrIUWsOC+4oWIBCoK1uzZ5jPazySd7ISDjy7VmWO
        34WsWs985Lqy4m1+o1kqYAGiGZ6GO57BPin34=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kZNIauqdr2LW6OZ8v9FvWcuUlxgW12+O
        dyJdi2dI9hwYWnfyy7s/0WIn0bX9KXPxMzXpW611pW3bCh7uihnkh8ktZNK5QsFm
        awQa+C9VtQh9jhcZIeJTXsUyZDrWYHY1TMNU+feJ7bjiJ5h6FvbsT9+mQFE8oj3c
        G2LRdajMbtk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 23E3FA0126;
        Wed,  8 Jan 2020 10:41:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 05F96A0124;
        Wed,  8 Jan 2020 10:41:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Torsten Krah <krah.tm@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] restore: invalidate cache-tree when removing entries with --staged
References: <07c84224bb0b093ab3770be9b5ab2ec23ce2d31a.camel@gmail.com>
        <234df85965f8a685be5e563fe795ed477f359d7c.camel@gmail.com>
        <f0638fc0d09c213b661d2b244d3457f362daebe0.camel@gmail.com>
        <20200108091119.GB87523@coredump.intra.peff.net>
        <2423f8c0b91578c0faf7527b7d97b0e1e9666261.camel@gmail.com>
        <20200108104008.GA2207365@coredump.intra.peff.net>
        <20200108114344.GA3380580@coredump.intra.peff.net>
Date:   Wed, 08 Jan 2020 07:41:39 -0800
In-Reply-To: <20200108114344.GA3380580@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 8 Jan 2020 06:43:44 -0500")
Message-ID: <xmqq4kx63qh8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E02DFF6-322D-11EA-9AE9-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index b52c490c8f..18ef5fb975 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -524,6 +524,8 @@ static int checkout_paths(const struct checkout_opts *opts,
>  	/* Now we are committed to check them out */
>  	if (opts->checkout_worktree)
>  		errs |= checkout_worktree(opts);
> +	else
> +		remove_marked_cache_entries(&the_index, 1);

Ah, I was wondering why we were seeing breakages on cache-tree,
which is fairly old and stable part of the system---even though it
had caused us quite a lot of pain while it was growing---all of a
sudden.  No wonder---this codepath is a fairly new one, introduced
when "restore" was added X-<.

And the fix looks right, of course.  Thanks for extracting a
reproducible recipe out of the original reporter and quickly
diagnosing it.  Very much appreciated.
