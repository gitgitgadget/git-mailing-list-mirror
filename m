Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1489EC3E8C5
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 21:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFEAA20888
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 21:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iOaXVGE2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387480AbgKPVNM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 16:13:12 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55110 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727478AbgKPVNM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 16:13:12 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6199CF67D0;
        Mon, 16 Nov 2020 16:13:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=EfF/Mv/mEMXU
        2TyubvoLKtc3iL4=; b=iOaXVGE2h/vIEZ/yP9JW3dH0Jp9IV3h5l0xycG+8oY/U
        Gdwc4CXFZLwDxiU3MJLzUTO9oVgNU6/Ln2s4IcaaqFa5YPImBpMlciSa5Fa4+PXl
        vbcguhun+yPBzV4txya9cN1F1ZJ3RY0gA7We186IYzzjuEiF9aiooK8EzECSozs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=LlPjKT
        Oq/nziJ41nd6DlQUpaOPtI9XPWi1AI3NV2cfAkhz/bps9vF8SKQpz+O+pnLFN+Yk
        Vg5PlY3bb7p4fnrPlIvSiociAhJMFbx3G030rujBU38yasf2hVtP9V2TsGGpRAzr
        fACHAJcxAP0Psa6++ZiLfCxbw9/Eu9CWTe9as=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5ABF1F67CC;
        Mon, 16 Nov 2020 16:13:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A1198F679D;
        Mon, 16 Nov 2020 16:13:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3 1/3] submodule: use "fetch" logic instead of custom
 remote discovery
References: <20201112203155.3342586-1-gitster@pobox.com>
        <20201114122132.4344-2-avarab@gmail.com>
Date:   Mon, 16 Nov 2020 13:13:05 -0800
In-Reply-To: <20201114122132.4344-2-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 14 Nov 2020 13:21:30 +0100")
Message-ID: <xmqqa6vh80pq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 861218E4-2850-11EB-A8BC-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Replace a use of the get_default_remote() function with an invocation
> of "git fetch"
>
> The "fetch" command already has logic to discover the remote for the
> current branch. However, before it learned to accept a custom
> refspec *and* use its idea of the default remote, it wasn't possible
> to get rid of some equivalent of the "get_default_remote" invocation
> here.
>
> As it turns out the recently added "--stdin" option to fetch[1] gives
> us a way to do that. Let's use it instead.

Ah, that was what your earlier question was about.

The hits from "git grep fetch_in_submodule" says that $1 is the path
to the submodule, $2 is the $depth and $3 (when exists) is the
object name of what we are fetching:

git-submodule.sh:578:	fetch_in_submodule "$sm_path" $depth ||
git-submodule.sh:601:	fetch_in_submodule "$sm_path" $depth ||
git-submodule.sh:607:	fetch_in_submodule "$sm_path" $depth "$sha1" ||

> While I'm at it simplify the "fetch_in_submodule" function. It wasn't
> necessary to pass "$@" to "fetch" since we'd only ever provide one
> SHA-1 as an argument in the previous "*" codepath (in addition to
> "--depth=3DN"). Rewrite the function to more narrowly reflect its
> use-case.

>  	cd "$1" &&
> -	case "$2" in
> -	'')
> -		git fetch ;;
> -	*)
> -		shift
> -		git fetch $(get_default_remote) "$@" ;;
> -	esac

So when $2 (i.e. --depth=3DN) is empty, we just did the default "git
fetch".  Otherwise, "git fetch <remote> --depth=3DN [<sha1>]" was run.

> +	if test $# -eq 3
> +	then
> +		echo "$3" | git fetch --stdin "$2"

This is not quite equivalent in that an empty depth would have
resulted in the default "git fetch" in the original code, with or
without "$3", totally ignoring "$sha1".  Is this a bugfix snuck in
"while we are at it", or is this an unintended regression?

> +	elif test "$2" -ne ""
> +	then
> +		git fetch "$2"
> +	else
> +		git fetch
> +	fi

Even if it is an unintended regression, fixing it should be trivial;
we just need to flip the order of conditions, like so:

	if test -z "$2"
	then
		git fetch
	elif test $# =3D 3
	then
		echo "$3" | git fetch --stdin "$2"
	else
		git fetch "$2"
	fi

