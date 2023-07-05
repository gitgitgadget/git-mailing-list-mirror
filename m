Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30828EB64DA
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 21:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbjGEVSd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 17:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjGEVSc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 17:18:32 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C03719AA
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 14:18:31 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B8C6633953;
        Wed,  5 Jul 2023 17:18:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=54ExVDqU76xDp0waA/GqsI83TnvAeSKCKIdGmh
        rx9dM=; b=dJ9MAMt05/9Q0jJ2t70ZnRTxT2zit7yPY3FM+26ulp+vuSg3hgFqMT
        1V8JcZa8a2QfoLnH25ib4pMn591J7uGqmIQL+vBuaSlvkHiPvpR5zrw8Mi8vDhPF
        KSjVZoabb6U+imwTZ8baA+kfHFV7kxf4aIukCX+hvmmHYAp6YswdQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B208B33952;
        Wed,  5 Jul 2023 17:18:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 507DA33951;
        Wed,  5 Jul 2023 17:18:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Thomas Guyot-Sionnest <tguyot@gmail.com>
Subject: Re: [PATCH v2 2/4] diff --no-index: die on error reading stdin
References: <cover.1687874975.git.phillip.wood@dunelm.org.uk>
        <cover.1688586536.git.phillip.wood@dunelm.org.uk>
        <be1d666769f2d6dd028c7d5ade0e9f563e953ab5.1688586536.git.phillip.wood@dunelm.org.uk>
Date:   Wed, 05 Jul 2023 14:18:26 -0700
In-Reply-To: <be1d666769f2d6dd028c7d5ade0e9f563e953ab5.1688586536.git.phillip.wood@dunelm.org.uk>
        (Phillip Wood's message of "Wed, 5 Jul 2023 20:49:28 +0100")
Message-ID: <xmqqilayxdjx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7B958256-1B79-11EE-8E97-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> If there is an error when reading from stdin then "diff --no-index"
> prints an error message but continues to try and diff a file named "-"
> resulting in an error message that looks like
>
>     error: error while reading from stdin: Invalid argument
>     fatal: stat '-': No such file or directory
>
> assuming that no file named "-" exists. If such a file exists it prints
> the first error message and generates the diff from that file which is
> not what the user wanted. Instead just die() straight away if we cannot
> read from stdin.

Makes sense.

> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  diff-no-index.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/diff-no-index.c b/diff-no-index.c
> index 77462ac2a9..4470e0271d 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -60,20 +60,19 @@ static int get_mode(const char *path, int *mode)
>  	return 0;
>  }
>  
> -static int populate_from_stdin(struct diff_filespec *s)
> +static void populate_from_stdin(struct diff_filespec *s)
>  {
>  	struct strbuf buf = STRBUF_INIT;
>  	size_t size = 0;
>  
>  	if (strbuf_read(&buf, 0, 0) < 0)
> -		return error_errno("error while reading from stdin");
> +		die_errno("error while reading from stdin");
>  
>  	s->should_munmap = 0;
>  	s->data = strbuf_detach(&buf, &size);
>  	s->size = size;
>  	s->should_free = 1;
>  	s->is_stdin = 1;
> -	return 0;
>  }
>  
>  static struct diff_filespec *noindex_filespec(const char *name, int mode)
