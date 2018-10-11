Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 863701F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 00:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbeJKHfK (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 03:35:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:36374 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725968AbeJKHfK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 03:35:10 -0400
Received: (qmail 16499 invoked by uid 109); 11 Oct 2018 00:10:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 11 Oct 2018 00:10:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23985 invoked by uid 111); 11 Oct 2018 00:09:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 10 Oct 2018 20:09:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Oct 2018 20:10:36 -0400
Date:   Wed, 10 Oct 2018 20:10:36 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v5 17/23] userdiff.c: remove implicit dependency on
 the_index
Message-ID: <20181011001035.GA13853@sigill.intra.peff.net>
References: <20180915161759.8272-1-pclouds@gmail.com>
 <20180921155739.14407-1-pclouds@gmail.com>
 <20180921155739.14407-18-pclouds@gmail.com>
 <20181010145116.GA11772@sigill.intra.peff.net>
 <xmqq7eipla9k.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7eipla9k.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 11, 2018 at 07:14:31AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I get why you're doing it: your topic here only cares about removing
> > index dependencies, so you did the minimal thing to move that forward.
> >
> > But if you think about what this function is doing, it is quite clearly
> > dependent on the whole repository, since the userdiff config we're
> > looking up may come from repo config.
> 
> In the case of userdiff that is pretty much limited to read-only
> operation, I fully agree, but in more general cases, we would need
> to pass both the repository and an in-core index separately, I would
> say.  Imagine doing a partial commit, where we construct a separate
> istate that is not the "repo's index" and use that to write out a
> tree object to be wrapped in a new commit, and update the current
> branch ref.

Yeah, agreed. I was actually puzzled at first why userdiff needs to know
about the index at all. But the answer is that the attr code may read
.gitattributes out of the index. It's _possible_ somebody would want to
do that with an index besides the normal repo one, but I find it
somewhat unlikely. I think my instinct there is based on it being
"read-only", as you said.

One thing that confused me even more is that diff_options now has a
"struct repository" field in it. I get how that saves passing it around,
but I also wonder if it may run into similar issues at some point. I'm
perfectly willing to punt on it until it actually comes up in practice,
though.

-Peff
