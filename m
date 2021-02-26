Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC13C433DB
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 22:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 756AA64EDC
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 22:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhBZWmY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 17:42:24 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54590 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhBZWmW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 17:42:22 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DD72F12584B;
        Fri, 26 Feb 2021 17:41:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BuJ1Rg5LIBf+okgEJa2DXBB2kwI=; b=XZUIGd
        8WKJidpEO8WGsDapBrgJj5FR/s37i2QVIrRt/hGP35+r4x5PipRjGyormm1URcKx
        8aCNIFslla2CowqNyhod0oNGut9UKadMio7taF0yI3AUNYPLiPZdJ9OWEELZEUTu
        t+TwfKSs5IjW/fuvCTBPmOQk2tTwJMZHjNDZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uv1qyqfVmJAEmkgqMPi31uVVb7NxJed3
        R3sCTtsV3YIP9//6CS7/kJW5ZucVaI/MeLFxURwI1OFVgliCz7Dq1K7x+MSu57KE
        5wVHRo9TP7vSEYNM89se+Kxp5DnJix/RgoKJ0VxLkcN07QG7RML3loPAlFEY3mfs
        jH+jz5SSLv0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D63C312584A;
        Fri, 26 Feb 2021 17:41:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 239AA125849;
        Fri, 26 Feb 2021 17:41:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH] pack-revindex.c: don't close unopened file descriptors
References: <34c017296a7c5fe4a2ea70f8a0b2d8586b34a4dc.1614357030.git.me@ttaylorr.com>
Date:   Fri, 26 Feb 2021 14:41:36 -0800
In-Reply-To: <34c017296a7c5fe4a2ea70f8a0b2d8586b34a4dc.1614357030.git.me@ttaylorr.com>
        (Taylor Blau's message of "Fri, 26 Feb 2021 11:31:02 -0500")
Message-ID: <xmqqtupyqwnz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C9806328-7883-11EB-8661-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> When opening a reverse index, load_revindex_from_disk() jumps to the
> 'cleanup' label in case something goes wrong: the reverse index had the
> wrong size, an unrecognized version, or similar.
>
> It also jumps to this label when the reverse index couldn't be opened in
> the first place, which will cause an error with the unguarded close()
> call in the label.
>
> Guard this call with "if (fd >= 0)" to make sure that we have a valid
> file descriptor to close before attempting to close it.
>
> Reported-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
> Dscho mentioned this to me privately when reviewing Coverity results for
> -rc0. This one is legitimate, and the fix is easy enough, too.

Thanks, both.

>
>  pack-revindex.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/pack-revindex.c b/pack-revindex.c
> index 83fe4de773..4262530449 100644
> --- a/pack-revindex.c
> +++ b/pack-revindex.c
> @@ -253,7 +253,8 @@ static int load_revindex_from_disk(char *revindex_name,
>  		*data_p = (const uint32_t *)data;
>  	}
>
> -	close(fd);
> +	if (fd >= 0)
> +		close(fd);
>  	return ret;
>  }
>
> --
> 2.30.0.667.g81c0cbc6fd
