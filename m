Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F3FC4363A
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 22:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05BA420829
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 22:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="N6dPCywi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756622AbgJ0WAk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 18:00:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53981 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374725AbgJ0WAj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 18:00:39 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B7C781424;
        Tue, 27 Oct 2020 18:00:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UbFkNSHKPj5mvfRtvZYEsBaIGQw=; b=N6dPCy
        wi25bHhl5H8c8F3SEuStM32Vsschk6ivn+AP3PL+l6BXuxhjoMgrY4RDeWMgQ4dK
        +B0RryrckMrhVsO6YLqSCcvxDWaXF9ZAbfhSV06GyLJ2x0BFJELnJIAmE9esmkGt
        nDiO1jcYcyg4jneQ/ix81cLEwH7kLQtesJcmM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v41iUHFrXB+X68jvGJZTGucaAhmGwhd1
        zG7nzpCgfBRcpp8fMOpshFUZfqCvjpNpmIa/FYw1mpHWqa3uOa8WknlKf0gGwIY+
        Qs4WLG5hWIGnnTKg4vij3Adlnl4QgpzyYxE/TwtJGwOK4rLr2W6hUgPL5I4lauPO
        C3FsgtzAP8o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6358481423;
        Tue, 27 Oct 2020 18:00:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D184B81420;
        Tue, 27 Oct 2020 18:00:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 7/8] verify_path(): disallow symlinks in
 .gitattributes and .gitignore
References: <20201005121609.GA2907272@coredump.intra.peff.net>
        <20201005121645.GG2907394@coredump.intra.peff.net>
        <20201027033518.GH2645313@google.com>
        <20201027075853.GH3005508@coredump.intra.peff.net>
Date:   Tue, 27 Oct 2020 15:00:36 -0700
In-Reply-To: <20201027075853.GH3005508@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 27 Oct 2020 03:58:53 -0400")
Message-ID: <xmqqv9ev9vnf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D8109942-189F-11EB-9FDC-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> diff --git a/environment.c b/environment.c
> index bb518c61cd..7c233e0e0e 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -73,6 +73,7 @@ int merge_log_config = -1;
>  int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
>  unsigned long pack_size_limit_cfg;
>  enum log_refs_config log_all_ref_updates = LOG_REFS_UNSET;
> +int allow_external_symlinks = 1;

OK, so by default it is not blocked...

> +static int symlink_leaves_repo(const char *target, const char *linkpath)
> +{
> +	/*
> +	 * Absolute paths are always considered to leave the repository (even
> +	 * if they happen to point to the working tree path).
> +	 */
> +	if (is_absolute_path(target))
> +		return 1;

Very sensible.

> +	/*
> +	 * Allow relative paths that start with a sequence of "../",
> +	 * as long as they do not break out of the symlink's root.
> +	 * This loop will detect break-out cases and return; otherwise, at the
> +	 * end of the loop "target" will point to the first non-".." component.
> +	 *
> +	 * We count the depth of linkpath by eating up directory components left
> +	 * to right. Technically the symlink would resolve right-to-left, but
> +	 * we don't care about the actual values, only the number.
> +	 */
> +	while (target[0] == '.') {
> +		if (!target[1]) {
> +			/* trailing "." -- ignore */
> +			target++;
> +		} else if (is_dir_sep(target[1])) {
> +			/* "./" -- ignore */
> +			target += 2;
> +		} else if (target[1] == '.' &&
> +			   (!target[2] || is_dir_sep(target[2]))) {
> +			/* ".." or "../" -- drop one from linkpath depth */
> +			while (!is_dir_sep(*linkpath)) {
> +				/* end-of-string; target exceeded our depth */
> +				if (!*linkpath)
> +					return 1;
> +				linkpath++;
> +			}
> +			/* skip final "/" */
> +			linkpath++;
> +
> +			/* skip past ".." */
> +			target += 2;
> +			/* and "/" if present */
> +			if (is_dir_sep(*target))
> +				target++;
> +		}
> +	}
> +
> +	/*
> +	 * Now we have a path in "target" that only go down into the tree.
> +	 * Disallow any interior "../", like "foo/../bar". These might be
> +	 * OK, but we cannot know unless we know whether "foo" is itself a
> +	 * symlink. So err on the side of caution.
> +	 */
> +	while (*target) {
> +		const char *v;
> +		if (skip_prefix(target, "..", &v) && (!*v || is_dir_sep(*v)))
> +			return 1;
> +		target++;
> +	}
> +
> +	return 0;
> +}
> +
> +int safe_symlink(const char *target, const char *linkpath)
> +{
> +	if (!allow_external_symlinks &&
> +	    symlink_leaves_repo(target, linkpath)) {
> +		errno = EPERM;
> +		return -1;
> +	}
> +
> +	return symlink(target, linkpath);
> +}

OK.  This is only about blocking creation of new symbolic links that
goes outside the working tree.  It obviously is a good thing to do.

We have some "symlink safety" in various parts of the system [*1*],
and I wonder if we can somehow consolidate the support to a more
central place.

Thanks.


[Footnote]

*1* For example, apply tries to be careful not to take the "path"
    recorded in the incoming patch blindly, and instead checks if
    any path component in it is a symbolic link before touching.
    Similarly, callers of has_symlink_leading_path() all try to be
    careful when the "path" they want to use to access a filesystem
    entity has a symbolic link in the middle on the filesystem.
