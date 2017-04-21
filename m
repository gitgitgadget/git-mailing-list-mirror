Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A9CB1FE90
	for <e@80x24.org>; Fri, 21 Apr 2017 06:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1035768AbdDUG3U (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 02:29:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:37568 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1035668AbdDUG3T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 02:29:19 -0400
Received: (qmail 2641 invoked by uid 109); 21 Apr 2017 06:29:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Apr 2017 06:29:17 +0000
Received: (qmail 14341 invoked by uid 111); 21 Apr 2017 06:29:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Apr 2017 02:29:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Apr 2017 02:29:15 -0400
Date:   Fri, 21 Apr 2017 02:29:15 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 00/15] Handle fopen() errors
Message-ID: <20170421062915.he5tlgjqq7kj5h32@sigill.intra.peff.net>
References: <20170420112609.26089-1-pclouds@gmail.com>
 <xmqqlgqu7cq8.fsf@gitster.mtv.corp.google.com>
 <xmqqk26e5swj.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk26e5swj.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 20, 2017 at 08:41:32PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I wonder if it is OK to only special case ENOENT for !fp cases,
> > where existing code silently returns.  Perhaps it is trying to read
> > an optional file, and it returns silently because lack of it is
> > perfectly OK for the purpose of the code.  Are there cases where
> > this optional file is inside an optional directory, leading to
> > ENOTDIR, instead of ENOENT, observed and reported by your check?
> 
> "git grep -B1 warn_on_inaccessible" is enlightening.  I wonder if we
> want to wrap the two lines into a hard to misuse helper function,
> something along this line.  Would having this patch as a preparatory
> step shrink your series?  The patch count would be the same, but you
> wouldn't be writing "if (errno != ENOENT)" lines yourself.

I had a similar thought while reading through it. I think it would be
shorter still with:

  FILE *fopen_or_warn(const char *path, const char *mode)
  {
	FILE *fh = fopen(path, mode);
	if (!fh)
		warn_failure_to_read_open_optional_path(path);
	return fh;
  }

And then quite a few of the patches could just be
s/fopen/fopen_or_warn/.

-Peff
