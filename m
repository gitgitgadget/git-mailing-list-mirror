Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB40EC07E9B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 07:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B673A61165
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 07:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbhGTGjk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 02:39:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:54316 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230177AbhGTGjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 02:39:16 -0400
Received: (qmail 2250 invoked by uid 109); 20 Jul 2021 07:19:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 20 Jul 2021 07:19:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19742 invoked by uid 111); 20 Jul 2021 07:19:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 20 Jul 2021 03:19:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 20 Jul 2021 03:19:29 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 02/11] refs/files: remove unused REF_DELETING in
 lock_ref_oid_basic()
Message-ID: <YPZ5ASyrdoCaXHzZ@coredump.intra.peff.net>
References: <patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com>
 <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
 <patch-02.11-033c0cec33d-20210716T140631Z-avarab@gmail.com>
 <xmqqk0lmnury.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk0lmnury.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 19, 2021 at 09:16:49AM -0700, Junio C Hamano wrote:

> > None of those callers pass REF_DELETING, the last such caller went
> > away in 8df4e511387 (struct ref_update: move "have_old" into "flags",
> > 2015-02-17). This is the start of even more removal of unused code in
> > and around this function.
> 
> While I agree that no existing calls to lock_ref_oid_basic() pass
> REF_DELETING to it (hence this patch is a benign no-op), inside
> ref_transaction_commit(), 8df4e511387 still used REF_DELETING, I
> think, like so:
> 
> 	/* Acquire all locks while verifying old values */
> 	for (i = 0; i < n; i++) {
> 		struct ref_update *update = updates[i];
> 		unsigned int flags = update->flags;
> 
> 		if (is_null_sha1(update->new_sha1))
> 			flags |= REF_DELETING;
> 		update->lock = lock_ref_sha1_basic(
> 				update->refname,
> 				((update->flags & REF_HAVE_OLD) ?
> 				 update->old_sha1 : NULL),
> 				NULL,
> 				flags,
> 				&update->type);

Good catch. That code got moved to refs/files-backend.c in 7bd9bcf372
(refs: split filesystem-based refs code into a new file, 2015-11-09),
and then pulled into a function in 165056b2fc (lock_ref_for_update():
new function, 2016-04-24). And then finally in 92b1551b1d (refs: resolve
symbolic refs first, 2016-04-25), we replaced the call to
lock_ref_sha1_basic() with lock_raw_ref().

So I think that final one is when the parameter actually became obsolete
(so the patch is still good, just a minor history inaccuracy).

-Peff
