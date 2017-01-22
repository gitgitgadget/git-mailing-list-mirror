Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE71C2092F
	for <e@80x24.org>; Sun, 22 Jan 2017 23:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750716AbdAVX1O (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 18:27:14 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50667 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750704AbdAVX1N (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 18:27:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 13A5B62A00;
        Sun, 22 Jan 2017 18:27:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uEBYPgg0uWWGKiuQAq6whIys2tg=; b=vL6zmj
        WEcQFTCGKgHtGBuDnXTowTIMiAMTwNzzyRigyJRYEKNcqXZAFa8bTR0en/TmrG6J
        baZZAlnzN7eeIw4wRX9+/OHkfhoNvWY7mYsiHfzSu6buXQ0UAbOR+s+SkzEBaIAo
        Iz2UBh7bZMJKKCd9n3eDJAS5oNCCobdPLLrFo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pQabCkfZad1NChQVS3yFYyx1SdIk/3ev
        GFBcrpiiJpLho+IDS1DhZugV4SFs5KErwacDdF7sJcuPHXY2muGuU2OAzQHWJDF5
        o8LR5aOXzVhckMPB3mOIaTU/MRYO0o5nnKUW+Z65QzC1iDzhRRZKnPkYmwTJBABD
        CX9hXi5qrf8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0A8E8629FF;
        Sun, 22 Jan 2017 18:27:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 79A00629FE;
        Sun, 22 Jan 2017 18:27:11 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [RFC PATCH] Option to allow cherry-pick to skip empty commits
References: <20170121131629.16326-1-giuseppe.bilotta@gmail.com>
Date:   Sun, 22 Jan 2017 15:27:10 -0800
In-Reply-To: <20170121131629.16326-1-giuseppe.bilotta@gmail.com> (Giuseppe
        Bilotta's message of "Sat, 21 Jan 2017 14:16:29 +0100")
Message-ID: <xmqqpojeu14h.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4CBAA3AA-E0FA-11E6-AFA3-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> This allows cherry-picking a set of commits, some of which may be
> redundant, without stopping to ask for the user intervention.
>
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  Documentation/git-cherry-pick.txt |  4 ++++
>  builtin/revert.c                  |  1 +
>  sequencer.c                       | 45 +++++++++++++++++++++++++++++++--------
>  sequencer.h                       |  1 +
>  4 files changed, 42 insertions(+), 9 deletions(-)
>
>
> I would like to add to cherry-pick the ability to skip patches. To this
> end, I'm working on two options: a general `--skip-empty` option to
> handle redundant and empty commits by simply skipping them (no user
> intervention), and a `--skip` option as an alternative form to
> `--continue` to skip the ongoing (conflicting or empty) commit.
>
> The patch here presents my implementation of the `--skip-empty` option,
> including documentation. Comments welcome.

Sounds like a useful thing to do.

> +static int allow_or_skip_empty(struct replay_opts *opts, struct commit *commit)
>  {
>  	int index_unchanged, empty_commit;
>  
>  	/*
> -	 * Three cases:
> +	 * Four cases:
>  	 *
> -	 * (1) we do not allow empty at all and error out.
> +	 * (1) we do not allow empty at all and error out;
>  	 *
> -	 * (2) we allow ones that were initially empty, but
> +	 * (2) we skip empty commits altogether;
> +	 *
> +	 * (3) we allow ones that were initially empty, but
>  	 * forbid the ones that become empty;
>  	 *
> -	 * (3) we allow both.
> +	 * (4) we allow both.
>  	 */

The original gave callers the choice to tell two cases (a commit was
empty in the original history, and a commit that was not empty in
the original history turns out to be redundant) apart and handle
them differently.  I tend to agree that skipping the former should
be the norm, and also I think it is sensible to drop the latter, and
that is what your updated (2) gives us, I think.

But I would suspect that it would rather be common to have a
deliberately empty commit in the original as a marker in a history
and want to keep that across cherry-picking a series, while wanting
to discard/skip patches that are already applied in an updated base.
Shouldn't that be supported as the fifth case?
