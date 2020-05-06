Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542C7C28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 22:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00CA520753
	for <git@archiver.kernel.org>; Wed,  6 May 2020 22:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EK/FNjn2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbgEFW3F (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 18:29:05 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61089 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729476AbgEFW3E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 18:29:04 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E906DC80E8;
        Wed,  6 May 2020 18:29:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+w/7UB7OflizHSaMuNGI1CBsGOo=; b=EK/FNj
        n21MKnDHIgZtzsQ8N69npugzcfwPROtgzYP/8khlmum0oeOFzsNBJ2zpzM/LXXxf
        q+mh2+wp07aUOmZ3nu1XlPlySjr0ZJwYZM5ARQKkqllc8EcwgqSBmhzJjP5F/An9
        F/F3eLWkl5rL5cKntPi8o8ANQBxEQ1NWwwdfo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lggwcn6Edw6ykRIXuL5KyQgR4y9rgb/0
        DewXhBSICaMHyz2DU8LRylFX0V4ZfFA+8ACMqrzZcDSO8vEosXCmfzpaETRjq9sh
        +gjaUH0XanE7eMo1KGcmxmC4xJlJ+nG/lTcjSV+YgeDW7HISYy+Wh1F5TQA6D5Sy
        34Ad/9voIyY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E1790C80E7;
        Wed,  6 May 2020 18:29:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 31642C80E3;
        Wed,  6 May 2020 18:29:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH] t5500: count objects through stderr, not trace
References: <nycvar.QRO.7.76.6.2005062304410.56@tvgsbejvaqbjf.bet>
        <20200506220741.71021-1-jonathantanmy@google.com>
Date:   Wed, 06 May 2020 15:28:58 -0700
In-Reply-To: <20200506220741.71021-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Wed, 6 May 2020 15:07:40 -0700")
Message-ID: <xmqqd07g66l1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FB757488-8FE8-11EA-9051-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> In two tests introduced by 4fa3f00abb ("fetch-pack: in protocol v2,
> in_vain only after ACK", 2020-04-28) and 2f0a093dd6 ("fetch-pack: in
> protocol v2, reset in_vain upon ACK", 2020-04-28), the count of objects
> downloaded is checked by grepping for a specific message in the packet
> trace. However, this is flaky as that specific message may be delivered
> over 2 or more packet lines.
>
> Instead, grep over stderr, just like the "fetch creating new shallow
> root" test in the same file.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> Thanks, Dscho. The commits introducing the flakiness have made it to
> master, so this commit is on master.

Hmph.  Do we coalesce the payload we receive in adjacent two packet
lines into one before writing it out, or do we know in this codepath
that the progress messages are the only thing we are writing out to
the standard error stream and we do not need to worry about other
stuff getting mixed in?  If that is the case, perhaps "just like we
already do in another test" is a lot weaker justification (it sounds
as if we are saying "another test is doing this thing, so if it is
broken, we are not making things worse") than what you actually
have ("the only thing we are writing out to the standard error
stream in the non-error case is these progress messages, and the
'Total 3 ' string, even if it is carried in two separate fragments,
will be shown without getting mixed with anything else on the
standard error stream").

Assuming that the way I (re)read your justification is correct, the
patch looks good to me.

Thanks, both.

>  t/t5500-fetch-pack.sh | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index 52dd1a688c..8c54e34ef1 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -386,7 +386,7 @@ test_expect_success 'clone shallow with packed refs' '
>  '
>  
>  test_expect_success 'in_vain not triggered before first ACK' '
> -	rm -rf myserver myclient trace &&
> +	rm -rf myserver myclient &&
>  	git init myserver &&
>  	test_commit -C myserver foo &&
>  	git clone "file://$(pwd)/myserver" myclient &&
> @@ -399,12 +399,12 @@ test_expect_success 'in_vain not triggered before first ACK' '
>  	# The new commit that the client wants to fetch.
>  	test_commit -C myserver bar &&
>  
> -	GIT_TRACE_PACKET="$(pwd)/trace" git -C myclient fetch --progress origin &&
> -	test_i18ngrep "Total 3 " trace
> +	git -C myclient fetch --progress origin 2>log &&
> +	test_i18ngrep "remote: Total 3 " log
>  '
>  
>  test_expect_success 'in_vain resetted upon ACK' '
> -	rm -rf myserver myclient trace &&
> +	rm -rf myserver myclient &&
>  	git init myserver &&
>  
>  	# Linked list of commits on master. The first is common; the rest are
> @@ -429,8 +429,8 @@ test_expect_success 'in_vain resetted upon ACK' '
>  	# first. The 256th commit is common between the client and the server,
>  	# and should reset in_vain. This allows negotiation to continue until
>  	# the client reports that first_anotherbranch_commit is common.
> -	GIT_TRACE_PACKET="$(pwd)/trace" git -C myclient fetch --progress origin master &&
> -	test_i18ngrep "Total 3 " trace
> +	git -C myclient fetch --progress origin master 2>log &&
> +	test_i18ngrep "Total 3 " log
>  '
>  
>  test_expect_success 'fetch in shallow repo unreachable shallow objects' '
