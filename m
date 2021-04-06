Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE55DC433B4
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 17:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 843726113C
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 17:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbhDFRj3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 13:39:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:42776 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233683AbhDFRj3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 13:39:29 -0400
Received: (qmail 8252 invoked by uid 109); 6 Apr 2021 17:39:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 06 Apr 2021 17:39:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30627 invoked by uid 111); 6 Apr 2021 17:39:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Apr 2021 13:39:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 6 Apr 2021 13:39:20 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 3/8] list-objects: move tag processing into its own
 function
Message-ID: <YGycyLTZflh3olRE@coredump.intra.peff.net>
References: <cover.1614600555.git.ps@pks.im>
 <cover.1615813673.git.ps@pks.im>
 <d8da0b24f46cd305cb1be304251745b6d9da641b.1615813673.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d8da0b24f46cd305cb1be304251745b6d9da641b.1615813673.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 15, 2021 at 02:14:40PM +0100, Patrick Steinhardt wrote:

> Move processing of tags into its own function to make the logic easier
> to extend when we're going to implement filtering for tags. No change in
> behaviour is expected from this commit.

Makes sense. Even without extending the logic, it is nice to see the
symmetric with the tree/blob paths.

Although I think it's not quite symmetric in practice...

> +static void process_tag(struct traversal_context *ctx,
> +			struct tag *tag,
> +			struct strbuf *base,
> +			const char *name)
> +{
> +	tag->object.flags |= SEEN;
> +	ctx->show_object(&tag->object, name, ctx->show_data);
> +}

I'm skeptical that "base" will ever be meaningful here (as it would be
for trees and blobs), because we are never recursing a tree to hit a
tag. We do later pass it to filter_object(), but I think it will always
be the empty string (we even assert(base->len == 0) in the caller).

So I am tempted to say it should not take a base parameter at all, and
later the call to filter_object() added to process_tag() should just
pass an empty string as the base. That would make it clear we do not
expect any kind of "base". That's mostly academic, but I think it also
makes clear that the "name" field is not something that should be
appended to the base (unlike trees and blobs, it is the name we got from
the top-level parsing, not a pathname).

-Peff
