Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2281CC00528
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 16:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbjHAQDd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 12:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjHAQDc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 12:03:32 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF631BF
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 09:03:30 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0FC2018BCC3;
        Tue,  1 Aug 2023 12:03:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=byCnvpn83cBbmsKBfdSu4bAZjCzzO7Acn37Uun
        0pHb4=; b=LzJDaRYJDIVEH+0tdLLWum5kINcT503Z9m5qm90QEQZTRbn/XGLqPH
        c0SCbfWAX1iDwFbquzP3LT1T8BK9L1ezpFsNnQ8rNoTFHwWclGvlTq7J/DSTjrfQ
        WjXl620/SaccDOK3pwHoUSiSX8aGOI5zAuJ4fRcOmL1UxbBISzjx0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 06A9A18BCC2;
        Tue,  1 Aug 2023 12:03:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6728A18BCC0;
        Tue,  1 Aug 2023 12:03:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] avoid SHA-1 functions deprecated in OpenSSL 3+
References: <20230801025454.1137802-1-e@80x24.org>
        <20230801025454.1137802-3-e@80x24.org>
Date:   Tue, 01 Aug 2023 09:03:25 -0700
In-Reply-To: <20230801025454.1137802-3-e@80x24.org> (Eric Wong's message of
        "Tue, 1 Aug 2023 02:54:54 +0000")
Message-ID: <xmqqsf92eomq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F2EB0860-3084-11EE-BA18-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> diff --git a/hash-ll.h b/hash-ll.h
> index 087b421bd5..10d84cc208 100644
> --- a/hash-ll.h
> +++ b/hash-ll.h
> @@ -45,6 +49,10 @@
>  #define git_SHA1_Update		platform_SHA1_Update
>  #define git_SHA1_Final		platform_SHA1_Final
>  
> +#ifdef platform_SHA1_Clone
> +#define git_SHA1_Clone	platform_SHA1_Clone
> +#endif
> +
> ...
> +#ifndef SHA1_NEEDS_CLONE_HELPER
>  static inline void git_SHA1_Clone(git_SHA_CTX *dst, const git_SHA_CTX *src)
>  {
>  	memcpy(dst, src, sizeof(*dst));
>  }
> +#endif

This smelled a bit strange in that all the other platform_* stuff is
"if a platform sha-1 header implements platform_SHA1_*, we will use
it to define git_SHA1_* (which is the symbol we use in the code)"
plus its inverse "if there is no specific platform_SHA1_*, we assume
OpenSSL compatible ones and use them as platform_SHA1_* (which in
turn will be used as git_SHA1-*)".

And that is why "#ifndef platform_SHA1_CTX" block gave us default
values for them.  And from that point of view, the first hunk
(i.e. "if SHA1_CLONE is defined for the platform, we use it") is
entirely sensible.

But I did not get why we guard the other hunk with a different CPP
macro.  If we have platform_SHA1_Clone already defined, and then
NEEDS_CLONE_HELPER not defined, we end up creating an static inline
platform_SHA1_CLONE here, and I was not sure if that is what we
wanted to do.

The answer to the above puzzle (at least it was a puzzle to me) is
that the new header "sha1/openssl.h" added by this series does have
platform_SHA1_Clone defined, and the code that includes it define
NEEDS_CLONE_HELPER to avoid this "static inline", so the CPP macro
SHA1_NEEDS_CLONE_HELPER means "we need more than just a straight
bitwise copy to clone the SHA context, which is provided elsewhere
in the form of platform_SHA1_Clone".

So everything evens out.  If we are with newer OpenSSL, we will
include sha1/openssl.h and get both platform_SHA1_Clone and
SHA1_NEEDS_CLONE_HELPER defined.  If we are with older OpenSSL or
non-OpenSSL, we do not get platform_SHA1_Clone (because the "#ifndef
platform_SHA1_CTX" block does not have a fallback default defined)
and we do not get SHA1_NEEDS_CLONE_HELPER either.  We either use the
memcpy() fallback only when we are not working with newer OpenSSL or
whatever defines its own platform_SHA1_Clone.  So the patch smelled
a bit strange, but there isn't anything incorrect per-se.

But then is this making folks unnecessary work when they add
non-OpenSSL support that needs more than just memcpy() to clone the
context?  What breaks if we turn these two hunks into

	#ifdef platform_SHA1_Clone
	#define git_SHA1_Clone platform_SHA1_Clone
	#else
	static inline void git_SHA1_Clone(git_SHA_CTX *dst, git_SHA_CTX *src)
	{
		memcpy(dst, src, sizeof(*dst));
	}
	#endif

and drop the requirement that they must define SHA1_NEEDS_CLONE_HELPER
if they want to define their own platform_SHA1_Clone()?

Thanks.  Everything else in the patch made sense (even though I am
not familiar with the EVP API) to me.

