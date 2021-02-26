Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBC4C433E0
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 22:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 794FD64EC4
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 22:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhBZWSo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 17:18:44 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56840 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhBZWSn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 17:18:43 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3256110B300;
        Fri, 26 Feb 2021 17:17:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8UTgY5zRMinbzE/eGIMhIqxwBes=; b=hSwtwi
        oi4W4RoybdT9pVoV095/BdoXkGWUk+ZjoPVqRmvewoYypyNak4oZnZXtGNrkTNbO
        TfqOhr+6QoARlk5KYZn+ZCzhyOpOoSgX9FXyWDXVbyhSXEBIXRmbZ6ZhLc89PWix
        z9KIS8DncnQugg1jVjeXi36h9u6cwD8H+TH/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CsZR8OzxAYdj2a4VTjkrE3p/HmiiDiAZ
        R+vxZAffsenZvGD4imXHJELLcmBGMrk6MgqSuyA6CRzKorYBRwcHo45UzaTLPAeR
        ddDD143/WCgQftvK/jnkHOwRVlxf3XMP9rehktRmfaW8hBWLsuAFVtqFLRG4sNqz
        dIQmhNytf64=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2B3B710B2FF;
        Fri, 26 Feb 2021 17:17:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 19C3410B2FE;
        Fri, 26 Feb 2021 17:17:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Aleksey Kliger <alklig@microsoft.com>
Subject: Re: [PATCH v2] Makefile: add OPEN_RETURNS_EINTR knob
References: <YDXZY8XFRayiM1If@coredump.intra.peff.net>
        <YDXaJHnZ5LgCj9NX@coredump.intra.peff.net>
        <xmqqzgzuyqli.fsf@gitster.g>
        <YDaY/M3Rw+6xwZlf@coredump.intra.peff.net>
        <YDiRywyld/0OTT5U@coredump.intra.peff.net>
Date:   Fri, 26 Feb 2021 14:17:53 -0800
In-Reply-To: <YDiRywyld/0OTT5U@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 26 Feb 2021 01:14:35 -0500")
Message-ID: <xmqq8s7ascby.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 794DB61A-7880-11EB-90FE-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> However, note that we must not enable this on Windows. It doesn't do
> anything there, and the macro overrides the existing mingw_open()
> redirection. I've added a preemptive #undef here in the mingw header
> (which is processed first) to just quietly disable it (we could also
> make it an #error, but there is little point in being so aggressive).
> ...
> diff --git a/compat/open.c b/compat/open.c
> new file mode 100644
> index 0000000000..eb3754a23b
> --- /dev/null
> +++ b/compat/open.c
> @@ -0,0 +1,25 @@
> +#include "git-compat-util.h"
> +
> +#undef open
> +int git_open_with_retry(const char *path, int flags, ...)
> +{
> +	mode_t mode = 0;
> +	int ret;
> +
> +	/*
> +	 * Also O_TMPFILE would take a mode, but it isn't defined everywhere.
> +	 * And anyway, we don't use it in our code base.
> +	 */

That is being extra careful---I like it very much.

> +	if (flags & O_CREAT) {
> +		va_list ap;
> +		va_start(ap, flags);
> +		mode = va_arg(ap, int);
> +		va_end(ap);
> +	}
> +
> +	do {
> +		ret = open(path, flags, mode);
> +	} while (ret < 0 && errno == EINTR);
> +
> +	return ret;
> +}

Thanks.

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 838246289c..551cc9f22f 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -788,6 +788,12 @@ int git_vsnprintf(char *str, size_t maxsize,
>  		  const char *format, va_list ap);
>  #endif
>  
> +#ifdef OPEN_RETURNS_EINTR
> +#undef open
> +#define open git_open_with_retry
> +int git_open_with_retry(const char *path, int flag, ...);
> +#endif
> +
>  #ifdef __GLIBC_PREREQ
>  #if __GLIBC_PREREQ(2, 1)
>  #define HAVE_STRCHRNUL
