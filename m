Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CC9020248
	for <e@80x24.org>; Tue,  5 Mar 2019 04:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfCEEUx (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 23:20:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:38798 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726590AbfCEEUx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 23:20:53 -0500
Received: (qmail 729 invoked by uid 109); 5 Mar 2019 04:20:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Mar 2019 04:20:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28568 invoked by uid 111); 5 Mar 2019 04:21:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 04 Mar 2019 23:21:09 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Mar 2019 23:20:51 -0500
Date:   Mon, 4 Mar 2019 23:20:51 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH] builtin/config.c: don't print a newline with --color
Message-ID: <20190305042050.GE19800@sigill.intra.peff.net>
References: <b5ca6391fd0273fb7d6b92bc5ada96df93bc5cf2.1551487219.git.me@ttaylorr.com>
 <xmqqtvgk69ik.fsf@gitster-ct.c.googlers.com>
 <20190303174214.GF23811@sigill.intra.peff.net>
 <xmqqlg1vw9f2.fsf@gitster-ct.c.googlers.com>
 <xmqqh8cjw7ob.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh8cjw7ob.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 04, 2019 at 02:05:40PM +0900, Junio C Hamano wrote:

> >> With respect to backwards compatibility, my thinking on the matter was
> >> basically:
> >>
> >>   1. Since --type=color was supposed to be a drop-in replacement for
> >>      --get-color, it's a bug that they don't behave the same.
> >>
> >>   2. It's a fairly recent feature, so nobody really noticed the bug
> >>      until recently (and it was in fact me who noticed and got annoyed
> >>      by it). If it were an ancient behavior, we might think about
> >>      retaining even bug compatibility, but that's not the case here.
> >
> > Now I think "we weren't consistent to begin with with --get-color,
> > and treating --type=color as a special case is justifiable"; and I
> > agree with the above two points.
> 
> Just to avoid an awkward situation where the ball gets dropped and
> left on the floor forgotten, the above does not mean I am 100% happy
> with the patch as posted.  There is no mention of --get-color
> anywhere, let alone it shows the ANSI sequence without traililng LF,
> which I would consider to be the most important part of the
> justification.  It is much stronger than "I expected there won't be
> any trailing LF from 'git config'", which was the only thing I
> managed to read in the original and led to my response.

Yeah, I agree it needs to be the main justification in the commit
message.

I do wonder, though, if we're digging ourselves a hole with the
inconsistency between different --types that will bite us later. Given
that it's not that hard to chomp the output (and as you noted, the shell
does it fairly transparently), and given that the caller has to switch
between "--get-color" and "--type=color", it's not that hard to handle
the output differently if you know to do so.

Mostly I was just surprised by the new behavior. Perhaps the right
solution is not a patch to the code, but to the documentation. Something
like:

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 495bb57416..61f3a9cdd7 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -252,7 +252,9 @@ Valid `<type>`'s include:
 	output.  The optional `default` parameter is used instead, if
 	there is no color configured for `name`.
 +
-`--type=color [--default=<default>]` is preferred over `--get-color`.
+`--type=color [--default=<default>]` is preferred over `--get-color`
+(but note that `--get-color` will omit the trailing newline printed by
+--type=color).
 
 -e::
 --edit::

-Peff
