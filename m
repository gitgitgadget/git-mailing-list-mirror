Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F1CC433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 20:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90B1F64E7D
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 20:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhBPUX4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 15:23:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:34896 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230198AbhBPUXx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 15:23:53 -0500
Received: (qmail 14770 invoked by uid 109); 16 Feb 2021 20:23:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Feb 2021 20:23:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29024 invoked by uid 111); 16 Feb 2021 20:23:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Feb 2021 15:23:12 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Feb 2021 15:23:11 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <ttaylorr@github.com>
Cc:     janek <27jf@protonmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Short status ignores --show-stash option
Message-ID: <YCwpr29Ghdk3ye1u@coredump.intra.peff.net>
References: <5ofQpdi3EmG_V-LqPrL6ZttzenOKG9xQ9MCdQ1OK7b_NcFZX0hqqmwr8mr2KByFwRa8ljzX4vj-_34Q6aPcXdZ8_qDahZfFSyJKj5cfyAjc=@protonmail.com>
 <YCwOA/CcPEA/he1X@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCwOA/CcPEA/he1X@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 16, 2021 at 01:25:32PM -0500, Taylor Blau wrote:

> and that would cause 'git status' to do what you expect:
> 
>     $ git.compile status --short --branch --show-stash
>     ## tb/empty-trailer-continuation
>      M wt-status.c
>      Your stash currently has 16 entries
> 
> But it may not be the right thing to do, since that explicitly breaks
> the --porcelain format. We may want something like this in addition to
> the above:
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 739110c5a7..ef855896a2 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1414,6 +1414,12 @@ int cmd_status(int argc, const char **argv, const char *prefix)
>             s.show_untracked_files == SHOW_NO_UNTRACKED_FILES)
>                 die(_("Unsupported combination of ignored and untracked-files arguments"));
> 
> +       if (status_format == STATUS_FORMAT_PORCELAIN ||
> +           status_format == STATUS_FORMAT_PORCELAIN_V2) {
> +               if (s.show_stash)
> +                       die(_("--porcelain is incompatible with --show-stash"));
> +       }
> +

I think ideally we'd define a porcelain format for it, since v2 has
explicit support for extending with new headers. Something like:

  # stash.number 16

would probably work. I don't think it's _strictly_ necessary, in that
the die() above does not paint us into a corner. We can always loosen it
later. But it is easy enough that it probably makes sense to just define
it while we are here.

And in particular, I think we may want to mimic it for --short, rather
than just showing the "long" output, which IMHO is kind of dissonant in
terms of the formatting (though again, we reserve the right to change
--short, so I don't think we've painted ourselves into a corner).

-Peff
