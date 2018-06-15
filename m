Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFA871F403
	for <e@80x24.org>; Fri, 15 Jun 2018 03:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965199AbeFOD2x (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 23:28:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:45302 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S964995AbeFOD2x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 23:28:53 -0400
Received: (qmail 17401 invoked by uid 109); 15 Jun 2018 03:28:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Jun 2018 03:28:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18097 invoked by uid 111); 15 Jun 2018 03:29:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 14 Jun 2018 23:29:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jun 2018 23:28:51 -0400
Date:   Thu, 14 Jun 2018 23:28:51 -0400
From:   Jeff King <peff@peff.net>
To:     Luat Nguyen <root@l4w.io>
Cc:     git@vger.kernel.org
Subject: Re: security: potential out-of-bound read at ewah_io.c
 |ewah_read_mmap|
Message-ID: <20180615032850.GA23241@sigill.intra.peff.net>
References: <2067D731-C415-4D19-8CDA-90D7DC638397@l4w.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2067D731-C415-4D19-8CDA-90D7DC638397@l4w.io>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 15, 2018 at 06:59:43AM +0800, Luat Nguyen wrote:

> Recently, I’ve found a security issue related to out-of-bound read at function named `ewah_read_mmap`

Thanks, this is definitely a bug worth addressing. But note...

> Assume that, an attacker can put malicious `./git/index` into a repo by somehow.

We generally don't consider .git/index (or pack .bitmap files, which
also use this implementation) to be a major part of Git's attack
surface, since they are generated locally. And if you can write to
somebody's .git directory, there are already much easier ways to execute
arbitrary code.

> Since there is lack of check whether the remaining size of `ptr`is
> equal to `buffer_size` or not.

Yep. We also fail to check if we even have enough bytes to read the
buffer_size in the first place.

Here are some patches. The first one fixes the problem you found. The
second one drops some dead code that has a related problem. And the
third just drops some dead code that I noticed in the same file. :)

  [1/3]: ewah_read_mmap: bounds-check mmap reads
  [2/3]: ewah: drop ewah_deserialize function
  [3/3]: ewah: drop ewah_serialize_native function

 ewah/ewah_io.c          | 106 ++++++++--------------------------------
 ewah/ewok.h             |   4 +-
 t/t5310-pack-bitmaps.sh |  13 +++++
 3 files changed, 35 insertions(+), 88 deletions(-)

-Peff
