Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BDC31F461
	for <e@80x24.org>; Mon, 26 Aug 2019 18:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387497AbfHZS6B (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 14:58:01 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55415 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbfHZS6B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 14:58:01 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 520C26E35E;
        Mon, 26 Aug 2019 14:57:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=blAxfX/hpBUG
        rcfT80FRk4mFIDQ=; b=bPuQaR1cD3SI1E4BHpZU14fDtKFQ5hvwpDMiu8SxbP70
        32Rgl34OegUJmRKAe/Mm6Um3SicY0gBAOdB2CP7FCTiGwC2zXmD46GsVsja4CrTr
        XJP5+7cBhsFeSNyDaVQeWrr7ERE/Fwc/Sf5V6ewRn4iuC4H7bjEfP/A1td+LPi0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=foBbKP
        8/B42gHPeKG7+HBarjaMbvV7rsDaGu9GOh5aEEKwTKACj3p6nIHOHy79kfbO870+
        zVQDMninV9AzfhUDfp57uqyS8UvrJkiG2W2VoU/e2NTQf/V3lB8lkhm04DoR+qaA
        Vb7cFD6qNh6aa6J+TZI5UbbiyEHdXzzr94Goo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4A0DD6E35D;
        Mon, 26 Aug 2019 14:57:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 70A516E35C;
        Mon, 26 Aug 2019 14:57:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, cbailey32@bloomberg.net, avarab@gmail.com
Subject: Re: [PATCH 2/2] grep: refactor and simplify PCRE1 support
References: <20190825182223.76288-1-carenas@gmail.com>
        <20190825182223.76288-3-carenas@gmail.com>
Date:   Mon, 26 Aug 2019 11:57:54 -0700
In-Reply-To: <20190825182223.76288-3-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Sun, 25 Aug 2019 11:22:23 -0700")
Message-ID: <xmqqy2zfg3f1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6A5B880C-C833-11E9-B4AA-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> diff --git a/grep.h b/grep.h
> index 1a044c501e..ff620d784a 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -3,15 +3,6 @@
>  #include "color.h"
>  #ifdef USE_LIBPCRE1
>  #include <pcre.h>
> -#ifndef NO_LIBPCRE1_JIT
> -#ifdef PCRE_CONFIG_JIT
> -#define GIT_PCRE1_USE_JIT
> -#define GIT_PCRE_STUDY_JIT_COMPILE PCRE_STUDY_JIT_COMPILE
> -#endif
> -#endif
> -#ifndef GIT_PCRE_STUDY_JIT_COMPILE
> -#define GIT_PCRE_STUDY_JIT_COMPILE 0
> -#endif
>  #else
>  typedef int pcre;
>  typedef int pcre_extra;

That's a patch pleasant to read ;-)

Will queue.  Thansk.
