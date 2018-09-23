Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4736A1F453
	for <e@80x24.org>; Sun, 23 Sep 2018 17:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbeIWXCO (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Sep 2018 19:02:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:56542 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726290AbeIWXCO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Sep 2018 19:02:14 -0400
Received: (qmail 13617 invoked by uid 109); 23 Sep 2018 17:04:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 23 Sep 2018 17:04:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19159 invoked by uid 111); 23 Sep 2018 17:03:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 23 Sep 2018 13:03:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 23 Sep 2018 13:04:04 -0400
Date:   Sun, 23 Sep 2018 13:04:04 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: Import/Export as a fast way to purge files from Git?
Message-ID: <20180923170404.GA1961@sigill.intra.peff.net>
References: <F65AF000-7AE0-44C8-81C8-E58D6769FAA3@gmail.com>
 <20180923155338.GF432229@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180923155338.GF432229@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 23, 2018 at 03:53:38PM +0000, brian m. carlson wrote:

> I suspect you're gaining speed mostly because you're running three
> processes total instead of at least one process (sh) per commit.  So I
> don't think there's anything that Git can do to make this faster on our
> end without a redesign.

It's not just the process startup overhead that makes it faster. Using
multiple processes means they have to communicate somehow. In this case,
git-read-tree is writing out the whole index for each commit, which
git-rm reads in and modifies, and then git-commit-tree finally converts
back to a tree. In addition to the raw CPU of that work, there's a bunch
of latency as each step is performed serially.

Whereas in the proposed pipeline, fast-export is writing out a diff and
fast-import is turning that directly back into tree objects. And both
processes are proceeding independently, so you benefit from multiple
cores.

Which isn't to say I really disagree with "Git can't really make this
faster". filter-branch has a ton of power to let you replay arbitrary
commands (including non-Git commands!), so the speed tradeoff in its
approach is very intentional. If we could modify the index in-place that
would probably make it a little faster, but that probably counts as
"redesign" in your statement. ;)

-Peff
