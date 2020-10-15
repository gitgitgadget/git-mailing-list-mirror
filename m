Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8976AC433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 19:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BB6C206D9
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 19:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391821AbgJOTmA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 15:42:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:33426 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391791AbgJOTmA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 15:42:00 -0400
Received: (qmail 24266 invoked by uid 109); 15 Oct 2020 19:41:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Oct 2020 19:41:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32420 invoked by uid 111); 15 Oct 2020 19:41:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Oct 2020 15:41:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Oct 2020 15:41:58 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nipunn Koorapati <nipunn1313@gmail.com>,
        Alex Vandiver <alexmv@dropbox.com>
Subject: Re: [PATCH] dir.c: fix comments to agree with argument name
Message-ID: <20201015194158.GA1490964@coredump.intra.peff.net>
References: <pull.757.git.1602766160815.gitgitgadget@gmail.com>
 <20201015160725.GA1104947@coredump.intra.peff.net>
 <xmqqk0vrfi1r.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk0vrfi1r.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 15, 2020 at 11:41:36AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> - * If "ss" is not NULL, compute SHA-1 of the exclude file and fill
> >> + * If "oid_stat" is not NULL, compute SHA-1 of the exclude file and fill
> >
> > Makes sense. This changed as part of 4b33e60201 (dir: convert struct
> > sha1_stat to use object_id, 2018-01-28). Perhaps it would likewise make
> > sense to stop saying "SHA-1" here, and just say "hash" (or even "object
> > id", though TBH I think the fact that the hash is the same as an
> > object-id is largely an implementation detail).
> 
> I do not quite get your "though TBH", though.  I do agree with you
> that it is an implementation detail that an object is named after
> the hash of its contents, so saying "compute object name" probably
> makes sense in more context than "compute hash" outside the narrow
> parts of the code that actually implements how object names are
> computed.  So I would have expected "because TBH", not "though TBH".

Sorry, I was just confused.

The implementation detail I meant is that we are using a "struct
object_id" in the oid_stat type (and also that "oid_stat" is likewise
exposing too much). I thought this was another version of our
stat_validity, where we are checking quickly to see if a random file
that is not necessarily part of the working tree has been updated.

And indeed, we do use it that way for files like .git/info/exclude,
where having an "object_id" is really irrelevant. But we also use it for
checking the validity of tracked files, where we populate it from an
actual blob (see dir.c:do_read_blob).

So it is actually reasonable to expose that in the name, and to think
about it as an object_id.

> Anyway.  Nipunn, can you fix both of them in the same commit, as
> they are addressing a problem from the same cause (i.e. we are no
> longer SHA-1 centric).

The v2 that Nipunn sent with "oid" in the comment looks good to me.

-Peff
