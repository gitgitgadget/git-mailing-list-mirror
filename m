Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BF4C2D0EF
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 04:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65FA420767
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 04:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404866AbgDPE4n (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 00:56:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:55652 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2404733AbgDPE4b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Apr 2020 00:56:31 -0400
Received: (qmail 16380 invoked by uid 109); 16 Apr 2020 04:56:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 16 Apr 2020 04:56:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25537 invoked by uid 111); 16 Apr 2020 05:07:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Apr 2020 01:07:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 16 Apr 2020 00:56:30 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        vd@FreeBSD.org
Subject: Re: [PATCH] diff-tree.c: load notes machinery when required
Message-ID: <20200416045630.GA21547@coredump.intra.peff.net>
References: <ce1ba0641e37ac84a104cd44af63e759324feb14.1586997354.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ce1ba0641e37ac84a104cd44af63e759324feb14.1586997354.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 15, 2020 at 06:37:38PM -0600, Taylor Blau wrote:

> Since its introduction in 7249e91 (revision.c: support --notes
> command-line option, 2011-03-29), combining '--notes' with any option
> that causes us to format notes (e.g., '--pretty', '--format="%N"', etc)
> results in a failed assertion at runtime.
> 
>   $ git rev-list HEAD | git diff-tree --stdin --pretty=medium --notes
>   commit 8f3d9f354286745c751374f5f1fcafee6b3f3136
>   git: notes.c:1308: format_display_notes: Assertion `display_notes_trees' failed.
>   Aborted
> 
> This failure is due to diff-tree not calling 'load_display_notes' to
> initialize the notes machinery.
> 
> Ordinarily, this failure isn't triggered, because it requires passing
> both '--notes' and another of the above mentioned options. In the case
> of '--pretty', for example, we set 'opt->verbose_header', causing
> 'show_log()' to eventually call 'format_display_notes()', which expects
> a non-NULL 'display_note_trees'.

This looks much better. One question, though...

> @@ -127,6 +128,14 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
>  	precompose_argv(argc, argv);
>  	argc = setup_revisions(argc, argv, opt, &s_r_opt);
> 
> +	memset(&w, 0, sizeof(w));
> +	userformat_find_requirements(NULL, &w);
> +
> +	if (!opt->show_notes_given && (!opt->pretty_given || w.notes))
> +		opt->show_notes = 1;
> +	if (opt->show_notes)
> +		load_display_notes(&opt->notes_opt);
> +

I assume these lines were lifted from builtin/log.c. But what is
pretty_given doing here?

In git-log, it's turning on notes for the default case when no format is
given. But here, if no format has been given we _wouldn't_ want to show
notes.

I think it's relatively harmless, since our default format is not to do
any pretty-printing, and therefore we wouldn't look at the notes. But it
does cause us to call load_display_notes() when we don't need to. I
think that conditional can be simplified to just:

  if (!opt->show_notes_given && w.notes)
	opt->show_notes = 1;

> Fix this by initializing the notes machinery after parsing our options,
> and harden this behavior against regression with a test in t4013. (Note
> that the added ref in this test requires updating two unrelated tests
> which use 'log --all', and thus need to learn about the new refs).

This makes the test update rather hard to follow, but I don't think
there's an easy way around it. I wondered if we could insert and remove
our notes just for our tests, but it's hard to do with the big while
loop in that script.

I also thought it might not be that bad to just add a few tests at the
end, but there are some complications (like removing sha1s from the
output; easily done with a custom format, but the point is to test
--pretty).

So what you have is probably the most sensible thing (and the new commit
would make it easier to test other commands around notes later, if we
chose to).

> @@ -398,6 +407,8 @@ diff --no-index --raw --no-abbrev dir2 dir
> 
>  diff-tree --pretty --root --stat --compact-summary initial
>  diff-tree --pretty -R --root --stat --compact-summary initial
> +diff-tree --pretty --notes note
> +diff-tree --format=%N note
>  diff-tree --stat --compact-summary initial mode
>  diff-tree -R --stat --compact-summary initial mode

Perhaps worth testing that:

  diff-tree --pretty note

does not print any notes by default?

-Peff
