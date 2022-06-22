Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F9AC433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 06:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236913AbiFVGMn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 02:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbiFVGMl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 02:12:41 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB3E205CD
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 23:12:39 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 28E691A3701;
        Wed, 22 Jun 2022 02:12:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=LMa/cySK1xt5
        //4fGzYpb1jFnnelEiTImjACE5ZfnUE=; b=p3fDwR6OXx9pyu+ZghyVVG4agWbx
        Fz3s34gWnnjhSdLPpFxNpSin7IHwHOx8D1geHR5mp7irpo2l6BcgVYYTZ5rqunqV
        QPEwRlP/DZ+XnUK9Te5nXdikg3A8T+G5DovSxJaOMJUbKeU7TP0EqL6zzh5eAhmq
        rwNPMm9+yNjKfoM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2173D1A3700;
        Wed, 22 Jun 2022 02:12:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BD0BF1A36F4;
        Wed, 22 Jun 2022 02:12:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        rsbecker@nexbridge.com,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 10/10] fetch tests: fix needless and buggy re-quoting
References: <xmqqa6a5g0m3.fsf@gitster.g>
        <cover-00.10-00000000000-20220621T222854Z-avarab@gmail.com>
        <patch-10.10-54129b94a77-20220621T222854Z-avarab@gmail.com>
Date:   Tue, 21 Jun 2022 23:12:34 -0700
In-Reply-To: <patch-10.10-54129b94a77-20220621T222854Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 22 Jun
 2022 00:34:22
        +0200")
Message-ID: <xmqqsfnx6xbh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4F62EC02-F1F2-11EC-8819-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> -	remote_url=3D"file://$TRASH_DIRECTORY/." && # NOT local yet!
> -	local cmdline_setup=3D"\"$remote_url\" \"$refspec_heads\""

Good riddance ;-)

> +	local remote_url=3D"file://$TRASH_DIRECTORY/." &&
> =20
> ...
> -			git fetch '"$cmdline_setup"' &&
> +			git fetch "$remote_url" "$refspec_heads" &&
> ...
> +			git$git_fetch_c fetch \
> +				${arg_fetch_prune:+--prune} \
> +				${arg_fetch_no_prune:+--no-prune} \
> +				${arg_fetch_prune_tags:+--prune-tags} \
> +				${arg_fetch_origin:+origin} \
> +				${arg_fetch_url:+"$remote_url"} \
> +				${arg_fetch_refspec_tags:+"refs/tags/*:refs/tags/*"} \
> +				${arg_fetch_refspec_heads:+"+refs/heads/*:refs/remotes/origin/*"} =
&&
> +

This makes it a lot clearer, with no perl, no sed, no eval.  It does
become louder, but should be easier to follow in general ...

>  test_configured_prune_type --mode link true  unset true  unset pruned =
pruned \
> -	"\"$remote_url\"" \
> +	REMOTE_URL \
>  	"refs/tags/*:refs/tags/*" "+refs/heads/*:refs/remotes/origin/*"

... except for a magic like this one.

We may remember the REMOTE_URL -> $remote_url trick used here this
week, but I am not sure if we find it sensible in 3 months.

But overall I think this makes it simpler.  I am not 100% sold on
the necessity of lengthy earlier steps, though.

Thanks.



