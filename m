Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2EFC433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 21:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiANVfN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 16:35:13 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53769 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiANVfM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 16:35:12 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 822701698B3;
        Fri, 14 Jan 2022 16:35:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6ODuKUbKxyzwwvw3kOfJIvIPk6ioNZmr2pV5xI
        xZbSw=; b=N2J0Os18mWNzPHgG9+qIdgOW1Yk9NrdAlvphYUdb/4RMr6lzSeP02M
        lbD7i2O+h+ZeGAf1mJdZQLcflNmjdUzIFrZExh1Cpt9IOojZBw9VWyN0WowMxqf5
        t90rYPbJnXGxKLqtWVOO5YC2Vp8e5CXNhIX9A12FrheLhPyCrI1+g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7AEE31698B2;
        Fri, 14 Jan 2022 16:35:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D7A921698AF;
        Fri, 14 Jan 2022 16:35:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, stolee@gmail.com
Subject: Re: [PATCH v3 2/9] midx.c: make changing the preferred pack safe
References: <cover.1638991570.git.me@ttaylorr.com>
        <cover.1641320129.git.me@ttaylorr.com>
        <7d20c13f8b48d2aef45c2c8c40efb6ecdb865aa8.1641320129.git.me@ttaylorr.com>
Date:   Fri, 14 Jan 2022 13:35:08 -0800
In-Reply-To: <7d20c13f8b48d2aef45c2c8c40efb6ecdb865aa8.1641320129.git.me@ttaylorr.com>
        (Taylor Blau's message of "Tue, 4 Jan 2022 13:15:43 -0500")
Message-ID: <xmqqwnj29f1v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9533CDE-7581-11EC-A350-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> ... It's likely we were using
> finalize_object_file() instead of a pure rename() because the former
> also adjusts shared permissions.

I thought the primary reason why we use finalize was because we
ignore EEXIST (and the assumption is that the files with the same
contents get the same name computed from their contents).

>  	tmp_file = write_rev_file_order(NULL, ctx->pack_order, ctx->entries_nr,
>  					midx_hash, WRITE_REV);
>  
> -	if (finalize_object_file(tmp_file, buf.buf))
> +	if (rename(tmp_file, buf.buf))
>  		die(_("cannot store reverse index file"));

Doesn't your new code die with it if buf.buf names an existing file?
