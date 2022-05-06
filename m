Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0FCC433EF
	for <git@archiver.kernel.org>; Fri,  6 May 2022 18:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390915AbiEFSWN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 14:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235427AbiEFSWL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 14:22:11 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92B9120AD
        for <git@vger.kernel.org>; Fri,  6 May 2022 11:18:27 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DD499119235;
        Fri,  6 May 2022 14:18:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Jpu44yQuSiIZq2tzdBf4T2kcUOvKFBgkqjOQ+5
        fPp+Y=; b=YILGSbbjd3UBJoDO6gA7ecgO+sjblzNwhF4+JCu7Hul5uzcKTZ6kKi
        bo93kFBlvYydt9CmOVW4bFPnO9RYpfmdiF97aR5GQgeqU+3YbDey56kikulc8llZ
        EvrIM/br0siSJwgHaPLBLhRBACGRLyuWick0O2S44ilGofFgwclAc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D1280119234;
        Fri,  6 May 2022 14:18:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 23046119233;
        Fri,  6 May 2022 14:18:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>, kernel-team@fb.com
Subject: Re: [PATCH v2 2/2] bisect: output bisect setup status in bisect log
References: <cover.1651796862.git.chris@chrisdown.name>
        <acab8859d02c95750fdbc691ac672c17d5be0291.1651796862.git.chris@chrisdown.name>
Date:   Fri, 06 May 2022 11:18:25 -0700
In-Reply-To: <acab8859d02c95750fdbc691ac672c17d5be0291.1651796862.git.chris@chrisdown.name>
        (Chris Down's message of "Fri, 6 May 2022 01:52:54 +0100")
Message-ID: <xmqqh762le32.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EC047DAE-CD68-11EC-B494-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chris Down <chris@chrisdown.name> writes:

> +__attribute__((format (printf, 1, 2)))
> +static void bisect_log_printf(const char *fmt, ...)
> +{
> +	va_list ap;
> +	char buf[1024];
> +
> +	va_start(ap, fmt);
> +	if (vsnprintf(buf, sizeof(buf), fmt, ap) < 0)
> +		*buf = '\0';
> +	va_end(ap);

We should just do

	struct strbuf buf = STRBUF_INIT;

	va_start(ap, fmt);
	strbuf_vaddf(&buf, fmt, ap);
	va_end(ap);

> +	printf("%s", buf);
> +	append_to_file(git_path_bisect_log(), "# %s", buf);

and free the resource with

	strbuf_release(&buf);

I think.

> +}

> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> index a02587d1a7..d16730a2e2 100755
> --- a/t/t6030-bisect-porcelain.sh
> +++ b/t/t6030-bisect-porcelain.sh
> @@ -1029,18 +1029,23 @@ test_expect_success 'bisect state output with multiple good commits' '
>         git bisect reset &&
>         git bisect start >output &&
>         grep "waiting for both good and bad commits" output &&
> +       git bisect log | grep "waiting for both good and bad commits" &&

Having "git" command on the left hand side of pipe would hide a
failure signalled by its exit status from the command.  The "but if
the command fails, how likely would we see the expected output to
its standard ouput?" argument aside, it is more common to write

	  git bisect log >output &&
	  grep "..." &&

instead.

Thanks.
