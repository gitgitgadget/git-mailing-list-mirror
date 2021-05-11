Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CD3C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 21:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2887611CA
	for <git@archiver.kernel.org>; Tue, 11 May 2021 21:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhEKVKm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 17:10:42 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50933 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhEKVKl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 17:10:41 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6741413D23C;
        Tue, 11 May 2021 17:09:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=u+ZIx+XuATYhJ60cIhI5WjbynJmmjXCc45gc0v
        QNnCw=; b=cJdry0kb18hgM/fPENcz8OTskakg+19gGN8WoMP6cttqAfjv4/3Nhu
        T/hYEriXORGA4Kh0sHTF/Pqhge5MD9LcDwa6Jqv6vOM81VaeiI9/ef9/mowOSTgG
        DEbVt/Rmb/Q6+GkJot1IsJDwlMI/Aa4uuSDqmm2DLKW9aOGh/AD0c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5F50513D23B;
        Tue, 11 May 2021 17:09:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 964A613D238;
        Tue, 11 May 2021 17:09:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] trace2: refactor to avoid gcc warning under -O3
References: <patch-1.1-87d9bcf1095-20210505T083951Z-avarab@gmail.com>
        <patch-1.1-782555daade-20210511T130231Z-avarab@gmail.com>
        <YJrEy8IPi+PFWuzT@coredump.intra.peff.net>
        <YJrIMbr6VkYGQMfs@coredump.intra.peff.net>
Date:   Wed, 12 May 2021 06:09:29 +0900
In-Reply-To: <YJrIMbr6VkYGQMfs@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 11 May 2021 14:08:49 -0400")
Message-ID: <xmqqcztxkmeu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2E005A1C-B29D-11EB-B92E-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I also wondered briefly why we needed the out-parameter at all, and not
> just letting the caller look at errno. The answer is that we need to
> preserve it across the close() call. The more usual thing in our code
> base _would_ be to use saved_errno, but not have it as an out-parameter.
>
> I.e.:
>
> diff --git a/trace2/tr2_dst.c b/trace2/tr2_dst.c
> index ae052a07fe..bda283e7f4 100644
> --- a/trace2/tr2_dst.c
> +++ b/trace2/tr2_dst.c
> @@ -204,15 +204,16 @@ static int tr2_dst_try_uds_connect(const char *path, int sock_type, int *out_fd)
>  
>  	fd = socket(AF_UNIX, sock_type, 0);
>  	if (fd == -1)
> -		return errno;
> +		return -1;
>  
>  	sa.sun_family = AF_UNIX;
>  	strlcpy(sa.sun_path, path, sizeof(sa.sun_path));
>  
>  	if (connect(fd, (struct sockaddr *)&sa, sizeof(sa)) == -1) {
> -		int e = errno;
> +		int saved_errno = errno;
>  		close(fd);
> -		return e;
> +		errno = saved_errno;
> +		return -1;
>  	}
>  
>  	*out_fd = fd;
> @@ -227,7 +228,6 @@ static int tr2_dst_try_unix_domain_socket(struct tr2_dst *dst,
>  {
>  	unsigned int uds_try = 0;
>  	int fd;
> -	int e;
>  	const char *path = NULL;
>  
>  	/*
> @@ -271,23 +271,21 @@ static int tr2_dst_try_unix_domain_socket(struct tr2_dst *dst,
>  	}
>  
>  	if (uds_try & TR2_DST_UDS_TRY_STREAM) {
> -		e = tr2_dst_try_uds_connect(path, SOCK_STREAM, &fd);
> -		if (!e)
> +		if (!tr2_dst_try_uds_connect(path, SOCK_STREAM, &fd))
>  			goto connected;
> -		if (e != EPROTOTYPE)
> +		if (errno != EPROTOTYPE)
>  			goto error;
>  	}
>  	if (uds_try & TR2_DST_UDS_TRY_DGRAM) {
> -		e = tr2_dst_try_uds_connect(path, SOCK_DGRAM, &fd);
> -		if (!e)
> +		if (!tr2_dst_try_uds_connect(path, SOCK_DGRAM, &fd))
>  			goto connected;
>  	}
>  
>  error:
>  	if (tr2_dst_want_warning())
>  		warning("trace2: could not connect to socket '%s' for '%s' tracing: %s",
>  			path, tr2_sysenv_display_name(dst->sysenv_var),
> -			strerror(e));
> +			strerror(errno));
>  
>  	tr2_dst_trace_disable(dst);
>  	return 0;
>
>
> I do prefer that approach, since I think it's more idiomatic for our
> code base, but for the sake of wrapping up this simple fix which has
> been discussed much more than I think it deserves, I am OK with either.
> :)

Yeah, the above looks nicer to me too.

>
> (I also found it interesting that the "error" goto in the caller only
> has one source. I think the code would be easier to reason about if it
> were inlined, but I'm happy to stop here for now).
>
> -Peff
