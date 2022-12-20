Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6C6C10F1E
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 15:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbiLTPoj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 10:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbiLTPoV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 10:44:21 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC2D1D0C8
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 07:44:16 -0800 (PST)
Received: (qmail 21523 invoked by uid 109); 20 Dec 2022 15:44:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 20 Dec 2022 15:44:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19239 invoked by uid 111); 20 Dec 2022 15:44:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 20 Dec 2022 10:44:16 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 20 Dec 2022 10:44:14 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] refs: fix corruption by not correctly syncing
 packed-refs to disk
Message-ID: <Y6HYTt58iecdBEdw@coredump.intra.peff.net>
References: <8c8ecf8e3718cbca049ee7a283edd7b7887e464e.1671547905.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8c8ecf8e3718cbca049ee7a283edd7b7887e464e.1671547905.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 20, 2022 at 03:52:14PM +0100, Patrick Steinhardt wrote:

> And while we do the dance when writing the `packed-refs` file, there is
> indeed one gotcha: we use a `FILE *` stream to write the temporary file,
> but don't flush it before synchronizing it to disk. As a consequence any
> data that is still buffered will not get synchronized and a crash of the
> machine may cause corruption.

The problem description makes sense, and so does your fix.

Grepping for other uses of fsync_component(), this looks like the only
buggy case (loose refs use write() directly, and most other files go via
finalize_hashfile(), which does likewise).

> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index c1c71d183e..6f5a0709fb 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -1263,7 +1263,8 @@ static int write_with_updates(struct packed_ref_store *refs,
>  		goto error;
>  	}
>  
> -	if (fsync_component(FSYNC_COMPONENT_REFERENCE, get_tempfile_fd(refs->tempfile)) ||
> +	if (fflush(out) ||
> +	    fsync_component(FSYNC_COMPONENT_REFERENCE, get_tempfile_fd(refs->tempfile)) ||
>  	    close_tempfile_gently(refs->tempfile)) {

It kind of feels like this ought to be part of fsync_component() or
close_tempfile_gently(), but it would pollute those interfaces:

  - fsync_component() doesn't otherwise know about stdio

  - close_tempfile_gently() doesn't otherwise know about syncing (and it
    would have to learn about fsync_components to do it right).

So given that this is the only affected site, it makes sense to just fix
it for now and worry about a more generalized solution if we run into it
again.

-Peff
