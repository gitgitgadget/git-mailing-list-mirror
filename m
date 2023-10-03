Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC2AE776DB
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 19:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240879AbjJCTKE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 15:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjJCTKC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 15:10:02 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5E5AB
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 12:09:58 -0700 (PDT)
Received: (qmail 13641 invoked by uid 109); 3 Oct 2023 19:09:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 03 Oct 2023 19:09:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13304 invoked by uid 111); 3 Oct 2023 19:09:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Oct 2023 15:09:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Oct 2023 15:09:55 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [silly] loose, pack, and another thing?
Message-ID: <20231003190955.GA1562@coredump.intra.peff.net>
References: <xmqqbkdometi.fsf@gitster.g>
 <20230928214010.3502838-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230928214010.3502838-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 28, 2023 at 02:40:10PM -0700, Jonathan Tan wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> > Just wondering if it would help to have the third kind of object
> > representation in the object database, sitting next to loose objects
> > and packed objects, say .git/objects/verbatim/<hex-object-name> for
> > the contents and .git/objects/verbatim/<hex-object-name>.type that
> > records "blob", "tree", "commit", or "tag" (in practice, I would
> > expect huge "blob" objects would be the only ones that use this
> > mechanism).
> > 
> > The contents will be stored verbatim without compression and without
> > any object header (i.e., the usual "<type> <length>\0") and the file
> > could be "ln"ed (or "cow"ed if the underlying filesystem allows it)
> > to materialize it in the working tree if needed.
> 
> This sounds like a useful feature. We probably would want to use the
> "ln" or "cow" every time we use streaming (stream_blob_to_fd() in
> streaming.h) currently, so hopefully we won't need to increase the
> number of ways in which we can write an object to the worktree (just
> change the streaming to write to a filename instead of an fd).

One thing that scares me about a regular "ln" between the worktree and
odb is that you are very susceptible to corrupting the repository by
modifying the worktree file with regular tools. If they do a complete
rewrite and atomic rename (or link) to put the new file in place, that
is OK. But opening the file for appending, or general writing, is bad.

You can get some safety with the immutable attribute (which applies to
the inode itself, and thus any path that hardlinks to it). But setting
that usually requires being root. And it creates other irritations for
normal use (you have to unset it before even removing the hardlink).

It would be nice if there was some portable copy-on-write abstraction we
could rely on, but I don't think there is one.

-Peff
