Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CF2C433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 01:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDCAF6135F
	for <git@archiver.kernel.org>; Wed, 19 May 2021 01:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbhESBhs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 21:37:48 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60893 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbhESBhr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 21:37:47 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4E72C13E17C;
        Tue, 18 May 2021 21:36:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oGoKF3v+DwTECviVnF4UuEt604erfhaUlDNsAb
        K6a9o=; b=PKhARmRNluYbC9tFhmL46EePuQgxAZ5/w1wileJmHCi/BES9I+A9/c
        VklZi193oDi3dRBjz+/BMvUKrcfk9Y716rAinT6L3+Rltuf5FpXMGhMI8iGE3Dti
        fX+0VVIvO79u80GRYB5lxs4Y/INwx2YtXe97+PmTM+19uQmpIrDzQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4560413E17B;
        Tue, 18 May 2021 21:36:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 40F8813E17A;
        Tue, 18 May 2021 21:36:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] xsize_t: avoid implementation defined behavior when len
 < 0
References: <YKPXVMchtGbwDuue@google.com>
Date:   Wed, 19 May 2021 10:36:22 +0900
In-Reply-To: <YKPXVMchtGbwDuue@google.com> (Jonathan Nieder's message of "Tue,
        18 May 2021 08:03:48 -0700")
Message-ID: <xmqqy2cbzeqx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9F2D3A70-B842-11EB-B145-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hi,
>
> This is *not* -rc material; it's just something I noticed and figured
> I would send it before I forget (among other benefits, this helps us
> kick the tires on the release candidate by having patches to work
> with).
>
> Thoughts welcome, as always.
>
> Jonathan
>
>  git-compat-util.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index a508dbe5a3..20318a0aac 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -986,11 +986,9 @@ static inline char *xstrdup_or_null(const char *str)
>  
>  static inline size_t xsize_t(off_t len)
>  {
> -	size_t size = (size_t) len;
> -
> -	if (len != (off_t) size)
> +	if (len < 0 || len > SIZE_MAX)
>  		die("Cannot handle files this big");

OK, so negative offset or offset that cannot be represented as size_t
are rejected.  That is much easier to read than the original ;-)

SIZE_MAX is associated with size_t so it presumably is an unsigned
constant; would it again trigger a sign-compare warning?

> -	return size;
> +	return (size_t) len;
>  }
>  
>  __attribute__((format (printf, 3, 4)))
