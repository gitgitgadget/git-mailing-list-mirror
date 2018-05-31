Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D1281F42D
	for <e@80x24.org>; Thu, 31 May 2018 05:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753934AbeEaFiN (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 01:38:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:57400 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753770AbeEaFiM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 01:38:12 -0400
Received: (qmail 12284 invoked by uid 109); 31 May 2018 05:38:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 31 May 2018 05:38:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9347 invoked by uid 111); 31 May 2018 05:38:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 31 May 2018 01:38:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 May 2018 01:38:10 -0400
Date:   Thu, 31 May 2018 01:38:10 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 4/4] color.ui config: add "isatty" setting
Message-ID: <20180531053810.GD17068@sigill.intra.peff.net>
References: <20180530210641.19771-1-avarab@gmail.com>
 <20180530210641.19771-5-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180530210641.19771-5-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 30, 2018 at 09:06:41PM +0000, Ævar Arnfjörð Bjarmason wrote:

> A co-worker of mine who was using UNIX systems when dinosaurs roamed
> the earth was lamenting that kids these days were using tools like
> "git" that thought they knew better than isatty(3) when deciding
> whether or not something was a terminal, and the state of the
> documentation fixed earlier in this series certainly didn't help.
> 
> So this setting is a small gift to all the UNIX graybeards out
> there. Now they can set color.ui=isatty and only emit fancy colors in
> situations when the gods of old intended, not whatever heuristic we've
> decided to set "auto" to.

I'm having trouble thinking of a case where anybody would actually
care about the distinction between these two.

If you're not using "-p", then colors will kick in if isatty() is true.
The whole "also check the pager" thing is only because we may check the
color isatty() after starting the pager. If we didn't, then nobody would
ever see color. If your pager doesn't understand color, then fine. Tell
Git not to send it color with color.pager=false.

If you are using "-p", we might send color to your pager even though you
weren't originally going to a terminal. But either your pager can handle
colors, in which case this is fine, or it cannot, in which case you
would already have needed to set color.pager as above to un-break all of
the non-p cases.

Is there some case where a pager can only handle color if _it's_ output
is going to a tty, and otherwise not? And you'd want color predicated on
whether the original output was a tty or not, even if you said "-p"?
That's the only case I can think of where the existing config is not
sufficient, but I'm having a hard time envisioning a practical use.

> As noted here this is *currently* the same as setting color.ui=auto &
> color.pager=false, but I think it's good to explicitly have this
> setting for any future changes. The reason, as now noted in the
> documentation is that the "auto" setting may become even smarter in
> the future and learn even deeper heuristics for when to turn itself on
> even if isatty(3) were returning true.

Are we actually thinking about teaching it deeper heuristics? I think
the fact that it _is_ based on isatty() is meant to be understood by the
user, and we wouldn't want to change that. True, there is the pager
exception, but the point of that is to maintain the "are we going to a
tty" model, even in the face of sticking a pager in the middle.

-Peff
