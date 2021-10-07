Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262D5C433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 20:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1225160FDC
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 20:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242128AbhJGUuD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 16:50:03 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53262 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241986AbhJGUuB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 16:50:01 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 759F9163EB3;
        Thu,  7 Oct 2021 16:48:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8N1NJaCw0W+G47pVu/MRtL8BSoKuow0CgkDehF
        cAp4A=; b=deY1OauDe6etGHRSsOHJ4UC1o5X5eSYsysdTu02QgzPRHwMBUZAaIZ
        96BK5hn1XVudftYS4ngC9FTsHUePTVDP0UPUmbPphyRs4Ft79YcbtYAKucu3Glhs
        zfDFy9XJKg1Sqw7i2+FMbBJdC0Xwu25PTxoRNXF2Uzax1tqdBE3So=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6E6FF163EB1;
        Thu,  7 Oct 2021 16:48:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BCC2A163EAE;
        Thu,  7 Oct 2021 16:48:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/5] cat-file: disable refs/replace with
 --batch-all-objects
References: <YVy1sx8Xb1xMLFQT@coredump.intra.peff.net>
        <YVy3N7ZX+s6Mi93y@coredump.intra.peff.net>
Date:   Thu, 07 Oct 2021 13:48:03 -0700
In-Reply-To: <YVy3N7ZX+s6Mi93y@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 5 Oct 2021 16:36:07 -0400")
Message-ID: <xmqqo880pnng.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DE889318-27AF-11EC-A281-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
> index 6467707c6e..27b27e2b30 100644
> --- a/Documentation/git-cat-file.txt
> +++ b/Documentation/git-cat-file.txt
> @@ -96,7 +96,8 @@ OPTIONS
>  	any alternate object stores (not just reachable objects).
>  	Requires `--batch` or `--batch-check` be specified. By default,
>  	the objects are visited in order sorted by their hashes; see
> -	also `--unordered` below.
> +	also `--unordered` below. Objects are presented as-is, without
> +	respecting the "replace" mechanism of linkgit:git-replace[1].

OK.

> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 243fe6844b..b713be545e 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -529,6 +529,8 @@ static int batch_objects(struct batch_options *opt)
>  		if (has_promisor_remote())
>  			warning("This repository uses promisor remotes. Some objects may not be loaded.");
>  
> +		read_replace_refs = 0;
> +
>  		cb.opt = opt;
>  		cb.expand = &data;
>  		cb.scratch = &output;

This is still early enough in the codeflow that we wouldn't have
looked up any object under the different name up to this point,
which is good.

