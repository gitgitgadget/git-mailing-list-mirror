Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124C8C433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 17:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244758AbiCJRfQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 12:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241154AbiCJRfP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 12:35:15 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0462151686
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 09:34:13 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1EA111053D5;
        Thu, 10 Mar 2022 12:34:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F/+BtoVeWP/3OHSgbPZmEDtfwBOzOa8sihnnA7
        PFPss=; b=PUG094n0k6pfsypg6udwSKSoqS5OVJdIRHtjUdplrbqAyr1xnfW95m
        R4rVLwO6XaSgkIEbIuavkg9n7WkmzFYWy19NmWh3MzWADGijhlHfzt5ZPVfWi5JD
        C9s29H4ut36jxstHzEWGJl4erI8XPGhcjVCJqkhzA0fXFJvMzRnrU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D9F31053D3;
        Thu, 10 Mar 2022 12:34:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.14.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4064E1053D2;
        Thu, 10 Mar 2022 12:34:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, rsbecker@nexbridge.com, bagasdotme@gmail.com,
        newren@gmail.com, avarab@gmail.com, nksingh85@gmail.com,
        sandals@crustytoothpaste.net,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH 6/8] core.fsync: add `fsync_component()` wrapper which
 doesn't die
References: <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
        <50e39f698a7c0cc06d3bc060e6dbc539ea693241.1646905589.git.ps@pks.im>
Date:   Thu, 10 Mar 2022 09:34:09 -0800
In-Reply-To: <50e39f698a7c0cc06d3bc060e6dbc539ea693241.1646905589.git.ps@pks.im>
        (Patrick Steinhardt's message of "Thu, 10 Mar 2022 10:53:17 +0100")
Message-ID: <xmqqwnh1g19q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C0AA122-A098-11EC-9E4F-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> We have a `fsync_component_or_die()` helper function which only syncs
> changes to disk in case the corresponding config is enabled by the user.
> This wrapper will always die on an error though, which makes it
> insufficient for new callsites we are about to add.

You can replace "which makes it ..." part with a bit more concrete
description to save suspense from the readers.

    fsync_component_or_die() that dies upon an error is not useful
    for callers with their own error handling or recovery logic,
    like ref transaction API.

    Split fsync_component() out that returns an error to help them.

> -void fsync_or_die(int fd, const char *);
> +int maybe_fsync(int fd);
> ...
> +static inline int fsync_component(enum fsync_component component, int fd)
> +{
> +	if (fsync_components & component)
> +		return maybe_fsync(fd);
> +	return 0;
> +}
>  
>  static inline void fsync_component_or_die(enum fsync_component component, int fd, const char *msg)
>  {
> -	if (fsync_components & component)
> -		fsync_or_die(fd, msg);
> +	if (fsync_component(component, fd) < 0)
> +		die_errno("fsync error on '%s'", msg);
>  }

I think in the eventuall reroll, these "static inline" functions on
the I/O code path will become real functions in write-or-die.c but
other than that this reorganization looks sensible.

Thanks.

> diff --git a/write-or-die.c b/write-or-die.c
> index 9faa5f9f56..4a5455ce46 100644
> --- a/write-or-die.c
> +++ b/write-or-die.c
> @@ -56,19 +56,21 @@ void fprintf_or_die(FILE *f, const char *fmt, ...)
>  	}
>  }
>  
> -void fsync_or_die(int fd, const char *msg)
> +int maybe_fsync(int fd)
>  {
>  	if (use_fsync < 0)
>  		use_fsync = git_env_bool("GIT_TEST_FSYNC", 1);
>  	if (!use_fsync)
> -		return;
> +		return 0;
>  
>  	if (fsync_method == FSYNC_METHOD_WRITEOUT_ONLY &&
>  	    git_fsync(fd, FSYNC_WRITEOUT_ONLY) >= 0)
> -		return;
> +		return 0;
>  
>  	if (git_fsync(fd, FSYNC_HARDWARE_FLUSH) < 0)
> -		die_errno("fsync error on '%s'", msg);
> +		return -1;
> +
> +	return 0;
>  }
>  
>  void write_or_die(int fd, const void *buf, size_t count)
