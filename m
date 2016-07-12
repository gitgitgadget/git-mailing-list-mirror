Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A36F1FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 20:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbcGLUt2 (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 16:49:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60591 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750734AbcGLUt1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2016 16:49:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 40074294BB;
	Tue, 12 Jul 2016 16:49:21 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=7tSIJaXFk95o
	cFG3zRVKu7rttaU=; b=i8qgqe79M1SSNY9haaLMKwu4Vh/MIz0+FzKuCa0pknTg
	T8Ikn8G/FZcspYSSPCrqlKK0Qwu1yszdDv6AsFISBxsyj+KrvgGsRJo6PwHHIa55
	2GfaJ7hitPsOJ7E2WN90kiXoUl4Tsy90eF/NP8L3eLt8RxyrwvU51a6w9Dg33Xc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cle6M4
	R5DjJRdYAjuj41bUm0ew2mRHYlQtqwQ3BUrYlZZ2P/HfDQkx4Iydy9ozsuVbu/Rx
	/vmXeui3Y3EneWTB2rprHStSzDwGxX2dPWAccFOR/NWo10qhhCr5DQztjeEL1JfP
	1HxOcb8IUAY99Lg4cTkQQE//GPSrNzBm/qHcQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 38492294BA;
	Tue, 12 Jul 2016 16:49:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AED83294B9;
	Tue, 12 Jul 2016 16:49:20 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:	git@vger.kernel.org, yuri.kanivetsky@gmail.com
Subject: Re: [PATCH v3 4/4] cache-tree: do not generate empty trees as a result of all i-t-a subentries
References: <20160706184829.31825-1-pclouds@gmail.com>
	<20160709052356.30570-1-pclouds@gmail.com>
	<20160709052356.30570-5-pclouds@gmail.com>
Date:	Tue, 12 Jul 2016 13:49:18 -0700
In-Reply-To: <20160709052356.30570-5-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
	Duy"'s message of "Sat, 9 Jul 2016 07:23:56 +0200")
Message-ID: <xmqqtwfu37ld.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1B900250-4872-11E6-9A3F-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> diff --git a/cache-tree.c b/cache-tree.c
> index c2676e8..2d50640 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -380,6 +380,13 @@ static int update_one(struct cache_tree *it,
>  			continue;
>  		}
>  
> +		/*
> +		 * "sub" can be an empty tree if subentries are i-t-a.
> +		 */
> +		if (sub && sub->cache_tree->entry_count < 0 &&
> +		    !hashcmp(sha1, EMPTY_TREE_SHA1_BIN))
> +			continue;
> +

Looks sensible, except that it is unclear if it is correct to assume
that "subentries are ita" always equals to "entry_count < 0" here.
I _think_ it is OK, as the function itself does use the latter as
the sign that it hit to_invalidate=1 case when it returns.

Thanks.

>  		strbuf_grow(&buffer, entlen + 100);
>  		strbuf_addf(&buffer, "%o %.*s%c", mode, entlen, path + baselen, '\0');
>  		strbuf_add(&buffer, sha1, 20);
> diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
> index 24aed2e..f4b2fac 100755
> --- a/t/t2203-add-intent.sh
> +++ b/t/t2203-add-intent.sh
> @@ -99,5 +99,19 @@ test_expect_success 'cache-tree does not ignore dir that has i-t-a entries' '
>  	)
>  '
>  
> +test_expect_success 'cache-tree does skip dir that becomes empty' '
> +	rm -fr ita-in-dir &&
> +	git init ita-in-dir &&
> +	(
> +		cd ita-in-dir &&
> +		mkdir -p 1/2/3 &&
> +		echo 4 >1/2/3/4 &&
> +		git add -N 1/2/3/4 &&
> +		git write-tree >actual &&
> +		echo $_EMPTY_TREE >expected &&
> +		test_cmp expected actual
> +	)
> +'
> +
>  test_done
