Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5CC32036C
	for <e@80x24.org>; Wed,  4 Oct 2017 08:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751449AbdJDICQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 04:02:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:60192 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751388AbdJDICP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 04:02:15 -0400
Received: (qmail 15537 invoked by uid 109); 4 Oct 2017 08:02:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 04 Oct 2017 08:02:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15854 invoked by uid 111); 4 Oct 2017 08:02:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 04 Oct 2017 04:02:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Oct 2017 04:02:13 -0400
Date:   Wed, 4 Oct 2017 04:02:13 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2017, #01; Wed, 4)
Message-ID: <20171004080212.jatd4clbjlctazun@sigill.intra.peff.net>
References: <xmqqy3orbcrr.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy3orbcrr.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 04, 2017 at 04:19:52PM +0900, Junio C Hamano wrote:

> * jt/partial-clone-lazy-fetch (2017-10-02) 18 commits
>  - fetch-pack: restore save_commit_buffer after use
>  - unpack-trees: batch fetching of missing blobs
>  - clone: configure blobmaxbytes in created repos
>  - clone: support excluding large blobs
>  - fetch: support excluding large blobs
>  - fetch: refactor calculation of remote list
>  - fetch-pack: support excluding large blobs
>  - pack-objects: support --blob-max-bytes
>  - pack-objects: rename want_.* to ignore_.*
>  - gc: do not repack promisor packfiles
>  - rev-list: support termination at promisor objects
>  - sha1_file: support lazily fetching missing objects
>  - introduce fetch-object: fetch one promisor object
>  - index-pack: refactor writing of .keep files
>  - fsck: support promisor objects as CLI argument
>  - fsck: support referenced promisor objects
>  - fsck: support refs pointing to promisor objects
>  - fsck: introduce partialclone extension
> 
>  A journey for "git clone" and "git fetch" to become "lazier" by
>  depending more on its remote repository---this is the beginning of
>  it.
> 
>  Needs review.

The merge of this topic into jch (at 766f92478b0) causes the test suite
to fail when compiled with ASan/UBSan. The simplest reproduction I could
come up with is:

   $ make SANITIZE=address,undefined BLK_SHA1=1 &&
     GIT_DIR=nope ./git shortlog </dev/null >/dev/null
   repository.c:69:31: runtime error: index 1869098813 out of bounds for type 'git_hash_algo [1]'

Note that the series is fine by itself, it's only the merge which fails.
Which implies to me it's some funny interaction with bc/hash-algo (which
introduces the hash_algo concept). But I didn't dig further.

+cc brian and Jonathan.

-Peff
