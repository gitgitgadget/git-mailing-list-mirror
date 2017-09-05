Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B816E208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 22:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754241AbdIEWDG (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 18:03:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:57986 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753715AbdIEWDD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 18:03:03 -0400
Received: (qmail 8251 invoked by uid 109); 5 Sep 2017 22:03:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 22:03:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17591 invoked by uid 111); 5 Sep 2017 22:03:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 18:03:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Sep 2017 18:03:01 -0400
Date:   Tue, 5 Sep 2017 18:03:01 -0400
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: BUG: attempt to trim too many characters
Message-ID: <20170905220300.isxbt5y5fd2scd6b@sigill.intra.peff.net>
References: <CA+55aFxW3qcETiMrNk5SqZU+_jtM2Rxeb3mhF=J=c0ChdGm1tg@mail.gmail.com>
 <20170905215056.4wihyd6hrtvk52yd@sigill.intra.peff.net>
 <CA+55aFywhyELmbhAorgTjJZeuNxE-+j2qSP=3d3vqQXNM6p54A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFywhyELmbhAorgTjJZeuNxE-+j2qSP=3d3vqQXNM6p54A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 05, 2017 at 02:55:08PM -0700, Linus Torvalds wrote:

> On Tue, Sep 5, 2017 at 2:50 PM, Jeff King <peff@peff.net> wrote:
> >
> > What version of git are you running? This should be fixed by 03df567fbf
> > (for_each_bisect_ref(): don't trim refnames, 2017-06-18) which is in
> > v2.14.
> 
> I'm way more recent than 2.14.
> 
> I'm at commit 238e487ea ("The fifth batch post 2.14")

Ugh. Bitten again by the fact that rev-parse and revision.c implement
the same things in subtly different ways.

This probably fixes it:

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 2bd28d3c08..9f24004c0a 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -757,8 +757,8 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--bisect")) {
-				for_each_ref_in("refs/bisect/bad", show_reference, NULL);
-				for_each_ref_in("refs/bisect/good", anti_reference, NULL);
+				for_each_fullref_in("refs/bisect/bad", show_reference, NULL, 0);
+				for_each_fullref_in("refs/bisect/good", anti_reference, NULL, 0);
 				continue;
 			}
 			if (opt_with_value(arg, "--branches", &arg)) {
