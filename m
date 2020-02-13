Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D682BC352A3
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 21:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9895F206B6
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 21:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hyqfGwzq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgBMVro (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 16:47:44 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51799 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgBMVro (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 16:47:44 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B3C95BD83F;
        Thu, 13 Feb 2020 16:47:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1e+NSqGNELWShxlXnB/He6x27Ak=; b=hyqfGw
        zqiU2pw8Mlip9iGZQ26jApgp4QN6f34CvXpo+1bEyGIoy4shwWd78PoVNa0z4R0g
        Np5eOPIywhYMD9x9xN4O9sE9kE0D4T8vp9VFku04pFOeNr97+ItJURSnf64WA3rK
        8yeEh2/1OIeDcP5CD7CjUuRrAyfp50cZD0yqU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pk+AwgEjiV4waj4xgMP+XXovF5CLK4fJ
        ucDqnhWpFTpuovoYgbAsjnT/D+zDsDJwffMHZ7AIa2sBwCClqJ8kt395VpuVI1Cm
        DI5y0KIXKWqft5L9MuR27TnlRgpkmWvJdpEQpMiZ4l5N1gDFy1XJSJQJWStp7QiP
        7zSLIs8dRG4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ABCC5BD83E;
        Thu, 13 Feb 2020 16:47:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B4B12BD83D;
        Thu, 13 Feb 2020 16:47:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 07/13] rev-list: allow bitmaps when counting objects
References: <20200213021506.GA1124607@coredump.intra.peff.net>
        <20200213022005.GG1126038@coredump.intra.peff.net>
Date:   Thu, 13 Feb 2020 13:47:38 -0800
In-Reply-To: <20200213022005.GG1126038@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 12 Feb 2020 21:20:05 -0500")
Message-ID: <xmqqftfeqhvp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 754C77A0-4EAA-11EA-B7A1-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> -	count_bitmap_commit_list(bitmap_git, &commit_count, NULL, NULL, NULL);
> +	count_bitmap_commit_list(bitmap_git, &commit_count,
> +				 revs->tree_objects ? &tree_count : NULL,
> +				 revs->blob_objects ? &blob_count : NULL,
> +				 revs->tag_objects ? &tag_count : NULL);

So count_bitmap_commit_list() has been prepared to count non-commits
already, but we are just starting to use that feature?

Interesting.

> -	printf("%d\n", commit_count);
> +	printf("%d\n", commit_count + tree_count + blob_count + tag_count);

Thanks.
