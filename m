Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B1EE1FC34
	for <e@80x24.org>; Fri,  8 Dec 2017 20:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751190AbdLHUT7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 15:19:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:52780 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750908AbdLHUT7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 15:19:59 -0500
Received: (qmail 27293 invoked by uid 109); 8 Dec 2017 20:19:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Dec 2017 20:19:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5493 invoked by uid 111); 8 Dec 2017 20:20:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Fri, 08 Dec 2017 15:20:20 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Dec 2017 15:19:57 -0500
Date:   Fri, 8 Dec 2017 15:19:57 -0500
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] diffcore: add a filter to find a specific blob
Message-ID: <20171208201957.GA456@sigill.intra.peff.net>
References: <20171208002447.20261-1-sbeller@google.com>
 <20171208002447.20261-2-sbeller@google.com>
 <20171208093434.GD26199@sigill.intra.peff.net>
 <643e1afd-43e2-7fcc-452b-8b9ceac6868c@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <643e1afd-43e2-7fcc-452b-8b9ceac6868c@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 08, 2017 at 04:28:23PM +0000, Ramsay Jones wrote:

> On 08/12/17 09:34, Jeff King wrote:
> > On Thu, Dec 07, 2017 at 04:24:47PM -0800, Stefan Beller wrote:
> [snip]
> >> Junio hinted at a different approach of solving this problem, which this
> >> patch implements. Teach the diff machinery another flag for restricting
> >> the information to what is shown. For example:
> >>
> >>   $ ./git log --oneline --blobfind=v2.0.0:Makefile
> >>   b2feb64309 Revert the whole "ask curl-config" topic for now
> >>   47fbfded53 i18n: only extract comments marked with "TRANSLATORS:"
> >>
> >> we observe that the Makefile as shipped with 2.0 was introduced in
> >> v1.9.2-471-g47fbfded53 and replaced in v2.0.0-rc1-5-gb2feb64309 by
> >> a different blob.
> 
> Sorry, this has nothing to do with this specific thread. :(
> 
> However, the above caught my eye. Commit b2feb64309 does not 'replace
> the Makefile with a different blob'. That commit was a 'last minute'
> revert of a topic _prior_ to v2.0.0, which resulted in the _same_
> blob as commit 47fbfded53. (i.e. a53f3a8326c2e62dc79bae7169d64137ac3dab20).

Right, I think the patch is working as advertised but the commit message
misinterprets the results. :)

If you add --raw, you can see that both commits introduce that blob, and
it never "goes away". That's because that happened in a merge, which we
don't diff in a default log invocation.

And in fact finding where this "goes away" is hard, because the merge
doesn't trigger "-c" or "--cc". It's 8eaf517835, which presumably was
forked before the revert in b2feb64309, and then the merge was able to
replace that blob completely with the other side of the merge.

Viewing with "-m" turns up a bunch of uninteresting merges. Looking at
"--first-parent" is how I got 8eaf517835.

So I think this one is tricky because of the revert. In the same way
that pathspec-limiting is often tricky in the face of a revert, because
the merges "hide" interesting things happening.

-Peff
