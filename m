Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7ACC4363A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 03:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A19F521D43
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 03:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xWS3Qydg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370164AbgJWD71 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 23:59:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55462 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S370058AbgJWD71 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 23:59:27 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2107885850;
        Thu, 22 Oct 2020 23:59:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Fa0s4YBaRhfEtuJAE02GqysQGOM=; b=xWS3Qy
        dg8FrfC9n2UoOJhlJdZHqPbKPQdqkLDILg26SWCvjJyK84I3ZsE1w8GDVSiUJ1At
        FaiQOeGSqk14MLLoNpfIYTXSF8FrwJaMe/BouTWE3GNsSxW1LVq/8WHQPegT0M9s
        +O4RSzQcTEGX0MsOw6dabFkt1jwtwdcnabKqk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jh7brtXhr89W6zm69PD34MtPZDGVEdYO
        iWenjv+ooexAFhXsGFidOW/X55BcHU8oXXc4p4bYZr3fkwTfeKh3NYkYZtloj9Yi
        8czPDDL2mRKxjpZukUFSkTCH2PRQR9IJ/R8dEjm1yYLrNhJi9ub/aUAdOyym8x9w
        qnVibp3qdXc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0691E8584E;
        Thu, 22 Oct 2020 23:59:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 66E9B8584D;
        Thu, 22 Oct 2020 23:59:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4] refs: implement reference transaction hook
References: <1d1a94426f95d842e0e3ea6a1569c0c45239229c.1591086316.git.ps@pks.im>
        <55c58e9b09691dc11dea911f26424594fb3922c9.1592549570.git.ps@pks.im>
        <20201023010315.GA1542721@coredump.intra.peff.net>
Date:   Thu, 22 Oct 2020 20:59:23 -0700
In-Reply-To: <20201023010315.GA1542721@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 22 Oct 2020 21:03:15 -0400")
Message-ID: <xmqqpn59k2xw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 236CB98A-14E4-11EB-90C4-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So I wonder if:
>
> diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
> index f6e741c6c0..8155522a1a 100755
> --- a/t/t1416-ref-transaction-hooks.sh
> +++ b/t/t1416-ref-transaction-hooks.sh
> @@ -9,6 +9,7 @@ test_expect_success setup '
>  	test_commit PRE &&
>  	PRE_OID=$(git rev-parse PRE) &&
>  	test_commit POST &&
> +	PRE_OID=$(git rev-parse PRE) &&
>  	POST_OID=$(git rev-parse POST)
>  '
>  
> @@ -52,10 +53,10 @@ test_expect_success 'hook gets all queued updates in prepared state' '
>  		fi
>  	EOF
>  	cat >expect <<-EOF &&
> -		$ZERO_OID $POST_OID HEAD
> -		$ZERO_OID $POST_OID refs/heads/master
> +		$PRE_OID $POST_OID HEAD
> +		$PRE_OID $POST_OID refs/heads/master
>  	EOF
> -	git update-ref HEAD POST <<-EOF &&
> +	git update-ref HEAD POST POST <<-EOF &&
>  		update HEAD $ZERO_OID $POST_OID
>  		update refs/heads/master $ZERO_OID $POST_OID
>  	EOF
> @@ -75,10 +76,10 @@ test_expect_success 'hook gets all queued updates in committed state' '
>  		fi
>  	EOF
>  	cat >expect <<-EOF &&
> -		$ZERO_OID $POST_OID HEAD
> -		$ZERO_OID $POST_OID refs/heads/master
> +		$PRE_OID $POST_OID HEAD
> +		$PRE_OID $POST_OID refs/heads/master
>  	EOF
> -	git update-ref HEAD POST &&
> +	git update-ref HEAD POST PRE &&
>  	test_cmp expect actual
>  '

I think that makes a lot of sense.  In addition, 

> ...  But we'd possibly want to actually change the behavior
> to always send the actual ref value to the hook.

I offhand do not see a reason why we shouldn't do that.

Thanks for carefully thinking things through.


