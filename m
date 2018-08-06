Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 222FC208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 18:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732519AbeHFVJW (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 17:09:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:44444 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729861AbeHFVJW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 17:09:22 -0400
Received: (qmail 20573 invoked by uid 109); 6 Aug 2018 18:58:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 06 Aug 2018 18:58:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30353 invoked by uid 111); 6 Aug 2018 18:58:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 06 Aug 2018 14:58:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Aug 2018 14:58:54 -0400
Date:   Mon, 6 Aug 2018 14:58:54 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] add a script to diff rendered documentation
Message-ID: <20180806185853.GA18119@sigill.intra.peff.net>
References: <20180803205204.GA3790@sigill.intra.peff.net>
 <20180806173720.GA5508@sigill.intra.peff.net>
 <xmqqy3djnyik.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy3djnyik.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 06, 2018 at 11:25:07AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > +while test $# -gt 0
> > +do
> > +	case "$1" in
> > +	-j)
> > +		parallel=${1#-j} ;;
> 
> This is curious.  Did you mean "-j*)" on the line above this one?

Hmph, yes, I think this was broken even in the original. And after going
through "rev-parse --parseopt", we should have a separate argument
anyway, even for the "stuck" form. Worse, the OPTIONS_SPEC doesn't
mention the argument, so it barfs on "-j4".

I think we need to squash this in:

diff --git a/Documentation/doc-diff b/Documentation/doc-diff
index 5d5b243384..f483fe427c 100755
--- a/Documentation/doc-diff
+++ b/Documentation/doc-diff
@@ -3,7 +3,7 @@
 OPTIONS_SPEC="\
 doc-diff [options] <from> <to> [-- <diff-options>]
 --
-j	parallel argument to pass to make
+j=n	parallel argument to pass to make
 f	force rebuild; do not rely on cached results
 "
 SUBDIRECTORY_OK=1
@@ -15,7 +15,7 @@ while test $# -gt 0
 do
 	case "$1" in
 	-j)
-		parallel=${1#-j} ;;
+		parallel=$2; shift ;;
 	-f)
 		force=t ;;
 	--)

> Then "script -j" (no explicit number) would get here and autodetect.
> Running the script without any "-j" would also get an empty parallel
> and come here.

Yeah, I think that is the wrong thing. If anything "-j" should behave
like "make -j". However, it looks like "rev-parse --parseopt" doesn't
play well with optional arguments for short-only options. You get "-j",
but then you have no idea whether the next argument is an optional value
for it, or another option entirely. Arguably it should give a blank
string or something (if you have long options, then it uses the
long-stock form, which is fine).

> So "script -j1" would be how a user would say "I want to use exactly
> one process, not any parallelism", which makes sense.

Right, that was the thing I actually wanted to have happen. :)

-Peff
