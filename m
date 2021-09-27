Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4B5C433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 20:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9DD360527
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 20:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236767AbhI0UIw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 16:08:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50798 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236733AbhI0UIv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 16:08:51 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F226F7B96;
        Mon, 27 Sep 2021 16:07:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nGHRSE9tlR8x6KPfuM0yiuFgogXSQsNGRDsLyX
        SXhqs=; b=dd9mvFr720mJW44R0zbItB5jhnMwH8YxykMBXn8wDb3t0JIi2QQLpv
        pYIEXeZNCXACIzYiyAJNmJDJwPDJ+4qF6Y63o+O9521SS5P0wAbSL00zb6sYkiNA
        dS3Haw7quVtUFaypuFWNIsU1ulGgt/36VPI2ibR+pezkjKWB3ibTc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 14EBFF7B95;
        Mon, 27 Sep 2021 16:07:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 70E45F7B94;
        Mon, 27 Sep 2021 16:07:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v6 4/8] core.fsyncobjectfiles: add windows support for
 batch mode
References: <pull.1076.v5.git.git.1632514331.gitgitgadget@gmail.com>
        <pull.1076.v6.git.git.1632527609.gitgitgadget@gmail.com>
        <bdb99822f8c45a8b2855ee2ab38c4460e4b5e22e.1632527609.git.gitgitgadget@gmail.com>
Date:   Mon, 27 Sep 2021 13:07:11 -0700
In-Reply-To: <bdb99822f8c45a8b2855ee2ab38c4460e4b5e22e.1632527609.git.gitgitgadget@gmail.com>
        (Neeraj Singh via GitGitGadget's message of "Fri, 24 Sep 2021 23:53:25
        +0000")
Message-ID: <xmqq1r59rde8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 80B70B04-1FCE-11EC-B713-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/compat/mingw.h b/compat/mingw.h
> index c9a52ad64a6..6074a3d3ced 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -329,6 +329,9 @@ int mingw_getpagesize(void);
>  #define getpagesize mingw_getpagesize
>  #endif
>  
> +int win32_fsync_no_flush(int fd);
> +#define fsync_no_flush win32_fsync_no_flush

...

> diff --git a/wrapper.c b/wrapper.c
> index bb4f9f043ce..1a1e2fba9c9 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -567,6 +567,10 @@ int git_fsync(int fd, enum fsync_action action)
>  						 SYNC_FILE_RANGE_WAIT_AFTER);
>  #endif
>  
> +#ifdef fsync_no_flush
> +		return fsync_no_flush(fd);
> +#endif
> +
>  		errno = ENOSYS;
>  		return -1;

This almost makes me wonder if we want to have a fallback
implementation of fsync_no_flush() that does

   int fsync_no_flush(int unused)
   {
	errno = ENOSYS;
	return -1;
   }

when nobody (like Windows) define their own fsync_no_flush().  That
way, this codepath does not have to have #ifdef/#endif here.

This function is already #ifdef ridden anyway, so reducing just one
instance may not make much difference, but since I noticed it ...

Thanks.
