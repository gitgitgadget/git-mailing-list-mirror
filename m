Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6E741F404
	for <e@80x24.org>; Thu,  6 Sep 2018 20:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbeIGB0q (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 21:26:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:41824 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725819AbeIGB0q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 21:26:46 -0400
Received: (qmail 30362 invoked by uid 109); 6 Sep 2018 20:49:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 06 Sep 2018 20:49:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8171 invoked by uid 111); 6 Sep 2018 20:49:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 06 Sep 2018 16:49:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Sep 2018 16:49:32 -0400
Date:   Thu, 6 Sep 2018 16:49:32 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, timschumi@gmx.de,
        Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: ordered string-list considered harmful, was Re: [PATCH v3] Allow
 aliases that include other aliases
Message-ID: <20180906204932.GA1482@sigill.intra.peff.net>
References: <20180906191203.GA26184@sigill.intra.peff.net>
 <CAGZ79kbi=Ppkt4tYx+G_RDwp7e3+SU-LofZ-QzMsO2=zEPucsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kbi=Ppkt4tYx+G_RDwp7e3+SU-LofZ-QzMsO2=zEPucsA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 06, 2018 at 01:04:18PM -0700, Stefan Beller wrote:

> On Thu, Sep 6, 2018 at 12:12 PM Jeff King <peff@peff.net> wrote:
> >
> > On Thu, Sep 06, 2018 at 10:59:42AM -0400, Jeff King wrote:
> >
> > > > +           string_list_append(&cmd_list, *argv[0]);
> > >
> > > This will create an unsorted list. You'd have to use
> > > string_list_insert() here for a sorted list, or
> > > unsorted_string_list_has_string() in the earlier call.
> > >
> > > It's unfortunate that string_list makes this so easy to get wrong.
> >
> > This is getting really off-topic (since it sounds like we'd probably
> > want to use an ordered list here), but is it crazy to think that
> > basically every use of an ordered string list could just be a hashmap?
> 
> Does a hashmap guarantee an order?

No, it definitely doesn't.

I guess the reading-between-the-lines assumption that I didn't quite say
is: I think most (if not all) of the users of sorted string lists don't
actually care about a particular order. They just want efficient lookup.

> I thought we had an example of an ordered list in the submodule code
> but could not find it, maybe it is gone already or did not rely on the order
> as I thought.
> 
> It turns out we make never use of a custom compare function in
> the stringlist, which helps gaining confidence this use case is nowhere
> to be found in the code.

Plenty of code uses the default strcmp. You can find users which assume
sorting by their use of string_list_insert() versus _append(). Or ones
that call string_list_sort(), of course.

-Peff
