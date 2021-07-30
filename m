Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D3AC4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 16:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAA5960F4A
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 16:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhG3Qrf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 12:47:35 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50325 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbhG3Qre (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 12:47:34 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0A49D14E8D0;
        Fri, 30 Jul 2021 12:47:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=yulIw0C0Zdjh
        WITEnJrheTbTJsUeSMCoPpXmik6+Zgw=; b=OWcDomr37si9p/+XpiyDi1hYYdeI
        QHlNA/uPK5LKcXw3yACn+w+m08VOUQCgpqTYlCerqw25ny61O0vP6lbiD4y/5YMw
        2hasyZ6H4b6QRNqLVt8xRH8nm6PXPdNHLAZBAAogoUuYOEFwgnh1S78XH/CnhI2J
        zn+Gjo2Xb7L+hXM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 027E714E8CF;
        Fri, 30 Jul 2021 12:47:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 49D0514E8CE;
        Fri, 30 Jul 2021 12:47:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>,
        "Tom G . Christensen" <tgc@jupiterrise.com>,
        Mischa POSLAWSKY <git@shiar.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v3 7/7] http: centralize the accounting of libcurl
 dependencies
References: <cover-0.5-00000000000-20210721T220402Z-avarab@gmail.com>
        <cover-v3-0.7-00000000000-20210730T092843Z-avarab@gmail.com>
        <patch-v3-7.7-93a2775d0ee-20210730T092843Z-avarab@gmail.com>
Date:   Fri, 30 Jul 2021 09:47:24 -0700
In-Reply-To: <patch-v3-7.7-93a2775d0ee-20210730T092843Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 30 Jul
 2021 11:31:59
        +0200")
Message-ID: <xmqqwnp721gj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D2085D98-F155-11EB-B767-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> As noted in preceding commits checking against LIBCURL_VERSION_NUM
> isn't as reliable as checking specific defines in curl, as some
> distros have been known to backport features. Furthermore we had at
> least one case of someone confusing base 10 for base 16 in comparing
> the version.
>
> Let's add a git-curl-compat.h header that'll keep track of these
> dependencies, and make the next round of deprecations easier. This
> patch is mostly obvious, with the following exceptions:
>
>  - In aeff8a61216 (http: implement public key pinning, 2016-02-15) a
>    dependency and warning() was added if curl older than 7.44.0 was
>    used, but the relevant code depended on CURLOPT_PINNEDPUBLICKEY,
>    introduced in 7.39.0.

I'd feel safe with this change iff we positively know that the
reason why the warning message and version guard back then said
7.44.0 instead of 7.39.0 was not because the symbol was there but
the feature was broken between these two versions, and the feature
became usable/reliable only after 7.44.0.  I do not recall the
review discussion around that commit offhand and somebody needs to
dig the archive.

>  - We did not use CURL_SOCKOPT_OK and instead hardcoded its value in
>    a15d069a198 (http: enable keepalive on TCP sockets, 2013-10-12),
>    let's use it and guard its use by a new GITCURL_HAVE_* check.

I agree with the spirit, but find the execution iffy.  I may find it
cleaner to hide all the version dependent details in curl-compat.h
and to define CURL_SOCKOPT_OK to 0 there, iff the symbol is missing.

That way, the use sites can unconditionally use CURL_SOCKOPT_OK, no?

>  - We guarded the support for http.version with a check for curl
>    7.47.0, looking at the history of how that happen reveals that an
>    earlier on-list version of d73019feb44 (http: add support selecting
>    http version, 2018-11-08) depended on CURL_HTTP_VERSION_2TLS (which
>    was added in 7.47.0).
>
>    But the version this code depended on was in fact 7.43.0, since
>    that's when CURL_HTTP_VERSION_2_0 was added.

OK.

> +#ifndef GIT_CURL_COMPAT_H
> +#define GIT_CURL_COMPAT_H
> +
> +/**
> + * This header centralized the declaration of our libcurl dependencies

-lizes, not -lized, no?

> + * to make it easy to discover the oldest versions we support, and to
> + * inform decisions about removing support for older libcurl in the
> + * future.
> + *
> + * The source of truth for what versions have which symbols is
> + * https://github.com/curl/curl/blob/master/docs/libcurl/symbols-in-ve=
rsions;
> + * the release dates are taken from curl.git (at
> + * https://github.com/curl/curl/).
> + *
> + * For each X symbol we need from curl we check if it exists and
> + * declare our own GIT_CURl_HAVE_X, or if it's for both X and Y
> + * GIT_CURl_HAVE_X_and_Y, where the "Y" in "X_and_Y" is only the part

GIT_CURL, not GIT_CURl, no?

> + * of the symbol name that "X" and "Y" don't have in common.
> + *
> + * We avoid comparisons against LIBCURL_VERSION_NUM, enterprise
> + * distros have been known to backport symbols to their older curl
> + * versions.
> + *
> + * Keep any symbols in date order of when their support was
> + * introduced, oldest first.

The above two paragraphs are somewhat at odds.  Perhaps with "...,
oldest first, in the official version of cURL library", it becomes a
non-issue, though.


The approach may mostly be sensible, but as I said, it is overkill
for things like this one:

[in curl-compat.h]
> +/**
> + * CURL_SOCKOPT_OK was added in 7.21.5, released in April 2011.
> + */
> +#ifdef CURL_SOCKOPT_OK
> +#define GITCURL_HAVE_CURL_SOCKOPT_OK 1
> +#endif

[in code]
>  	if (rc < 0)
>  		warning_errno("unable to set SO_KEEPALIVE on socket");
> =20
> -	return 0; /* CURL_SOCKOPT_OK only exists since curl 7.21.5 */
> +#ifdef GITCURL_HAVE_CURL_SOCKOPT_OK
> +	return CURL_SOCKOPT_OK;
> +#else
> +	return 0;
> +#endif
>  }

It would be far simpler and cleaner to do this instead only in
curl-compat.h, no?

    #ifndef CURL_SOCKOPT_OK
    #define CURL_SOCKOPT_OK 0
    #endif

When we drop support for versions that do not have symbol X, the
header must change (you'd probably remove the entry with the comment
for the symbol X), but there is no need to touch all the code that
uses GITCURL_HAVE_X for a symbol like this one.

Again, of course, not all symbols and the way we conditionally
compile things are like this simple, and GITCURL_HAVE_* approach
may have merit at those places, but definitely not here.

I really wish that you did not succumb to the temptation of feature
creep while going from v2 to v3.  With this close to the preview
release, what we want is not a topic that covers more, but a topic
that corrects issues that have been identified in it and can be
merged down for the next release before -rc1.

Thanks.
