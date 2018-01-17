Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B21F1F406
	for <e@80x24.org>; Wed, 17 Jan 2018 21:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753626AbeAQVKP (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 16:10:15 -0500
Received: from verein.lst.de ([213.95.11.211]:58037 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753462AbeAQVKN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 16:10:13 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id DBE8968DBC; Wed, 17 Jan 2018 22:10:11 +0100 (CET)
Date:   Wed, 17 Jan 2018 22:10:11 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jeff King <peff@peff.net>
Cc:     Christoph Hellwig <hch@lst.de>, git@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] enable core.fsyncObjectFiles by default
Message-ID: <20180117211011.GA355@lst.de>
References: <20180117184828.31816-1-hch@lst.de> <20180117205509.GA14828@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180117205509.GA14828@sigill.intra.peff.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 17, 2018 at 03:55:09PM -0500, Jeff King wrote:
> I'm definitely sympathetic, and I've contemplated a patch like this a
> few times. But I'm not sure we're "safe by default" here after this
> patch. In particular:
> 
>   1. This covers only loose objects. We generally sync pack writes
>      already, so we're covered there. But we do not sync ref updates at
>      all, which we'd probably want to in a default-safe setup (a common
>      post-crash symptom I've seen is zero-length ref files).

I've not seen them myself yet, but yes, they need an fsync.

>   2. Is it sufficient to fsync() the individual file's descriptors?
>      We often do other filesystem operations (like hardlinking or
>      renaming) that also need to be committed to disk before an
>      operation can be considered saved.

No, for metadata operations we need to fsync the directory as well.

>   3. Related to (2), we often care about the order of metadata commits.
>      E.g., a common sequence is:
> 
>        a. Write object contents to tempfile.
> 
>        b. rename() or hardlink tempfile to final name.
> 
>        c. Write object name into ref.lock file.
> 
>        d. rename() ref.lock to ref
> 
>      If we see (d) but not (b), then the result is a corrupted
>      repository. Is this guaranteed by ext4 journaling with
>      data=ordered?

It is not generally guranteed by Linux file system semantics.  Various
file system will actually start writeback of file data before rename,
but not actually wait on it.
