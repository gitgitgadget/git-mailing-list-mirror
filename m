Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87A5F1F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 21:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbeKTIFC (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 03:05:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:45058 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731020AbeKTIFC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 03:05:02 -0500
Received: (qmail 25824 invoked by uid 109); 19 Nov 2018 21:39:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 19 Nov 2018 21:39:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22713 invoked by uid 111); 19 Nov 2018 21:38:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 19 Nov 2018 16:38:49 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Nov 2018 16:39:25 -0500
Date:   Mon, 19 Nov 2018 16:39:24 -0500
From:   Jeff King <peff@peff.net>
To:     Max Kirillov <max@max630.net>
Cc:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] t5562: skip if NO_CURL is enabled
Message-ID: <20181119213924.GA2318@sigill.intra.peff.net>
References: <20181119101535.16538-1-carenas@gmail.com>
 <20181119184018.GA5348@jessie.local>
 <CAPUEsphLMBpxtJakAhQmdKf04H9X4m-8sBSHNFE_eAngn-44Ow@mail.gmail.com>
 <20181119212603.GC5348@jessie.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181119212603.GC5348@jessie.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 19, 2018 at 11:26:03PM +0200, Max Kirillov wrote:

> On Mon, Nov 19, 2018 at 11:36:08AM -0800, Carlo Arenas wrote:
> > NO_CURL reflects the build setting (for http support); CURL checks for
> > the curl binary, but as Ævar points out the requirements must be from
> > somewhere else since a NO_CURL=1 build (tested in macOS) still passes
> > the test, but not in NetBSD.
> > 
> > tests 3-8 seem to fail because perl is hardcoded to /urs/bin/perl in
> > t5562/invoke-with-content-length.pl,
> 
> I see.
> 
> In other perl files I can see either '#!/usr/bin/perl' or
> '#!/ust/bin/env perl'. The second one should be more
> portable. Does the latter work on the NetBSD?
> 
> To all: what is supposed to be done about it?

You should swap this out for $PERL_PATH. You can use write_script() to
help if you're copying the script around anyway. Though it looks like
you just run it from the one function. So maybe just:

diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
index b24d8b05a4..90d890d02f 100755
--- a/t/t5562-http-backend-content-length.sh
+++ b/t/t5562-http-backend-content-length.sh
@@ -31,6 +31,7 @@ test_http_env() {
 		PATH_TRANSLATED="$PWD/.git/git-$handler_type-pack" \
 		GIT_HTTP_EXPORT_ALL=TRUE \
 		REQUEST_METHOD=POST \
+		"$PERL_PATH" \
 		"$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl \
 		    "$request_body" git http-backend >act.out 2>act.err
 }

(note that it's normally OK to just run "perl", because we use a
shell-function wrapper that respects $PERL_PATH, but here we're actually
passing it to "env").

You could also lose the executable bit on the script at that point. It
doesn't matter much, but it would catch an erroneous call relying on the
shebang line.

-Peff
