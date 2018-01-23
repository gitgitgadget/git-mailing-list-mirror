Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 488911F404
	for <e@80x24.org>; Tue, 23 Jan 2018 00:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751255AbeAWA7x (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 19:59:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:54036 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751239AbeAWA7w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 19:59:52 -0500
Received: (qmail 14124 invoked by uid 109); 23 Jan 2018 00:59:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 23 Jan 2018 00:59:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13026 invoked by uid 111); 23 Jan 2018 01:00:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 22 Jan 2018 20:00:29 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Jan 2018 19:59:50 -0500
Date:   Mon, 22 Jan 2018 19:59:50 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Elia Pinto <gitter.spiros@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] Fixes compile warning with -Wimplicit-fallthrough CFLAGS
Message-ID: <20180123005950.GH26357@sigill.intra.peff.net>
References: <1516665078-107974-1-git-send-email-gitter.spiros@gmail.com>
 <CAPig+cSuBRcM7BBw1MKOOVSZv+CVVrY-dWfSGj+31DA4QMrruA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cSuBRcM7BBw1MKOOVSZv+CVVrY-dWfSGj+31DA4QMrruA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 22, 2018 at 07:54:18PM -0500, Eric Sunshine wrote:

> On Mon, Jan 22, 2018 at 6:51 PM, Elia Pinto <gitter.spiros@gmail.com> wrote:
> > This patch add explicit fallthrough compiler attribute
> > when needed on switch case statement eliminating
> > the compile warning [-Werror=implicit-fallthrough=].
> > It does this by means of a macro that takes into account
> > the versions of the compilers that include that attribute.
> > [...]
> > Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> > ---
> > diff --git a/convert.c b/convert.c
> > @@ -1554,7 +1554,7 @@ static int ident_filter_fn(struct stream_filter *filter,
> >                 switch (ident->state) {
> >                 default:
> >                         strbuf_add(&ident->left, head, ident->state);
> > -                       /* fallthrough */
> > +                       GIT_FALLTHROUGH;
> >                 case IDENT_SKIPPING:
> >                         /* fallthrough */
> 
> Why doesn't this /* fallthrough */ deserve the same treatment?
> 
> >                 case IDENT_DRAINING:

I can't answer that philosophically, but I can tell you why the compiler
does not complain. :)

Usually case arms with no statements between them are exempt from
fallthrough warnings. So:

  switch (foo)
  case 1:
  case 2:
  case 3:
     /* do one thing */
     break;
  case 4:
     /* do another thing */
     break;
  }

does not need any annotations for cases 1 and 2 to fallthrough. Which
means that the original comment was not actually necessary for the
compiler, though the original author considered it a useful comment.

So there you get into philosophy. Should it be converted to a
compiler-visible annotation, or is it better left as a comment?

-Peff
