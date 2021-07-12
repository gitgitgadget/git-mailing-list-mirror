Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA39C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4879B611C1
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbhGLSBk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 14:01:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:46744 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229907AbhGLSBj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 14:01:39 -0400
Received: (qmail 19541 invoked by uid 109); 12 Jul 2021 17:58:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 Jul 2021 17:58:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8373 invoked by uid 111); 12 Jul 2021 17:58:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Jul 2021 13:58:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 12 Jul 2021 13:58:50 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/3] strbuf.h API users: don't hardcode 8192, use
 STRBUF_HINT_SIZE
Message-ID: <YOyC2gJ4PWCTepKn@coredump.intra.peff.net>
References: <cover-0.3-00000000000-20210707T103712Z-avarab@gmail.com>
 <patch-2.3-a920a9971e8-20210707T103712Z-avarab@gmail.com>
 <xmqqo8bdda2j.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqo8bdda2j.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 07, 2021 at 03:37:56PM -0700, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
> 
> > Change a couple of users of strbuf_init() that pass a hint of 8192 to
> > pass STRBUF_HINT_SIZE instead.
> >
> > Both of these hardcoded occurrences pre-date the use of the strbuf
> > API. See 5242bcbb638 (Use strbuf API in cache-tree.c, 2007-09-06) and
> > af6eb82262e (Use strbuf API in apply, blame, commit-tree and diff,
> > 2007-09-06).
> >
> > In both cases the exact choice of 8192 is rather arbitrary, e.g. for
> > commit buffers I think 1024 or 2048 would probably be a better
> > default (this commit message is getting this commit close to the
> > former, but I daresay it's already way above the average for git
> > commits).
> 
> Yes, they are arbitrary within the context of these callers.
> 
> I do not think using STRBUF_HINT_SIZE macro in them is the right
> thing to do at all, as there is no reason to think that the best
> value for the write chunk sizes in these codepath has any linkage to
> the best value for the read chunk sizes used by strbuf_read() at
> all.  When benchmarking reveals that the best default size for
> strbuf_read() is 16k, you'd update STRBUF_HINT_SIZE to 16k, but how
> do you tell that it also happens to be the best write buffer size
> for the cache-tree writeout codepath (answer: you don't)?

Being cc'd on this series, I feel compelled to respond with some review.
But I'm in such agreement with what you said here (and downthread, and
also in your response to patch 1) that I can only add a lame "me too". :)

-Peff
