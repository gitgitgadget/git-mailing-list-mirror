Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AA4F1F453
	for <e@80x24.org>; Sat, 22 Sep 2018 19:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbeIWBro (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 21:47:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:56210 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726153AbeIWBrn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 21:47:43 -0400
Received: (qmail 23864 invoked by uid 109); 22 Sep 2018 19:53:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 22 Sep 2018 19:53:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14834 invoked by uid 111); 22 Sep 2018 19:52:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 22 Sep 2018 15:52:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 22 Sep 2018 15:52:58 -0400
Date:   Sat, 22 Sep 2018 15:52:58 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com, sunshine@sunshineco.com, sbeller@google.com
Subject: Re: [PATCH v2 2/3] transport.c: introduce core.alternateRefsCommand
Message-ID: <20180922195258.GA20983@sigill.intra.peff.net>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1537555544.git.me@ttaylorr.com>
 <9797f525517142b3494cfbd17a10dfeb3bf586e2.1537555544.git.me@ttaylorr.com>
 <20180922180231.GD432229@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180922180231.GD432229@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 22, 2018 at 06:02:31PM +0000, brian m. carlson wrote:

> On Fri, Sep 21, 2018 at 02:47:43PM -0400, Taylor Blau wrote:
> > +expect_haves () {
> > +	printf "%s .have\n" $(git rev-parse $@) >expect
> > +}
> > +
> > +extract_haves () {
> > +	depacketize - | grep '\.have' | sed -e 's/\\0.*$//g'
> 
> It looks like you're trying to match a NUL here in the sed expression,
> but from my reading of it, POSIX doesn't permit BREs to match NUL.

No, it's trying to literally match backslash followed by 0. The
depacketize() script will have undone the NUL already. In perl, no less,
making it more or less equivalent to your suggestion. ;)

So I think this is fine (modulo that the grep and sed can be combined).
Yet another option would be to simply strip away everything except the
object id (which is all we care about), like:

  depacketize | perl -lne '/^(\S+) \.have/ and print $1'

Or the equivalent in sed. I am happy with any solution that does the
correct thing.

-Peff
