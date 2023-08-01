Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D909CC0015E
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 19:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjHATx2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 15:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjHATx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 15:53:26 -0400
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17491E67
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 12:53:26 -0700 (PDT)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id C982E1F545;
        Tue,  1 Aug 2023 19:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1690919605;
        bh=y95EB+tyO6UuTNJxOyT8CY0+B8c7oZLx8eB9LtIpHh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m4lNXX+9R4nauzlKtjkbT7RBCNEUfcZsDv6O4AEbFAppqpv8avymTAmqi96KyNd5l
         L41PkRnzCwI9sy542nbyr/QFtTb4LwuiSpcUjyAFkBV38iKUKsH6wOSw26PHVqkVIN
         a+D/s8Xszkkg/lQ9gFHIVYdkELiAA3Q+x8bU1HiQ=
Date:   Tue, 1 Aug 2023 19:53:25 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] avoid SHA-1 functions deprecated in OpenSSL 3+
Message-ID: <20230801195325.M746978@dcvr>
References: <20230801025454.1137802-1-e@80x24.org>
 <20230801025454.1137802-3-e@80x24.org>
 <xmqqsf92eomq.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsf92eomq.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <e@80x24.org> writes:
> 
> > diff --git a/hash-ll.h b/hash-ll.h
> > index 087b421bd5..10d84cc208 100644
> > --- a/hash-ll.h
> > +++ b/hash-ll.h
> > @@ -45,6 +49,10 @@
> >  #define git_SHA1_Update		platform_SHA1_Update
> >  #define git_SHA1_Final		platform_SHA1_Final
> >  
> > +#ifdef platform_SHA1_Clone
> > +#define git_SHA1_Clone	platform_SHA1_Clone
> > +#endif
> > +
> > ...
> > +#ifndef SHA1_NEEDS_CLONE_HELPER
> >  static inline void git_SHA1_Clone(git_SHA_CTX *dst, const git_SHA_CTX *src)
> >  {
> >  	memcpy(dst, src, sizeof(*dst));
> >  }
> > +#endif
> 
> This smelled a bit strange in that all the other platform_* stuff is
> "if a platform sha-1 header implements platform_SHA1_*, we will use
> it to define git_SHA1_* (which is the symbol we use in the code)"
> plus its inverse "if there is no specific platform_SHA1_*, we assume
> OpenSSL compatible ones and use them as platform_SHA1_* (which in
> turn will be used as git_SHA1-*)".
> 
> And that is why "#ifndef platform_SHA1_CTX" block gave us default
> values for them.  And from that point of view, the first hunk
> (i.e. "if SHA1_CLONE is defined for the platform, we use it") is
> entirely sensible.
> 
> But I did not get why we guard the other hunk with a different CPP
> macro.  If we have platform_SHA1_Clone already defined, and then
> NEEDS_CLONE_HELPER not defined, we end up creating an static inline
> platform_SHA1_CLONE here, and I was not sure if that is what we
> wanted to do.
> 
> The answer to the above puzzle (at least it was a puzzle to me) is
> that the new header "sha1/openssl.h" added by this series does have
> platform_SHA1_Clone defined, and the code that includes it define
> NEEDS_CLONE_HELPER to avoid this "static inline", so the CPP macro
> SHA1_NEEDS_CLONE_HELPER means "we need more than just a straight
> bitwise copy to clone the SHA context, which is provided elsewhere
> in the form of platform_SHA1_Clone".
> 
> So everything evens out.  If we are with newer OpenSSL, we will
> include sha1/openssl.h and get both platform_SHA1_Clone and
> SHA1_NEEDS_CLONE_HELPER defined.  If we are with older OpenSSL or
> non-OpenSSL, we do not get platform_SHA1_Clone (because the "#ifndef
> platform_SHA1_CTX" block does not have a fallback default defined)
> and we do not get SHA1_NEEDS_CLONE_HELPER either.  We either use the
> memcpy() fallback only when we are not working with newer OpenSSL or
> whatever defines its own platform_SHA1_Clone.  So the patch smelled
> a bit strange, but there isn't anything incorrect per-se.
> 
> But then is this making folks unnecessary work when they add
> non-OpenSSL support that needs more than just memcpy() to clone the
> context?  What breaks if we turn these two hunks into
> 
> 	#ifdef platform_SHA1_Clone
> 	#define git_SHA1_Clone platform_SHA1_Clone
> 	#else
> 	static inline void git_SHA1_Clone(git_SHA_CTX *dst, git_SHA_CTX *src)
> 	{
> 		memcpy(dst, src, sizeof(*dst));
> 	}
> 	#endif
> 
> and drop the requirement that they must define SHA1_NEEDS_CLONE_HELPER
> if they want to define their own platform_SHA1_Clone()?

I just copied the existing SHA256 stuff and mostly did a
s/SHA256/SHA1/ in patch 2/2.  I'm not sure why
SHA256_NEEDS_CLONE_HELPER was needed, either, but I decided
to keep the SHA1 and SHA256 code as similar as possible for
consistency.

We could probably drop both *_NEEDS_CLONE_HELPER macros,
but that's a separate patch.
