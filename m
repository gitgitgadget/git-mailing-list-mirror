Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 100CE203C1
	for <e@80x24.org>; Mon, 12 Dec 2016 22:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752088AbcLLWZu (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 17:25:50 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60272 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751022AbcLLWZt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 17:25:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4500E580E5;
        Mon, 12 Dec 2016 17:25:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Zk0YUbdv5705mBbFhqVaCQtdIVY=; b=EJQ+1I
        FRMNwhAwIYR9GL0FX8U3Ysq7Spv6WSaZuPfqQDo/zhlK/I7k4a0Cy8SUnayt1b7U
        Xcihnh/Yee8MkNEJT0otFTt1ZuWjnRoaUw/gzfLEaZwB7/zU+yU8yAIG9mOAablD
        to63wY50GXI4EHaYTaUsC7s8+RW6vOBrZOeEM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TTWJ56lxPMRuhlnraDYFp9x4jOM/EFLx
        JAHs9vnqC/TR9Tww1e+KjgihKTa2zyemfx3gTcWfM0iQWJjsFI46e0pn0H5/MxMS
        W9VTZiSirV31ug+JJHSM3wzrztnKWISQO7u61bYoBw4JJelsxN3ATYYr2HDWbhs0
        MeFmJXbG8dQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 36B59580E3;
        Mon, 12 Dec 2016 17:25:48 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 84E98580E0;
        Mon, 12 Dec 2016 17:25:47 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jacob.keller@gmail.com, ramsay@ramsayjones.plus.com, tboegi@web.de,
        j6t@kdbg.org, pclouds@gmail.com
Subject: Re: [PATCH v3 3/4] real_path: create real_pathdup
References: <1481241494-6861-1-git-send-email-bmwill@google.com>
        <1481566615-75299-1-git-send-email-bmwill@google.com>
        <1481566615-75299-4-git-send-email-bmwill@google.com>
Date:   Mon, 12 Dec 2016 14:25:46 -0800
In-Reply-To: <1481566615-75299-4-git-send-email-bmwill@google.com> (Brandon
        Williams's message of "Mon, 12 Dec 2016 10:16:54 -0800")
Message-ID: <xmqq4m289445.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EE066DF4-C0B9-11E6-ACA7-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Create real_pathdup which returns a caller owned string of the resolved
> realpath based on the provide path.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  abspath.c | 13 +++++++++++++
>  cache.h   |  1 +
>  2 files changed, 14 insertions(+)
>
> diff --git a/abspath.c b/abspath.c
> index 8c6c76b..79ee310 100644
> --- a/abspath.c
> +++ b/abspath.c
> @@ -205,6 +205,19 @@ const char *real_path_if_valid(const char *path)
>  	return strbuf_realpath(&realpath, path, 0);
>  }
>  
> +char *real_pathdup(const char *path)
> +{
> +	struct strbuf realpath = STRBUF_INIT;
> +	char *retval = NULL;
> +
> +	if (strbuf_realpath(&realpath, path, 0))
> +		retval = strbuf_detach(&realpath, NULL);
> +
> +	strbuf_release(&realpath);
> +
> +	return retval;
> +}

OK.  Taken alone, the above makes a reader wonder if it still makes
sense for strbuf_realpath() to return realpath.buf (or NULL upon
error).  An obvious alternative is to return 0 on success and -1 on
failure.

But other callers of strbuf_realpath() are mimicking the historical
"give a path in 'const char *', receive a path in 'const char *'
that you have to xstrdup() if you want to keep it" interface, and
this interface may be easier for them.  I dunno.

>  /*
>   * Use this to get an absolute path from a relative one. If you want
>   * to resolve links, you should use real_path.
> diff --git a/cache.h b/cache.h
> index 7a81294..e12a5d9 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1068,6 +1068,7 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
>  		      int die_on_error);
>  const char *real_path(const char *path);
>  const char *real_path_if_valid(const char *path);
> +char *real_pathdup(const char *path);
>  const char *absolute_path(const char *path);
>  const char *remove_leading_path(const char *in, const char *prefix);
>  const char *relative_path(const char *in, const char *prefix, struct strbuf *sb);
