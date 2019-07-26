Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 941791F462
	for <e@80x24.org>; Fri, 26 Jul 2019 21:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfGZVHW (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 17:07:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64126 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfGZVHW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 17:07:22 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F506151478;
        Fri, 26 Jul 2019 17:07:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=uIZABb/i9NGc
        7nVxuU+DZx4BxfQ=; b=LQ8YD7hHH2QX6ed33SoZBg3ikG9dxSZCxkyNmq3d2Jul
        EEAMuX1LrdTB1rcZQaX5fxOdjrbQ+bg4ZtR1XiUE1bE0z+cOb7VNveae4jI3uDfa
        pUnyqWu8vwhJEUv9rHvu67ld8HnQ/Q4vAdyXra1fhH2uyjZhieIps/LsPLM5VUg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=h7ecme
        IpZHdsBJ97RFZyuFzREap9tYYzmX/WqUC7YMgdPc5BscXSikHVx+GCHrR2WoaNwq
        JwCoZMrTSlb9HFFWO4xxf41WnfvVnhLCwGOGO7qBEO+RRSDLwBzACH4bLk0QHztK
        Q0R7ZQt62L2AMHsVAARbux2QiE2acEudED9i0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 65ED7151477;
        Fri, 26 Jul 2019 17:07:17 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D0489151475;
        Fri, 26 Jul 2019 17:07:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 8/8] grep: optimistically use PCRE2_MATCH_INVALID_UTF
References: <20190724151415.3698-1-avarab@gmail.com>
        <20190726150818.6373-9-avarab@gmail.com>
Date:   Fri, 26 Jul 2019 14:07:15 -0700
In-Reply-To: <20190726150818.6373-9-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 26 Jul 2019 17:08:18 +0200")
Message-ID: <xmqqd0hwmrng.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 591AC998-AFE9-11E9-8618-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/Makefile b/Makefile
> index bd246f2989..dd38d5e527 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -726,6 +726,7 @@ TEST_BUILTINS_OBJS +=3D test-oidmap.o
>  TEST_BUILTINS_OBJS +=3D test-online-cpus.o
>  TEST_BUILTINS_OBJS +=3D test-parse-options.o
>  TEST_BUILTINS_OBJS +=3D test-path-utils.o
> +TEST_BUILTINS_OBJS +=3D test-pcre2-config.o

This won't even build with any released pcre version; shouldn't we
make it at least conditionally compiled code?  Specifically...

>  TEST_BUILTINS_OBJS +=3D test-pkt-line.o
>  TEST_BUILTINS_OBJS +=3D test-prio-queue.o
>  TEST_BUILTINS_OBJS +=3D test-reach.o
> diff --git a/grep.c b/grep.c
> index c7c06ae08d..8b8b9efe12 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -474,7 +474,7 @@ static void compile_pcre2_pattern(struct grep_pat *=
p, const struct grep_opt *opt
>  	}
>  	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->patte=
rn) &&
>  	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
> -		options |=3D PCRE2_UTF;
> +		options |=3D (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
> =20
>  	p->pcre2_pattern =3D pcre2_compile((PCRE2_SPTR)p->pattern,
>  					 p->patternlen, options, &error, &erroffset,
> diff --git a/grep.h b/grep.h
> index c0c71eb4a9..506f05b97b 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -21,6 +21,9 @@ typedef int pcre_extra;
>  #ifdef USE_LIBPCRE2
>  #define PCRE2_CODE_UNIT_WIDTH 8
>  #include <pcre2.h>
> +#ifndef PCRE2_MATCH_INVALID_UTF
> +#define PCRE2_MATCH_INVALID_UTF 0
> +#endif

... unlike this piece of code ...

>  #else
>  typedef int pcre2_code;
>  typedef int pcre2_match_data;
> diff --git a/t/helper/test-pcre2-config.c b/t/helper/test-pcre2-config.=
c
> new file mode 100644
> index 0000000000..5258fdddba
> --- /dev/null
> +++ b/t/helper/test-pcre2-config.c
> @@ -0,0 +1,12 @@
> +#include "test-tool.h"
> +#include "cache.h"
> +#include "grep.h"
> +
> +int cmd__pcre2_config(int argc, const char **argv)
> +{
> +	if (argc =3D=3D 2 && !strcmp(argv[1], "has-PCRE2_MATCH_INVALID_UTF"))=
 {
> +		int value =3D PCRE2_MATCH_INVALID_UTF;

... this part does not have any fallback definition.
