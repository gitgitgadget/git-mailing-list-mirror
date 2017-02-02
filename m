Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 939401FAAD
	for <e@80x24.org>; Thu,  2 Feb 2017 12:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751501AbdBBMmz (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 07:42:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:48334 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751452AbdBBMmy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 07:42:54 -0500
Received: (qmail 2572 invoked by uid 109); 2 Feb 2017 12:42:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Feb 2017 12:42:53 +0000
Received: (qmail 19400 invoked by uid 111); 2 Feb 2017 12:42:56 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.42.43.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Feb 2017 07:42:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Feb 2017 13:42:44 +0100
Date:   Thu, 2 Feb 2017 13:42:44 +0100
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH] document behavior of empty color name
Message-ID: <20170202124238.53k74cedpp2rcmzo@sigill.intra.peff.net>
References: <xmqqpoj2q25n.fsf@gitster.mtv.corp.google.com>
 <20170201002129.xb62hmxwrzwgp6vg@sigill.intra.peff.net>
 <20170202091615.GA22337@ash>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170202091615.GA22337@ash>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 02, 2017 at 04:16:15PM +0700, Duy Nguyen wrote:

> > I hadn't heard anything back,
> 
> Sorry I was accidentally busy during Luna new year holiday.

No problem. That sounds much more fun than working on Git. :)

> > -	if (!len)
> > -		return -1;
> > +	if (!len) {
> > +		dst[0] = '\0';
> > +		return 0;
> > +	}
> >  
> >  	if (!strncasecmp(ptr, "reset", len)) {
> >  		xsnprintf(dst, end - dst, GIT_COLOR_RESET);
> 
> I wonder if it makes more sense to do this in builtin/config.c. The
> "default value" business is strictly git-config command's. The parsing
> function does not need to know. Maybe something like this?

I don't think so. The default value is a git-config thing, but you would
want to be able to do the same thing in a config file. For example, to
disable coloring entirely for part of the diff, you could do:

  [color "diff"]
  meta = ""

> This is also a good opportunity to document this behavior in
> git-config.txt, I think.

Yeah. Maybe:

-- >8 --
Subject: [PATCH] document behavior of empty color name

Commit 55cccf4bb (color_parse_mem: allow empty color spec,
2017-02-01) clearly defined the behavior of an empty color
config variable. Let's document that, and give a hint about
why it might be useful.

It's important not to say that it makes the item uncolored,
because it doesn't. It just sets no attributes, which means
that any previous attributes continue to take effect.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 33a007b52..49b264566 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -170,6 +170,9 @@ The position of any attributes with respect to the colors
 be turned off by prefixing them with `no` or `no-` (e.g., `noreverse`,
 `no-ul`, etc).
 +
+An empty color string produces no color effect at all. This can be used
+to avoid coloring specific elements without disabling color entirely.
++
 For git's pre-defined color slots, the attributes are meant to be reset
 at the beginning of each item in the colored output. So setting
 `color.decorate.branch` to `black` will paint that branch name in a
-- 
2.11.0.948.gca97da533

