Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499C4C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 16:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EBFF6135E
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 16:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhJUQSt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 12:18:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64695 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbhJUQSq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 12:18:46 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E3E70FBCF0;
        Thu, 21 Oct 2021 12:16:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=S7HpSznRdmMbtifNdR97yJzCwmTRNNXbXuhnnC
        fMVSY=; b=UYDYQw1+x4oPY3c5y8Y+opVHbKmYbckKvtkPzOCIYA+eKbChkIH2+s
        Ft/8Gp+JCBl1YJut2/tTZ+9PcAtaIhqH9gLmKamWWnjDlAfQwF8u1b/PH2Ki+hIB
        37dSlNHw0227C0eZ5+g7kzanmKdIP6WKPriOZOH4m/SZinMpWs1SQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DC2ADFBCEF;
        Thu, 21 Oct 2021 12:16:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 47421FBCEE;
        Thu, 21 Oct 2021 12:16:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, dstolee@microsoft.com,
        peff@peff.net
Subject: Re: [PATCH 01/11] midx.c: clean up chunkfile after reading the MIDX
References: <cover.1634787555.git.me@ttaylorr.com>
        <30f6f23daf49814f479865eea5f9ee68de209d5f.1634787555.git.me@ttaylorr.com>
Date:   Thu, 21 Oct 2021 09:16:27 -0700
In-Reply-To: <30f6f23daf49814f479865eea5f9ee68de209d5f.1634787555.git.me@ttaylorr.com>
        (Taylor Blau's message of "Wed, 20 Oct 2021 23:39:47 -0400")
Message-ID: <xmqqy26mmjz8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3EDBE924-328A-11EC-8A3F-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>  cleanup_fail:
>  	free(m);
>  	free(midx_name);
> -	free(cf);
> +	free_chunkfile(cf);
>  	if (midx_map)
>  		munmap(midx_map, midx_size);
>  	if (0 <= fd)

Not a fault of this patch, but I think the code is calling close()
on an already closed file descriptor in cleanup_fail codepath, when
"goto cleanup_fail" is reached after xmmap() returned, e.g. when
oid_version() does not match hash_version, when we failed to read
the ToC.

Also, it is not clear why is it a dying offence if we do not find
packnames chunk, but it is just a "pretend as if we do not have this
midx file and everybody else is happy" when we failed to read the
ToC.

