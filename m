Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97D661F453
	for <e@80x24.org>; Thu,  1 Nov 2018 22:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeKBHGL (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 03:06:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:37146 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726273AbeKBHGL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 03:06:11 -0400
Received: (qmail 7193 invoked by uid 109); 1 Nov 2018 22:01:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 01 Nov 2018 22:01:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29922 invoked by uid 111); 1 Nov 2018 22:00:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 01 Nov 2018 18:00:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Nov 2018 18:01:20 -0400
Date:   Thu, 1 Nov 2018 18:01:20 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Daniels Umanovskis <daniels@umanovskis.se>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v5] branch: introduce --show-current display option
Message-ID: <20181101220119.GA26383@sigill.intra.peff.net>
References: <20181025190421.15022-1-daniels@umanovskis.se>
 <CAPig+cRVdogY8VLXcftbY=n9tQ9wDo4YrnrdU6+pZ3ch6uhZGA@mail.gmail.com>
 <xmqqefcdfs1j.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqefcdfs1j.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 26, 2018 at 09:52:24AM +0900, Junio C Hamano wrote:

> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> >> +       test_when_finished "git tag -d branch-and-tag-name" &&
> >> +       git tag branch-and-tag-name &&
> >
> > If git-tag crashes before actually creating the new tag, then "git tag
> > -d", passed to test_when_finished(), will error out too, which is
> > probably undesirable since "cleanup code" isn't expected to error out.
> 
> Ah, I somehow thought that clean-up actions set up via when_finished
> are allowed to fail without affecting the outcome, but apparently I
> was mistaken.

If a when_finished block fails, we consider that a test failure. But if
we failed to create the tag, the test is failing anyway. Do we actually
care at that point?

We would still want to make sure we run the rest of the cleanup, but
looking at the definition of test_when_finished(), I think we do.

> I haven't gone through the list of when_finished clean-up actions
> that do not end with "|| :"; I suspect some of them are simply being
> sloppy and would want to have "|| :", but what I want to find out
> out of such an audit is if there is a legitimate case where it helps
> to catch failures in the clean-up actions.  If there is none, then
> ...

I think in the success case it is legitimately helpful. If that "tag -d"
failed above (after the tag creation and the rest of the test
succeeded), it would certainly be unexpected and we would want to know
that it happened. So I think "|| :" in this case is not just
unnecessary, but actively bad.

-Peff
