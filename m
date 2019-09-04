Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB8DD1F461
	for <e@80x24.org>; Wed,  4 Sep 2019 07:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfIDH32 (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 03:29:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:38742 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725938AbfIDH32 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 03:29:28 -0400
Received: (qmail 1210 invoked by uid 109); 4 Sep 2019 07:29:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 04 Sep 2019 07:29:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12130 invoked by uid 111); 4 Sep 2019 07:31:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Sep 2019 03:31:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 4 Sep 2019 03:29:27 -0400
From:   Jeff King <peff@peff.net>
To:     randall.s.becker@rogers.com
Cc:     git@vger.kernel.org
Subject: Re: [BUG} stash show does not show untracked files stashed (reposted)
Message-ID: <20190904072926.GA18470@sigill.intra.peff.net>
References: <002901d55e8f$e4a4af70$adee0e50$@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <002901d55e8f$e4a4af70$adee0e50$@rogers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 29, 2019 at 01:33:36PM -0400, randall.s.becker@rogers.com wrote:

> I don't know whether this is new behaviour following changes to stash, but
> here goes.
> 
> Suppose I have files a,b,c,d modified, but only file d is in the index.
> After stash push  (or save) --include-untracked, stash show only displays
> file d. A subsequent pop will restore files a,b,c,d. So functionally push
> and pop are fine, but stash show appears to ignores files in the stash. The
> git log below shows a previous commit (dce2e3e) to the WIP stash (ab0834c)
> that does contain the untracked files, and git diff is happy to show the
> contents when using the ref directly. It is just counterintuitive for stash
> show not to display all entries previously pushed. I would have expected
> symmetry. This is not new.

Right, this is expected but unfortunate. The same problem occurs with
stashed changes to the index. The fundamental issue is that a stash is
not representing a single diff, but rather up to three diffs:

  - changes to the working tree

  - changes to the index

  - a set of untracked files

each of which is stored as a separate commit.

This has been discussed off and on. A while ago I suggested a possible
output format that shows all three:

  https://public-inbox.org/git/20170317141417.g2oenl67k74nlqrq@sigill.intra.peff.net/

The patch there is useless now, as stash has been rewritten in C (though
that probably means it would be possible to make it less hacky). The
main obstacle IMHO is whether we're comfortable changing the output away
from a single diff. I could imagine somebody scripting around stash,
though if the output remained the same for stashes without index changes
or untracked files, that makes problems less likely.

-Peff
