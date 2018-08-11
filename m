Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C9991F404
	for <e@80x24.org>; Sat, 11 Aug 2018 20:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbeHKXFD (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Aug 2018 19:05:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:51310 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727539AbeHKXFD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Aug 2018 19:05:03 -0400
Received: (qmail 3073 invoked by uid 109); 11 Aug 2018 17:43:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 11 Aug 2018 17:43:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28754 invoked by uid 111); 11 Aug 2018 17:43:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 11 Aug 2018 13:43:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 11 Aug 2018 13:43:01 -0400
Date:   Sat, 11 Aug 2018 13:43:01 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/9] Add missing includes and forward declares
Message-ID: <20180811174301.GA9287@sigill.intra.peff.net>
References: <20180811043218.31456-1-newren@gmail.com>
 <20180811043218.31456-2-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180811043218.31456-2-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 10, 2018 at 09:32:10PM -0700, Elijah Newren wrote:

> diff --git a/argv-array.h b/argv-array.h
> index a39ba43f57..c46238784c 100644
> --- a/argv-array.h
> +++ b/argv-array.h
> @@ -1,6 +1,8 @@
>  #ifndef ARGV_ARRAY_H
>  #define ARGV_ARRAY_H
>  
> +#include "git-compat-util.h"   /* for LAST_ARG_MUST_BE_NULL */

Following up on what I said in the other message, I think we should omit
this. All header files should assume the environment provided by
git-compat-util.h is already loaded (and all non-compat C files should
make sure they load it first).

> diff --git a/color.h b/color.h
> index 5b744e1bc6..74edbffc9d 100644
> --- a/color.h
> +++ b/color.h
> @@ -1,6 +1,8 @@
>  #ifndef COLOR_H
>  #define COLOR_H
>  
> +#include <stdio.h>

This one is more actively wrong than the git-compat-util.h one. Anybody
who already included git-compat-util.h would not be helped by this. And
anybody who _didn't_ may be hurt, because now git-compat-util.h might
run into ordering problems caused by headers already loaded as part of
stdio.h (and keep in mind that stdio.h often brings in other
system-dependent definitions, too).

> diff --git a/bulk-checkin.h b/bulk-checkin.h
> index a85527318b..e036231636 100644
> --- a/bulk-checkin.h
> +++ b/bulk-checkin.h
> @@ -4,6 +4,8 @@
>  #ifndef BULK_CHECKIN_H
>  #define BULK_CHECKIN_H
>  
> +#include "cache.h" /* for object_type */

As I said earlier, I don't mind includes like these that make
everybody's lives a little easier, and shouldn't introduce any funny
ordering constraints.

IMHO, though, comments like "for X" are probably a bad idea. That may be
accurate _now_, but it is very likely to grow stale without anybody
noticing. You only care about that "X" if you are thinking about
removing the include, and then the right answer is not to trust the
comment, but to remove the include and make sure there is no
other breakage.

The one exception is if there is some subtlety, like including a header
file that uses macros to replace a function, and removing it wouldn't
break compilation but produce a different result. But then:

  - I'd hope we don't have anything like that, because it sounds
    horrible ;)

  - you'd probably want a much more explanatory comment

> [...]

The rest of them are all variants on these three (or forward
declarations, which I put in the same boat as this third recursive
include; i.e., it's a good change).

-Peff
