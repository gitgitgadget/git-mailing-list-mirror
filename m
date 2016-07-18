Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 835A72018B
	for <e@80x24.org>; Mon, 18 Jul 2016 20:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbcGRUst (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 16:48:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57846 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751531AbcGRUss convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jul 2016 16:48:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 10EA92DB62;
	Mon, 18 Jul 2016 16:48:47 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2gDrnJbMGMJa
	dWosOhrJAFsio7s=; b=qFohe53g+Pt2UyaxOrtaFkygS7W8PWliz2MmAFPwe+EW
	GIHRCJIFkI4gBfMEv8/nL/MtWOEqtxaB9yVbvSKdhJkCiOPgoIRkjEE8TBQxhRSR
	zO9MyEq1Ll6uI6DY/DwOVt/FLr5dXSEAFrGwH1q6TyBoYjjdRiutHFmVYum/9rs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=WS/e2A
	6P294p5jLvCSZcb929+Ow79BIJFd8EAC2yvgjfkvXVKgxSfY0+3bdCN8ptkMGlKL
	3HppFJVOfZJD+h+EGsrO/lbALHfeggC5c6fcMwTKrcvI6g5oWo9XV/P66mXOmu/w
	bFxNOOeLfk9ygPWKcM2AiPxCSYrOiwrrEDcp8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 098F22DB60;
	Mon, 18 Jul 2016 16:48:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7A00A2DB5F;
	Mon, 18 Jul 2016 16:48:46 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:	git@vger.kernel.org, yuri.kanivetsky@gmail.com
Subject: Re: [PATCH v4 0/4] cache-tree building fix in the presence of ita entries
References: <20160709052356.30570-1-pclouds@gmail.com>
	<20160716050627.9416-1-pclouds@gmail.com>
Date:	Mon, 18 Jul 2016 13:48:44 -0700
In-Reply-To: <20160716050627.9416-1-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
	Duy"'s message of "Sat, 16 Jul 2016 07:06:23 +0200")
Message-ID: <xmqqbn1uiser.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 05A58D6E-4D29-11E6-BA7D-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> v4 removes the leading underscore from _EMPTY_BLOB and _EMPTY_TREE and
> updates 4/4 slightly like this.
>
> diff --git a/cache-tree.c b/cache-tree.c
> index 2d50640..f28b1f4 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -325,6 +325,7 @@ static int update_one(struct cache_tree *it,
>  		const unsigned char *sha1;
>  		unsigned mode;
>  		int expected_missing = 0;
> +		int contains_ita = 0;
>  
>  		path = ce->name;
>  		pathlen = ce_namelen(ce);
> @@ -341,7 +342,8 @@ static int update_one(struct cache_tree *it,
>  			i += sub->count;
>  			sha1 = sub->cache_tree->sha1;
>  			mode = S_IFDIR;
> -			if (sub->cache_tree->entry_count < 0) {
> +			contains_ita = sub->cache_tree->entry_count < 0;
> +			if (contains_ita) {
>  				to_invalidate = 1;
>  				expected_missing = 1;
>  			}
> @@ -381,10 +383,9 @@ static int update_one(struct cache_tree *it,
>  		}
>  
>  		/*
> -		 * "sub" can be an empty tree if subentries are i-t-a.
> +		 * "sub" can be an empty tree if all subentries are i-t-a.
>  		 */
> -		if (sub && sub->cache_tree->entry_count < 0 &&
> -		    !hashcmp(sha1, EMPTY_TREE_SHA1_BIN))
> +		if (contains_ita && !hashcmp(sha1, EMPTY_TREE_SHA1_BIN))
>  			continue;
>  
>  		strbuf_grow(&buffer, entlen + 100);

This makes quite a lot of sense; even though I do not think it would
change the behaviour within the context of current code, it
definitely is easier to understand and prevents future mistakes.

Will queue.

Thanks.
