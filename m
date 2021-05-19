Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54371C433ED
	for <git@archiver.kernel.org>; Wed, 19 May 2021 00:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31E9A6135C
	for <git@archiver.kernel.org>; Wed, 19 May 2021 00:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352861AbhESAts (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 20:49:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62434 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237067AbhESAtr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 20:49:47 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C992D0922;
        Tue, 18 May 2021 20:48:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZH8HbjXqLIJWHwnRsZ3qx4lMFnGqoP9xTWuAkj
        Cf7o0=; b=j/XvejIJvAAKEkf5LSwbn8D4545FQjdJGHB8n2UHvycrGIBdcx6QS5
        wXlLtYQPX2cQkQqneo0NDE59GNJ109FCxgoEPw6Hxwev7+8aD30ZIZ4OL9KZr/Z0
        ESK1ZcndFgrdcQpfvRi+8QROXV8aDhia0fxLiT1v8VbJ0+5saUU3s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 837A5D0921;
        Tue, 18 May 2021 20:48:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0E6EBD0920;
        Tue, 18 May 2021 20:48:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] simple-ipc: correct ifdefs when NO_PTHREADS is defined
References: <pull.955.git.1621352192238.gitgitgadget@gmail.com>
Date:   Wed, 19 May 2021 09:48:27 +0900
In-Reply-To: <pull.955.git.1621352192238.gitgitgadget@gmail.com> (Jeff
        Hostetler via GitGitGadget's message of "Tue, 18 May 2021 15:36:31
        +0000")
Message-ID: <xmqqk0nv1rc4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ECD2F7BC-B83B-11EB-94BC-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +# Simple-ipc requires threads and platform-specific IPC support.
> +# (We group all Unix variants in the top-level else because Windows
> +# also defines NO_UNIX_SOCKETS.)
>  ifdef USE_WIN32_IPC
> +	BASIC_CFLAGS += -DSUPPORTS_SIMPLE_IPC
>  	LIB_OBJS += compat/simple-ipc/ipc-shared.o
>  	LIB_OBJS += compat/simple-ipc/ipc-win32.o
> +else
> +ifndef NO_PTHREADS
> +ifndef NO_UNIX_SOCKETS
> +	BASIC_CFLAGS += -DSUPPORTS_SIMPLE_IPC
> +	LIB_OBJS += compat/simple-ipc/ipc-shared.o
> +	LIB_OBJS += compat/simple-ipc/ipc-unix-socket.o
> +endif
> +endif

OK, so "!defined(NO_PTHREADS) && !defined(NO_UNIX_SOCKETS)" is the
requirement for SIMPLE_IPC unless you are on Windows.

> diff --git a/compat/simple-ipc/ipc-unix-socket.c b/compat/simple-ipc/ipc-unix-socket.c
> index 38689b278df3..c23b17973983 100644
> --- a/compat/simple-ipc/ipc-unix-socket.c
> +++ b/compat/simple-ipc/ipc-unix-socket.c
> @@ -6,10 +6,16 @@
>  #include "unix-socket.h"
>  #include "unix-stream-server.h"
>  
> +#ifdef SUPPORTS_SIMPLE_IPC
> +
>  #ifdef NO_UNIX_SOCKETS
>  #error compat/simple-ipc/ipc-unix-socket.c requires Unix sockets
>  #endif
>  
> +#ifdef NO_PTHREADS
> +#error compat/simple-ipc/ipc-unix-socket.c requires pthreads
> +#endif
> +

Do we want to duplicate the requirement here and risk them drifting
apart?

> @@ -997,3 +1003,5 @@ void ipc_server_free(struct ipc_server_data *server_data)
>  	free(server_data->fifo_fds);
>  	free(server_data);
>  }
> +
> +#endif /* SUPPORTS_SIMPLE_IPC */

If anything, I do not think we want a huge #ifdef/#endif around the
whole file.  Feeding this source to your compiler when these three C
proprocessor macros do not agree with its use is an error, so perhaps
lose all of these #ifdef/#endif around the three macros and refer human
readers to the top-level Makefile with a comment, e.g.

/*
 * Non Windows platforms need !NO_UNIX_SOCKETS and !NO_PTHREADS
 * to compile and use this file.  See the top-level Makefile.
 */

if we really wanted to have a way to help builders identify the
reason why their build is failing.

