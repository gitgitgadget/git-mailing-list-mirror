Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AC0220248
	for <e@80x24.org>; Tue, 12 Mar 2019 20:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfCLU0I (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 16:26:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:47700 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726534AbfCLU0I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 16:26:08 -0400
Received: (qmail 2354 invoked by uid 109); 12 Mar 2019 20:26:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 12 Mar 2019 20:26:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3400 invoked by uid 111); 12 Mar 2019 20:26:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 12 Mar 2019 16:26:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Mar 2019 16:26:06 -0400
Date:   Tue, 12 Mar 2019 16:26:06 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [RFC/PATCH] packfile: use extra variable to clarify code in
 use_pack()
Message-ID: <20190312202605.GA24350@sigill.intra.peff.net>
References: <e561b83f-cf1c-eef8-7651-8519ce105491@ramsayjones.plus.com>
 <b4106d4b-5f9e-4577-c8ed-641df33d4fb5@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b4106d4b-5f9e-4577-c8ed-641df33d4fb5@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 12, 2019 at 05:39:13PM +0000, Ramsay Jones wrote:

> On 12/03/2019 16:55, Ramsay Jones wrote:
> > From: Jeff King <peff@peff.net>
> > 
> > Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>

Could definitely use a commit message. I think it's something like:

  We use the "offset" variable for two purposes. It's the offset into
  the packfile that the caller provides us (which is rightly an off_t,
  since we might have a packfile much larger than memory). But later we
  also use it as the offset within a given mmap'd window, and that
  window cannot be larger than a size_t.

  For the second use, the fact that we have an off_t leads to some
  confusion when we assign it to the "left" variable, is a size_t. It is
  in fact correct (because our earlier "offset -= win->offset" means we
  must be within the pack window), but using a separate variable of the
  right type makes that much more obvious.

You'll note that I snuck in the assumption that "left" is a size_t,
which as you noted is not quite valid yet. :)

> Heh, of course I should have tried applying on top of today's
> codebase before sending it out! :(
> 
> Having just done so, it quickly showed that this patch assumes
> that the 'left' parameter to use_pack() has been changed from
> an 'unsigned long *' to an 'size_t *' as part of the series
> that was being discussed in the above link.

Yep. Until then,  I do not think there is much point (and in fact I'd
suspect this code behaves incorrectly on Windows, where "unsigned long"
is too short; hopefully they clamp pack windows to 4GB by default
there, which would work around it).

But I would be very happy if you wanted to resurrect the "left" patch
and then do this on top. :)

-Peff
