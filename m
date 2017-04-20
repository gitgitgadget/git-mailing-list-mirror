Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7738F207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 21:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S947438AbdDTVDB (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 17:03:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:37241 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S947411AbdDTVC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 17:02:58 -0400
Received: (qmail 1634 invoked by uid 109); 20 Apr 2017 21:02:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 21:02:57 +0000
Received: (qmail 9544 invoked by uid 111); 20 Apr 2017 21:03:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 17:03:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Apr 2017 17:02:55 -0400
Date:   Thu, 20 Apr 2017 17:02:55 -0400
From:   Jeff King <peff@peff.net>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Increase core.packedGitLimit
Message-ID: <20170420210254.f4ykyi46bso5uj3o@sigill.intra.peff.net>
References: <20170420204118.17856-1-dturner@twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170420204118.17856-1-dturner@twosigma.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 20, 2017 at 04:41:18PM -0400, David Turner wrote:

> When core.packedGitLimit is exceeded, git will close packs.  If there
> is a repack operation going on in parallel with a fetch, the fetch
> might open a pack, and then be forced to close it due to
> packedGitLimit being hit.  The repack could then delete the pack
> out from under the fetch, causing the fetch to fail.
> 
> Increase core.packedGitLimit's default value to prevent
> this.
> 
> On current 64-bit x86_64 machines, 48 bits of address space are
> available.  It appears that 64-bit ARM machines have no standard
> amount of address space (that is, it varies by manufacturer), and IA64
> and POWER machines have the full 64 bits.  So 48 bits is the only
> limit that we can reasonably care about.  We reserve a few bits of the
> 48-bit address space for the kernel's use (this is not strictly
> necessary, but it's better to be safe), and use up to the remaining
> 45.  No git repository will be anywhere near this large any time soon,
> so this should prevent the failure.

Yep, I think this is a reasonable direction.

> ---
>  git-compat-util.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This probably needs an update to the core.packedGitLimit section of
Documentation/config.txt.

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 8a4a3f85e7..1c5de153a5 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -616,7 +616,7 @@ extern int git_lstat(const char *, struct stat *);
>  #endif
>  
>  #define DEFAULT_PACKED_GIT_LIMIT \
> -	((1024L * 1024L) * (size_t)(sizeof(void*) >= 8 ? 8192 : 256))
> +	((1024L * 1024L) * (size_t)(sizeof(void*) >= 8 ? (32 * 1024L * 1024L) : 256))

I wondered if we would run afoul of integer sizes on 64-bit systems where
"long" is still only 32-bits (i.e., Windows). But I think it's OK,
because the values before we cast to size_t are in megabytes. So your
32*1024*1024 needs only 25 bits to store it. And then after we cast to
size_t, everything is in 64-bit.

-Peff
