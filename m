Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7009C433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 17:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EB9C610D0
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 17:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbhKDR3g (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 13:29:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51975 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbhKDR3g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 13:29:36 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A5A7FFC4EB;
        Thu,  4 Nov 2021 13:26:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2htWSGhQKqSLV0Rztoz6qVMT98b275kNuVPj6Y
        WuJ6g=; b=VYdyr4EH0iiDYci7snk+0+DzyWHsmEb14wBAn4gHGoNA60C8WZuapt
        gA/p++MVR4WYN0DYvO63k6o1gWxYLzhs92DK9waStYmn16de9fHqFCwI3UFZ1unF
        84JT4TWfEU38Mgd3GPYXhzWznqkYOvW951hHa1wEerLZiB/NTZBBY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9C6CAFC4EA;
        Thu,  4 Nov 2021 13:26:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0E18CFC4E9;
        Thu,  4 Nov 2021 13:26:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matt Cooper via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matt Cooper <vtbassmatt@gmail.com>
Subject: Re: [PATCH v4 8/8] clean/smudge: allow clean filters to process
 extremely large files
References: <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
        <pull.1068.v4.git.1635867971.gitgitgadget@gmail.com>
        <41fda423982d99847d3879f5ea1eb3570ae9eab6.1635867971.git.gitgitgadget@gmail.com>
Date:   Thu, 04 Nov 2021 10:26:55 -0700
In-Reply-To: <41fda423982d99847d3879f5ea1eb3570ae9eab6.1635867971.git.gitgitgadget@gmail.com>
        (Matt Cooper via GitGitGadget's message of "Tue, 02 Nov 2021 15:46:11
        +0000")
Message-ID: <xmqqlf233k80.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 692EAEFE-3D94-11EC-89D0-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matt Cooper via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  struct filter_params {
>  	const char *src;
> -	unsigned long size;
> +	size_t size;
>  	int fd;
>  	const char *cmd;
>  	const char *path;

OK, this member is used in only two places in the file.  One is used
as a parameter to write_in_full() that is prepared to take size_t.
The other is to assign to this member from a size_t parameter the
apply_single_file_filter() function got from the caller, and the
callchain leading down to the function are size_t aware.

So, this may only make "a small dent" as described in the proposed
log message, but it does move it in the right direction.

Thanks.
