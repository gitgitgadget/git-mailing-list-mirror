Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE59C33C9E
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 02:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11BF1207FF
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 02:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgA2Cbs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 21:31:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:47040 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726478AbgA2Cbr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 21:31:47 -0500
Received: (qmail 13150 invoked by uid 109); 29 Jan 2020 02:31:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 29 Jan 2020 02:31:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12915 invoked by uid 111); 29 Jan 2020 02:39:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jan 2020 21:39:22 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Jan 2020 21:31:46 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4] avoid computing zero offsets from NULL pointer
Message-ID: <20200129023146.GA596379@coredump.intra.peff.net>
References: <20200125053542.GA744596@coredump.intra.peff.net>
 <20200125053834.GB744673@coredump.intra.peff.net>
 <xmqq7e1cbr9w.fsf@gitster-ct.c.googlers.com>
 <20200127211933.GA3794@coredump.intra.peff.net>
 <xmqqtv4f8nlm.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtv4f8nlm.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 28, 2020 at 10:03:49AM -0800, Junio C Hamano wrote:

> > I'm not sure if it's worth it, though.
> 
> As long as we make it clear to those who add new callers that
> any mmfile_t with .ptr==NULL must come with .size==0, it is fine.

TBH, I'm not sure it _is_ fine. The concept that it's safe for a ptr/len
pair to use NULL/0 is true in a lot of places, but the mmfile struct
gets used in a lot of places, much of which is xdiff code we didn't
write. I have no idea if that assumption holds everywhere.

We'd be fixing this one spot, and that's enough to make the tests happy
with UBSan. But I don't know if it's something we ought to be
recommending.

> > Yet another alternative is to consider it a bug to use an mmfile_t with
> > a NULL pointer, figure out where that's being set up, and fix it.
> 
> But that would still require us to make it clear to those who add
> new callers that mmfile_t with .ptr==NULL is a bug, and the current
> callers must be using that as it is convenient for them, I presume,
> so I think a simple comment should probably be sufficient.

Yep, but it's not much different than the hundreds of other function
interfaces we have where sometimes you can pass NULL and sometimes not.

So anyway. What do we want to do here? The fix I have? Something more
elaborate and reusable? Or perhaps just switch it to:

diff --git a/xdiff-interface.c b/xdiff-interface.c
index 3cd2ac2855..4d20069302 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -84,8 +84,8 @@ static void trim_common_tail(mmfile_t *a, mmfile_t *b)
 {
 	const int blk = 1024;
 	long trimmed = 0, recovered = 0;
-	char *ap = a->ptr ? a->ptr + a->size : a->ptr;
-	char *bp = b->ptr ? b->ptr + b->size : b->ptr;
+	char *ap = a->size ? a->ptr + a->size : a->ptr;
+	char *bp = b->size ? b->ptr + b->size : b->ptr;
 	long smaller = (a->size < b->size) ? a->size : b->size;
 
 	while (blk + trimmed <= smaller && !memcmp(ap - blk, bp - blk, blk)) {

By checking "size" instead of "ptr", then we know that the addition is a
noop. And we'd continue to catch a NULL pointer mixed with a non-zero
length (as a segfault). And a non-NULL pointer with a zero length does
the right thing.

> > As an aside, I also wondered whether we could run into problems with
> > "memcmp(NULL, ..., 0)", which is also undefined behavior. But we don't
> > here because the first half of the while() condition wouldn't trigger.
> 
> Yes, although the details slightly differ ;-)
> 
> What is problematic actually is "memcmp(NULL - 1024, ..., 1024)",
> which is guarded with "1024 + trimmed <= smaller &&" that will never
> be true as long as "mmfile_t with .ptr==NULL must have .size==0"
> holds true, right?

Yes, because "smaller" would always be "0". And that part of the code
always uses a 1024-size blk, so it would never have passed "0" to memcmp
anyway.

-Peff
