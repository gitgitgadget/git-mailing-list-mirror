Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F281A1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 01:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbeHOE2U (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 00:28:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:55748 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725927AbeHOE2U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 00:28:20 -0400
Received: (qmail 16407 invoked by uid 109); 15 Aug 2018 01:38:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 15 Aug 2018 01:38:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28738 invoked by uid 111); 15 Aug 2018 01:38:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 Aug 2018 21:38:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Aug 2018 21:38:25 -0400
Date:   Tue, 14 Aug 2018 21:38:25 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, danshu@microsoft.com,
        marc@marc-stevens.nl
Subject: Re: [PATCH 0/9] Add missing includes and forward declares
Message-ID: <20180815013825.GA12178@sigill.intra.peff.net>
References: <20180811043218.31456-1-newren@gmail.com>
 <87mutts3sz.fsf@evledraar.gmail.com>
 <CABPp-BEADR15gOrH+GBQxKLZR2fCQwhaPWgf3VS--Z0bTNP0rA@mail.gmail.com>
 <20180811173406.GA9119@sigill.intra.peff.net>
 <xmqqr2j25dlm.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr2j25dlm.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 11:24:37AM -0700, Junio C Hamano wrote:

> As things are slowly moving out of the so-far kitchen-sink "cache.h"
> into more specific subsystem headers (like object-store.h), we may
> actually want to tighten the "header that includes it first" part a
> bit in the future, so that 'git grep cache.h' would give us a more
> explicit and a better picture of what really depends on knowing what
> the lowest level plumbing API are built around.

Yeah, I agree that's a good long-term goal. I think "builtin.h" is
reasonable to remain as a magic header for builtins.

> > So I think the better test is a two-line .c file with:
> >
> >   #include "git-compat-util.h"
> >   #include $header_to_check
> 
> But until that tightening happens, I do not actually mind the
> two-line .c file started with inclusion of cache.h instead of
> git-compat-util.h.  That would limit the scope of this series
> further.

I can go either way on this. Using cache.h makes Elijah's current series
a bit more focused. But I think we'd eventually want to go there anyway.
I don't have a strong opinion on doing it now or later.

> > I wonder if there's an easy way to check. I guess adding '-Dint=foo' to
> > the command line, and then putting '#undef int' at the top of
> > git-compat-util would catch just about any code the compiler sees that
> > doesn't have git-compat-util included. :)
> 
> ;-).

So much to my amazement, my off-the-cuff suggestion actually worked
pretty well. The only failures were xdiff (expected, since it does its
own system-header stuff, though IMHO we might think about changing that)
and the programs in t/helper. Here's a patch to address the latter (and
you can see now why I said the above thing about "builtin.h"):

-- >8 --
Subject: [PATCH] test-tool.h: include git-compat-util.h

The test-tool programs include "test-tool.h" as their first
include, which breaks our CodingGuideline of "the first
include must be git-compat-util.h or an equivalent". This
isn't actually a problem, as test-tool.h doesn't define
anything tricky, but we should probably follow our own rule.

Rather than change them all, let's instead make test-tool.h
one of those equivalents, just like we do for builtin.h
(which many of the actual git builtins include first).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/helper/test-tool.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 80cbcf0857..75d7c782f0 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -1,6 +1,8 @@
 #ifndef __TEST_TOOL_H__
 #define __TEST_TOOL_H__
 
+#include "git-compat-util.h"
+
 int cmd__chmtime(int argc, const char **argv);
 int cmd__config(int argc, const char **argv);
 int cmd__ctype(int argc, const char **argv);
-- 
2.18.0.1070.g4763fa3c01

