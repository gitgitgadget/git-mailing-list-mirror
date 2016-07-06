Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1F3B2070C
	for <e@80x24.org>; Wed,  6 Jul 2016 19:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755781AbcGFT0Y (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 15:26:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55259 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755494AbcGFT0X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2016 15:26:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C07EA28F1C;
	Wed,  6 Jul 2016 15:26:21 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=LkL0CjPe8EYi
	t1FO+hu3uN3xhKw=; b=f5zmi2aqvKiwraxGXvNISciPCHv4MSCjbrF4aP+SyKB0
	IriDVLsfcBmnaXkhGwOisX3bF2hRdDdAGb+1CEa8yIE1Zg6EIUH45e2H8lt/G/7b
	JJcRRUFB5Vvq/5mkFEeGNcfsokAyfM8ZEEHYVbPCuaOrJpedp/QFCVjsjDTYrd8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=FLjdYy
	W3Z2HVvbXoDcr+bcfxV516S6+s6zkAU1jgGiwwyXLUWKnkGreobhr4vgpWATjctC
	4l9X6HJ4MIMmfPf7IZ6a4USHYJM1MNYviaedncXoBN038dpsIzK/oQ8AR2CtmgX5
	pMCy1fffQ+2iPqaKSciqyOVrHDCfs2l+BleGk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B79F728F1B;
	Wed,  6 Jul 2016 15:26:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3C9AD28F1A;
	Wed,  6 Jul 2016 15:26:21 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:	git@vger.kernel.org, yuri.kanivetsky@gmail.com
Subject: Re: [PATCH v2 2/2] cache-tree: do not generate empty trees as a result of all i-t-a subentries
References: <20160704174807.6578-1-pclouds@gmail.com>
	<20160706184829.31825-1-pclouds@gmail.com>
	<20160706184829.31825-3-pclouds@gmail.com>
Date:	Wed, 06 Jul 2016 12:26:19 -0700
In-Reply-To: <20160706184829.31825-3-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
	Duy"'s message of "Wed, 6 Jul 2016 20:48:29 +0200")
Message-ID: <xmqqeg76sh44.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8516EC24-43AF-11E6-837D-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> @@ -426,6 +433,15 @@ int cache_tree_update(struct index_state *istate, int flags)
>  	i = update_one(it, cache, entries, "", 0, &skip, flags);
>  	if (i < 0)
>  		return i;
> +	/*
> +	 * Top dir can become empty if all entries are i-t-a (even
> +	 * from subdirs). Note that we do allow to create an empty
> +	 * tree from an empty index. Only error when an empty tree is
> +	 * a result of the i-t-a thing.
> +	 */
> +	if (it->entry_count < 0 &&
> +	    !hashcmp(it->sha1, EMPTY_TREE_SHA1_BIN))
> +		return error(_("cannot build a tree from just intent-to-add entries"));

The test would not let you tell between the two possible ways the
last step "git commit" fails.

Did it fail due to the protection this change adds (i.e. you should
be checking if "git write-tree" fails if that is the case we want to
cover), or did it fail because you recorded an empty tree as the
root commit without giving the --allow-empty option?

In any case, I am not sure about the logic in the comment, either.
"git commit --allow-empty" should be able to create a new commit
without any files in it, no?

>  	istate->cache_changed |= CACHE_TREE_CHANGED;
>  	return 0;
>  }
> diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
> index 24aed2e..a19f06b 100755
> --- a/t/t2203-add-intent.sh
> +++ b/t/t2203-add-intent.sh
> @@ -99,5 +99,17 @@ test_expect_success 'cache-tree does not ignore dir that has i-t-a entries' '
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
> +		test_must_fail git commit -m committed
> +	)
> +'
> +
>  test_done
