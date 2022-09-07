Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F777C38145
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 20:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiIGUog (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 16:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiIGUof (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 16:44:35 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7337815A37
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 13:44:29 -0700 (PDT)
Received: (qmail 23322 invoked by uid 109); 7 Sep 2022 20:44:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 07 Sep 2022 20:44:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14601 invoked by uid 111); 7 Sep 2022 20:44:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Sep 2022 16:44:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 7 Sep 2022 16:44:28 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     =?utf-8?B?56iL5rSL?= <chengyang@xiaomi.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?5L2V5rWp?= <hehao@xiaomi.com>,
        Xin7 Ma =?utf-8?B?6ams6ZGr?= <maxin7@xiaomi.com>,
        =?utf-8?B?55+z5aWJ5YW1?= <shifengbing@xiaomi.com>,
        =?utf-8?B?5Yeh5Yab6L6J?= <fanjunhui@xiaomi.com>,
        =?utf-8?B?546L5rGJ5Z+6?= <wanghanji@xiaomi.com>
Subject: Re: [PATCH 1/3] parse_object(): allow skipping hash check
Message-ID: <YxkCrAocfstZod8a@coredump.intra.peff.net>
References: <YxfQi4qg8uJHs7Gp@coredump.intra.peff.net>
 <YxfRTubqh7aFvNJs@coredump.intra.peff.net>
 <f79b0ccd-3e36-f447-0dbb-6e40ad547c8d@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f79b0ccd-3e36-f447-0dbb-6e40ad547c8d@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 07, 2022 at 10:15:37AM -0400, Derrick Stolee wrote:

> A quick search shows many uses of parse_object() across the codebase.
> It would certainly be nice if they all suddenly got faster by avoiding
> this hashing, but I also suppose that most of the calls are using
> parse_object() only because they are unsure if they are parsing a
> commit or a tag and would never parse a large blob.

Yeah. I think we use parse_object() as a catch-all for "somebody gave us
an oid, and we need to know what it is". I suspect that most normal uses
would not get much faster, because we typically do feed it non-blob
objects that are small, and whose contents we need to access anyway to
parse them. So we're paying only the overhead of sha1 on a buffer we
already have in memory.

In cases where we might not need the parsed contents at all, our best
bet is to actually remove or delay the parsing entirely. E.g., I think
upload-pack used to be aggressive about parsing the ref tips that it
advertised, but really we can just tell the client about them and only
parse the ones they ask for.

> I think this approach of making parse_object_with_flags() is the best
> way to incrementally approach things here. If we decide that we need
> the _with_flags() version specifically to avoid this hash check, then
> we could probably take the second approach: remove the hash check from
> parse_object() and swap the places that care to use read_object_file()
> instead. My guess is that in the long term there will be fewer swaps
> to read_object_file() than to parse_object_with_flags().
> 
> However, this is a good first step to make progress without doing the
> time-consuming audit of every caller to parse_object().

The notion that this hash check in parse_object() might be slow is
certainly not new. I've been thinking about it for at least a decade. ;)
But until this recent case of direct-fetching blobs, I hadn't seen an
instance where it really made a significant and measurable difference.

So I'm definitely not opposed to going to a world where we drop the
extra hash checks entirely, if that buys us something. The
incrementalism is conservative, but it also makes it easy to
convert specific call-sites to measure the outcomes.

-Peff
