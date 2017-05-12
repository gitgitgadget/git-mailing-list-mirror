Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B78BA201A4
	for <e@80x24.org>; Fri, 12 May 2017 03:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbdELDGL (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 23:06:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:50054 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750708AbdELDGL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 23:06:11 -0400
Received: (qmail 11162 invoked by uid 109); 12 May 2017 03:06:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 May 2017 03:06:11 +0000
Received: (qmail 20632 invoked by uid 111); 12 May 2017 03:06:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 23:06:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 May 2017 23:06:08 -0400
Date:   Thu, 11 May 2017 23:06:08 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH v5] fetch-pack: always allow fetching of literal SHA1s
Message-ID: <20170512030608.s4jw2g4ijivp3f52@sigill.intra.peff.net>
References: <20170509182042.28389-1-jonathantanmy@google.com>
 <20170511223054.25239-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170511223054.25239-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 03:30:54PM -0700, Jonathan Tan wrote:

> fetch-pack, when fetching a literal SHA-1 from a server that is not
> configured with uploadpack.allowtipsha1inwant (or similar), always
> returns an error message of the form "Server does not allow request for
> unadvertised object %s". However, it is sometimes the case that such
> object is advertised. This situation would occur, for example, if a user
> or a script was provided a SHA-1 instead of a branch or tag name for
> fetching, and wanted to invoke "git fetch" or "git fetch-pack" using
> that SHA-1.
> 
> Teach fetch-pack to also check the SHA-1s of the refs in the received
> ref advertisement if a literal SHA-1 was given by the user.
> 
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---

This looks good to me. There's one minor nit that I don't think I saw
mentioned, and I don't think needs to hold up the patch. But I wanted to
mention it just in case I'm wrong that it doesn't matter.

>  static void filter_refs(struct fetch_pack_args *args,
>  			struct ref **refs,
>  			struct ref **sought, int nr_sought)
>  {
>  	struct ref *newlist = NULL;
>  	struct ref **newtail = &newlist;
> +	struct ref *unmatched = NULL;
>  	struct ref *ref, *next;
> +	struct oidset tip_oids = OIDSET_INIT;
>  	int i;
>  
>  	i = 0;
> @@ -631,7 +651,8 @@ static void filter_refs(struct fetch_pack_args *args,
>  			ref->next = NULL;
>  			newtail = &ref->next;
>  		} else {
> -			free(ref);
> +			ref->next = unmatched;
> +			unmatched = ref;
>  		}

The incoming "refs" list is sorted, and we rely on that sorting to do
the linear walk. Likewise, we append to newlist via newtail, so it
remains sorted (and I suspect the consumers of the list rely on that).
But your new "unmatched" list is done by prepending, so it's in reverse
order.

I don't think that matters for our purposes here, and the list doesn't
escape our function. So there's no bug, but I just wonder if it might
end up biting somebody in the future. I'm OK with leaving it, though.

-Peff
