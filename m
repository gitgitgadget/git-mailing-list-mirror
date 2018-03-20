Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78DB11F404
	for <e@80x24.org>; Tue, 20 Mar 2018 04:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751261AbeCTEgz (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 00:36:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:35462 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751084AbeCTEgy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 00:36:54 -0400
Received: (qmail 30516 invoked by uid 109); 20 Mar 2018 04:36:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 20 Mar 2018 04:36:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29070 invoked by uid 111); 20 Mar 2018 04:37:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 20 Mar 2018 00:37:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Mar 2018 00:36:52 -0400
Date:   Tue, 20 Mar 2018 00:36:52 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] read-cache: fix an -Wmaybe-uninitialized warning
Message-ID: <20180320043652.GC13302@sigill.intra.peff.net>
References: <6d434e76-cfa0-2a6e-f163-b54316a24cee@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6d434e76-cfa0-2a6e-f163-b54316a24cee@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 19, 2018 at 05:56:11PM +0000, Ramsay Jones wrote:

> For the purposes of this discussion, the ce_write_entry() function has
> three code blocks of interest, that look like so:
> 
>         /* block #1 */
>         if (ce->ce_flags & CE_STRIP_NAME) {
>                 saved_namelen = ce_namelen(ce);
>                 ce->ce_namelen = 0;
>         }
> 
>         /* block #2 */
>         /*
> 	 * several code blocks that contain, among others, calls
>          * to copy_cache_entry_to_ondisk(ondisk, ce);
>          */
> 
>         /* block #3 */
>         if (ce->ce_flags & CE_STRIP_NAME) {
>                 ce->ce_namelen = saved_namelen;
>                 ce->ce_flags &= ~CE_STRIP_NAME;
>         }
> 
> The warning implies that gcc thinks it is possible that the first
> block is not entered, the calls to copy_cache_entry_to_ondisk()
> could toggle the CE_STRIP_NAME flag on, thereby entering block #3
> with saved_namelen unset. However, the copy_cache_entry_to_ondisk()
> function does not write to ce->ce_flags (it only reads). gcc could
> easily determine this, since that function is local to this file,
> but it obviously doesn't.

Weird. It seems like it would be pretty easy for it to know that we
don't write the flags field at all. But I also don't see any other thing
that would fool the compiler.

> In order to suppress this warning, we make it clear to the reader
> (human and compiler), that block #3 will only be entered when the
> first block has been entered, by introducing a new 'stripped_name'
> boolean variable. We also take the opportunity to change the type
> of 'saved_namelen' to 'unsigned int' to match ce->ce_namelen.

These probably both ought to be size_t, but it makes sense to match
ce_namelen for now.

> diff --git a/read-cache.c b/read-cache.c
> index 2eb81a66b..49607ddcd 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2104,13 +2104,15 @@ static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *ce,
>  			  struct strbuf *previous_name, struct ondisk_cache_entry *ondisk)
>  {
>  	int size;
> -	int saved_namelen = saved_namelen; /* compiler workaround */
>  	int result;
> +	unsigned int saved_namelen;
> +	int stripped_name = 0;

Maybe too clever, but I think you could just do:

  unsigned int saved_namelen = 0;
  ...
	saved_namelen = ce_namelen(ce);
  ...
  if (saved_namelen)
	ce->ce_namelen = saved_namelen;
  ce->ce_flags &= ~CE_STRIP_NAME;

the zero-length name case (if that's even legal) would work out the
same.

That probably falls under the category of bikeshedding, though.

-Peff
