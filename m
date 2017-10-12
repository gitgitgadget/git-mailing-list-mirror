Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B609120372
	for <e@80x24.org>; Thu, 12 Oct 2017 20:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753225AbdJLUFk (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 16:05:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:51340 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753010AbdJLUFi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 16:05:38 -0400
Received: (qmail 32698 invoked by uid 109); 12 Oct 2017 20:05:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Oct 2017 20:05:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19454 invoked by uid 111); 12 Oct 2017 20:05:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Oct 2017 16:05:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Oct 2017 16:05:36 -0400
Date:   Thu, 12 Oct 2017 16:05:36 -0400
From:   Jeff King <peff@peff.net>
To:     Orgad Shaneh <orgads@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: Out of memory with diff.colormoved enabled
Message-ID: <20171012200536.m6oz4zrjcze3yw4i@sigill.intra.peff.net>
References: <CAGHpTBLQ8vi00e3Tt3KTrCfaAWhZKQX6u6Ca17t2ySVQdoGc5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGHpTBLQ8vi00e3Tt3KTrCfaAWhZKQX6u6Ca17t2ySVQdoGc5g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 12, 2017 at 10:53:23PM +0300, Orgad Shaneh wrote:

> There is an infinite loop when colormoved is used with --ignore-space-change:
> 
> git init
> seq 20 > test
> git add test
> sed -i 's/9/42/' test
> git -c diff.colormoved diff --ignore-space-change -- test

Thanks for an easy reproduction recipe.

It looks like the problem is that next_byte() doesn't make any forward
progress in the buffer with --ignore-space-change. We try to convert
whitespace into a single space (I'm not sure why, but I'm not very
familiar with this part of the code). But if there's no space, then the
"cp" pointer never gets advanced.

This fixes it, but I have no idea if it's doing the right thing:

diff --git a/diff.c b/diff.c
index 69f03570ad..e8dedc7357 100644
--- a/diff.c
+++ b/diff.c
@@ -713,13 +713,17 @@ static int next_byte(const char **cp, const char **endp,
 		return -1;
 
 	if (DIFF_XDL_TST(diffopt, IGNORE_WHITESPACE_CHANGE)) {
-		while (*cp < *endp && isspace(**cp))
+		int saw_whitespace = 0;
+		while (*cp < *endp && isspace(**cp)) {
 			(*cp)++;
+			saw_whitespace = 1;
+		}
 		/*
 		 * After skipping a couple of whitespaces, we still have to
 		 * account for one space.
 		 */
-		return (int)' ';
+		if (saw_whitespace)
+			return (int)' ';
 	}
 
 	if (DIFF_XDL_TST(diffopt, IGNORE_WHITESPACE)) {

I guess it would be equally correct to not enter that if-block unless
isspace(**cp).

-Peff
