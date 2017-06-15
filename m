Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 114A120401
	for <e@80x24.org>; Thu, 15 Jun 2017 13:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752599AbdFON6A (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 09:58:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:40685 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752170AbdFON57 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 09:57:59 -0400
Received: (qmail 30309 invoked by uid 109); 15 Jun 2017 13:57:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jun 2017 13:57:53 +0000
Received: (qmail 23319 invoked by uid 111); 15 Jun 2017 13:57:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jun 2017 09:57:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Jun 2017 09:57:52 -0400
Date:   Thu, 15 Jun 2017 09:57:52 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] checkout: don't write merge results into the object
 database
Message-ID: <20170615135751.qxn6bsfsxz5es236@sigill.intra.peff.net>
References: <b46827a5-2a8f-c343-ac1f-814fc8a16943@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b46827a5-2a8f-c343-ac1f-814fc8a16943@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 15, 2017 at 01:33:42PM +0200, René Scharfe wrote:

> Merge results need to be written to the worktree, of course, but we
> don't necessarily need object entries for them, especially if they
> contain conflict markers.  Use pretend_sha1_file() to create fake
> blobs to pass to make_cache_entry() and checkout_entry() instead.

Conceptually this makes sense, although I have a comment below.

Out of curiosity, did this come up when looking into the cherry-pick
segfault/error from a few hours ago?

> @@ -225,8 +225,8 @@ static int checkout_merged(int pos, const struct checkout *state)
>  	 * (it also writes the merge result to the object database even
>  	 * when it may contain conflicts).
>  	 */
> -	if (write_sha1_file(result_buf.ptr, result_buf.size,
> -			    blob_type, oid.hash))
> +	if (pretend_sha1_file(result_buf.ptr, result_buf.size,
> +			      OBJ_BLOB, oid.hash))
>  		die(_("Unable to add merge result for '%s'"), path);
>  	free(result_buf.ptr);

I wondered if pretend_sha1_file() makes a copy of the buffer, and indeed
it does. So this is correct.

But that raises an interesting question: how big are these objects, and
is it a good idea to store them in RAM? Obviously they're in RAM
already, but I'm not sure if it's one-at-a-time. We could be bumping the
peak RAM used if there's a large number of these entries. Touching the
on-disk odb does feel hacky, but it also means they behave like other
objects.

If it is a concern, I think it could be solved by "unpretending" after
our call to checkout_entry completes. That would need a new call in
sha1_file.c, but it should be easy to write.

-Peff
