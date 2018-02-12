Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DFC61F404
	for <e@80x24.org>; Mon, 12 Feb 2018 17:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752836AbeBLR3Y (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 12:29:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:49314 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751200AbeBLR3X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 12:29:23 -0500
Received: (qmail 25537 invoked by uid 109); 12 Feb 2018 17:29:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Feb 2018 17:29:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10029 invoked by uid 111); 12 Feb 2018 17:30:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 12 Feb 2018 12:30:07 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Feb 2018 12:29:21 -0500
Date:   Mon, 12 Feb 2018 12:29:21 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] describe: confirm that blobs actually exist
Message-ID: <20180212172921.GA5004@sigill.intra.peff.net>
References: <20180212172306.GA4918@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180212172306.GA4918@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 12, 2018 at 12:23:06PM -0500, Jeff King wrote:

> We can fix this by replacing the lookup_blob() call with a
> check of the true type via sha1_object_info(). This is not
> quite as efficient as we could possibly make this check. We
> know in most cases that the object was already parsed in the
> earlier commit lookup, so we could call lookup_object(),
> which does auto-create, and check the resulting struct's
> type (or NULL).  However it's not worth the fragility nor
> code complexity to save a single object lookup.

By the way, I did notice one other inefficiency here: we always call
lookup_commit_reference_gently() first, which will call parse_object().
So if you were to "git describe" an enormous blob, we'd load the whole
thing into memory for no purpose. We could structure this as:

  type = sha1_object_info(oid.hash, NULL);
  if (type == OBJ_BLOB)
          describe_blob(&oid);
  else if (lookup_commit_reference_gently(&oid, 1))
          describe_commit(&oid);
  else
          describe("neither commit nor blob");

That incurs an extra object lookup for the commit case, but potentially
saves reading the blob. We could have our cake and eat it, too, if
sha1_file.c had a function like "parse this object unless it's a blob,
in which case just fill in the type info".

Arguably that should be the default when parse_object() is called on a
blob, but I suspect some older code may rely on parse_object() to check
that the object is present and consistent.

Anyway, I don't know that it's really worth caring about too much, but
just something I noticed.

Maybe a #leftoverbits if somebody cares.

-Peff
