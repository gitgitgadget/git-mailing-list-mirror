Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4492C433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 05:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbhK3FQf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 00:16:35 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58006 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235511AbhK3FQd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 00:16:33 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A4F9EF3958;
        Tue, 30 Nov 2021 00:13:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b2PxNv4uGp121oiwUj1vCfMPIXe1TcgZcxKemi
        04BgE=; b=mQIPb3SmX3Ca+SvBz6z/lVeoqzw9lqDGOGS6NsM03J/sJT509hWOrB
        9eYhnWsivcZBXZcBySEoGU1rZUnqGrxRtnVXs1cUh94Q2K6KbA8FPXSCs2Aa0P5F
        NszazV9sAaFO+WbRzrGeSad3YkKVxeXlxPN9Ck5mgOEv+RtOk0fIk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D7AAF3957;
        Tue, 30 Nov 2021 00:13:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 01DF2F3956;
        Tue, 30 Nov 2021 00:13:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Baruch Burstein <bmburstein@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>
Subject: Re: [RFC PATCH] vreportf: ensure sensible ordering of normal and
 error output
References: <20211130043946.19987-1-sunshine@sunshineco.com>
Date:   Mon, 29 Nov 2021 21:13:10 -0800
In-Reply-To: <20211130043946.19987-1-sunshine@sunshineco.com> (Eric Sunshine's
        message of "Mon, 29 Nov 2021 23:39:46 -0500")
Message-ID: <xmqqtufu2pll.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 36F2BD24-519C-11EC-895B-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> This is RFC because I naturally worry about potential fallout from
> making a change to such a core function. I can't think of any case that
> it wouldn't be advantageous to flush stdout before stderr, so this
> change _seems_ safe, however, it may be that I'm just not imaginative
> enough, hence my hesitancy.

If stdout and stderr are both going to the same place (e.g. the
user's terminal), this would probably is an improvement, but if the
standard output is going to a pipe talking to another process, which
may care when the output is flushed, this may hurt.

But as long as the calling code is using stdio, it cannot precisely
control when the buffered contents are flushed anyway, so as long as
the caller has working standard output, this may be OK.

Hits from "git grep -l vreportf" includes http-backend.c; where is
its standard output connected, and can it have some unflushed stuff
in its standard output buffer, I wonder?

>  usage.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/usage.c b/usage.c
> index c7d233b0de..0fc7640b25 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -27,6 +27,7 @@ void vreportf(const char *prefix, const char *err, va_list params)
>  	}
>  
>  	*(p++) = '\n'; /* we no longer need a NUL */
> +	fflush(stdout);
>  	fflush(stderr);
>  	write_in_full(2, msg, p - msg);
>  }
