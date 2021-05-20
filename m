Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E340C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 23:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0D6A6128A
	for <git@archiver.kernel.org>; Thu, 20 May 2021 23:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbhETXD3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 19:03:29 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51973 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbhETXD3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 19:03:29 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E5FDE11E4DA;
        Thu, 20 May 2021 19:02:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8MpGKzFsnHdxeVjf/WZJSkgpbZfckmWJh8RUF/
        601io=; b=MIZVdkjhqAwC+dsoWP306EFBwvIqs6+XrQj/b7MKH6Cjdf7YwMyrou
        xQS8yzHUcdhiTV9ovt477OzXPCcMBfjt6wLQ2VsCV60VsocSAHEeRFB5+PzpVWna
        0U4yLneUk9jGeDsXCNWBKPygjqFNRtNwrKDHZB0LpNuMj8euxG/Ik=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5FFD411E4D9;
        Thu, 20 May 2021 19:02:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9A04611E4D2;
        Thu, 20 May 2021 19:02:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3] simple-ipc: correct ifdefs when NO_PTHREADS is defined
References: <pull.955.v2.git.1621520547726.gitgitgadget@gmail.com>
        <pull.955.v3.git.1621535291406.gitgitgadget@gmail.com>
Date:   Fri, 21 May 2021 08:01:59 +0900
In-Reply-To: <pull.955.v3.git.1621535291406.gitgitgadget@gmail.com> (Jeff
        Hostetler via GitGitGadget's message of "Thu, 20 May 2021 18:28:10
        +0000")
Message-ID: <xmqq5yzdt3fc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 630B09B8-B9BF-11EB-856C-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  Makefile                            | 22 ++++++++++++++++++++--
>  compat/simple-ipc/ipc-shared.c      | 10 +++++++---
>  compat/simple-ipc/ipc-unix-socket.c |  8 ++++++--
>  compat/simple-ipc/ipc-win32.c       |  8 ++++++--
>  contrib/buildsystems/CMakeLists.txt | 10 +++++++++-
>  simple-ipc.h                        |  4 ----
>  6 files changed, 48 insertions(+), 14 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 3a2d3c80a81a..ea4c0a77604d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1687,13 +1687,31 @@ ifdef NO_UNIX_SOCKETS
>  else
>  	LIB_OBJS += unix-socket.o
>  	LIB_OBJS += unix-stream-server.o
> -	LIB_OBJS += compat/simple-ipc/ipc-shared.o
> -	LIB_OBJS += compat/simple-ipc/ipc-unix-socket.o
>  endif
>  
> +# Simple IPC requires threads and platform-specific IPC support.
> +# Only platforms that have both should include these source files
> +# in the build.
> +#
> +# On Windows-based systems, Simple IPC requires threads and Windows
> +# Named Pipes.  These are always available, so Simple IPC support
> +# is optional.

The last part for windows feels funny in that even if they were not
always available, the builder can still choose to compile Simple IPC
support out, hence it is optional (this is true for both Windows and
others).  In other words, "prereqs are always satisified" does not
lead to "hence it is optional".

But let's leave it as-is.  We could rewrite it to "..., so Simple
IPC is always enabled", though.

> +#
> +# On Unix-based systems, Simple IPC requires pthreads and Unix
> +# domain sockets.  So support is only enabled when both are present.

Other than that, looks good to me.

Will queue.
