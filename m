Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFCFC433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7999561181
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbhKRQl4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 11:41:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:33956 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230174AbhKRQl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 11:41:56 -0500
Received: (qmail 30391 invoked by uid 109); 18 Nov 2021 16:38:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 18 Nov 2021 16:38:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30982 invoked by uid 111); 18 Nov 2021 16:38:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 Nov 2021 11:38:55 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 18 Nov 2021 11:38:54 -0500
From:   Jeff King <peff@peff.net>
To:     TimTIM via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, TimTIM <t2@live.hk>
Subject: Re: [PATCH] http-protocol.txt: add missing flush to example
Message-ID: <YZaBnlUWDiid3Pc3@coredump.intra.peff.net>
References: <pull.1141.git.git.1637234203401.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1141.git.git.1637234203401.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 18, 2021 at 11:16:43AM +0000, TimTIM via GitGitGadget wrote:

> From: TimTim Wong <t2@live.hk>
> 
> Signed-off-by: Timothy Wong <i@timtim.hk>
> ---
>     Fix example in documentation
>     
>     wants must be flushed with 0000 before haves

This explanation would probably make more sense in the commit message.

I think this is only true for the v0 protocol. In the v2 protocol, we
take all of the wants/haves as a single sequence. That may be OK for our
purposes here, though. While the v2 docs do refer to http-protocol.txt,
it is only for the "Initial Client Request" section. The actual v2 fetch
primitive is defined separately in protocol-v2.txt.

> diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
> index cc5126cfeda..facb315a993 100644
> --- a/Documentation/technical/http-protocol.txt
> +++ b/Documentation/technical/http-protocol.txt
> @@ -314,8 +314,9 @@ Clients MUST first perform ref discovery with
>     C: Content-Type: application/x-git-upload-pack-request
>     C:
>     C: 0032want 0a53e9ddeaddad63ad106860237bbf53411d11a7\n
> -   C: 0032have 441b40d833fdfa93eb2908e52742248faf0ee993\n
>     C: 0000
> +   C: 0032have 441b40d833fdfa93eb2908e52742248faf0ee993\n
> +   C: done

OK, so the "have" lines moves after the flush, which makes sense.
There's no longer a trailing flush, though. Instead, we put in a "done"
command. This is OK, and what we'd often send in practice, but it is
optional (due to "no-done"). I wonder if it is worth keeping things
simpler. I dunno.

(BTW, if you run with GIT_TRACE_PACKET here, it's a bit misleading. We
_do_ send a flush after the "done", but it's the flush to tell
remote-curl that it should send the stateless-rpc packet; it doesn't
actually go over the wire with the HTTP request).

> @@ -337,9 +338,9 @@ server advertises capability `allow-tip-sha1-in-want` or
>  `allow-reachable-sha1-in-want`.
>  
>    compute_request   =  want_list
> +		       "0000"
>  		       have_list
> -		       request_end
> -  request_end       =  "0000" / "done"
> +		       "done"
>  

OK, so here we put the flush after want_list, which is good. But this
loses the optionality of "done". I think it's valid to just send the
flush, but this BNF no longer reflects that. Or if I'm wrong, I think
this needs to be discussed in the commit message.

I wondered if the non-http protocol had a similar problem, but it treats
the "want" and "have" phases more independently. E.g., we get:

    upload-request    =  want-list
                       *shallow-line
                       *1depth-request
                       [filter-request]
                       flush-pkt

and then later:

    upload-haves      =  have-list
                         compute-end
    compute-end       =  flush-pkt / PKT-LINE("done")

which is OK.

-Peff
