Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD55420365
	for <e@80x24.org>; Mon,  2 Oct 2017 06:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750798AbdJBGZb (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 02:25:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:57282 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750715AbdJBGZa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 02:25:30 -0400
Received: (qmail 9088 invoked by uid 109); 2 Oct 2017 06:25:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 06:25:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26168 invoked by uid 111); 2 Oct 2017 06:26:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 02:26:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Oct 2017 02:25:28 -0400
Date:   Mon, 2 Oct 2017 02:25:28 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] builtin/: add UNLEAKs
Message-ID: <20171002062528.naa5hrqoao5sifs3@sigill.intra.peff.net>
References: <20171001174208.1693753-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171001174208.1693753-1-martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 01, 2017 at 07:42:08PM +0200, Martin Ågren wrote:

> Add some UNLEAKs where we are about to return from `cmd_*`. UNLEAK the
> variables in the same order as we've declared them. While addressing
> `msg` in builtin/tag.c, convert the existing `strbuf_release()` calls as
> well.

It might have raised Junio's eyebrows less to say something like:

   ...convert the existing strbuf_release() calls as well (they're not
   wrong, but they also accomplish nothing and create an inconsistency
   with the UNLEAKed variables).

That aside, the patch looks good.

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 3345a0d16..2daa4412a 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1298,6 +1298,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>  		strbuf_release(&buf);
>  	}
>  
> +	UNLEAK(opts);
>  	if (opts.patch_mode || opts.pathspec.nr)
>  		return checkout_paths(&opts, new.name);
>  	else

Seeing hunks like this makes me happy with the UNLEAK() solution. It
would have been a real pain to do this via actual freeing.

-Peff
