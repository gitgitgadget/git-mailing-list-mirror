Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B491C433F5
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 14:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F1B061074
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 14:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhJTOuV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 10:50:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58889 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhJTOuV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 10:50:21 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1089BF2C14;
        Wed, 20 Oct 2021 10:48:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=CgHw5UfFWGDEvKEs7cesZja6Ohvc6+d25wFQgoggF4w=; b=bxEV
        QjtyQi8EXZB+01I2dImT6OwicCzkjABA2ibYW/EW4f1t9akeP4rRvMC0MpZG4TDv
        RvtkcuUZ5krQYnbWxmAkGNCp0rzCf4VQI+tX20fIsmZETDB6bdfyqzeLeuMgIa7y
        hVcMOHdV4RaOA33vXZ99QUBuXq0cMcL+t+1NId8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0646FF2C13;
        Wed, 20 Oct 2021 10:48:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 41923F2C11;
        Wed, 20 Oct 2021 10:48:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/4] gitfaq: add documentation on proxies
References: <20211020010624.675562-1-sandals@crustytoothpaste.net>
        <20211020010624.675562-3-sandals@crustytoothpaste.net>
Date:   Wed, 20 Oct 2021 07:48:04 -0700
Message-ID: <xmqqbl3jrbvf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB98DE76-31B4-11EC-8763-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Many corporate environments and local systems have proxies in use.  Note
> the situations in which proxies can be used and how to configure them.
> At the same time, note what standards a proxy must follow to work with
> Git.  Explicitly call out certain classes that are known to routinely
> have problems reported various places online, including in the Git for
> Windows issue tracker and on Stack Overflow, and recommend against the
> use of such software.

The new section only talks about http(s), but I recall Peff recently
helped folks with broken invocation of socat, a relay that does not
handle severing connection only in one direction very well.

I wonder if it fits in this section.

> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  Documentation/gitfaq.txt | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
> index 946691c153..abc0f62e6c 100644
> --- a/Documentation/gitfaq.txt
> +++ b/Documentation/gitfaq.txt
> @@ -241,6 +241,24 @@ How do I know if I want to do a fetch or a pull?::
>  	ignore the upstream changes.  A pull consists of a fetch followed
>  	immediately by either a merge or rebase.  See linkgit:git-pull[1].
>  
> +[[proxy]]
> +Can I use a proxy with Git?::
> +	Yes, Git supports the use of proxies.  Git honors the standard `http_proxy`,
> +	`https_proxy`, and `no_proxy` environment variables commonly used on Unix, and
> +	it also can be configured with `http.proxy` and similar options for HTTPS (see
> +	linkgit:git-config[1]).  The `http.proxy` and related options can be
> +	customized on a per-URL pattern basis.  In addition, Git can in theory
> +	function normally with transparent proxies that exist on the network.
> ++
> +However, note that for Git to work properly, the proxy must be completely
> +transparent.  The proxy cannot modify, tamper with, change, or buffer the
> +connection in any way, or Git will almost certainly fail to work.  Note that
> +many proxies, including many TLS middleboxes, Windows antivirus and firewall
> +programs other than Windows Defender and Windows Firewall, and filtering proxies
> +fail to meet this standard, and as a result end up breaking Git.  Because of the
> +many reports of problems, we recommend against the use of these classes of
> +software and devices.
> +
>  Design
>  ------
>  
