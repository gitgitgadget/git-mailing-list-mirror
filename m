Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A52B51F404
	for <e@80x24.org>; Thu, 30 Aug 2018 02:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbeH3Gyx (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 02:54:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:33396 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727197AbeH3Gyx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 02:54:53 -0400
Received: (qmail 1111 invoked by uid 109); 30 Aug 2018 02:54:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Aug 2018 02:54:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21992 invoked by uid 111); 30 Aug 2018 02:55:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 29 Aug 2018 22:55:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Aug 2018 22:54:57 -0400
Date:   Wed, 29 Aug 2018 22:54:57 -0400
From:   Jeff King <peff@peff.net>
To:     Gabriel Holodak <gthepiper@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: Possible bug: identical lines added/removed in git diff
Message-ID: <20180830025457.GA665@sigill.intra.peff.net>
References: <CAE6=WB_4_PhjfQpubFcYkNKejfDr22s-y0nPQKw5Yd4GVaN4Yw@mail.gmail.com>
 <CAGZ79kZ1BVTLnNYSs+NjEO1T1-PySSdZzVU-0ZfivjT_pfvviQ@mail.gmail.com>
 <CAE6=WB_t7zG3jtELiMfggqxjvD4jJyJ02pNPmV3fey=3nSejuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE6=WB_t7zG3jtELiMfggqxjvD4jJyJ02pNPmV3fey=3nSejuA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 29, 2018 at 10:10:25PM -0400, Gabriel Holodak wrote:

> > Could you cut down to a real minimal reproduction, i.e. just these 20
> > lines or so?
> 
> I'm working on getting down to a minimal reproduction, a few lines at
> a time. One thing that seems strange: as I've removed lines, there are
> a bunch of lines that don't matter. Then I'll find some lines that, if
> removed, completely fix the issue. But the ordering for these
> apparently important lines doesn't matter. They just have to be
> somewhere in the file to cause the duplicated diffs.
> 
> I'll upload again when I've figured out all the unimportant lines to remove.

Yeah, I reproduced based on your initial post, but noticed that when I
cut it down the problem went away.

An easy and pretty mechanical reproduction is:

  git diff --no-index unitera_bold_italic.bdf.{old,new} |
  sed -ne '/STARTCHAR U+00F0/,/ENDCHAR/p'

which shows a hunk that could easily be reduced by its first line
("DWIDTH 8 0"), and which has a common line in the middle of -/+ run.
But if we cut it down to the lines in that hunk, like this:

  for i in unitera_bold_italic.bdf.{old,new}; do
    sed -ne '/STARTCHAR U+00F0/,/ENDCHAR/p' <$i >$i.cut
  done
  git diff --no-index unitera_bold_italic.bdf.{old,new}.cut

then those two lines become context.

I note also that GNU "diff -u" gets this case right.

> > Do you have any smudge filters or configuration regarding
> > line endings?
> 
> No filters, I did have core.autocrlf = input. But as I mentioned, I
> can also reproduce with an empty config.

Me too. Amusingly, if you have diff.colorMoved configured, the context
lines appear as moves, showing that we really do know they're the same
(but that happens as post-diff processing, so I am not at all surprised
that it is orthogonal to the original issue).

-Peff
