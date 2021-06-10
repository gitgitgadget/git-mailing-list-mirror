Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3065DC48BD1
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 14:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12E0E610E6
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 14:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhFJOxg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 10:53:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:51388 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230298AbhFJOxf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 10:53:35 -0400
Received: (qmail 7990 invoked by uid 109); 10 Jun 2021 14:51:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Jun 2021 14:51:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30942 invoked by uid 111); 10 Jun 2021 14:51:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Jun 2021 10:51:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 10 Jun 2021 10:51:38 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Nikhil Gupta <nikhilgupta2102@gmail.com>,
        git-packagers@googlegroups.com, Git List <git@vger.kernel.org>
Subject: Re: Build errors when building git on MacOS 11 (x86-64) and for M1
 macs
Message-ID: <YMIm+hqqeY2IjEW3@coredump.intra.peff.net>
References: <f5487adb-b7dc-4f97-bca1-749701337759n@googlegroups.com>
 <87sg1p24zc.fsf@evledraar.gmail.com>
 <YMIjaytMYslKjK6z@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YMIjaytMYslKjK6z@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 10, 2021 at 10:36:27AM -0400, Jeff King wrote:

> Most compilers put the directory of the source file at the start of the
> search path. E.g., gcc says under -I:
> 
>   1. For the quote form of the include directive, the directory of the
>      current file is searched first.
> 
> Which is why we need "-I." at all; we are finding "archive.h" from
> "builtin/*.c". I'm not sure what "current file" there means, or how
> portable it is. Is it the source file being filed, or the file
> containing the #include directive?
> 
> I'd hope it's consistently the latter. Otherwise "foo.h" which includes
> "bar.h" cannot be included as "../foo.h" (from builtin/foo.c) and as
> "foo.h" (from top-level foo.c).
> 
> If so, then yeah, using "../archive.h" (and dropping -I. entirely) would
> be an option. Which is nice, because it makes things less magical and
> more predictable (think what confusion we'd see if we introduced
> "archive.h" into builtin/ ourselves).

There's a related case, which is that within trace2/foo.c, we'd include
trace2/foo.h. Without "-I.", the correct include there is just "foo.h".

So what was explicit actually becomes implicit. Here's a real example to
make this file work without -I:

  diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
  index a8018f18cc..592c194ab4 100644
  --- a/trace2/tr2_tgt_perf.c
  +++ b/trace2/tr2_tgt_perf.c
  @@ -1,15 +1,15 @@
  -#include "cache.h"
  -#include "config.h"
  -#include "run-command.h"
  -#include "quote.h"
  -#include "version.h"
  -#include "json-writer.h"
  -#include "trace2/tr2_dst.h"
  -#include "trace2/tr2_sid.h"
  -#include "trace2/tr2_sysenv.h"
  -#include "trace2/tr2_tbuf.h"
  -#include "trace2/tr2_tgt.h"
  -#include "trace2/tr2_tls.h"
  +#include "../cache.h"
  +#include "../config.h"
  +#include "../run-command.h"
  +#include "../quote.h"
  +#include "../version.h"
  +#include "../json-writer.h"
  +#include "tr2_dst.h"
  +#include "tr2_sid.h"
  +#include "tr2_sysenv.h"
  +#include "tr2_tbuf.h"
  +#include "tr2_tgt.h"
  +#include "tr2_tls.h"

So I dunno. I had hoped it would be a strict readability improvement,
but now I'm not so sure.

-Peff
