Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9049BC49EA5
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70F0A6120D
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbhFXToW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 15:44:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:60036 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232805AbhFXToV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 15:44:21 -0400
Received: (qmail 13130 invoked by uid 109); 24 Jun 2021 19:42:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Jun 2021 19:42:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16090 invoked by uid 111); 24 Jun 2021 19:42:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Jun 2021 15:42:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 24 Jun 2021 15:42:00 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com
Subject: Re: [PATCH 1/4] csum-file: introduce checksum_valid()
Message-ID: <YNTgCMN3ImaLmzKT@coredump.intra.peff.net>
References: <cover.1624473543.git.me@ttaylorr.com>
 <3f1fcf348473d7320d46e3df6fe97c482b9888f2.1624473543.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3f1fcf348473d7320d46e3df6fe97c482b9888f2.1624473543.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 23, 2021 at 02:39:07PM -0400, Taylor Blau wrote:

> +int hashfile_checksum_valid(const unsigned char *data, size_t total_len)
> +{
> +	unsigned char got[GIT_MAX_RAWSZ];
> +	git_hash_ctx ctx;
> +	size_t data_len = total_len - the_hash_algo->rawsz;
> +
> +	if (total_len < the_hash_algo->rawsz)
> +		return 0; /* say "too short"? */
> +
> +	the_hash_algo->init_fn(&ctx);
> +	the_hash_algo->update_fn(&ctx, data, data_len);
> +	the_hash_algo->final_fn(got, &ctx);
> +
> +	return hasheq(got, data + data_len);
> +}

This "too short" comment is a little ugly, but I don't think it's easy
to do better. This function does not otherwise print anything to stderr,
so calling error() here would probably be bad. And having multiple
return types would complicate the callers.

I _suspect_ it's hard to trigger anyway, because the callers would
generally have complained about a too-short file in the first place. So
possibly it could be a BUG(). But I think leaving it as-is is the more
conservative choice, as we don't know what checks callers will have
done.

In the long run, we might want to teach this function to actually write
to stderr (or an error buffer), because it may be useful to say:

  hash mismatch: trailer checksum claims 1234abcd, but we computed 5678cdef

or similar. In which case we could then say "too short" in the same way.
I'm content to leave that for later if somebody cares. In every case of
file corruption I've seen, things are sufficiently complicated and
confusing that I turn to a hex dump of the file anyway. ;)

-Peff
