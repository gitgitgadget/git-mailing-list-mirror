Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131E4C433B4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 13:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C64D461182
	for <git@archiver.kernel.org>; Wed,  5 May 2021 13:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbhEEN4b (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 09:56:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:45332 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232967AbhEEN4b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 09:56:31 -0400
Received: (qmail 18438 invoked by uid 109); 5 May 2021 13:55:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 05 May 2021 13:55:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9718 invoked by uid 111); 5 May 2021 13:55:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 May 2021 09:55:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 5 May 2021 09:55:33 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] streaming.c: move {open,close,read} from vtable to
 "struct git_istream"
Message-ID: <YJKj1bVEfWOWrvhs@coredump.intra.peff.net>
References: <cover-0.5-00000000000-20210505T122816Z-avarab@gmail.com>
 <patch-5.5-52606cd72ac-20210505T122816Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-5.5-52606cd72ac-20210505T122816Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 05, 2021 at 02:33:32PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Move the definition of the structure around the open/close/read
> functions introduced in 46bf043807c (streaming: a new API to read from
> the object store, 2011-05-11) to instead populate "close" and "read"
> members in the "struct git_istream".
> 
> This gets us rid of an extra pointer deference, and I think makes more
> sense. The "close" and "read" functions are the primary interface to
> the stream itself.
> 
> Let's also populate a "open" callback in the same struct. That's now
> used by open_istream() after istream_source() decides what "open"
> function should be used. This isn't needed to get rid of the
> "stream_vtbl" variables, but makes sense for consistency.

Yeah, I think if we are going to get rid of the open vtable in an earlier
patch, it makes sense to go all the way here and make things consistent.

If we had a bunch of these objects, having the layer of indirection to
the vtable would save us some per-object memory. But we really only ever
have one of these open at a time.

-Peff
