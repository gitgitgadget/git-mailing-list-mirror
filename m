Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8E2C4321E
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 20:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiK3Ur4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 15:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiK3Urx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 15:47:53 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E3E17AAC
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 12:47:50 -0800 (PST)
Received: (qmail 19056 invoked by uid 109); 30 Nov 2022 20:47:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Nov 2022 20:47:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8061 invoked by uid 111); 30 Nov 2022 20:47:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Nov 2022 15:47:50 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 30 Nov 2022 15:47:49 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4] object-file: refactor corrupt object diagnosis
Message-ID: <Y4fBdW4IMhVXazm4@coredump.intra.peff.net>
References: <cover.1669839849.git.jonathantanmy@google.com>
 <a8c5fcd9f860a0434f974779bae6edf6a8ceeaca.1669839849.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a8c5fcd9f860a0434f974779bae6edf6a8ceeaca.1669839849.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 30, 2022 at 12:30:47PM -0800, Jonathan Tan wrote:

> +void die_if_corrupt(struct repository *r,
> +		    const struct object_id *oid,
> +		    const struct object_id *real_oid)
> +{
> +	const struct packed_git *p;
> +	const char *path;
> +	struct stat st;
>  
>  	obj_read_lock();
>  	if (errno && errno != ENOENT)
>  		die_errno(_("failed to read object %s"), oid_to_hex(oid));
>  
>  	/* die if we replaced an object with one that does not exist */
> -	if (repl != oid)
> +	if (real_oid != oid)
>  		die(_("replacement %s not found for %s"),
> -		    oid_to_hex(repl), oid_to_hex(oid));
> +		    oid_to_hex(real_oid), oid_to_hex(oid));

This kind of pointer comparison is a little subtle. Within a single
function, as this code was before this patch, it's probably OK to assume
that we use pointer indirection, and a non-replaced object will use the
original pointer. But for a public function, it seems like a gotcha
that:

  oidcpy(&real_oid, lookup_replace_object(r, &oid));
  die_if_corrupt(r, &oid, &real_oid);

would produce the wrong answer (it would think replacement happened even
if it didn't).

So maybe:

  if (!oideq(real_oid, oid))

instead? It's a little slower, but the point of this is to diagnose and
die, so it's not exactly a hot path. :)

-Peff
