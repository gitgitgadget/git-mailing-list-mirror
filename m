Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3A061F42D
	for <e@80x24.org>; Fri, 11 May 2018 08:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752576AbeEKI2n (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 04:28:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:35944 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750852AbeEKI2m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 04:28:42 -0400
Received: (qmail 20216 invoked by uid 109); 11 May 2018 08:28:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 May 2018 08:28:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31579 invoked by uid 111); 11 May 2018 08:28:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 11 May 2018 04:28:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 May 2018 04:28:40 -0400
Date:   Fri, 11 May 2018 04:28:40 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] tag: fix column output not using all terminal space
Message-ID: <20180511082840.GA22086@sigill.intra.peff.net>
References: <20180511075602.9182-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180511075602.9182-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 11, 2018 at 09:56:02AM +0200, Nguyễn Thái Ngọc Duy wrote:

> git-tag runs a separate git-column command via run_column_filter().
> This makes the new 'git-column' process fail to pick up the terminal
> width for some reason and fall back to default width. Just explicitly
> pass terminal width and avoid this terminal width detection business
> in subprocesses.

I think "some reason" is that we start the pager before running "git
column". Running "git --no-pager tag --column=row" seems to fix it.

It doesn't seem to have anything to do with the pager program itself.
Doing:

  # use sh to avoid optimizing out pager invocation
  GIT_PAGER='sh -c cat' git tag --column=row

shows the same problem. It looks like we force term_columns() to run
before invoking the pager in order to cache the value. That makes sense,
since TIOCGWINSZ on stdout is not going to be valid after we start
piping it to the pager. But of course our git-column sub-process won't
see that; the value is cached only in memory.

So I think the approach of communicating the width to the sub-process is
the right one. But I think we'd probably want to do so through the
$COLUMNS variable, rather than passing a command-line option. That would
fix the same bug for other cases where we might have multiple layers of
sub-processes (e.g., if we pipe to the pager and then run a hook which
columnizes output).

Something like this seems to make it work for me:

diff --git a/pager.c b/pager.c
index 92b23e6cd1..c4f3412a84 100644
--- a/pager.c
+++ b/pager.c
@@ -162,8 +162,12 @@ int term_columns(void)
 #ifdef TIOCGWINSZ
 	else {
 		struct winsize ws;
-		if (!ioctl(1, TIOCGWINSZ, &ws) && ws.ws_col)
+		if (!ioctl(1, TIOCGWINSZ, &ws) && ws.ws_col) {
+			char buf[64];
 			term_columns_at_startup = ws.ws_col;
+			xsnprintf(buf, sizeof(buf), "%d", ws.ws_col);
+			setenv("COLUMNS", buf, 0);
+		}
 	}
 #endif
 

though perhaps that should go into setup_pager(), which is what is
actually making stdout inaccessible.

As an aside, I was confused while looking into this because I _thought_
I had COLUMNS set:

  $ echo $COLUMNS
  119

But it turns out that bash sets that by default (if you have the
checkwinsize option on) but does not export it. ;)

-Peff
