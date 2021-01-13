Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6ED1C433E0
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 13:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62CD0221F1
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 13:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbhAMN0W (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 08:26:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:54696 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbhAMN0W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 08:26:22 -0500
Received: (qmail 22460 invoked by uid 109); 13 Jan 2021 13:25:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 13 Jan 2021 13:25:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29875 invoked by uid 111); 13 Jan 2021 13:25:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 Jan 2021 08:25:41 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 13 Jan 2021 08:25:40 -0500
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 2/2] fetch-pack: refactor writing promisor file
Message-ID: <X/701Isbo8M9W2VP@coredump.intra.peff.net>
References: <20210112082159.2277214-1-chriscool@tuxfamily.org>
 <20210112082159.2277214-2-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210112082159.2277214-2-chriscool@tuxfamily.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 12, 2021 at 09:21:59AM +0100, Christian Couder wrote:

> Let's replace the 2 different pieces of code that write a
> promisor file in 'builtin/repack.c' and 'fetch-pack.c'
> with a new function called 'write_promisor_file()' in
> 'pack-write.c' and 'pack.h'.
> 
> This might also help us in the future, if we want to put
> back the ref names and associated hashes that were in
> the promisor files we are repacking in 'builtin/repack.c'
> as suggested by a NEEDSWORK comment just above the code
> we are refactoring.

I think the interface for the callers is much nicer. Not a new problem,
but one thing I did notice in the implementation:

> +void write_promisor_file(const char *promisor_name, struct ref **sought, int nr_sought)
> +{
> +	int i;
> +	FILE *output = xfopen(promisor_name, "w");
> +
> +	for (i = 0; i < nr_sought; i++)
> +		fprintf(output, "%s %s\n", oid_to_hex(&sought[i]->old_oid),
> +			sought[i]->name);
> +	fclose(output);
> +}

We check errors on open via xfopen(), which is good. But we would not
notice any problems writing via fprintf or fclose. Is it worth doing
something like:

  err = ferror(output);
  err |= fclose(output);
  return err ? -1 : 0;

?

(As an aside, this ferror/fclose dance is awkward enough and has caused
us enough questions in the past that I wonder if it is worth
encapsulating into a wrapper).

The existing callers behave the same way (checking open, but not the
writes), so definitely not a regression. But the helper function may
provide an opportunity to make things more robust without adding a lot
of duplicated code.

-Peff
