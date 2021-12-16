Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A289EC433F5
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 18:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238911AbhLPSOO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 13:14:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:53436 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231582AbhLPSON (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 13:14:13 -0500
Received: (qmail 22087 invoked by uid 109); 16 Dec 2021 18:14:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Dec 2021 18:14:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20187 invoked by uid 111); 16 Dec 2021 18:14:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Dec 2021 13:14:12 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 16 Dec 2021 13:14:11 -0500
From:   Jeff King <peff@peff.net>
To:     Andriy Makukha via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Andriy Makukha <andriy.makukha@gmail.com>
Subject: Re: [PATCH] strlcpy(): safer and faster version
Message-ID: <YbuB8xeHLNSYnv/a@coredump.intra.peff.net>
References: <pull.1097.git.1639675881065.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1097.git.1639675881065.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 16, 2021 at 05:31:20PM +0000, Andriy Makukha via GitGitGadget wrote:

> Original strlcpy() has a significant disadvantage of being both unsafe
> and inefficient. It unnecessarily calculates length of `src` which may
> result in a segmentation fault if `src` is not terminated with a
> NUL-character.

I think any code that passes such a "src" is still broken after your
code. If the length of "src" is less than "size", then the result in
"dest" will contain garbage we read from the memory after "src".

Likewise in that case using strnlen() isn't any faster, since it has to
look at the same number of bytes either way (it may even be slower since
its loop has two conditions to check).

> In this fix, if `src` is too long, strlcpy() returns `size`. This
> allows to still detect an error while fixing the mentioned
> vulnerabilities. It deviates from original strlcpy(), but for a good
> reason.

This could potentially break callers of strlcpy(), though, because it's
changing the semantics of the return value. For example, if they use the
return value to expand a buffer to hold the result.

I do think the proposed semantics are better (I have actually fixed a
real overflow bug where somebody assumed strlcpy() returned the number
of bytes written). But we probably should not call it strlcpy(), because
that's has well-known behavior that we're not meeting.

I don't think any of the current code would be broken by this (most does
not even look at the return value at all). It just seems like an
accident waiting to happen.

Personally, I don't love strlcpy() in the first place. Avoiding heap
overflows is good, but unexpected truncation can also be buggy. That's
why try to either size buffers automatically (strbuf, xstrfmt,
FLEX_ALLOC, etc) or assert that we didn't truncate (xsnprintf).

Some cases could probably be converted away from strlcpy(). For
instance, the color stuff in add-interactive.c should be using
xsnprintf(), since the point of COLOR_MAXLEN is to hold the
longest-possible color. The ones in difftool.c probably ought to be
strbufs. There are definitely some that want the truncation semantics
(e.g., usernames in archive-tar.c). We might be better off providing a
function whose name makes it clear that truncation is OK.

>  size_t gitstrlcpy(char *dest, const char *src, size_t size)
>  {
> -	size_t ret = strlen(src);
> +	/*
> +	 * NOTE: original strlcpy returns full length of src, but this is
> +	 * unsafe. This implementation returns `size` if src is too long.
> +	 * This behaviour is faster and still allows to detect an issue.
> +	 */
> +	size_t ret = strnlen(src, size);

Also, strnlen() isn't portable, so we'd need a solution there (open
coding or yet another compat wrapper).

-Peff
