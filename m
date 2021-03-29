Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DA4C433E3
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 12:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C54F61494
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 12:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbhC2Mxk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 08:53:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:35532 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231389AbhC2MxX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 08:53:23 -0400
Received: (qmail 10788 invoked by uid 109); 29 Mar 2021 12:53:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 29 Mar 2021 12:53:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13581 invoked by uid 111); 29 Mar 2021 12:53:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Mar 2021 08:53:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 29 Mar 2021 08:53:22 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, dstolee@microsoft.com,
        gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v3 15/16] pack-revindex: write multi-pack reverse indexes
Message-ID: <YGHNwin9zcrP00dI@coredump.intra.peff.net>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1615482270.git.me@ttaylorr.com>
 <fa3acb5d5af3aab46dd2a9703e4da03928625346.1615482270.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fa3acb5d5af3aab46dd2a9703e4da03928625346.1615482270.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 11, 2021 at 12:05:38PM -0500, Taylor Blau wrote:

> Implement the writing half of multi-pack reverse indexes. This is
> nothing more than the format describe a few patches ago, with a new set
> of helper functions that will be used to clear out stale .rev files
> corresponding to old MIDXs.

Looks good.

> +struct clear_midx_data {
> +	char *keep;
> +	const char *ext;
> +};
> +
> +static void clear_midx_file_ext(const char *full_path, size_t full_path_len,
> +				const char *file_name, void *_data)

This will clean up _any_ stale midx .rev file. So even if we miss one
when writing a new midx (due to a bug, race, power loss, etc), we'll
catch it later.

We _might_ want to also teach various tempfile-cleanup code run by gc to
likewise look for unattached midx .rev files, but I don't think we
necessarily have to do it now.

>  void clear_midx_file(struct repository *r)
>  {
>  	char *midx = get_midx_filename(r->objects->odb->path);
> @@ -1049,6 +1162,8 @@ void clear_midx_file(struct repository *r)
>  	if (remove_path(midx))
>  		die(_("failed to clear multi-pack-index at %s"), midx);
>  
> +	clear_midx_files_ext(r, ".rev", NULL);
> +
>  	free(midx);

The sole caller now doesn't pass the "keep" hash, so we'd always delete
all of them. I guess we'll see that change once somebody starts actually
writing them.

-Peff
