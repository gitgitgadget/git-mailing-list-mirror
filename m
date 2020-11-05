Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92781C388F9
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 13:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F36421734
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 13:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730658AbgKENej (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 08:34:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:48664 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgKENej (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 08:34:39 -0500
Received: (qmail 15869 invoked by uid 109); 5 Nov 2020 13:34:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Nov 2020 13:34:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22787 invoked by uid 111); 5 Nov 2020 13:34:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Nov 2020 08:34:38 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 5 Nov 2020 08:34:37 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: range-diff should suppress context-only changes?
Message-ID: <20201105133437.GC91972@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 05, 2020 at 12:22:32AM +0000, Elijah Newren via GitGitGadget wrote:

> Range-diff vs v3:
> [...]
>   7:  42633b8d03 !  7:  5e8004c728 strmap: add more utility functions
>      @@ strmap.h: void *strmap_get(struct strmap *map, const char *str);
>       + * iterate through @map using @iter, @var is a pointer to a type strmap_entry
>       + */
>       +#define strmap_for_each_entry(mystrmap, iter, var)	\
>      -+	for (var = hashmap_iter_first_entry_offset(&(mystrmap)->map, iter, 0); \
>      -+		var; \
>      -+		var = hashmap_iter_next_entry_offset(iter, 0))
>      ++	hashmap_for_each_entry(&(mystrmap)->map, iter, var, ent)
>       +
>        #endif /* STRMAP_H */
>   8:  ea942eb803 =  8:  fd96e9fc8d strmap: enable faster clearing and reusing of strmaps
>   9:  c1d2172171 !  9:  f499934f54 strmap: add functions facilitating use as a string->int map
> [...]
>       @@ strmap.h: static inline int strmap_empty(struct strmap *map)
>      - 		var; \
>      - 		var = hashmap_iter_next_entry_offset(iter, 0))
>      + #define strmap_for_each_entry(mystrmap, iter, var)	\
>      + 	hashmap_for_each_entry(&(mystrmap)->map, iter, var, ent)
>        
>       +
>       +/*
>      @@ strmap.h: static inline int strmap_empty(struct strmap *map)

Definitely not a problem with your patches, but I noticed this curiosity
in the range-diff. Patch 7 changes the definition of the macro, but it
gets mentioned again in patch 9, even though the code wasn't touched.
The issue is that it the change from 7 ends up in the context of 9; the
actual modification in patch 9 is in those final couple lines touching a
comment (and they didn't change at all between the two versions).

I wonder if it would be reasonable to suppress range-diff hunks in which
all of the changed lines are context lines.

-Peff
