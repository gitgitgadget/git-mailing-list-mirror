Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B802C43334
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 08:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbiGFIXy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 04:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiGFIXc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 04:23:32 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09678240A1
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 01:23:30 -0700 (PDT)
Received: (qmail 2665 invoked by uid 109); 6 Jul 2022 08:23:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Jul 2022 08:23:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18229 invoked by uid 111); 6 Jul 2022 08:23:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Jul 2022 04:23:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 6 Jul 2022 04:23:28 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] sha256: add support for Nettle
Message-ID: <YsVGgFlxUbwtL6zn@coredump.intra.peff.net>
References: <20220705230518.713218-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220705230518.713218-1-sandals@crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 05, 2022 at 11:05:18PM +0000, brian m. carlson wrote:

> Let's add another option that's compatible with the GPLv2, which is
> Nettle.  It also has recently gained support for Intel's SHA-NI
> instructions, which compare very favorably to other implementations.
> For example, using this implementation and SHA-1 DC on a machine with
> SHA-NI, hashing a 2 GiB file with SHA-1 takes 7.582 seconds, while
> hashing the same file with SHA-256 takes 2.278 seconds.

Nifty. I was curious about the speed on my machine, since I still had
that sha256 import of linux.git. Sadly, it's not nearly as impressive:

  [blk_sha256]
  $ time git index-pack --verify objects/pack/*.pack
  real	2m40.164s
  user	12m30.626s
  sys	0m31.567s

  [nettle]
  $ time git index-pack --verify objects/pack/*.pack
  real	2m21.346s
  user	10m14.507s
  sys	0m30.943s

which I take to mean that it doesn't support the Intel SHA extensions
(and /proc/cpuinfo confirms that). Still, 12-18% speedup is a nice and
easy win.

>  Makefile        |  7 +++++++
>  hash.h          |  4 +++-
>  sha256/nettle.h | 28 ++++++++++++++++++++++++++++
>  3 files changed, 38 insertions(+), 1 deletion(-)
>  create mode 100644 sha256/nettle.h

The patch itself looks good to me, modulo the guard typo already pointed
out.

-Peff
