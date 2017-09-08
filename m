Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60C6B20286
	for <e@80x24.org>; Fri,  8 Sep 2017 03:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754657AbdIHDRK (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 23:17:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:60340 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753991AbdIHDRH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 23:17:07 -0400
Received: (qmail 6681 invoked by uid 109); 8 Sep 2017 03:17:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Sep 2017 03:17:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5442 invoked by uid 111); 8 Sep 2017 03:17:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Sep 2017 23:17:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Sep 2017 23:17:05 -0400
Date:   Thu, 7 Sep 2017 23:17:05 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?utf-8?B?UGF3ZcWC?= Marczewski <pwmarcz@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Strange behavior of git rev-list
Message-ID: <20170908031705.5zqs7jhamzgda47t@sigill.intra.peff.net>
References: <CACNsYJ-UeEONZ+mDgg6x5Bi+D3VmS=5eGCYq1gEPHVsMEJGojA@mail.gmail.com>
 <20170907094718.b6kuzp2uhvkmwcso@sigill.intra.peff.net>
 <CACNsYJ8rRSf5gNtnPS05CnYCYGmoBymbgH7UumuOuBz1jp6RBA@mail.gmail.com>
 <20170907101126.u574pr7l5odff6zo@sigill.intra.peff.net>
 <CAGZ79kaubRDXnetj+EXawnr50LMo4tGObz+-Bd-=KerndLfSaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kaubRDXnetj+EXawnr50LMo4tGObz+-Bd-=KerndLfSaA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 07, 2017 at 12:24:02PM -0700, Stefan Beller wrote:

> > We've discussed storing true generation numbers in the past, which would
> > make this optimization more robust, as well as allow us to speed up many
> > other traversals (e.g., the "tag --contains"). It's something I'd like
> > to revisit, but it's not at the top of the pile.
> 
> (We just had an office discussion if this is part of the hash transition plan,
> i.e. have a field in the commit object to contain its generation number.
> and as I think the generation numbers would lead to fast and correct
> behavior unlike the current heuristic which is only fast, I would try
> to make a strong point actual generation numbers inside commit objects)

I'm still moderately against storing generation numbers inside the
objects. They're redundant with the existing parent pointers, which
means it's an opportunity for the two sets of data to disagree. And as
we've seen, once errors are cemented in history it's very hard to fix
them, because you break any history built on top.

I'm much more in favor of building a local cache of generation numbers
(either on the fly or during repacks, where we can piggy-back on the
existing pack .idx for indexing).

-Peff
