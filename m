Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B92C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 23:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6E9560551
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 23:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhJ1XYN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 19:24:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62029 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbhJ1XYM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 19:24:12 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B328FA35F;
        Thu, 28 Oct 2021 19:21:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=naBxKJX0z0mHJvzTtaWgmis1WKf0wFV73MkvO9
        pnSao=; b=xLJrJvD/HflVt3FViKWXTcw1BO5eACqP8l8aTO0XttNaXdPcbjuTm/
        LDX/EIJZM1a93CDGM+1bsQNdVQ5WimAQPwBc3cVzTRuTKkH6beyhco/zsErpXF7o
        asRPJBKJ5SIRl9+y4sS9hJnJFKlGSQUhc8Ehe9gHHlEA6MHlURSLU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 921EFFA35E;
        Thu, 28 Oct 2021 19:21:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D7C7EFA35D;
        Thu, 28 Oct 2021 19:21:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ivan Frade via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ivan Frade <ifrade@google.com>
Subject: Re: [PATCH v5 1/2] fetch-pack: redact packfile urls in traces
References: <pull.1052.v4.git.1635288599.gitgitgadget@gmail.com>
        <pull.1052.v5.git.1635461500.gitgitgadget@gmail.com>
        <c95b3cafcd66ce64a140b767664a8fc98eb535bf.1635461500.git.gitgitgadget@gmail.com>
Date:   Thu, 28 Oct 2021 16:21:41 -0700
In-Reply-To: <c95b3cafcd66ce64a140b767664a8fc98eb535bf.1635461500.git.gitgitgadget@gmail.com>
        (Ivan Frade via GitGitGadget's message of "Thu, 28 Oct 2021 22:51:39
        +0000")
Message-ID: <xmqqa6isohve.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CFA169F0-3845-11EC-AC11-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ivan Frade via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/pkt-line.c b/pkt-line.c
> index 2dc8ac274bd..06013d2a54a 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -370,6 +370,31 @@ int packet_length(const char lenbuf_hex[4])
>  	return (val < 0) ? val : (val << 8) | hex2chr(lenbuf_hex + 2);
>  }
>  
> +static char *find_packfile_uri_path(const char *buffer)
> +{
> +	const char *URI_MARK = "://";
> +	char *path;
> +	int len;
> +
> +	/* First char is sideband mark */
> +	buffer += 1;
> +
> +	len = strspn(buffer, "0123456789abcdefABCDEF");
> +	if (!(len == 40 || len == 64) || buffer[len] != ' ')
> +		return NULL; /* required "<hash>SP" not seen */

People may have comments on hardcoded 40/64 here and offer a better
way to write it ;-)

> +	path = strstr(buffer + len + 1, URI_MARK);
> +	if (!path)
> +		return NULL;
> +
> +	path = strchr(path + strlen(URI_MARK), '/');
> +	if (!path || !*(path + 1))
> +		return NULL;
> +
> +	/* position after '/' */
> +	return ++path;
> +}

Other than that, the patch this round looks quite clean.

Nicely done.

Thanks, will queue.
