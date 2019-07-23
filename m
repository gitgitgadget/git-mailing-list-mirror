Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C95A91F461
	for <e@80x24.org>; Tue, 23 Jul 2019 16:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387571AbfGWQtv (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jul 2019 12:49:51 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58554 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729558AbfGWQtv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jul 2019 12:49:51 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 61101822F1;
        Tue, 23 Jul 2019 12:49:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K+D6428x95veZ26uo9hvNAaxqTg=; b=dcAxlr
        6TZqmYsgDT63+nwMnud3o6a1GnC8CZTtnPCeyvey7B3SFgF1ustkA83pfb+A9oiT
        kvT8svdgD19Szc8EXJ1jCjw+YZJiUdpjbOyeH5kVhmKoyTVYkiVV2OK7curWVoup
        g0yKMx2uyRpGl1XFmnxmGQuVdFRmEV6Ni4EXg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=skbXaFBs75VkFyWRtFDNLwNjDkdEvbTQ
        VHTO2iFuaKkUjfvrgcNT1qIZaIWW0gKiN0uMw6a0Btf3dn1W0BHRG6kWLsoaqmzL
        iVX2dUR1Ts/FqeYW0PFyeWxNP526ieBR2cxaDd0yrb/83yo8rvZ3ad5QEnJyEgz4
        7azVLXL5jgA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 59958822F0;
        Tue, 23 Jul 2019 12:49:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8829A822EF;
        Tue, 23 Jul 2019 12:49:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matt Turner <mattst88@gmail.com>, Rene Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org,
        David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: Re: [PATCH] archive: Store checksum correctly
References: <20190723025736.23036-1-mattst88@gmail.com>
Date:   Tue, 23 Jul 2019 09:49:44 -0700
In-Reply-To: <20190723025736.23036-1-mattst88@gmail.com> (Matt Turner's
        message of "Mon, 22 Jul 2019 19:57:36 -0700")
Message-ID: <xmqqd0i0u253.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E0C5D05E-AD69-11E9-A515-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matt Turner <mattst88@gmail.com> writes:

> tar2sqfs (part of https://github.com/topics/tar2sqfs) rejects tarballs
> made with git archive with the message
>
>     invalid tar header checksum!
>
> tar2sqfs recomputes the tarball's checksum to verify it. Its checksum
> implementation agrees with GNU tar, which contains a comment that states
>
>     Fill in the checksum field.  It's formatted differently from the
>     other fields: it has [6] digits, a null, then a space ...
>
> Correcting this allows tar2sqfs to correctly process the tarballs made
> by git archive.
>
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  archive-tar.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/archive-tar.c b/archive-tar.c
> index 3e53aac1e6..f9a157bfd1 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -215,7 +215,9 @@ static void prepare_header(struct archiver_args *args,
>  	memcpy(header->magic, "ustar", 6);
>  	memcpy(header->version, "00", 2);
>  
> -	xsnprintf(header->chksum, sizeof(header->chksum), "%07o", ustar_header_chksum(header));
> +	xsnprintf(header->chksum, sizeof(header->chksum), "%06o", ustar_header_chksum(header));
> +	header->chksum[6] = '\0';
> +	header->chksum[7] = ' ';

Wow.  The choice of %07o is as old as the very original of tar-tree
implementation in our codebase, starting at ae64bbc1 ("tar-tree:
Introduce write_entry()", 2006-03-25).

I think the updated behaviour matches Wikipedia [*1*] where it
spells out that 6 octal is followed by a NUL and a SP; it also says
various implementations do not adhere to this format---perhaps they
meant us ;-)

Frustratingly, I couldn't find this spelled out in POSIX [*2*] X-<.
The closest I found there was

    All other fields are leading zero-filled octal numbers using
    digits from the ISO/IEC 646:1991 standard IRV. Each numeric
    field is terminated by one or more <space> or NUL characters.

which sounds as if the standard wanted to be deliberately more
inclusive than what tar2sqfs is insisting on.

I think a change like this would impact kernel.org folks' tarball
uploading tool, but that is not a reason not to apply this patch.



[References].

*1* https://en.wikipedia.org/wiki/Tar_(computing)
*2* http://pubs.opengroup.org/onlinepubs/9699919799/utilities/pax.html

