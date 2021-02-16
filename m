Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC83C433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 22:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9E4C64DFF
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 22:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhBPWxq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 17:53:46 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59861 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhBPWxo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 17:53:44 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C0ACE118D33;
        Tue, 16 Feb 2021 17:53:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BGkPcwjpWruHfZNHaC1BIvq78Do=; b=JYma5V
        nY1ZTzHo7WpQjrvpZTZ0yr3ryRuwYZjOHio/CqbLx1zFFyxsqgu3g7xTa808WUWY
        K70GsNTxtYqSfyGHrH7SYGj9wOSJ+k1PLXV567IV1+oRgoBoALFwh9FRnU+CBuXe
        H6St034xFr4d7YcQuaIuSNw/5CizwXEk/oQbY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XGLsoOal1Mbpfl/r78yff5dYxLQGlWLV
        kzN1HOHO+3tQONmkk8TGWJwUCD6ji6NU0FqrJuhT25egNPabJFfO8jXV4yWjGpd5
        Dairg9L2Z/rGpIBwmmrwtl7VE8Qhg+jNEeauFL7W8xq/mN4lXmRgtG/3X2DV6EjE
        artiXxMXOXU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BA203118D32;
        Tue, 16 Feb 2021 17:53:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 87A1B118D30;
        Tue, 16 Feb 2021 17:52:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] t/perf: handle worktrees as test repos
References: <YCwnPVFsYDa0SNmG@coredump.intra.peff.net>
        <YCwoOMo7obrNOGYX@coredump.intra.peff.net>
Date:   Tue, 16 Feb 2021 14:52:57 -0800
In-Reply-To: <YCwoOMo7obrNOGYX@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 16 Feb 2021 15:16:56 -0500")
Message-ID: <xmqqtuqbocae.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B78584A0-70A9-11EB-A74D-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Feb 16, 2021 at 03:12:45PM -0500, Jeff King wrote:
>
>> Having written that, it occurs to me that an even simpler solution is to
>> just always use the commondir as the source of the scratch repo. It does
>> not produce the same outcome, but the point is generally just to find a
>> suitable starting point for a repository. Grabbing the main repo instead
>> of one of its worktrees is probably OK for most tests.
>
> The patch there is delightfully simple:
>
> diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
> index e385c6896f..7018256cd4 100644
> --- a/t/perf/perf-lib.sh
> +++ b/t/perf/perf-lib.sh
> @@ -75,7 +75,7 @@ test_perf_create_repo_from () {
>  	BUG "not 2 parameters to test-create-repo"
>  	repo="$1"
>  	source="$2"
> -	source_git="$("$MODERN_GIT" -C "$source" rev-parse --git-dir)"
> +	source_git="$("$MODERN_GIT" -C "$source" rev-parse --git-common-dir)"
>  	objects_dir="$("$MODERN_GIT" -C "$source" rev-parse --git-path objects)"
>  	mkdir -p "$repo/.git"
>  	(
>
> but I do wonder if somebody would find it confusing.

That does look quite a lot simpler.

What are the possible downsides?  Per-worktree references may not be
pointing at the same objects?
