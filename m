Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F476C636CA
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 10:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F01176120E
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 10:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237954AbhGUJVw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 05:21:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:52896 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237061AbhGUJEv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 05:04:51 -0400
Received: (qmail 1721 invoked by uid 109); 21 Jul 2021 09:44:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Jul 2021 09:44:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2668 invoked by uid 111); 21 Jul 2021 09:45:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Jul 2021 05:45:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 21 Jul 2021 05:45:12 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 01/24] pack-bitmap.c: harden 'test_bitmap_walk()' to
 check type bitmaps
Message-ID: <YPfsqJrCTFQXhltJ@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <a18baeb0b42994ebcb216df5fe69459ba9a33795.1624314293.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a18baeb0b42994ebcb216df5fe69459ba9a33795.1624314293.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 21, 2021 at 06:24:59PM -0400, Taylor Blau wrote:

> The special `--test-bitmap` mode of `git rev-list` is used to compare
> the result of an object traversal with a bitmap to check its integrity.
> This mode does not, however, assert that the types of reachable objects
> are stored correctly.
> 
> Harden this mode by teaching it to also check that each time an object's
> bit is marked, the corresponding bit should be set in exactly one of the
> type bitmaps (whose type matches the object's true type).

Yep, makes sense, and the patch looks good.

> +{
> +	enum object_type bitmap_type = OBJ_NONE;
> [...]
> +
> +	if (!bitmap_type)
> +		die("object %s not found in type bitmaps",
> +		    oid_to_hex(&obj->oid));

I think the suggestion to do:

  if (bitmap_type == OBJ_NONE)

is reasonable here, as it assumes less about the enum. I do think
OBJ_BAD and OBJ_NONE were chosen with these kind of numeric comparisons
in mind, but there is no reason to rely on them in places we don't need
to.

-Peff
