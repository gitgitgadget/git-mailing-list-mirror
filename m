Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4B9C2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 21:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACF4020784
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 21:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HDTwrXHH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgDOVgX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 17:36:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52547 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728886AbgDOVgT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 17:36:19 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F82C4C2FA;
        Wed, 15 Apr 2020 17:36:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0Iwcib/fxXWBnkJKp+YqjPLm0yE=; b=HDTwrX
        HHuW9yoS7H3YuqLvsiVv2Wc1nC6tCZnpssAoMdwSNOML6zrTmorWUYRbZd/bheT8
        +GIwjk+FOX++17i/TVqSKpwplKjmERgVZHuI12echQIbR/bkH5UrQmG9dDAVb0AU
        tFsR825cfQiPvODgLar39/tnsHb7mJVuQNUIM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Xf1Zp+2Zx83RKmMoYQDhpjTVUyv5Pvfi
        +H5/ZbeOAfp3dVtwG6pGvRcGm/10UaCkEsxXBSOD73XDPHEY8Tg0u0gGY3jZ7rk0
        7vWWfCd/XlQl+iyvSKt1hxN6/VA7giwG9Q5KczKrZkmzNPfEz/o4GkIqgJglYd5L
        rZsG5/RLyw0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1738A4C2F8;
        Wed, 15 Apr 2020 17:36:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 77E1C4C2F7;
        Wed, 15 Apr 2020 17:36:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     luciano.rocha@booking.com
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 1/1] freshen_file(): use NULL `times' for implicit current-time
References: <5e95d37d.1c69fb81.2b4ec.ce9f@mx.google.com>
Date:   Wed, 15 Apr 2020 14:36:14 -0700
In-Reply-To: <5e95d37d.1c69fb81.2b4ec.ce9f@mx.google.com> (luciano rocha's
        message of "Tue, 14 Apr 2020 16:27:26 +0200")
Message-ID: <xmqq4ktk5t4h.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 21DF2C2E-7F61-11EA-ADB5-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

luciano.rocha@booking.com writes:

> Update freshen_file() to use a NULL `times', semantically equivalent to
> the currently setup, with an explicit `actime' and `modtime' set to the
> "current time", but with the advantage that it works with other files
> not owned by the current user.
>
> Fixes an issue on shared repos with a split index, where eventually a
> user's operation creates a shared index, and another user will later do
> an operation that will try to update its freshness, but will instead
> raise a warning:
>   $ git status
>   warning: could not freshen shared index '.git/sharedindex.bd736fa10e0519593fefdb2aec253534470865b2'

A couple of questions:

 - Does utime(fn, NULL) work for any non-owner user, or does the
   user need to have write access to it?

 - If the answer is not "you need to be able to write", doesn't the
   bug lie elsewhere, namely, why .git/sharedindex.* not writable by
   the current user, if it is a shared repository setting?

Thanks.

> Signed-off-by: Luciano Miguel Ferreira Rocha <luciano.rocha@booking.com>
> ---
>  sha1-file.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/sha1-file.c b/sha1-file.c
> index 6926851724..ccd34dd9e8 100644
> --- a/sha1-file.c
> +++ b/sha1-file.c
> @@ -881,9 +881,7 @@ void prepare_alt_odb(struct repository *r)
>  /* Returns 1 if we have successfully freshened the file, 0 otherwise. */
>  static int freshen_file(const char *fn)
>  {
> -	struct utimbuf t;
> -	t.actime = t.modtime = time(NULL);
> -	return !utime(fn, &t);
> +	return !utime(fn, NULL);
>  }
>  
>  /*
