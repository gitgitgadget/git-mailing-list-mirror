Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E092C433FE
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 20:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJRU32 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 16:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJRU30 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 16:29:26 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB13FFE7
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 13:29:24 -0700 (PDT)
Received: (qmail 590 invoked by uid 109); 18 Oct 2022 20:29:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Oct 2022 20:29:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23095 invoked by uid 111); 18 Oct 2022 20:29:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Oct 2022 16:29:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 Oct 2022 16:29:23 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Mathias Rav <m@git.strova.dk>, git@vger.kernel.org,
        pwagland@gmail.com
Subject: Re: [PATCH] revision: ignore non-existent objects in resolve-undo
 list
Message-ID: <Y08Mo8AL4DmFhZao@coredump.intra.peff.net>
References: <20221018175530.086c8c74@apus>
 <xmqqfsflum70.fsf@gitster.g>
 <xmqqbkq9ulum.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbkq9ulum.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 18, 2022 at 09:40:01AM -0700, Junio C Hamano wrote:

> And the patch goes in the right direction.  It is a bit sad that it
> now has to do parse_object() but in the normal case, the object
> referenced should be a blob that exists, for which the cost of
> parsing it would be none (just setting .parsed member to true), so
> it should be OK.

This isn't quite true. parse_object() will still inflate the object
contents to check the sha1. I think has_object_file() is probably the
right thing here. We want to know if the object is missing entirely.

We'd not notice corrupted bytes, of course, but that is OK. Traversal
does not open blobs we reach via trees, either. For pack-objects, we
rely on either:

  - for repacking to disk, we check the pack crc for already-packed
    objects (which avoids inflating them). For loose objects, we'll
    inflate them later when we convert them to packed form.

  - for packing to stdout for fetch/push, the receiver is expected to
    check the sha1 via index-pack, etc.

So I think just checking "do we have it? If not, gently skip it" is the
right thing here. And in the long run we'd hopefully remove that code,
as "we don't have it" becomes less "this was probably gc'd with an older
version of git" to "oops, there is a bug in Git that lost this object".

I notice that 5a5ea141e7 (revision: mark blobs needed for resolve-undo
as reachable, 2022-06-09) uses parse_object() in the fsck code path.
That _might_ be better as lookup_object(), as earlier stages of fsck
would have checked the bytes of each object and created an in-memory
object struct. Though I guess in that sense, it doesn't matter;
parse_object() will hit lookup_object() first and see that in-memory
struct.

-Peff
