Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29F6C2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 00:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7962067C
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 00:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbgAaAOR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 19:14:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:49196 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727566AbgAaAOR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 19:14:17 -0500
Received: (qmail 9877 invoked by uid 109); 31 Jan 2020 00:14:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 31 Jan 2020 00:14:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28504 invoked by uid 111); 31 Jan 2020 00:22:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 Jan 2020 19:22:02 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 30 Jan 2020 19:14:16 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] diff: only prefetch for certain output formats
Message-ID: <20200131001416.GB2394563@coredump.intra.peff.net>
References: <20200130055136.GA2184413@coredump.intra.peff.net>
 <20200130232002.203193-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200130232002.203193-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 30, 2020 at 03:20:02PM -0800, Jonathan Tan wrote:

> > +	/*
> > +	 * At this point we know there's actual work to do: we have rename
> > +	 * destinations that didn't find an exact match, and we have potential
> > +	 * sources. So we'll have to do inexact rename detection, which
> > +	 * requires looking at the blobs. It's worth pre-fetching them as a
> > +	 * group now.
> > +	 */
> > +	for (i = 0; i < rename_dst_nr; i++) {
> [...]
> 
> And also the equivalent code in diffcore_break() and in diffcore_std()
> after both these functions are invoked (in case nothing got prefetched,
> but the diff still requires blobs).

I think diffcore_break() would probably be OK to just pre-fetch
everything if it's enabled, since it has to look at the content of all
modifications. Though I suppose _technically_ added/deleted entries do
not get looked at, I doubt anybody would care in practice since the
primary use is to then feed all of the pairs into the rename code.

The diffcore_std() logic would be similar to what you wrote earlier
based on theformats. I think you'd want it to come first, before
diffcore_rename(), because it fetches a superset of refname (if it
fetches anything at all). I.e., for "diff -M -p", you'd want:

  1. diffcore_std() sees "-p" and fetches everything

  2. diffcore_rename() sees there's nothing we don't already have

rather than:

  1. diffcore_rename() fetches a few blobs to do rename detection

  2. diffcore_std() fetches a few more blobs that weren't rename
     candidates, but we need for "-p"

-Peff
