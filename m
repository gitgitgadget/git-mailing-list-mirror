Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95A7C433DB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 03:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D85A64DFB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 03:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhA2Dl2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 22:41:28 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61824 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhA2Dl1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 22:41:27 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C2B40FD104;
        Thu, 28 Jan 2021 22:40:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+AImhOqRho2thkamN6Qdoa9IAzg=; b=T397Oc
        1/cgFe6ZfeuZkVcDgEGH2u2GBoXYGJtMSv10/cvsYM4c6FuM4pLsJuRMcmSKQ3e6
        mKS7qom1LgtOM0PJtWDSCluTWeaFbg9Xw6zLZwfvZM/WESv4NHeR9QPA2Ltopjag
        X5zburhOtKF+YHPvcQcRV7sOgE0fqU2PSGcuE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eCrXz/ZHm+RtWDtc182v+9rDkGkiX/XA
        N/iC2rUi15Qzkwo2+p0TJyXh2GZYB5mQdtyeLuvVBg238Vc3+0uwmJO1MXRYNwKm
        yHWTal8WkF5L2hlPlj4IjZw8fCMGiQm19RRwCM8p1dIWZvsX1Uyd6GT83oAIes6r
        il1p8sD50xg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BCA41FD102;
        Thu, 28 Jan 2021 22:40:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EBCBFFD101;
        Thu, 28 Jan 2021 22:40:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com
Subject: Re: [PATCH 05/10] p5303: measure time to repack with keep
References: <cover.1611098616.git.me@ttaylorr.com>
        <b3b2574d4d9d10f226b52d81fe0e6bf1f761504e.1611098616.git.me@ttaylorr.com>
Date:   Thu, 28 Jan 2021 19:40:40 -0800
In-Reply-To: <b3b2574d4d9d10f226b52d81fe0e6bf1f761504e.1611098616.git.me@ttaylorr.com>
        (Taylor Blau's message of "Tue, 19 Jan 2021 18:24:16 -0500")
Message-ID: <xmqqft2ktnpj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C2DEFF68-61E3-11EB-A1C7-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> From: Jeff King <peff@peff.net>

Not a fault of this series at all, but before the precontext of the
first hunk, there is  


> diff --git a/t/perf/p5303-many-packs.sh b/t/perf/p5303-many-packs.sh
> index 277d22ec4b..85b077b72b 100755
> --- a/t/perf/p5303-many-packs.sh
> +++ b/t/perf/p5303-many-packs.sh
> @@ -27,8 +27,11 @@ repack_into_n () {

this construct:

	... |
	sed -n '1~5p' |
	head -n "$1" |
        ...

which is a GNUism.  Peff often says that very small population
actually run our perf suite, and this seems to corroborate the
conjecture.

>  	>pushes &&
>  
>  	# create base packfile
> -	head -n 1 pushes |
> -	git pack-objects --delta-base-offset --revs staging/pack &&
> +	base_pack=$(
> +		head -n 1 pushes |
> +		git pack-objects --delta-base-offset --revs staging/pack
> +	) &&
> +	test_export base_pack &&
>  
>  	# and then incrementals between each pair of commits
>  	last= &&
> @@ -87,6 +90,15 @@ do
>  		  --reflog --indexed-objects --delta-base-offset \
>  		  --stdout </dev/null >/dev/null
>  	'
> +
> +	test_perf "repack with keep ($nr_packs)" '
> +		git pack-objects --keep-true-parents \
> +		  --honor-pack-keep --assume-kept-packs-closed \
> +		  --keep-pack=pack-$base_pack.pack \
> +		  --non-empty --all \
> +		  --reflog --indexed-objects --delta-base-offset \
> +		  --stdout </dev/null >/dev/null
> +	'
>  done
>  
>  # Measure pack loading with 10,000 packs.
