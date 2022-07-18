Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE2CC43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 15:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbiGRPqB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 11:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbiGRPqA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 11:46:00 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3993118E03
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 08:45:59 -0700 (PDT)
Received: (qmail 32335 invoked by uid 109); 18 Jul 2022 15:45:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Jul 2022 15:45:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10422 invoked by uid 111); 18 Jul 2022 15:45:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Jul 2022 11:45:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 18 Jul 2022 11:45:52 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] revisions API: don't leak memory on argv elements
 that need free()-ing
Message-ID: <YtWAMP0ROFseFs6B@coredump.intra.peff.net>
References: <cover-0.6-00000000000-20220713T130511Z-avarab@gmail.com>
 <patch-6.6-4a581a4a6ce-20220713T130511Z-avarab@gmail.com>
 <YtV4KmrTBkmcx6m3@coredump.intra.peff.net>
 <220718.86zgh6wiwa.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220718.86zgh6wiwa.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 18, 2022 at 05:13:05PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > But if you went just a little further and made the option "rev should
> > own its own argv", then I think you can simplify life for callers even
> > more. They could construct a strvec themselves and then hand it off to
> > the rev_info, to be cleaned up when release_revisions() is called (and
> > of course freeing the "--" when we overwrite it in the interim, as you
> > do here).
> >
> > Then all of the bisect callers from the previous patch could avoid
> > having to deal with the strvec at all. They'd call bisect_rev_setup(),
> > which would internally attach the memory to rev_info.
> 
> Yes, I experimented with this, and it's a solid approach.
> 
> But it's a much larger change, particularly since we'd also want to
> update the API itself to take take "const" in the appropriate places to
> do it properly.

Hmm. I was thinking that we'd just have rev_info.we_own_our_argv, and
then release it in release_revisions(). But actually, rev_info does not
hold onto the argv at all! It's totally processed in setup_revisions().

And there it either:

  - becomes part of prune_data (in which case a copy is made)

  - is passed to handle_revisions_opt(), etc, in which case it is parsed
    but not held onto (it's possible that some string option holds onto
    a pointer, but the only one I found is --filter, which makes a
    copy).

  - is passed to handle_revision_arg(), but these days
    add_rev_cmdline(), etc, make copies. As they must, otherwise --stdin
    would be totally buggy.

So I actually wonder if the comment in bisect_rev_setup() is simply
wrong. It was correct in 2011 when I wrote it, but things changed in
df835d3a0c (add_rev_cmdline(): make a copy of the name argument,
2013-05-25), etc.

In that case, we could replace your patch 5 in favor of just calling
strvec_clear() at the end of bisect_rev_setup(). It's possible there's a
case I'm missing that makes this generally not-safe, but in the case of
bisect_rev_setup() there's a very limited set of items in our argv in
the first place. Doing so also passes the test suite with
SANITIZE=address, though again, this is just exercising the very limited
bisect options here.

-Peff
