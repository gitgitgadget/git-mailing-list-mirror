Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD25C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 23:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5B65613B1
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 23:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243224AbhI1XwC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 19:52:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:57302 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243238AbhI1Xv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 19:51:56 -0400
Received: (qmail 12054 invoked by uid 109); 28 Sep 2021 23:50:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Sep 2021 23:50:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6266 invoked by uid 111); 28 Sep 2021 23:50:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Sep 2021 19:50:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Sep 2021 19:49:57 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Neeraj Singh <nksingh85@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2021, #08; Mon, 27)
Message-ID: <YVOqJTU5HmnXlC5P@coredump.intra.peff.net>
References: <xmqq8rzhmsi7.fsf@gitster.g>
 <CABPp-BGuzd_TH57-1RvwJQD5r3S3ZkJcuiPnU8aWee8pgzUBEw@mail.gmail.com>
 <YVOn3hDsb5pnxR53@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YVOn3hDsb5pnxR53@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 28, 2021 at 07:40:14PM -0400, Jeff King wrote:

> but then fsck shows that our cache is corrupted:
> 
>   Checking object directories: 100% (256/256), done.
>   error: refs/notes/textconv/foo: invalid sha1 pointer 1e9b3ecffca73411001043fe914a7ec0e7291043
>   error: refs/notes/textconv/foo: invalid reflog entry 1e9b3ecffca73411001043fe914a7ec0e7291043
>   dangling tree 569b6e414203d2f50bdaafc1585eae11e28afc37
> 
> Now I'll admit the textconv-cache is a pretty seldom-used feature. And
> that there _probably_ aren't a lot of other ways that the diff code
> would try to write objects or references. But I think it speaks to the
> kind of subtle interactions we should worry about (and certainly
> corrupting the repository is a pretty bad outcome, though at least in
> this case it's "just" a cache and we could blow away that ref manually).

I haven't looked at the way the bulk-fsync code uses tmp_objdir at all
yet, but this is the same kind of thing to be watching out for. I've
added Neeraj to the cc. The full reproduction showing the problem with
Elijah's patch is in the replied-to mail:

  https://lore.kernel.org/git/YVOn3hDsb5pnxR53@coredump.intra.peff.net/

The batch-fsync stuff might be OK in that the goal there is presumably
not to throw away the result, but to eventually migrate it into the odb.
So the unintended interaction to look out for there might be more like:

  - some code foo() wants to write a bunch of objects; it opens up a
    tmp_objdir to batch them

  - some other code bar() deep in the call-stack wants to write an
    object for whatever reason (maybe it's a caching textconv). Its
    object ends up in the tmp_objdir, too.

  - bar() writes a ref pointing to the object's oid, thinking it has
    fully written the object.

  - foo() encounters an error and aborts, rolling back the tmp_objdir,
    including the object written by bar(). Now our ref is corrupt.

As I said, I haven't looked at how the bulk-fsync stuff uses
tmp_objdir. But if it's doing the same "globally all object writes go to
the tmpdir" then it's at risk of this sort of thing.

-Peff
