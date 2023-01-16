Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6D3C46467
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 17:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbjAPRuC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 12:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234858AbjAPRtV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 12:49:21 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7413A58C
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 09:30:06 -0800 (PST)
Received: (qmail 15522 invoked by uid 109); 16 Jan 2023 17:30:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 16 Jan 2023 17:30:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31782 invoked by uid 111); 16 Jan 2023 17:30:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Jan 2023 12:30:05 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Jan 2023 12:30:04 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] format-patch: unleak "-v <num>"
Message-ID: <Y8WJnGHs5nM5GwBM@coredump.intra.peff.net>
References: <xmqqv8l8gr6s.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv8l8gr6s.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 15, 2023 at 12:03:39AM -0800, Junio C Hamano wrote:

> The "subject_prefix" member of "struct revision" usually is always
> set to a borrowed string (either a string literal like "PATCH" that
> appear in the program text as a hardcoded default, or the value of
> "format.subjectprefix") and is never freed when the containing
> revision structure is released.  The "-v <num>" codepath however
> violates this rule and stores a pointer to an allocated string to
> this member, relinquishing the responsibility to free it when it is
> done using the revision structure, leading to a small one-time leak.
> 
> Instead, keep track of the string it allocates to let the revision
> structure borrow, and clean it up when it is done.

FWIW, this looks obviously correct to me.

The word "unleak" in the subject made me think about UNLEAK(), so this
is a small tangent. This is exactly the kind of case that I designed
UNLEAK() for, because the solution really is "while you are assigning to
X, also keep a copy of the pointer in Y to be freed later".

And UNLEAK() is just "keep a copy of the pointer in Y to know that we
_could_ free it later". And of course "do nothing if we are not
leak-detecting". But since we seem to be moving away from UNLEAK(), and
since it would not even save any lines here, I'm perfectly happy with
this solution.

-Peff
