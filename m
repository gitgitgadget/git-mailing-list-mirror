Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E09C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 19:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C444206F9
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 19:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgKDTl4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 14:41:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:47778 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbgKDTl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 14:41:56 -0500
Received: (qmail 11025 invoked by uid 109); 4 Nov 2020 19:41:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Nov 2020 19:41:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14106 invoked by uid 111); 4 Nov 2020 19:41:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Nov 2020 14:41:55 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 4 Nov 2020 14:41:55 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Sathyajith Bhat <sathya@sathyasays.com>, git@vger.kernel.org
Subject: Re: Re*: Segfault in git when using git logs
Message-ID: <20201104194155.GA3060815@coredump.intra.peff.net>
References: <CAMsWJsyPVQWV++gc2YJriEOEWBELa_xj2G0NWFMSgNYt47swiQ@mail.gmail.com>
 <20201102144321.GA3962443@coredump.intra.peff.net>
 <20201103101553.GH24813@szeder.dev>
 <20201103182102.GA459792@coredump.intra.peff.net>
 <xmqq361qs31a.fsf@gitster.c.googlers.com>
 <20201103185711.GA461461@coredump.intra.peff.net>
 <xmqqimamqjhl.fsf@gitster.c.googlers.com>
 <xmqq7dr1nh3a.fsf_-_@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7dr1nh3a.fsf_-_@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 04, 2020 at 09:54:01AM -0800, Junio C Hamano wrote:

> >> Should this be checking rev->diffopt.pathspec.nr?
> [...]
> 
> I wonder if rev->prune_data.nr is what matters here, though.
> 
> The prune_data is often identical to diffopt.pathspec, but the
> former affects the paths that participate in history simplification,
> while the latter is used when deciding which paths to show
> differences between the commit and its parent(s) and used to widen
> the set independently from prune_data for the "--full-diff" option.

Hmm, yeah, I think you are right. We only care about whether there is an
entry, so I didn't think "widen" would matter. But one form of widening
is to have no pathspec at all. :)

> -- >8 --
> Subject: [PATCH] log: diagnose -L used with pathspec as an error
> 
> The -L option is documented to accept no pathspec, but the
> command line option parser has allowed the combination without
> checking so far.  Ensure that there is no pathspec when the -L
> option is in effect to fix this.
> 
> Incidentally, this change fixes another bug in the command line
> option parser, which has allowed the -L option used together
> with the --follow option.  Because the latter requires exactly
> one path given, but the former takes no pathspec, they become
> mutually incompatible automatically.  Because the -L option
> follows renames on its own, there is no reason to give --follow
> at the same time.

Makes sense...

> diff --git a/builtin/log.c b/builtin/log.c
> index 0a7ed4bef9..9d70f3e60b 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -206,6 +206,9 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
>  	if (argc > 1)
>  		die(_("unrecognized argument: %s"), argv[1]);
>  
> +	if (rev->line_level_traverse && rev->prune_data.nr)
> +		die(_("-L<range>:<file> cannot be used with pathspec"));
> +

I was thinking this would have to go deeper in the revision code, but
"-L" is strictly a git-log thing. So this looks like the right place to
add the check.

> +# Basic command line option parsing
> +test_expect_success '-L is incompatible with pathspec' '
> +	# This may fail due to "no such path a.c in commit",
> +	# or "-L is incompatible with pathspec". Either is acceptable.
> +	test_must_fail git log -L1,1:a.c -- a.c &&

This test confuses me. What are we looking for here? Presumably we'd
fail with:

  git log -L1,1:a.c

too. If the test were "basic command line parsing", I could see checking
that. But that's only what the comment says. :) I don't see how adding
in the pathspec is interesting, nor that it matches the test title.

> +	# This must fail due to "-L is incompatible with pathspec".
> +	test_must_fail git log -L1,1:b.c -- b.c &&

Right, this is what we fixed. Would using test_i18ngrep on the stderr be
better than the comment?

> +	# These must fail due to "follow requires one pathspec".
> +	test_must_fail git log -L1,1:b.c --follow &&
> +	test_must_fail git log --follow -L1,1:b.c &&

These are really tests of --follow, but I don't mind seeing them here as
reinforcement for the concepts that the commit message claims.

> +	# This may fail due to "-L is incompatible with pathspec",
> +	# or "-L is incompatible with pathspec". Either is acceptable.
> +	test_must_fail git log --follow -L1,1:b.c -- b.c

Should one of those be "-L is incompatible with --follow"? Though of
course we did not add such a check, so we know that it will be "-L is
incompatible with pathspec", even without the --follow.

-Peff
