Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CF0C433E6
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 22:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0C4164FC9
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 22:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbhCJWXg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 17:23:36 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56482 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbhCJWXd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 17:23:33 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A924B5098;
        Wed, 10 Mar 2021 17:23:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8F/Z/SPOvNmNHZcE0Zye5KoStbI=; b=UI47Me
        u47/5qKnmw5r1saV8AMux1P6b4PzhEJhdcc/x6Jz6DDEhk4djAEns3vTucY2Vl2O
        OMN2eohNAzKFMHxB+tO46pMYWEPkEIIsQDoDmTDEMztOqoOnCfuTb5j1RTPEt1gt
        P/OYdZerWuLT3YsxHbMx515I/yP3JLbZhtHaU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cDRWA3z+o5mXw8uzqfPTWtvC42QTYLBS
        oNDF4jE6nGztmEpJpTeJIWEX3wBCfzmMet0Kc+J9Xurhx6xgP5tMVX/6spVzPUL4
        9FejMNdnLhLA2lB6ONb8NfNI4NpAgzH3xYItphOljw2uHEtWnKY8wJXbfH14aynV
        d/+PXDcE4hM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 232C5B5096;
        Wed, 10 Mar 2021 17:23:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AA596B5095;
        Wed, 10 Mar 2021 17:23:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 3/3] filter-branch: drop $_x40 glob
References: <YEj8meoPn/g6tCe3@coredump.intra.peff.net>
        <YEj82fOf+F4xJC8S@coredump.intra.peff.net>
Date:   Wed, 10 Mar 2021 14:23:30 -0800
In-Reply-To: <YEj82fOf+F4xJC8S@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 10 Mar 2021 12:07:37 -0500")
Message-ID: <xmqqpn06ir6l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3F7B0334-81EF-11EB-8C2A-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> When checking whether a commit was rewritten to a single object id, we
> use a glob that insists on a 40-hex result. This works for sha1, but
> fails t7003 when run with GIT_TEST_DEFAULT_HASH=sha256.
>
> Since the previous commit simplified the case statement here, we only
> have two arms: an empty string or a single object id. We can just loosen
> our glob to match anything, and still distinguish those cases (we lose
> the ability to notice bogus input, but that's not a problem; we are the
> one who wrote the map in the first place, and anyway update-ref will
> complain loudly if the input isn't a valid hash).

If the input is any valid extended sha-1 expression, it probably
would not barf, so we technically are losing a bit of internal
safety valve to notice bogus rewrite (if the map recorded output of
"git describe --always", this part would not notice and keep working
just fine, but other parts of the code may not be happy).

But if this were a new code that said "It is either empty of non-empty,
and non-empty ones are object names we write, so we do not have to
insist it is hex object names", it is very likely that we would
accept it without any extra checks, so I think this is perfectly OK.

Thanks.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  git-filter-branch.sh | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index a1e80bd552..cb89372813 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -498,8 +498,6 @@ fi
>  
>  # Finally update the refs
>  
> -_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
> -_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
>  echo
>  while read ref
>  do
> @@ -519,7 +517,7 @@ do
>  		git update-ref -m "filter-branch: delete" -d "$ref" $sha1 ||
>  			die "Could not delete $ref"
>  	;;
> -	$_x40)
> +	*)
>  		echo "Ref '$ref' was rewritten"
>  		if ! git update-ref -m "filter-branch: rewrite" \
>  					"$ref" $rewritten $sha1 2>/dev/null; then
> @@ -533,9 +531,6 @@ do
>  			fi
>  		fi
>  	;;
> -	*)
> -		die "BUG: multiple ancestors in map file?"
> -	;;
>  	esac
>  	git update-ref -m "filter-branch: backup" "$orig_namespace$ref" $sha1 ||
>  		 exit
