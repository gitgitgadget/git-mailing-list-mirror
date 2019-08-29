Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97A241F461
	for <e@80x24.org>; Thu, 29 Aug 2019 14:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfH2OKM (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 10:10:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:32920 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726518AbfH2OKM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 10:10:12 -0400
Received: (qmail 23883 invoked by uid 109); 29 Aug 2019 14:10:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 29 Aug 2019 14:10:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23193 invoked by uid 111); 29 Aug 2019 14:11:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 29 Aug 2019 10:11:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 29 Aug 2019 10:10:11 -0400
From:   Jeff King <peff@peff.net>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org
Subject: Re: Is git clone followed by git verify-tag meaningful?
Message-ID: <20190829141010.GD1797@sigill.intra.peff.net>
References: <20190828203224.GE26001@chatter.i7.local>
 <20190828234706.GB25355@sigill.intra.peff.net>
 <20190829133457.GA26173@chatter.i7.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190829133457.GA26173@chatter.i7.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 29, 2019 at 09:34:57AM -0400, Konstantin Ryabitsev wrote:

> As you know, for the Linux kernel we provide both tag signatures and
> detached PGP signatures on tarballs (and the same is true for git). The
> argument I hear frequently is that providing detached tarball signatures is
> redundant[*] when tags are already PGP-signed, so I wanted to double-check
> that all checksums are computed and matched on the client in the process of
> "git checkout" and we're not just verifying a signature of a non-verified
> checksum.
> 
> In other words, I needed to double-check that what we get in the end is
> assurance that "all files in this repository are exactly the same as on the
> developer's system at the time when they ran 'git tag -s'."

Then yes, there is no need to fsck. When the objects were received on
the server side (by push) and then again when you got them from the
server (by clone), their sha1s were recomputed from scratch, not
trusting the sender at all in either case.

(Again, assuming you trust sha1; I think you should, especially since we
use the collision-detecting sha1 by default, but I wanted to make that
part clear).

> > Even without the fsck, we will compute the sha1 of each object (we must,
> > because the other side doesn't send it at all), and that we have all
> > objects reachable from the refs. So verifying the tag at that point
> > demonstrates a signature on the tag object, which refers to probably
> > some commit via sha1, which refers to actual trees and blobs by a chain
> > of sha1s. If you believe in the integrity of sha1, then it has
> > effectively signed all of that content.
> 
> So, the client will actually calculate those checksums during the checkout
> stage to make sure that all content in the repository matches the hash of
> the commit being checked out, correct?

It's not during the checkout itself, but rather during the transfer of
objects into the receiving repository. I.e., there is no need to even
have a checkout. E.g., you could verify the tag and then use "git
archive".

Do note that both archive and checkout can modify files from their
in-repository state using gitattributes (e.g., to do line-ending
conversion, or using export-subst to add things like the commit ID into
the generated tarball). So it's possible that a tarball (either
generated from git-archive or from checked out contents) may not be
byte-for-byte identical.

Depending on your use case, that can range from an annoyance to ignore
(if a developer is using those features, tell them not to do that) to a
security issue (if you are somehow certifying the tarball contents based
on the tag signature, there is room for a malicious signer to tweak the
tarball contents).

But I think your question is mostly just "if I clone the repo and verify
the tag, is it what the original person signed?". And that answer is
yes.

-Peff
