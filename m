Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB1CC433E0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 23:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 146E364FF9
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 23:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbhCDXNB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 18:13:01 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59194 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbhCDXNB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 18:13:01 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2F650118A59;
        Thu,  4 Mar 2021 18:13:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GpGLUY8RbqyZATV1YKd0O18dpPQ=; b=uJgUfY
        TW5s8Zim36LS7CuFfxz129CNVwiYJwu+0YhIJ6tFDsre9ban9zosFaVH5v/lgEDb
        sgtJjcY4SC3UyI4WwXwr9SzrLX+eDUgo2CZ2Toq/X1gvMLrDHzkHh4WOAjrkEND5
        4ttbcX0FhP/xV3NrOj5UykK5EvI8eYFTB52fE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UMviC1JIdEiIYNEkTsis2KK2f5itgHga
        dog+JgCm9h0JLxZVWz6LPEjk1BUwIimiY8qJE6Kq5tNUWgQmoAxulI+vNwXvpg5e
        kdAPoV/wAkWtpvaR4KgNBhkqt+FOWHGD5Kq208nKeOEe/16r6pjLOjPavS77AMQB
        r/7PkGJrjec=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 282D2118A58;
        Thu,  4 Mar 2021 18:13:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6D922118A56;
        Thu,  4 Mar 2021 18:12:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 2/8] unix-socket: simplify initialization of
 unix_stream_listen_opts
References: <pull.893.git.1614889047.gitgitgadget@gmail.com>
        <6ef867bf37d366071d5f0f101e7430d859f529b5.1614889047.git.gitgitgadget@gmail.com>
Date:   Thu, 04 Mar 2021 15:12:56 -0800
In-Reply-To: <6ef867bf37d366071d5f0f101e7430d859f529b5.1614889047.git.gitgitgadget@gmail.com>
        (Jeff Hostetler via GitGitGadget's message of "Thu, 04 Mar 2021
        20:17:21 +0000")
Message-ID: <xmqqa6ricy2v.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28BA3548-7D3F-11EB-A843-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  	struct lock_file lock = LOCK_INIT;
> +	long timeout;
>  	int fd_socket;
>  	struct unix_stream_server_socket *server_socket;
>  
> +	timeout = opts->timeout_ms;
> +	if (opts->timeout_ms <= 0)
> +		timeout = DEFAULT_UNIX_STREAM_LISTEN_TIMEOUT;

If we have 0 as a special value to tell this API to use the default
value, do we need to treat negative values the same way?

Do we see any value in being able to say "no timeout---if we can do
so immediately fine, otherwise return me a failure"?  Deep in the
callchain, lockfile.c::lock_file_timeout(), which is the workhorse
of the feature, notices timeout_ms==0 and makes a direct call to
lock_file() after all, so we are prepared for such a caller already.

And if this is such a caller that may benefit from being able to say
"fail if we cannot immediately lock", perhaps we might want to allow
0 to be used as a real value and use something else as a signal to
use the timeout value determined by the helper as the default.

IOW, I would find the above iffy and prefer any of the following
over it:

(0)	if (!opts->timeout_ms)
		timeout = DEFAULT_UNIX_STREAM_LISTEN_TIMEOUT;
	else if (opts->timeout_ms < 0)
		BUG("...");

(1)	if (opts->timeout_ms < 0)
		timeout = DEFAULT_UNIX_STREAM_LISTEN_TIMEOUT;

(2)	if (opts->timeout_ms == -1)
		timeout = DEFAULT_UNIX_STREAM_LISTEN_TIMEOUT;
	else if (opts->timeout_ms < 0)
		BUG("...");

> diff --git a/unix-socket.h b/unix-socket.h
> index 8faf5b692f90..bec925ee0213 100644
> --- a/unix-socket.h
> +++ b/unix-socket.h
> @@ -7,13 +7,10 @@ struct unix_stream_listen_opts {
>  	unsigned int disallow_chdir:1;
>  };
>  
> -#define DEFAULT_UNIX_STREAM_LISTEN_TIMEOUT (100)
> -#define DEFAULT_UNIX_STREAM_LISTEN_BACKLOG (5)
> -
>  #define UNIX_STREAM_LISTEN_OPTS_INIT \
>  { \
> -	.timeout_ms = DEFAULT_UNIX_STREAM_LISTEN_TIMEOUT, \
> -	.listen_backlog_size = DEFAULT_UNIX_STREAM_LISTEN_BACKLOG, \
> +	.timeout_ms = 0, \
> +	.listen_backlog_size = 0, \
>  	.disallow_chdir = 0, \
>  }

I thought the point of suggested fix was to allow 0-initialize the
whole structure, so that we do not have to have the C preprocessor
macro UNIX_STREAM_LISTEN_OPTS_INIT at all.  I.e. it would allow us
to do

-	struct unix_stream_listen_opts opts = UNIX_STREAM_LISTEN_OPTS_INIT;
+	struct unix_stream_listen_opts opts = { 0 };

in builtin/credential-cache--daemon.c::serve_cache().

If we cannot use 0 as a special value, however, for the timeout,
then we cannot get rid of UNIX_STREAM_LISTEN_OPTS_INIT, but at least
we should be able to do

	#define UNIX_STREAM_LISTEN_OPTS_INIT { .timeout_ms = -1 }

and leave everything else 0-initialized.

Thanks.
