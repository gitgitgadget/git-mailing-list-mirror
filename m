Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5A9B1F404
	for <e@80x24.org>; Fri,  7 Sep 2018 03:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbeIGHvf (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 03:51:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:42252 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725940AbeIGHvf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 03:51:35 -0400
Received: (qmail 14674 invoked by uid 109); 7 Sep 2018 03:12:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Sep 2018 03:12:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10772 invoked by uid 111); 7 Sep 2018 03:13:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 06 Sep 2018 23:13:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Sep 2018 23:12:53 -0400
Date:   Thu, 6 Sep 2018 23:12:53 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, timschumi@gmx.de,
        Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: ordered string-list considered harmful, was Re: [PATCH v3] Allow
 aliases that include other aliases
Message-ID: <20180907031253.GA31728@sigill.intra.peff.net>
References: <20180906191203.GA26184@sigill.intra.peff.net>
 <CAGZ79kbi=Ppkt4tYx+G_RDwp7e3+SU-LofZ-QzMsO2=zEPucsA@mail.gmail.com>
 <20180906204932.GA1482@sigill.intra.peff.net>
 <CAGZ79kbFe8WMswWy+SorYUvEj2r5rUQdjx=zbVK5BfeU+Mgx9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kbFe8WMswWy+SorYUvEj2r5rUQdjx=zbVK5BfeU+Mgx9A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 06, 2018 at 01:54:15PM -0700, Stefan Beller wrote:

> > > It turns out we make never use of a custom compare function in
> > > the stringlist, which helps gaining confidence this use case is nowhere
> > > to be found in the code.
> >
> > Plenty of code uses the default strcmp. You can find users which assume
> > sorting by their use of string_list_insert() versus _append(). Or ones
> > that call string_list_sort(), of course.
> 
> Here comes my reading-between-the-lines assumption:
> 
> When using the default comparison function, you probably only care
> about the efficient lookup as described above, but if you had a non-default
> order, then we'd have strong evidence of the contrary as the author of such
> code would have found reasons why that order is superior than default order
> (and don't tell me a different order helps making lookups even more efficient,
> this must be another reason).

That's a reasonable hypothesis. It looks like there are a few cases
where we assign to a string_list.cmp, so I picked one arbitrarily to
look at: split_maildir() uses a custom filename comparison. Despite
having no recollection of this code, it appears to come from my commit
18505c3423. :)

And yes, we really do care about order there, as we're trying to read
the files in "maildir order". And I don't think a hash would do.

That said, I don't think we care about using string-list's sorted
operations here (like its binary-search lookup). It would be enough for
us to generate the list (whether as string-list or no; we'd actually be
happy with any array), sort it, and then iterate over the result.

So I think some of these are definitely going to require some thoughtful
conversion to the correct data type. Mostly what I was asking in the
beginning was: does this seem like an overtly terrible line of thinking
to anyone. And so far I think the answer is no. So the next step is to
proceed to actually trying some conversions, and seeing what kinds of
snags I hit. The devil, as usual, is in the details. :)

-Peff
