Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A831C433DF
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 15:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 716B822D74
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 15:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbgHJPgv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:36:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:54094 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728156AbgHJP1G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 11:27:06 -0400
Received: (qmail 21766 invoked by uid 109); 10 Aug 2020 15:27:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 10 Aug 2020 15:27:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6493 invoked by uid 111); 10 Aug 2020 15:27:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 Aug 2020 11:27:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 10 Aug 2020 11:27:05 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] extend --abbrev support to diff-patch format
Message-ID: <20200810152705.GA61606@coredump.intra.peff.net>
References: <cover.1596887883.git.congdanhqx@gmail.com>
 <xmqqd03zej8w.fsf@gitster.c.googlers.com>
 <20200810100038.GB37030@coredump.intra.peff.net>
 <20200810123148.GB17119@danh.dev>
 <xmqqy2mmcz1e.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy2mmcz1e.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 10, 2020 at 08:15:41AM -0700, Junio C Hamano wrote:

> > 	A lot of those patches couldn't be applied cleanly to old
> > 	versions of said software, thus requires some changes from
> > 	developer and they needs to be regenerated from their trimmed
> > 	tree. Because the archive tree has significantly fewer
> > 	objects, the abbreviation in the index line is usually shorter
> > 	than the original patch. Thus, it generates some noise when
> > 	said developers try to compare the new patch with the original
> > 	patch if there's an exact file-hunk match.
> >
> > 	Make the object name's abbreviation length configurable to
> > 	lower those noise.
> 
> I agree with Peff that with the above as the sole motivating use
> case, the "--full-index" option is the right approach.  It is a much
> more robust solution than "--abbrev=16 would be long enough for all
> project participants to avoid length drift".  IOW these four
> paragraphs do not argue _for_ this change, at least to me.

Yeah, that's what I was getting at: if you care about robust
machine-readability, then the full index is the best solution. Reading
between the lines, I think the argument may be "using --full-index is
too long and therefore ugly, so people like the short-ish names but with
a bit of extra safety".

There's an extra challenge here, which is that you have to convince the
sender to use the extra --abbrev option, even though they themselves
won't be the ones running into the problem when applying. But I don't
think there's an elegant solution to that (we could just bump the
default abbrev everywhere to 12+, which is enough in practice).

Though I'm not 100% sure that "git apply" is smart enough to only look
at blobs (i.e., if "1234abcd" is ambiguous between a tree and a blob,
ignore the tree since patches always apply to blobs). That might be
another avenue that would make things more likely to work without
anybody having to configure anything.

> On the other hand, I think you could argue that "--full-index" is
> merely a synonym for "--abbrev=40", and the patch fixes the
> inconsistency between the object names on the "index" line, which
> can choose only between the default abbrev length and the full
> abbrev length, and all the other places we show object names, which
> uniformly honor the "--abbrev" option.

Yeah, I certainly don't mind the extra flexibility between "full" and
"default" for "index" lines. I do wonder if people want to configure the
abbreviations for those lines separately from other parts. I don't know
that I've ever particularly cared about that flexibility, but the fact
that they were set up separately all those years ago makes me think
somebody might.

-Peff
