Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5ADC433FE
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 05:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbiJZFzM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 01:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbiJZFzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 01:55:09 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6568A2E685
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 22:55:06 -0700 (PDT)
Received: (qmail 11155 invoked by uid 109); 26 Oct 2022 05:55:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 26 Oct 2022 05:55:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2106 invoked by uid 111); 26 Oct 2022 05:55:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 26 Oct 2022 01:55:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 26 Oct 2022 01:55:04 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?utf-8?B?7KCV7J6s7Jqw?= <thebound7@gmail.com>
Subject: Re: [PATCH] apply: reject patches larger than ~1 GiB
Message-ID: <Y1jLuMN6biwR87ga@coredump.intra.peff.net>
References: <70f5763834dff373a5573a99ec4cdfa36cadf34c.1666722251.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <70f5763834dff373a5573a99ec4cdfa36cadf34c.1666722251.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 25, 2022 at 02:24:31PM -0400, Taylor Blau wrote:

> To avoid potential overflow and truncation issues in `git apply`, apply
> similar treatment as in dcd1742e56 (xdiff: reject files larger than
> ~1GB, 2015-09-24), where the xdiff code was taught to reject large
> files for similar reasons.

I think this is a reasonable stopgap measure. In the case of xdiff, we
knew that we were working with text files. Is that always true here,
though? I.e., after this patch are we blocked from handling a 1GB binary
diff patch?

I'm mostly asking from a devil's advocate position. Even if the answer
is yes, I think this may still be the right thing to do, at least in the
short term.

> The maximum size was chosen somewhat arbitrarily, but picking a value
> just shy of a gigabyte allows us to double it without overflowing 2^31-1
> (after which point our value would wrap around to a negative number).
> To give ourselves a bit of extra margin, the maximum patch size is a MiB
> smaller than a full GiB, which gives us some slop in case we allocate
> "(records + 1) * sizeof(int)" or similar.

This was eerily familiar, and I wondered what "records" meant in
apply.c. But that is just the example from xdiff. :) I agree that the
same "extra margin" argument makes sense here, just out of caution.

> +/*
> + * apply.c isn't equipped to handle arbitrarily large patches, because
> + * it intermingles `unsigned long` with `int` for the type used to store
> + * buffer lengths.
> + *
> + * Only process patches that are just shy of 1 GiB large in order to
> + * avoid any truncation or overflow issues.
> + */
> +#define MAX_APPLY_SIZE (1024UL * 1024 * 1023)
> +
>  static int read_patch_file(struct strbuf *sb, int fd)
>  {
> -	if (strbuf_read(sb, fd, 0) < 0)
> +	if (strbuf_read(sb, fd, 0) < 0 || sb->len >= MAX_APPLY_SIZE)
>  		return error_errno("git apply: failed to read");

The patch itself looks reasonable. We'll potentially allocate an
unbounded amount of RAM before rejecting the patch, but there's not an
easy fix there without teaching strbuf_read() to accept a maximum.

It's probably not worth worrying about given the attack surface here
(it's not like anybody is reading patches from a socket that will cause
a DoS).

-Peff
