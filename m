Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7CB31F404
	for <e@80x24.org>; Sat,  8 Sep 2018 16:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbeIHVJv (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 17:09:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:43738 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726880AbeIHVJv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 17:09:51 -0400
Received: (qmail 11578 invoked by uid 109); 8 Sep 2018 16:23:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 08 Sep 2018 16:23:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29091 invoked by uid 111); 8 Sep 2018 16:23:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 08 Sep 2018 12:23:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Sep 2018 12:23:31 -0400
Date:   Sat, 8 Sep 2018 12:23:31 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH v2] config.mak.dev: add -Wformat-security
Message-ID: <20180908162331.GB9016@sigill.intra.peff.net>
References: <20180907181905.GA15897@sigill.intra.peff.net>
 <CACsJy8CshOFNgHq-QQZp3GM3Ua+iuKMDvA+YaKKh1QGF5FrHqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8CshOFNgHq-QQZp3GM3Ua+iuKMDvA+YaKKh1QGF5FrHqg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 08, 2018 at 03:38:19PM +0200, Duy Nguyen wrote:

> On Fri, Sep 7, 2018 at 8:21 PM Jeff King <peff@peff.net> wrote:
> >
> > We currently build cleanly with -Wformat-security, and it's
> > a good idea to make sure we continue to do so (since calls
> > that trigger the warning may be security vulnerabilities).
> 
> Nice. I had this flag in my config.mak too before switching to
> DEVELOPER=1. Didn't realize I lost the flag until now.

I thought I used to use it, too, but I realized recently that I never
did (I experimented with format-nonliteral a long time ago but gave up).

AFAIK we've never actually had a case that this triggered, because it's
so narrow (as opposed to format-nonliteral).

> > diff --git a/config.mak.dev b/config.mak.dev
> > index 9a998149d9..f832752454 100644
> > --- a/config.mak.dev
> > +++ b/config.mak.dev
> > @@ -14,6 +14,7 @@ CFLAGS += -Wpointer-arith
> >  CFLAGS += -Wstrict-prototypes
> >  CFLAGS += -Wunused
> >  CFLAGS += -Wvla
> > +CFLAGS += -Wformat-security
> 
> Maybe keep it sorted

Heh, I didn't even notice the original was sorted. Here it is in the
right spot:

-- >8 --
Subject: config.mak.dev: add -Wformat-security

We currently build cleanly with -Wformat-security, and it's
a good idea to make sure we continue to do so (since calls
that trigger the warning may be security vulnerabilities).

Note that we cannot use the stronger -Wformat-nonliteral, as
there are case where we are clever with passing around
pointers to string literals. E.g., bisect_rev_setup() takes
bad_format and good_format parameters. These ultimately come
from literals, but they still trigger the warning.

Some of these might be fixable (e.g., by passing flags from
which we locally select a format), and might even be worth
fixing (not because of security, but just because it's an
easy mistake to pass the wrong format). But there are other
cases which are likely quite hard to fix (we actually
generate formats in a local buffer in some cases). So let's
punt on that for now and start with -Wformat-security, which
is supposed to catch the most important cases.

Signed-off-by: Jeff King <peff@peff.net>
---
 config.mak.dev | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.dev b/config.mak.dev
index 9a998149d9..92d268137f 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -7,6 +7,7 @@ CFLAGS += -pedantic
 CFLAGS += -DUSE_PARENS_AROUND_GETTEXT_N=0
 endif
 CFLAGS += -Wdeclaration-after-statement
+CFLAGS += -Wformat-security
 CFLAGS += -Wno-format-zero-length
 CFLAGS += -Wold-style-definition
 CFLAGS += -Woverflow
-- 
2.19.0.rc2.594.gc4806cd463

