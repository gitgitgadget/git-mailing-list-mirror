Return-Path: <SRS0=xqrk=6B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6D4C38A29
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 19:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54F0620715
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 19:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="thxwdI1Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730833AbgDQTvb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Apr 2020 15:51:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61316 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730449AbgDQTvb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Apr 2020 15:51:31 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 595315DB60;
        Fri, 17 Apr 2020 15:51:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FaB1lts3iSHMtsv5M4l8s582YLM=; b=thxwdI
        1Zd9/nu8/ba1b0w8Y4+TZ0LDOOcrh0fgID+5YP26KieNtQugLBdtVpGFdQCbZGGa
        oWpf5f4HZd18vN6ioPfRRjLaupTU6DONDz1mWoh+UlnqciwtfG0WBkLlQAAF2CT5
        K5/9O8YYAU6VKQD5GXHM+0U+3CQer0LW5hbV0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=B8uT4ffXMzHxnn+4fzNAzFRNftwa218M
        NxG/O0PFuGABV9LVxVvW35lUz98/oTY1MA1NmpopnE0Ycrz6eKQgAU2ZZ5D1k+a/
        h6PgvG1XaoaFZpGndm3H6tNs0/v3bStdhgfDilyv4RmUWoxClwzGezBZnjpJVXCd
        98oVHBLSmGs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 517865DB5F;
        Fri, 17 Apr 2020 15:51:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C995F5DB5D;
        Fri, 17 Apr 2020 15:51:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v4 1/5] send-pack: fix inconsistent porcelain output
References: <20200416162415.5751-1-worldhello.net@gmail.com>
        <20200417094536.9463-2-worldhello.net@gmail.com>
Date:   Fri, 17 Apr 2020 12:51:26 -0700
In-Reply-To: <20200417094536.9463-2-worldhello.net@gmail.com> (Jiang Xin's
        message of "Fri, 17 Apr 2020 05:45:32 -0400")
Message-ID: <xmqqlfmtvqkh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D2F5D7CC-80E4-11EA-941A-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> diff --git a/transport.c b/transport.c
> index 1fdc7dac1a..13d638d5fe 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -715,7 +715,15 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
>  
>  	close(data->fd[1]);
>  	close(data->fd[0]);
> -	ret |= finish_connect(data->conn);
> +	/*
> +	 * Atomic push may abort the connection early and close the pipe,
> +	 * which may cause an error for `finish_connect()`. Ignore this error
> +	 * for atomic git-push.
> +	 */
> +	if (ret || args.atomic)
> +		finish_connect(data->conn);
> +	else
> +		ret = finish_connect(data->conn);

Which means that the return value from this function under the
atomic mode is what we got from an earlier call to send_pack().

Which may have failed, in which case we do want to relay the error
to our caller, or may have succeeded, which is also fine to relay to
our caller.

> The following code at the end of function `send_pack()` indicates that
> `send_pack()` should not return an error if some references are rejected
> in porcelain mode.

Under porcelain mode, if we already saw an error before we get to
the "if porcelain, do not bother checking the remote status", we
do relay the error to our caller.  That happens in the part you
omitted from your quote:

>     int send_pack(...)
>         ... ...

	if (ret < 0)
		return ret;

>
>         if (args->porcelain)
>             return 0;
>
>         for (ref = remote_refs; ref; ref = ref->next) {
>             switch (ref->status) {
>             case REF_STATUS_NONE:
>             case REF_STATUS_UPTODATE:
>             case REF_STATUS_OK:
>                 break;
>             default:
>                 return -1;
>             }
>         }
>         return 0;
>     }

So it is not like we are disabling all errors under the porcelain
mode.

> diff --git a/send-pack.c b/send-pack.c
> index 0407841ae8..1835cd5582 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -489,7 +487,8 @@ int send_pack(struct send_pack_args *args,
>  			if (use_atomic) {
>  				strbuf_release(&req_buf);
>  				strbuf_release(&cap_buf);
> -				return atomic_push_failure(args, remote_refs, ref);
> +				atomic_push_failure(args, remote_refs, ref);
> +				return args->porcelain ? 0 : -1;
>  			}

And this is in line with the way how rejected pushes are handled, I guess.

Sounds a bit convoluted but correct ;-)
