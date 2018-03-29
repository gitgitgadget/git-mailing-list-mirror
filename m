Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 646211F404
	for <e@80x24.org>; Thu, 29 Mar 2018 19:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751183AbeC2TmC (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 15:42:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:47770 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750979AbeC2TmB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 15:42:01 -0400
Received: (qmail 23195 invoked by uid 109); 29 Mar 2018 19:42:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 29 Mar 2018 19:42:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21594 invoked by uid 111); 29 Mar 2018 19:43:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 29 Mar 2018 15:43:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Mar 2018 15:41:59 -0400
Date:   Thu, 29 Mar 2018 15:41:59 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 1/9] git_config_set: fix off-by-two
Message-ID: <20180329194159.GB2939@sigill.intra.peff.net>
References: <cover.1522336130.git.johannes.schindelin@gmx.de>
 <899ea23951627426ccd0aac79f824af386c5590c.1522336130.git.johannes.schindelin@gmx.de>
 <CAGZ79kapTWGsYznt7rr0QTNX+uH85TPY8AOA1jtDJ6_q8edX1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kapTWGsYznt7rr0QTNX+uH85TPY8AOA1jtDJ6_q8edX1Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 29, 2018 at 11:15:33AM -0700, Stefan Beller wrote:

> > When calling `git config --unset abc.a` on this file, it leaves this
> > (invalid) config behind:
> >
> >         [
> >         [xyz]
> >                 key = value
> >
> > The reason is that we try to search for the beginning of the line (or
> > for the end of the preceding section header on the same line) that
> > defines abc.a, but as an optimization, we subtract 2 from the offset
> > pointing just after the definition before we call
> > find_beginning_of_line(). That function, however, *also* performs that
> > optimization and promptly fails to find the section header correctly.
> 
> This commit message would be more convincing if we had it in test form.

I agree a test might be nice. But I don't find the commit message
unconvincing at all. It explains pretty clearly why the bug occurs, and
you can verify it by looking at find_beginning_of_line.

>     [abc]a
> 
> is not written by Git, but would be written from an outside tool or person
> and we barely cope with it?

Yes, I don't think git would ever write onto the same line. But clearly
we should handle anything that's syntactically valid.

-Peff
