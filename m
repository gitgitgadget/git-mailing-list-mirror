Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B174EC433DB
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 19:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65C746148E
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 19:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhBRTzi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 14:55:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:37994 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232124AbhBRTxA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 14:53:00 -0500
Received: (qmail 28487 invoked by uid 109); 18 Feb 2021 19:52:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 18 Feb 2021 19:52:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23834 invoked by uid 111); 18 Feb 2021 19:52:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 Feb 2021 14:52:17 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 18 Feb 2021 14:52:17 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 06/10] fsck.h: move
 FSCK_{FATAL,INFO,ERROR,WARN,IGNORE} into an enum
Message-ID: <YC7FcTnduQiaF+W5@coredump.intra.peff.net>
References: <20210217194246.25342-1-avarab@gmail.com>
 <20210218105840.11989-7-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210218105840.11989-7-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 18, 2021 at 11:58:36AM +0100, Ævar Arnfjörð Bjarmason wrote:

> Move the FSCK_{FATAL,INFO,ERROR,WARN,IGNORE} defines into a new
> fsck_msg_type enum.

Makes sense. As with my previous comment, I wonder if "severity" is a
more descriptive term.

> diff --git a/fsck.h b/fsck.h
> index 0c75789d219..c77e8ddf10b 100644
> --- a/fsck.h
> +++ b/fsck.h
> @@ -3,10 +3,13 @@
>  
>  #include "oidset.h"
>  
> -#define FSCK_ERROR 1
> -#define FSCK_WARN 2
> -#define FSCK_IGNORE 3
> -
> +enum fsck_msg_type {
> +	FSCK_INFO = -2,
> +	FSCK_FATAL = -1,
> +	FSCK_ERROR = 1,
> +	FSCK_WARN,
> +	FSCK_IGNORE
> +};

You kept the values the same as they were before, which is good in a
refactoring step, but...wow, the ordering is weird and confusing.

In FATAL/ERROR/WARN/IGNORE the number increases as severity decreases.
Maybe reversed from how I'd do it, but at least the order makes sense.
But somehow INFO is on the far side of FATAL?

Again, not something to address in this patch, but I hope something we
could maybe deal with in the longer term (perhaps along with fixing the
weird "INFO is a warning from the user's perspective, but WARNING is
generally an error" behavior).

I also know that this is assigning WARN and IGNORE based on
counting-by-one from ERROR, so it's correct. But I think it would be
more obvious if you simply filled in the values manually, so a reader
does not have to wonder why some are assigned and some are not.

-Peff
