Return-Path: <SRS0=+pXB=2E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7D7C43603
	for <git@archiver.kernel.org>; Sat, 14 Dec 2019 00:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E5A20724
	for <git@archiver.kernel.org>; Sat, 14 Dec 2019 00:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfLNAiW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 19:38:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:46710 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726678AbfLNAiW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 19:38:22 -0500
Received: (qmail 4962 invoked by uid 109); 14 Dec 2019 00:38:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 14 Dec 2019 00:38:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32010 invoked by uid 111); 14 Dec 2019 00:42:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 13 Dec 2019 19:42:50 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 13 Dec 2019 19:38:20 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] Makefile: drop GEN_HDRS
Message-ID: <20191214003820.GA927924@coredump.intra.peff.net>
References: <xmqq1rt7hkp6.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1rt7hkp6.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 13, 2019 at 03:25:41PM -0800, Junio C Hamano wrote:

> Get rid of GEN_HDRS, which is used only once to list the headers we
> do not run hdr-check test on, and instead explicitly list that the
> ones, either tracked or generated, that we exempt from the test.

Yeah, I think this is an improvement by itself.

After reading this, though:

>  - If we value the header cleanliness check, we eventually want to
>    teach our header generating scripts to produce clean headers.
>    Keeping the blanket "generated headers can be left as dirty as we
>    want" exception does not nudge us in the right direction.

I did expect to see the actual hdr-check behavior move towards checking
these generated versions. However, both are kind of interesting.

unicode-width.h isn't a "real" header file; it's meant to be included in
the middle of a function. I think it _could_ be changed to define
"struct interval" itself, and then be a static file-scope variable. But
there's not really a compelling reason to do so.

But "command-list.h" is more of a traditional header file, being
included at the top of help.c. In theory the hdr-check target could add
a dependency on it, and then we could check it along with everything
else. But even without that first step, if I remove it from EXCEPT_HDRS,
nothing happens!

That's because LIB_H is created by running find in the local filesystem.
So until it's generated, we don't realize it's there to check. I kind of
wonder if it should be part of LIB_H. I suspect that on some systems,
we'd fail to notice a rebuild when command-list.txt is updated (but
nobody noticed, because it is only systems that do not have
compiler-supported dependency tracking, and most developers are no
modern platforms that do).

-Peff
