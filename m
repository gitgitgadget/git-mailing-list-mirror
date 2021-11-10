Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E736C433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 23:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 648F561159
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 23:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbhKJXtX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 18:49:23 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62122 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbhKJXtV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 18:49:21 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A90AD15C728;
        Wed, 10 Nov 2021 18:46:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SXlnaFFmOBOcdSL/wIEcdf6IPZ1hrQowUfPGDP
        8XeDg=; b=Dpd0yzhqRS9iIoUI/ynBCg38k21DcL2csdbUUdL5l9+7ORToMJrSWw
        5Iu0Opf8HbUIY3uycunUcIjTdG0KswCKTlacHt2tsTwc6r69LI+vpaM9nxTChm6q
        BIUPoeWKlGJVHwI78BtNEbSXy0H0rS5JowgRjxyQzqtyVRMEAd1AY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A181815C727;
        Wed, 10 Nov 2021 18:46:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BA50315C725;
        Wed, 10 Nov 2021 18:46:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Anders Kaseorg <andersk@mit.edu>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Andreas Heiduk <andreas.heiduk@mathema.de>
Subject: Re: [PATCH v5 1/4] fetch: Protect branches checked out in all
 worktrees
References: <2f983e36-532f-ac87-9ade-fba4c6b9d276@mit.edu>
        <20211109230941.2518143-1-andersk@mit.edu>
        <nycvar.QRO.7.76.6.2111101315330.21127@tvgsbejvaqbjf.bet>
Date:   Wed, 10 Nov 2021 15:46:28 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2111101315330.21127@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Wed, 10 Nov 2021 13:18:55 +0100
        (CET)")
Message-ID: <xmqq8rxvwp4b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6D400984-4280-11EC-949D-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> ... (apart from the slightly iffy assumption that `buf->ref`
> starts with `refs/heads/` and therefore `buf->ref + strlen("refs/heads/")`
> would not overrun, but I _think_ the current code enforces that prefix
> somewhere along the lines)

I think that is in 4/4, where the existing code does this:

> diff --git a/branch.c b/branch.c
> index 7a88a4861e..1aaf694b39 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -199,18 +199,20 @@ int validate_branchname(const char *name, struct strbuf *ref)
>   */
>  int validate_new_branchname(const char *name, struct strbuf *ref, int force)
>  {
> -	const char *head;
> +	const struct worktree *wt;
>  
>  	if (!validate_branchname(name, ref))
>  		return 0;

This takes a bare branch name in "name" (or a shorthand like @{-1}),
expand that into a full refname into "ref".  Before passing the ref
into check_refname_format(), "refs/heads/" is unconditionally added
at the beginning.  So we know ref begins with "refs/heads/" after
this point.

>  	if (!force)
>  		die(_("A branch named '%s' already exists."),
>  		    ref->buf + strlen("refs/heads/"));

And we already assume ref->buf has "refs/heads/" as its prefix.  It
may be nice to use skip_prefix(), but it probably is not worth it.

> +	wt = find_shared_symref("HEAD", ref->buf);
> +	if (wt && !wt->is_bare)
> +		die(_("Cannot force update the branch '%s'"
> +		      "checked out at '%s'."),
> +		    ref->buf + strlen("refs/heads/"), wt->path);

And this new use just reuses what we assume to be valid.

So, correctness-wise, I do not think there is much to tweak further
on top of this round.  I've always queued this round more or less
as-is.

In preparation for the next development cycle, however, it might
make sense to add a preparatory clean-up step to downcase the first
word of "die()" messages in the files that are involved in this
series (not necessarily the ones that are touched by the patches,
but all of them) and then apply these four patches (with matching
adjustments, like "Cannot force update" -> "cannot force update") on
top.  In another review message, I also noticed some inefficient
code that is due to insufficient support from the worktree.c API,
but that is not about correctness and can be left out of the series
to get these fixes early in the next cycle.

Thanks.


