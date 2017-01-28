Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1158F1F437
	for <e@80x24.org>; Sat, 28 Jan 2017 04:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750800AbdA1EHO (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 23:07:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:46254 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750731AbdA1EHM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 23:07:12 -0500
Received: (qmail 26176 invoked by uid 109); 28 Jan 2017 04:07:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 28 Jan 2017 04:07:12 +0000
Received: (qmail 4801 invoked by uid 111); 28 Jan 2017 04:07:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 27 Jan 2017 23:07:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Jan 2017 23:07:10 -0500
Date:   Fri, 27 Jan 2017 23:07:10 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/3] color.c: fix color_parse_mem() with value_len == 0
Message-ID: <20170128040709.tqx4u45ktgpkbfm4@sigill.intra.peff.net>
References: <20170109103258.25341-1-pclouds@gmail.com>
 <20170119114123.23784-1-pclouds@gmail.com>
 <20170119114123.23784-2-pclouds@gmail.com>
 <20170119163841.zhtpz6rxdieaywuy@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170119163841.zhtpz6rxdieaywuy@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 19, 2017 at 11:38:41AM -0500, Jeff King wrote:

> On Thu, Jan 19, 2017 at 06:41:21PM +0700, Nguyễn Thái Ngọc Duy wrote:
> 
> > In this code we want to match the word "reset". If len is zero,
> > strncasecmp() will return zero and we incorrectly assume it's "reset" as
> > a result.
> 
> This is probably a good idea. This _is_ user-visible, so it's possible
> somebody was using empty config as a synonym for "reset". But since it
> was never documented, I feel like relying on that is somewhat crazy.

Hrm. This seems to break the add--interactive script if you do not have
color.diff.plain set:

  $ GIT_TRACE=1 git add -p
  ...
  22:58:12.568990 [pid=11401] git.c:387  trace: built-in: git 'config' '--get-color' 'color.diff.plain' ''
  fatal: unable to parse default color value
  config --get-color color.diff.plain : command returned error: 128

As you can see, the default value the empty string, which is now an
error.

The default in the C code for that value is GIT_COLOR_NORMAL, which
really is the empty string. So I think the old code was buggy to choose
"reset", but the new one is worse because it fails entirely. :)

We probably want something like this instead:

diff --git a/color.c b/color.c
index 190b2da96..dee61557e 100644
--- a/color.c
+++ b/color.c
@@ -212,8 +212,10 @@ int color_parse_mem(const char *value, int value_len, char *dst)
 		len--;
 	}
 
-	if (!len)
-		return -1;
+	if (!len) {
+		dst[0] = '\0';
+		return 0;
+	}
 
 	if (!strncasecmp(ptr, "reset", len)) {
 		xsnprintf(dst, end - dst, GIT_COLOR_RESET);

The breakage is in 'next' (it looks like it went out a few days ago; I'm
surprised I didn't notice until now).

-Peff
