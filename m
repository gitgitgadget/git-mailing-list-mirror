Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6655E1F406
	for <e@80x24.org>; Wed, 17 Jan 2018 20:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754788AbeAQUzO (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 15:55:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:46942 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755038AbeAQUzL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 15:55:11 -0500
Received: (qmail 17050 invoked by uid 109); 17 Jan 2018 20:55:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 17 Jan 2018 20:55:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5212 invoked by uid 111); 17 Jan 2018 20:55:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 17 Jan 2018 15:55:47 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Jan 2018 15:55:09 -0500
Date:   Wed, 17 Jan 2018 15:55:09 -0500
From:   Jeff King <peff@peff.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     git@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] enable core.fsyncObjectFiles by default
Message-ID: <20180117205509.GA14828@sigill.intra.peff.net>
References: <20180117184828.31816-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180117184828.31816-1-hch@lst.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 17, 2018 at 07:48:28PM +0100, Christoph Hellwig wrote:

> fsync is required for data integrity as there is no gurantee that
> data makes it to disk at any specified time without it.  Even for
> ext3 with data=ordered mode the file system will only commit all
> data at some point in time that is not guaranteed.
> 
> I've lost data on development machines with various times countless
> times due to the lack of this option, and now lost trees on a
> git server with ext4 as well yesterday.  It's time to make git
> safe by default.

I'm definitely sympathetic, and I've contemplated a patch like this a
few times. But I'm not sure we're "safe by default" here after this
patch. In particular:

  1. This covers only loose objects. We generally sync pack writes
     already, so we're covered there. But we do not sync ref updates at
     all, which we'd probably want to in a default-safe setup (a common
     post-crash symptom I've seen is zero-length ref files).

  2. Is it sufficient to fsync() the individual file's descriptors?
     We often do other filesystem operations (like hardlinking or
     renaming) that also need to be committed to disk before an
     operation can be considered saved.

  3. Related to (2), we often care about the order of metadata commits.
     E.g., a common sequence is:

       a. Write object contents to tempfile.

       b. rename() or hardlink tempfile to final name.

       c. Write object name into ref.lock file.

       d. rename() ref.lock to ref

     If we see (d) but not (b), then the result is a corrupted
     repository. Is this guaranteed by ext4 journaling with
     data=ordered?

It may be that data=ordered gets us what we need for (2) and (3). But I
think at the very least we should consider fsyncing ref updates based on
a config option, too.

-Peff
