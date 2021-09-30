Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD85C433F5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 07:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87C8861368
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 07:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348820AbhI3HnT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 03:43:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:58126 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348701AbhI3HnS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 03:43:18 -0400
Received: (qmail 22305 invoked by uid 109); 30 Sep 2021 07:41:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 30 Sep 2021 07:41:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24302 invoked by uid 111); 30 Sep 2021 07:41:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 Sep 2021 03:41:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 30 Sep 2021 03:41:34 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: [PATCH 5/7] tmp-objdir: new API for creating and removing
 primary object dirs
Message-ID: <YVVqLo6yNzPtXVv6@coredump.intra.peff.net>
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
 <67d3b2b09f9ddda616cdd0d1b12ab7afc73670ed.1630376800.git.gitgitgadget@gmail.com>
 <87r1d9xh71.fsf@evledraar.gmail.com>
 <CABPp-BG_qigBoirMGR-Yk9Niyxt0UmYCEqojsYxbSEarLAmraA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BG_qigBoirMGR-Yk9Niyxt0UmYCEqojsYxbSEarLAmraA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 28, 2021 at 09:22:32PM -0700, Elijah Newren wrote:

> > Not your fault & this pre-dates your patch, but FWIW I prefer our APIs
> > that don't have these "hidden struct" shenanigans (like say "struct
> > string_list") so a caller could just access this, we can just declare it
> > "const" appropriately.
> >
> > We're also all in-tree friends here, so having various accessors for no
> > reason other than to access struct members seems a bit too much.
> 
> That's a fair point, but just to play counterpoint for a minute...
> 
> FWIW, I dislike when our public facing APIs are polluted with all
> kinds of internal details.  merge-recursive being a case in point.
> When writing merge-ort, although I had a struct with public fields,
> that struct also contained an opaque struct (pointer) within it to
> hide several private fields.  (I would have liked to hide or remove a
> few more fields, but couldn't do so while the merge_recursive_options
> struct was shared between both merge-ort and merge-recursive.)
> 
> That said, I agree it can certainly be overdone, and tmp_objdir is
> pretty simple.  However, sometimes even in simple cases I like when
> folks make use of an opaque struct because it means folks put some
> effort into thinking more about the API that should be exposed.
> That's something we as a project have often overlooked in the past, as
> evidenced both by our one-shot usage mentality, and the existence of
> external projects like libgit2 attempting to correct this design
> shortcoming.  I'd like git to move more towards being structured as a
> reusable library as well as a useful command-line tool.

Right, it was definitely a conscious decision to keep the tmp-objdir API
as slim as possible, just because it's such a complicated and confusing
thing in the first place.

For something like a strbuf, giving direct access to the fields makes
sense. Exposing the details of how the struct works (like accessing
".buf" as a NUL-terminated string) are part of its usefulness.

But tmp_objdir represents a more abstract concept, and I wanted to
insulate callers from the details.

That said, the notion of "this is the path of the objdir" is not that
contentious, so I don't mind it too much (but it would be a jump to
exposing the details at all).

-Peff
