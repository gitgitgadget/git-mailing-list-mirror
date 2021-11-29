Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41E0C4332F
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 19:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348444AbhK2TRl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 14:17:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:39470 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234209AbhK2TPl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 14:15:41 -0500
Received: (qmail 5374 invoked by uid 109); 29 Nov 2021 19:12:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 29 Nov 2021 19:12:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5043 invoked by uid 111); 29 Nov 2021 19:12:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Nov 2021 14:12:23 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 29 Nov 2021 14:12:22 -0500
From:   Jeff King <peff@peff.net>
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Subject: Re: [PATCH v3 0/5] unpack large objects in stream
Message-ID: <YaUmFpIeCvHdKixj@coredump.intra.peff.net>
References: <20211009082058.41138-1-chiyutianyi@gmail.com>
 <20211122033220.32883-1-chiyutianyi@gmail.com>
 <CAO0brD3VPtUrpCE2kCJDram=bLMN=89++=bgf1TddriTYo-nsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO0brD3VPtUrpCE2kCJDram=bLMN=89++=bgf1TddriTYo-nsA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 29, 2021 at 03:01:47PM +0800, Han Xin wrote:

> Han Xin <chiyutianyi@gmail.com> writes:
> >
> > From: Han Xin <hanxin.hx@alibaba-inc.com>
> >
> > Although we do not recommend users push large binary files to the git repositories,
> > it's difficult to prevent them from doing so. Once, we found a problem with a surge
> > in memory usage on the server. The source of the problem is that a user submitted
> > a single object with a size of 15GB. Once someone initiates a git push, the git
> > process will immediately allocate 15G of memory, resulting in an OOM risk.
> >
> > Through further analysis, we found that when we execute git unpack-objects, in
> > unpack_non_delta_entry(), "void *buf = get_data(size);" will directly allocate
> > memory equal to the size of the object. This is quite a scary thing, because the
> > pre-receive hook has not been executed at this time, and we cannot avoid this by hooks.
> >
> > I got inspiration from the deflate process of zlib, maybe it would be a good idea
> > to change unpack-objects to stream deflate.
> >
> 
> Hi, Jeff.
> 
> I hope you can share with me how Github solves this problem.
> 
> As you said in your reply at：
> https://lore.kernel.org/git/YVaw6agcPNclhws8@coredump.intra.peff.net/
> "we don't have a match in unpack-objects, but we always run index-pack
> on incoming packs".
> 
> In the original implementation of "index-pack", for objects larger than
> big_file_threshold, "fixed_buf" with a size of 8192 will be used to
> complete the calculation of "oid".

We set transfer.unpackLimit to "1", so we never run unpack-objects at
all. We always run index-pack, and every push, no matter how small,
results in a pack.

We also set GIT_ALLOC_LIMIT to limit any single allocation. We also have
custom code in index-pack to detect large objects (where our definition
of "large" is 100MB by default):

  - for large blobs, we do index it as normal, writing the oid out to a
    file which is then processed by a pre-receive hook (since people
    often push up large files accidentally, the hook generates a nice
    error message, including finding the path at which the blob is
    referenced)

  - for other large objects, we die immediately (with an error message).
    100MB commit messages aren't a common user error, and it closes off
    a whole set of possible integer-overflow parsing attacks (e.g.,
    index-pack in strict-mode will run every tree through fsck_tree(),
    so there's otherwise nothing stopping you from having a 4GB filename
    in a tree).

> I tried the implementation in jk/no-more-unpack-objects, as you noted:
>   /* XXX This will expand too-large objects! */
>   if (!data)
>   data = new_data = get_data_from_pack(obj_entry);
> If the conditions of --unpack are given, there will be risks here.
> When I create an object larger than 1GB and execute index-pack, the
> result is as follows:
>   $GIT_ALLOC_LIMIT=1024m git index-pack --unpack --stdin <large.pack
>   fatal: attempting to allocate 1228800001 over limit 1073741824

Yeah, that issue was one of the reasons I never sent the "index-pack
--unpack" code to the list. We don't actually use those patches at
GitHub. It was something I was working on for upstream but never
finished.

-Peff
