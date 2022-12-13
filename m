Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD35AC4332F
	for <git@archiver.kernel.org>; Tue, 13 Dec 2022 10:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbiLMKhP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Dec 2022 05:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbiLMKhO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2022 05:37:14 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AC2CC9
        for <git@vger.kernel.org>; Tue, 13 Dec 2022 02:37:13 -0800 (PST)
Received: (qmail 14271 invoked by uid 109); 13 Dec 2022 10:37:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Dec 2022 10:37:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3964 invoked by uid 111); 13 Dec 2022 10:37:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Dec 2022 05:37:11 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Dec 2022 05:37:08 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        avarab@gmail.com
Subject: Re: [PATCH v4 3/4] object-file: emit corruption errors when detected
Message-ID: <Y5hV1IC7c4bmEXnN@coredump.intra.peff.net>
References: <Y5ebC1qwJi5VwnCh@coredump.intra.peff.net>
 <20221212225212.2556886-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221212225212.2556886-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 12, 2022 at 02:52:12PM -0800, Jonathan Tan wrote:

> > > Junio made a point that there could, for example, be no path when the
> > > odb list is empty (maybe in the future) so I don't think this would be
> > > sufficient. But there is already a comment there pointing to a comment
> > > in another function that states "path ... (if any)" so this is something
> > > that callers should already take care of. In my changes, I'll initialize
> > > it to NULL and whenever I use it, I'll check for non-NULL first.
> > 
> > If we return a non-negative value, then we opened something, so by
> > definition, don't we have a path of the thing we opened?
> 
> Hmm...are you saying "path is guaranteed when there is no error; when
> there is an error, the caller must check"? If yes, I think we are in
> agreement. In any case, to make things more concrete, I've just sent a
> new version [1].

Almost. I'm saying "path is guaranteed when there is no error; when
there is an error, the value of path is meaningless and should not be
looked at".

If you want to enforce that open_loose_object() sets "path" to NULL on
error, and then say "the caller must check", that would be valid. But
without that, even checking it for NULL is pointless (because you may
see a path which got ENOENT, even though we got an interesting errno
from an earlier path).

-Peff
