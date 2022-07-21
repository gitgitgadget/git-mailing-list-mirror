Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B813C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 23:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbiGUXAE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 19:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiGUXAD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 19:00:03 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FB18E1CB
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 16:00:02 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 891321ABF24;
        Thu, 21 Jul 2022 19:00:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=8dq9hIp9Rv00uvydDpGM2yv5h2ppY45iA3/NTpPznes=; b=FsuT
        zbBogC57i3YcFvHFVzfGwRUYLGy/WEx/Ca0cd8rcoA/YIs0zjwbEeFQA25zexz4B
        rQii+G4PZjKqIQ4+4rDOa0AItcKi3i8sqcZy0Jyk+vX6DP+JMFIxpsec7avWzdck
        HUjb1Dvjt6q8h2mTUtXQpakGkZ1xjMHNcxhEYuQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7190A1ABF1E;
        Thu, 21 Jul 2022 19:00:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 068C31ABF09;
        Thu, 21 Jul 2022 18:59:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/6] remote-curl: add 'get' capability
References: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
        <977f0af40fc5cf3f0a7f167e2d2a47099168f47f.1654545325.git.gitgitgadget@gmail.com>
Date:   Thu, 21 Jul 2022 15:59:56 -0700
Message-ID: <xmqq35eudqc3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D7C195AE-0948-11ED-985C-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static void parse_get(struct strbuf *buf)
> +{
> +	struct http_get_options opts = { 0 };
> +	struct strbuf url = STRBUF_INIT;
> +	struct strbuf path = STRBUF_INIT;
> +	const char *p, *space;
> +
> +	if (!skip_prefix(buf->buf, "get ", &p))
> +		die(_("http transport does not support %s"), buf->buf);
> +
> +	space = strchr(p, ' ');
> +
> +	if (!space)
> +		die(_("protocol error: expected '<url> <path>', missing space"));
> +
> +	strbuf_add(&url, p, space - p);
> +	strbuf_addstr(&path, space + 1);
> +
> +	if (http_get_file(url.buf, path.buf, &opts))
> +		die(_("failed to download file at URL '%s'"), url.buf);

Micronit:

Do we plan to add some "interesting" options later to opts?

Otherwise, the third parameter to http_get_file() can safely be
NULL, I think.

> +	test_must_fail git remote-http $url $url <input 2>err &&

It has been a while since I worked with remote-http, but does this
need two $url?
