Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0F6C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 15:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbiKHPHi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 10:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbiKHPHh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 10:07:37 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76CE1834F
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 07:07:36 -0800 (PST)
Received: (qmail 7869 invoked by uid 109); 8 Nov 2022 15:07:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Nov 2022 15:07:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5132 invoked by uid 111); 8 Nov 2022 15:07:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Nov 2022 10:07:35 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 8 Nov 2022 10:07:35 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4 4/6] revision: add new parameter to exclude hidden refs
Message-ID: <Y2pwt77e9KP5J3XD@coredump.intra.peff.net>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1667901510.git.ps@pks.im>
 <c7fa6698dbe7b0eb5e2b9c4725e9bdc6cdb22983.1667901510.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c7fa6698dbe7b0eb5e2b9c4725e9bdc6cdb22983.1667901510.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 08, 2022 at 11:03:51AM +0100, Patrick Steinhardt wrote:

> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -195,6 +195,13 @@ respectively, and they must begin with `refs/` when applied to `--glob`
>  or `--all`. If a trailing '/{asterisk}' is intended, it must be given
>  explicitly.
>  
> +--exclude-hidden=[receive|uploadpack]::
> +	Do not include refs that have been hidden via either one of
> +	`receive.hideRefs` or `uploadpack.hideRefs` (see linkgit:git-config[1])
> +	that the next `--all`, `--branches`, `--tags`, `--remotes` or `--glob`
> +	would otherwise consider. This option is cleared when seeing one of
> +	these pseudo-refs.

OK, so this one drops "transfer", which I think is good. But again, I
think the explanation here is subtly misleading, because it's not just
"hidden via those sections", but "hidden as receive-pack or upload-pack
would, respecting both those sections _and_ transfer".

I also wondered if we could simplify the explanation a bit by tying it
into the existing --exclude, and then we don't need that mouthful of
pseudo-ref options. So together something like:

  Do not include refs that would be hidden by `receive-pack` or
  `upload-pack`, by consulting the appropriate `receive.hideRefs` or
  `uploadpack.hideRefs`, along with `transfer.hideRefs`. Like
  `--exclude`, this option affects the next pseudo-ref option (`--all`,
  `--glob`, etc), and is cleared after processing them.

But then I read the next section in the --exclude docs, which says:

  The patterns given should not begin with refs/heads, refs/tags, or
  refs/remotes when applied to --branches, --tags, or --remotes,
  respectively, and they must begin with refs/ when applied to --glob or
  --all. If a trailing /* is intended, it must be given explicitly.

Yikes. So --all is going to process "refs/heads/foo", but --branches
will see just "foo". And that means that:

  git rev-list --exclude-hidden=receive --branches

will not work! Because receive.hideRefs is naming fully qualified refs,
but we'll pass unqualified ones to ref_is_hidden(). Even though that
function takes a "full" refname argument, I think that has to do with
namespaces.

I'm sure this _could_ be made to work, but I wonder if it is worth the
trouble. If it's not going to work, though, I think we'd want to detect
the situation and complain, at least for now. And likewise the
documentation needs to make clear it only works with --all and --glob.

Sorry to have misled in my initial suggestion to turn --visible-refs
into --exclude-hidden. However, I do still stand by that suggestion.
Even if we don't make it work with "--branches" now, the user-visible
framework is still there, so it becomes a matter of extending the
implementation later, rather than re-designing the options.

-Peff
