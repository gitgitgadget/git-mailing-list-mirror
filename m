Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 960F920248
	for <e@80x24.org>; Wed,  3 Apr 2019 11:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfDCLgH (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 07:36:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:45362 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725941AbfDCLgH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 07:36:07 -0400
Received: (qmail 422 invoked by uid 109); 3 Apr 2019 11:36:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 03 Apr 2019 11:36:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7830 invoked by uid 111); 3 Apr 2019 11:36:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 03 Apr 2019 07:36:33 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Apr 2019 07:36:05 -0400
Date:   Wed, 3 Apr 2019 07:36:05 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, David Kastrup <dak@gnu.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] blame.c: don't drop origin blobs as eagerly
Message-ID: <20190403113604.GA2941@sigill.intra.peff.net>
References: <20190402115625.21427-1-dak@gnu.org>
 <xmqqv9zvsfay.fsf@gitster-ct.c.googlers.com>
 <CACsJy8AbkmJ69ucCfGMdXHGvfko89SxH=DKjra6Ltwf7wpy-Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8AbkmJ69ucCfGMdXHGvfko89SxH=DKjra6Ltwf7wpy-Og@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 03, 2019 at 04:32:30PM +0700, Duy Nguyen wrote:

> That might explain why I could not see significant gain when blaming
> linux.git's MAINTAINERS file (0.5s was shaved out of 13s) even though
> the number of objects read was cut by half (8424 vs 15083).

I did a few timings, too, and managed to come up with similar
improvements (only a small fraction, and only for large files). I think
the main thing is simply that loading the blob from the object database
is a fraction of the total work done. We still have to actually diff the
blobs, which is at least as expensive as loading them from disk.

We also have to load commits and trees from disk as we traverse.
Enabling the commit-graph would shrink that portion (and make
improvements in the blob loading proportionally more impressive).

All that said, this seems like an easy and obvious win, and worth doing.
0.5s is still something.

I suspect we could do even better by storing and reusing not just the
original blob between diffs, but the intermediate diff state (i.e., the
hashes produced by xdl_prepare(), which should be usable between
multiple diffs). That's quite a bit more complex, though, and I imagine
would require some surgery to xdiff.

-Peff
