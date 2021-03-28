Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A4EC433C1
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 07:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E30C36197E
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 07:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhC1HRr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 03:17:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:51246 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229538AbhC1HRj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 03:17:39 -0400
Received: (qmail 25652 invoked by uid 109); 28 Mar 2021 07:17:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 28 Mar 2021 07:17:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24699 invoked by uid 111); 28 Mar 2021 07:17:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 28 Mar 2021 03:17:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 28 Mar 2021 03:17:37 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 4/4] usage.c: add a non-fatal bug() function to go with
 BUG()
Message-ID: <YGAtkW2YWNbcAn8m@coredump.intra.peff.net>
References: <cover-0.5-00000000000-20210328T022343Z-avarab@gmail.com>
 <patch-4.5-515d146cac8-20210328T022343Z-avarab@gmail.com>
 <xmqqh7kvolgn.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqh7kvolgn.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 27, 2021 at 11:12:40PM -0700, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
> 
> > Add a bug() function that works like error() except the message is
> > prefixed with "bug:" instead of "error:".
> >
> > The reason this is needed is for e.g. the fsck code. If we encounter
> > what we'd consider a BUG() in the middle of fsck traversal we'd still
> > like to try as hard as possible to go past that object and complete
> > the fsck, instead of hard dying. A follow-up commit will introduce
> > such a use in object-file.c.
> 
> Reading the description above, i.e. "to go past that object", the
> assumed use case seems to be to deal with a data error, not a
> program bug (which is where we use BUG()---e.g. one helper function
> in the fsck code detected that the caller wasn't careful enough to
> vet the data it has and called it with incoherent data).  If we find
> a tree entry whose mode bits implies that the object recorded in the
> entry ought to be a blob, and later find out that the object turns
> out to be a tree, that is a corrupt repository and the code that
> detected is not buggy (and we shouldn't use BUG(), of course).
> 
> So, ... I am skeptical.  If the code is prepared to handle breakage,
> we would not want to die, but then I am not sure why it has to be
> different from error().

Yeah, this seems like it is missing the point of BUG() completely.  I
took a peek at patch 5/5 of the follow-on, which uses bug(). It looks
like it should really be an error() return or similar. The root cause
would be open_istream() on a loose object failing (which might be
corruption, or might even be a transient OS error!).

-Peff
