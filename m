Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ADE81F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 06:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfJKGVi (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 02:21:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:45414 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726401AbfJKGVi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 02:21:38 -0400
Received: (qmail 13201 invoked by uid 109); 11 Oct 2019 06:21:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 Oct 2019 06:21:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30649 invoked by uid 111); 11 Oct 2019 06:24:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Oct 2019 02:24:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 11 Oct 2019 02:21:37 -0400
From:   Jeff King <peff@peff.net>
To:     Joey Hess <id@joeyh.name>
Cc:     git@vger.kernel.org
Subject: Re: git cat-file --batch surprising carriage return behavior
Message-ID: <20191011062136.GA25741@sigill.intra.peff.net>
References: <20191008192257.GA16870@kitenet.net>
 <20191008200050.GA26453@sigill.intra.peff.net>
 <20191009152851.GC19679@kitenet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191009152851.GC19679@kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 09, 2019 at 11:28:51AM -0400, Joey Hess wrote:

> > I suspect it's not entirely sufficient for clean input, though. You're
> > not feeding filenames but rather full "object names". I wouldn't be
> > surprised if we mis-parse "$rev:$path" when $path has "@{}" or similar
> > in it.
> 
> Nothing I've tried along the lines of "HEAD:{yesterday}" has misparsed
> the part after the colon as anything but a filename.

It's possible we've fixed them all. We definitely don't parse strictly
left-to-right. The first thing we try to do is strip bits like ^{commit}
off the end, before we even find the colon. But after doing so, we
should generally be left with a resolvable name, and I think that uses
the "basic" parser which will not allow colons. I.e., this:

  mkdir subdir
  echo whatever >subdir/file
  git add subdir
  git commit -m 'add directory'
  git show HEAD:subdir^{tree}

really does look for the file "subdir^{tree}" in HEAD, and not
"HEAD:subdir" as a tree.

We have had bugs in the past; I'm thinking specifically of 8cd4249c4c
(interpret_branch_name: always respect "namelen" parameter, 2014-01-15).
But I couldn't find any problematic inputs after poking around for a few
minutes.

> The one I can think of where there's a parse ambiguity is that while
> :foo gets file foo, :1:foo does not get file "1:foo". Instead it's
> treated as a stage number. Using either HEAD:1:foo or :./1:foo
> will avoid that ambiguity.

Yeah, that makes sense.

-Peff
