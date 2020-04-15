Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1588C2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 22:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B604A206E9
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 22:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732103AbgDOW3J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 18:29:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:55252 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727993AbgDOW3H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 18:29:07 -0400
Received: (qmail 14667 invoked by uid 109); 15 Apr 2020 22:29:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 15 Apr 2020 22:29:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12312 invoked by uid 111); 15 Apr 2020 22:39:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Apr 2020 18:39:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Apr 2020 18:29:05 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Vasil Dimov via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Vasil Dimov <vd@freebsd.org>
Subject: Re: [PATCH 1/2] range-diff: fix a crash in parsing git-log output
Message-ID: <20200415222905.GA3595509@coredump.intra.peff.net>
References: <pull.760.git.git.1586960921.gitgitgadget@gmail.com>
 <2375e34100e571f9c3ce658d28aba6648fba18a6.1586960921.git.gitgitgadget@gmail.com>
 <xmqqsgh47okk.fsf@gitster.c.googlers.com>
 <20200415162326.GG2464307@coredump.intra.peff.net>
 <20200415220242.GA45241@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200415220242.GA45241@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 15, 2020 at 04:02:42PM -0600, Taylor Blau wrote:

> Subject: [PATCH] diff-tree.c: load notes machinery with '--notes'
> 
> Since its introduction in 7249e91 (revision.c: support --notes
> command-line option, 2011-03-29), combining '--notes' with '--pretty'
> causes 'git diff-tree' to fail a runtime assertion:
> 
>   $ git rev-list HEAD | git diff-tree --stdin --pretty=medium --notes
>   commit 8f3d9f354286745c751374f5f1fcafee6b3f3136
>   git: notes.c:1308: format_display_notes: Assertion `display_notes_trees' failed.
>   Aborted
> 
> This failure is due to diff-tree not calling 'load_display_notes' to
> initialize the notes machinery.

Yes, I think that's the problem that I saw. And this definitely fixes
that case, but I think there's another related one.

  $ git notes add -m foo
  $ git log -1 --format='%h %N'
  94316974f7 foo
  $ git rev-list -1 HEAD | git diff-tree --stdin --format='%h %N' -s
  94316974f7e27dccc6b87f3946bce5d2fc252dc2 %N

This is true even with your patch. With your patch I can add --notes to
get the right output:

  $ git rev-list -1 HEAD | git diff-tree --stdin --format='%h %N' -s --notes
  94316974f7e27dccc6b87f3946bce5d2fc252dc2 foo

(It's also slightly curious that %h doesn't abbreviate in diff-tree; I
guess this is a side effect of the plumbing having no default abbrev
setting; it may be simplest to just live with it).

> @@ -126,6 +126,8 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
> 
>  	precompose_argv(argc, argv);
>  	argc = setup_revisions(argc, argv, opt, &s_r_opt);
> +	if (opt->show_notes)
> +		load_display_notes(&opt->notes_opt);

In git-log we have the equivalent of these new lines, but just before it
we check the userformat, too:

          memset(&w, 0, sizeof(w));
          userformat_find_requirements(NULL, &w);
  
          if (!rev->show_notes_given && (!rev->pretty_given || w.notes))
                  rev->show_notes = 1;
          if (rev->show_notes)
                  load_display_notes(&rev->notes_opt);

I think we'd want to do the same here. Even though it's plumbing, I
can't think of any reason why somebody would _not_ want notes to be
auto-enabled when they say "%N".

> Ordinarily, this failure isn't triggered, because it requires passing
> both '--notes' and '--pretty'. Specifically, passing '--pretty' sets
> 'opt->verbose_header', causing 'show_log()' to eventually call
> 'format_display_notes()', which expects a non-NULL 'display_note_trees'.
> Without initializing the notes machinery, 'display_note_trees' remains
> NULL, and thus triggers an assertion failure. This doesn't occur without
> '--pretty' since we never call 'format_display_notes()' without it.

It's not just --pretty, of course, but any option that causes us to
actually try to format notes (--format, --oneline, etc).

-Peff
