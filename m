Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1EEC2089D
	for <e@80x24.org>; Fri, 28 Jul 2017 21:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752759AbdG1VxE (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jul 2017 17:53:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62425 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752660AbdG1VxD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2017 17:53:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 547CC9B684;
        Fri, 28 Jul 2017 17:52:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b1A/4YhUewXtI2sMx5dr3N9p+8s=; b=o+TeYl
        nPJj453cYXMKWBOx40k6DFfRV7kbzjw3LfYsXWVNTnle5TS9n3dhwTeuenQa8mZ3
        lnPdRsrBLDHSzWJvItzHiSAWk+u0aZkiVMdCN82WT27UDhrKFvG6RMBCINNoNq4X
        lxxAdCYvG5RjtDBOceERIh3p7ekeSovwXjD10=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=elDawTix4G5sQFh3EDloSC4WggEyGAHK
        7ebDtfu11J4ssavFxI2LIQJ+3hq2uYa8QTP0Iea5KxIzLeQOZFWrb9YbV3w8U0eL
        NJ17TT4XVp/jxzlS0CjKSXYRhthhPG5+gXeCjbuI3VlmJeS4wsYUJLQg5OdEQv4/
        nEnkbWq8vfc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4AF829B682;
        Fri, 28 Jul 2017 17:52:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 894B09B681;
        Fri, 28 Jul 2017 17:52:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] alter hash function: expose test dependencies on sha1
References: <20170728171817.21458-1-sbeller@google.com>
        <20170728171817.21458-2-sbeller@google.com>
Date:   Fri, 28 Jul 2017 14:52:53 -0700
In-Reply-To: <20170728171817.21458-2-sbeller@google.com> (Stefan Beller's
        message of "Fri, 28 Jul 2017 10:18:16 -0700")
Message-ID: <xmqq7eysmdoq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1C2DC802-73DF-11E7-A571-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> DO NOT APPLY.
>
> Alter the hash function such that with this patch
> any dependency on sha1 in tests will make the test
> fail. This patch applied on master yields this list:
>
> ./t0000-basic.sh
> ....
> ./t8008-blame-formats.sh
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  sha1dc/sha1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Everybody knew and said that we need to make tests less dependent on
the exact hash and in such a way that the ones that currently do
would test the morally equivalent thing with a new hash before we
can go forward.  And everybody said that one way to start that is to
build a Git with different hash function and trying to run tests.

This is the first report of doing so, and the large list above is
the biggest contribution this message makes to the "let's wean
ourselves off of SHA-1" journey.

Thanks for starting this.

>
> diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
> index 25eded1399..e18acee9ca 100644
> --- a/sha1dc/sha1.c
> +++ b/sha1dc/sha1.c
> @@ -1756,7 +1756,7 @@ static void sha1_process(SHA1_CTX* ctx, const uint32_t block[16])
>  void SHA1DCInit(SHA1_CTX* ctx)
>  {
>  	ctx->total = 0;
> -	ctx->ihv[0] = 0x67452301;
> +	ctx->ihv[0] = 0x07452301;
>  	ctx->ihv[1] = 0xEFCDAB89;
>  	ctx->ihv[2] = 0x98BADCFE;
>  	ctx->ihv[3] = 0x10325476;
