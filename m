Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 044B71F461
	for <e@80x24.org>; Mon, 26 Aug 2019 19:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732421AbfHZTO4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 15:14:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:56284 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731134AbfHZTO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 15:14:56 -0400
Received: (qmail 7289 invoked by uid 109); 26 Aug 2019 19:14:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 26 Aug 2019 19:14:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22963 invoked by uid 111); 26 Aug 2019 19:16:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 26 Aug 2019 15:16:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 26 Aug 2019 15:14:55 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bryan Turner <bturner@atlassian.com>,
        Giuseppe =?utf-8?B?Q3JpbsOy?= <giuscri@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [BUG] You can't have single quote in your username
Message-ID: <20190826191455.GA25695@sigill.intra.peff.net>
References: <CAGV3M55WAQOAOiZPPgR+6p2EVzakrbz1gYAMh-BqxCVDeLCq9w@mail.gmail.com>
 <CAGyf7-EdxDn_BwguXNUNg76K9z30X0=C1btMR0dfiHR9bLjhwQ@mail.gmail.com>
 <20190822170817.GB35435@google.com>
 <20190822184312.xhrf2ij3bh3vovrq@localhost.localdomain>
 <20190823082900.GG20404@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190823082900.GG20404@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 23, 2019 at 10:29:00AM +0200, SZEDER Gábor wrote:

> On Fri, Aug 23, 2019 at 12:13:12AM +0530, Pratyush Yadav wrote:
> > > Does it make more sense to replace this strbuf_addstr_without_crud()
> > > setup with something more intelligent (i.e. checking for matching crud
> > > on either end, like ^[$crudchars].*\1$? We already check for matched <>.
> > 
> > Sounds like something easy enough to implement. There are two types of 
> > characters that crud() removes: there are the ones which _should_ appear 
> > on both the start and end (', ", <, >), and the ones which don't 
> > necessarily have to (., ,, :, ;, \).
> > 
> > So we'd need to handle two cases. For the former type, remove a 
> > character both at the start and at the end. For the latter, remove only 
> > where they appear.
> 
> If we go down this route, then someone might want to write ő as o" or
> ű as u", which still supposed to be used in pairs, but what if someone
> wants to write ä as a:, ö as o:, ü as u:, ç as "c,", ş as "s,", etc.
> 
> What I wonder is whether we really have to remove crud from the user
> name if it comes from the configuration.

Probably not. I think most of this crud-handling is really about pulling
names out of email. Digging around in the archive, one of the few
entries that actually talks about this crud-removal being helpful is:

  https://public-inbox.org/git/alpine.LFD.2.00.0812010836280.3256@nehalem.linux-foundation.org/

So it might make sense to push these rules into "git mailinfo" instead
of applying them everywhere. But we'd still need something at least for
GECOS, where "Your Name,,,," is common.

Unfortunately since these rules have been in place for ages, we don't
really know how often they're helping. Loosening it just for user.name,
etc is probably the most conservative choice.

We'd still want to keep the low-level removal of "<>\n", since those are
syntactically significant to Git (i.e., if they sneak in you end up with
a broken commit object). There's some discussion in this thread (which
is also about trailing single-quotes!):

  https://public-inbox.org/git/20120629124122.GG1258@camk.edu.pl/

Another real-world case that would be helped is: "Your Name, Jr.":

  https://public-inbox.org/git/CAMP44s2OoxUVFE57e8C2Km7rcGn88KkLXxdaA3s5RE6nZ7TU=A@mail.gmail.com/

-Peff
