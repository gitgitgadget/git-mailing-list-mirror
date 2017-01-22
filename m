Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C00AE2092F
	for <e@80x24.org>; Sun, 22 Jan 2017 22:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750725AbdAVWrv (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 17:47:51 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62068 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750714AbdAVWru (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 17:47:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C0F1636CB;
        Sun, 22 Jan 2017 17:47:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fb4MK2iRTEBODUrToWoZ4BLanzI=; b=cbLPcy
        wgYlegw5oPoOUTsxbL3QRodQD3NgabQW3HACPRQdBCgwgmXybGXroCv6Glq7poDc
        YwF1Bv8taFq7CUpElqtYBlcDEwoB4hoj7om6yMhIGac68wvjLNSenBb3WLp9YMUI
        dPEaN5CgtdPXqUZpPMgqLS+8Wz+sA6QS1t3rw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WDmQx7p6lOEfxoMDM+MAknSemZrFD4dR
        Yzm78J8SS+8V1i+dA6VcVjIZOFPgAB6eJrCqVok7MEUerApVd93/ostu9YCmMh5R
        lqEX1Mpzrih6WXRMppkqwbHrohXL9ee+q7oIZNvVVH9SQiBkxN7QQHDTZZ7YCreK
        7vdRB/fJ74M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 548BE636CA;
        Sun, 22 Jan 2017 17:47:49 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9492E636C9;
        Sun, 22 Jan 2017 17:47:48 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vladimir Panteleev <git@thecybershadow.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] show-ref: Optimize show_ref a bit
References: <20170121010821.25046-1-git@thecybershadow.net>
        <20170121010821.25046-4-git@thecybershadow.net>
Date:   Sun, 22 Jan 2017 14:47:47 -0800
In-Reply-To: <20170121010821.25046-4-git@thecybershadow.net> (Vladimir
        Panteleev's message of "Sat, 21 Jan 2017 01:08:20 +0000")
Message-ID: <xmqqa8aivhik.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CC5656B4-E0F4-11E6-91A8-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vladimir Panteleev <git@thecybershadow.net> writes:

> The inner `if (verify)' check was not being used before the preceding
> commit, as show_ref was never being called from a code path where
> verify was non-zero.
>
> Adding a `!verify' check to the outer if skips an unnecessary string
> comparison when verify is non-zero, and show_ref is already called
> with a reference exactly matching pattern.
>
> Signed-off-by: Vladimir Panteleev <git@thecybershadow.net>
> ---
>  builtin/show-ref.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/builtin/show-ref.c b/builtin/show-ref.c
> index bcdc1a95e..3cf344d47 100644
> --- a/builtin/show-ref.c
> +++ b/builtin/show-ref.c
> @@ -43,7 +43,7 @@ static int show_ref(const char *refname, const struct object_id *oid,
>  		if (!match)
>  			return 0;
>  	}
> -	if (pattern) {
> +	if (pattern && !verify) {
>  		int reflen = strlen(refname);
>  		const char **p = pattern, *m;
>  		while ((m = *p++) != NULL) {
> @@ -54,9 +54,6 @@ static int show_ref(const char *refname, const struct object_id *oid,
>  				continue;
>  			if (len == reflen)
>  				goto match;
> -			/* "--verify" requires an exact match */
> -			if (verify)
> -				continue;
>  			if (refname[reflen - len - 1] == '/')
>  				goto match;
>  		}

Having to do this change probably is an indication that the division
of labour between show_ref() and show_one() up to this step needs to
be rethought.

Conceptually, "git show-ref" works in two ways:

 * When in --verify mode, the end user gives which refnames to
   consider showing.

 * Otherwise the end user gives pattern and the command infers which
   refnames to consider showing using the pattern.

And for the refnames that are considered for showing, we may do
various things, like -d to deref and --quiet to be silent.  We want
this actual "output" step to be the same between two modes of
operation.

So a better division of labour would be:

 * Make show_ref() about "using pattern, enumerate what refs to
   show" and call show_one().

 * Update show_one() and teach _it_ to handle quiet and deref_tags.

 * From cmd_show_ref(), in --verify mode, make sure the ref exists
   and call show_one(), because we do not do the "using pattern,
   enumerate what refs to show" at all.

And from that point of view, I think 4/4 is going in the wrong
direction.

I also think that "git show-ref --verify HEAD" should work; it is OK
that the command accepts "--head" in that case, but when in --verify
mode, the end user gives which refnames to consider showing, and
HEAD given from the command line is a signal enough that that
psuedo-ref is what the end user wants to be shown.  "--head" is
about not filtering in "enumerate the ones that match the given
patterns" mode, and it feels unnecessary to require it in "--verify"
mode.

Thanks.
