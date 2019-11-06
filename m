Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D61331F454
	for <e@80x24.org>; Wed,  6 Nov 2019 02:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730711AbfKFCRF (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 21:17:05 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59085 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730231AbfKFCRE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 21:17:04 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A28AF240A5;
        Tue,  5 Nov 2019 21:16:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lxeOKRL4o5dX2lvVWzeikyhB2DU=; b=VV1DTn
        e3wM4V8FRLFepDBE6NUroou4iP6il+SmJs7Kp1GuRazLiUJvh3UcsfwqzdlFIZvS
        aVeRDaq5fQOlV6ZxVtrohYUqyut6HgjjnOWhCQMdpTfisLY2ZRIe7MLqHbujNPEi
        /xFUeX1Vr8vjbHck57e9jGFuM1qZWYDEutfw0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ThyhOiUUmCoV3FlgoAwn+9WM9Xq9Essx
        /AZod1LDxqI7hc7rGBRxdsb1YyDsaMyv9COXegjK4PzS+FgFQhYXet8nC8VGzpUI
        U0hYNY1q/6HlNboI3tgVp0mINWLEGtVgUgqJ6GO2q2f3q2Yv/G4hkkBja/g0tYYu
        v5akWBLsgfw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9AFC4240A4;
        Tue,  5 Nov 2019 21:16:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 096C1240A3;
        Tue,  5 Nov 2019 21:16:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 30/32] ident.c: fix LGTM warning on the possible abuse of the '=' operator
References: <20191104095923.116086-1-gitter.spiros@gmail.com>
Date:   Wed, 06 Nov 2019 11:16:58 +0900
In-Reply-To: <20191104095923.116086-1-gitter.spiros@gmail.com> (Elia Pinto's
        message of "Mon, 4 Nov 2019 09:59:21 +0000")
Message-ID: <xmqqbltpwxyd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8315E122-003B-11EA-81FF-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elia Pinto <gitter.spiros@gmail.com> writes:

Did I miss the first 29 patches (with what I see in this patch, I
do not know if I want to see them immediately, though ;-))?

> Fix the LGTM warning of the rule that finds uses of the assignment
> operator = in places where the equality operator == would
> make more sense.

I know you did not mean that existing

	} else if ((email = query_user_email()) && email[0]) {

better reads if it were written like so:

	} else if ((email == query_user_email()) && email[0]) {

but that is the only way how that sentence can be read (at least to
me) without looking at what the patch actually does.

As "email" has already been assigned to at this point in the
codeflow, I agree that, to an eye that does not (and is not willing
to spend cycles to) understand what the code is doing, the latter do
look more natural: "If the value of the variable is the same as the
return value of the query_user_email() function, and ...".  And if
"email" were a simpler arithmetic type it would have been even more
(iow, it is clear "email" is a character string from "&& email[0]",
so it is unlikely that "email == que()" is what the user intended).

So I am somewhat sympathetic to the "warnings" here, but not all
that much, especially if squelching makes the codeflow harder to
follow by introducing otherwise unnecessary nesting levels (like
this patch did).  I suspect that it might be possible to futher
restructure the code in such a way that we do not have to do an
assignment in a conditional without making the code deeply nested,
and that may perhaps be worth doing.

But the thing is, assignment in a cascading conditional is so useful
in avoiding pointless nesting of the code (imagine a reverse patch
of this one---which is easy to sell as cleaning-up and streamlining
the code).

So, I dunno.

> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
>  ident.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/ident.c b/ident.c
> index e666ee4e59..07f2f03b0a 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -172,12 +172,15 @@ const char *ident_default_email(void)
>  			strbuf_addstr(&git_default_email, email);
>  			committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
>  			author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
> -		} else if ((email = query_user_email()) && email[0]) {
> -			strbuf_addstr(&git_default_email, email);
> -			free((char *)email);
> -		} else
> -			copy_email(xgetpwuid_self(&default_email_is_bogus),
> +		} else {
> +			email = query_user_email();
> +			if (email && email[0]) {
> +				strbuf_addstr(&git_default_email, email);
> +				free((char *)email);
> +			} else
> +				copy_email(xgetpwuid_self(&default_email_is_bogus),
>  				   &git_default_email, &default_email_is_bogus);
> +		}
>  		strbuf_trim(&git_default_email);
>  	}
>  	return git_default_email.buf;
