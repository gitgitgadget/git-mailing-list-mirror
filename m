Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD10C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 20:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbiLLUvI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 15:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbiLLUvG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 15:51:06 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E6A183A8
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 12:51:02 -0800 (PST)
Received: (qmail 6387 invoked by uid 109); 12 Dec 2022 20:51:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 Dec 2022 20:51:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29564 invoked by uid 111); 12 Dec 2022 20:49:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Dec 2022 15:49:47 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 12 Dec 2022 15:49:46 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        avarab@gmail.com
Subject: Re: [PATCH v4 3/4] object-file: emit corruption errors when detected
Message-ID: <Y5eT6jodUdNr6hK6@coredump.intra.peff.net>
References: <cover.1669839849.git.jonathantanmy@google.com>
 <cover.1670622176.git.jonathantanmy@google.com>
 <07d28db92c2c61358755b3d501bc5bd35a760de1.1670622176.git.jonathantanmy@google.com>
 <xmqqv8mkxgd1.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv8mkxgd1.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 10, 2022 at 09:16:42AM +0900, Junio C Hamano wrote:

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > +	fd = open_loose_object(r, oid, &path);
> > +	if (fd < 0) {
> > +		if (errno != ENOENT)
> > +			error_errno(_("unable to open loose object %s"), path);
> > +		return -1;
> > +	}
> 
> I know there was a discussion in the previous round, but is this use
> of path truly safe?  Currently it may happen to be as long as there
> is at least one element on the odb list, but when thinking things
> through with future-proofing point of view, I do not think assuming
> that path is always computable is a healthy thing to do in the
> longer term.
> 
> Our "struct object_id" may be extended in the future and allow us to
> express "invalid" object name, in which case the error return we get
> may not even be about "loose object file not openable" but "there
> will never be a loose object file for such an invalid object name",
> in which case there won't be any path returned from the function.

Actually, I think it is much worse than that. The code as written above
is already buggy (which is my fault, as I suggested it).

In open_loose_object() we'll continue to iterate and pick out the "most
interesting errno". But we'll throw away the path that gave us that
errno. So we might well say:

  unable to open loose object /some/alternate/12/34abcd: permission denied

when the actual problem is in /main/objdir/12/34abcd.

It's fixable, but with some pain in handling the allocations. I think it
would be sufficient to just say:

  error_errno(_("unable to open loose object %s"), oid_to_hex(oid));

here. And possibly put a comment above open_loose_object() that "path"
is only guaranteed to point to something sensible when a non-negative
value is returned.

-Peff
