Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A19C05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 04:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjBBEjq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 23:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjBBEjm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 23:39:42 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4529F5CFF0
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 20:39:41 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 542891727AB;
        Wed,  1 Feb 2023 23:39:40 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=IPQiebu5eSaMp435bvYcYuh1CeWi9MaudOj5dIO
        A0Dw=; b=s6+UHoxn0ioWXLNTKCrAEYhkN1Nk52DYEd/3i6edsq/mJrlvdJpeEgp
        Lo7Sk0GXRn3gVa0lEC5zIPjQYICuPbiFJiZTtOFjwYOOU8118IrRzOSMKlBYitzA
        eVtp22kDp56aFNClk7wXlxJK24m4woIyZ0TlauQz3oI/HGGS7zAk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4BA291727AA;
        Wed,  1 Feb 2023 23:39:40 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [108.15.224.39])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C07011727A9;
        Wed,  1 Feb 2023 23:39:39 -0500 (EST)
        (envelope-from tmz@pobox.com)
Date:   Wed, 1 Feb 2023 23:39:37 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/4] t/lib-httpd: bump required apache version to 2.2
Message-ID: <Y9s+ifALGYniOVHK@pobox.com>
References: <Y9pOmR5fOfCHwYpF@coredump.intra.peff.net>
 <Y9pO8bBZjXjEZhR/@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9pO8bBZjXjEZhR/@coredump.intra.peff.net>
X-Pobox-Relay-ID: 9ACB9500-A2B3-11ED-9FBA-307A8E0A682E-09356542!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> Apache 2.2 was released in 2005, almost 18 years ago. We can probably
> assume that people are running a version at least that old (and the
> stakes for removing it are fairly low, as the worst case is that they
> would not run the http tests against their ancient version).
> 
> Dropping support for the older versions cleans up the config file a
> little, and will also enable us to bump the required version further
> (with more cleanups) in a future patch.
> 
> Note that the file actually checks for version 2.1. In apache's
> versioning scheme, odd numbered versions are for development and even
> numbers are for stable releases. So 2.1 and 2.2 are effectively the same
> from our perspective.
> 
> Older versions would just fail to start, which would generally cause us
> to skip the tests. However, we do have version detection code in
> lib-httpd.sh which produces a nicer error message, so let's update that,
> too. I didn't bother handling the case of "3.0", etc. Apache has been on
> 2.x for 21 years, with no signs of bumping the major version.  And if
> they eventually do, I suspect there will be enough breaking changes that
> we'd need to update more than just the numeric version check. We can
> worry about that hypothetical when it happens.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/lib-httpd.sh          | 11 +++++++----
>  t/lib-httpd/apache.conf |  8 --------
>  2 files changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
> index 608949ea80..8fc411ff41 100644
> --- a/t/lib-httpd.sh
> +++ b/t/lib-httpd.sh
> @@ -99,16 +99,19 @@ then
>  fi
>  
>  HTTPD_VERSION=$($LIB_HTTPD_PATH -v | \

Trivial, but is it worth getting rid of the unnecessary
backslash, while you're improving things here?  Maybe that's
a mild tangent for code that's otherwise not adjusted very
often?

The backslash was present when lib-httpd.sh was added in
faa4bc35a0 (http-push: add regression tests, 2008-02-27).
The line was last touched in e429dfd5e4 (t/lib-httpd.sh: use
the $( ... ) construct for command substitution,
2015-12-22).

> -	sed -n 's/^Server version: Apache\/\([0-9]*\)\..*$/\1/p; q')
> +	sed -n 's/^Server version: Apache\/\([0-9.]*\).*$/\1/p; q')
> +HTTPD_VERSION_MAJOR=$(echo $HTTPD_VERSION | cut -d. -f1)
> +HTTPD_VERSION_MINOR=$(echo $HTTPD_VERSION | cut -d. -f2)

-- 
Todd
