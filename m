Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E11341F453
	for <e@80x24.org>; Mon, 28 Jan 2019 17:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731231AbfA1R1K (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 12:27:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:51604 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727365AbfA1R1J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 12:27:09 -0500
Received: (qmail 5986 invoked by uid 109); 28 Jan 2019 17:27:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 28 Jan 2019 17:27:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26970 invoked by uid 111); 28 Jan 2019 17:27:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 28 Jan 2019 12:27:14 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Jan 2019 12:27:07 -0500
Date:   Mon, 28 Jan 2019 12:27:07 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH/RFC] completion: complete refs in multiple steps
Message-ID: <20190128172707.GA3050@sigill.intra.peff.net>
References: <20190128094155.2424-1-pclouds@gmail.com>
 <20190128143828.GJ6702@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190128143828.GJ6702@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 28, 2019 at 03:38:28PM +0100, SZEDER Gábor wrote:

> > -	__gitcomp_direct "$(__git_refs "$remote" "$track" "$pfx" "$cur_" "$sfx")"
> > +	__gitcomp_direct "$(__git_refs "$remote" "$track" "$pfx" "$cur_" "$sfx" | __git_collapse_refs "$cur_")"
> >  }
> 
> In general I think it would be much better to rely more on 'git
> for-each-ref' to do the heavy lifting, extending it with new format
> specifiers/options as necessary.

FWIW, that was my first thought, too.

> '%(refname:rstrip=-<N>)' already comes somewhat close to what we would
> need for full ref completion (i.e. 'refs/b<TAB>' to complete
> 'refs/bisec/bad'), we only have to figure out how many "ref path
> components" to show based on the number of path components in the
> current word to be completed.  Alas, it won't add the trailing '/' for
> "ref directories".

I think it also makes it hard to do one thing which (I think) people
would want: if there is a single deep ref, complete the whole thing.
E.g., given:

  $ git for-each-ref --refname='%(refname)'
  refs/heads/foo/bar
  refs/heads/foo/baz
  refs/heads/another/deep/one

we'd ideally complete "fo" to "foo/" and "ano" to "another/deep/one",
rather than making the user tab through each level.

Doing that requires actually understanding that the refs are in a list,
and not formatting each one independently. So I kind of wonder if it
would be easier to simply have a completion mode in ref-filter.

-Peff
