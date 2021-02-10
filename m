Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55928C433E0
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 16:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 144F264E77
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 16:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhBJQQX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 11:16:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:56474 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229917AbhBJQQU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 11:16:20 -0500
Received: (qmail 32482 invoked by uid 109); 10 Feb 2021 16:15:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Feb 2021 16:15:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20725 invoked by uid 111); 10 Feb 2021 16:15:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Feb 2021 11:15:38 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 10 Feb 2021 11:15:37 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Bryan Turner <bturner@atlassian.com>, SURA <surak8806@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] mailmap: only look for .mailmap in work tree
Message-ID: <YCQGqeHB4rXi6dG0@coredump.intra.peff.net>
References: <CAD6AYr-BD08FcbnVfHpOUt7ZwFH0PgoATgyegKnBQ3GOe9isdA@mail.gmail.com>
 <YB148VZJqKIPC8P2@coredump.intra.peff.net>
 <CAGyf7-EB=J1j1LOUiUBHE+g-hA1WXUNy3F4y84rCRwzGc2zo_A@mail.gmail.com>
 <YCLGgpfkJzg5nP7v@coredump.intra.peff.net>
 <xmqqv9b1ylyj.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv9b1ylyj.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 09, 2021 at 01:23:32PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >   If the file `.mailmap` exists at the toplevel of the repository[...]
> >
> > which likewise reinforces the notion that we are looking in the working
> > tree.
> 
> > diff --git a/mailmap.c b/mailmap.c
> > index eb77c6e77c..9bb9cf8b30 100644
> > --- a/mailmap.c
> > +++ b/mailmap.c
> > @@ -225,7 +225,8 @@ int read_mailmap(struct string_list *map)
> >  	if (!git_mailmap_blob && is_bare_repository())
> >  		git_mailmap_blob = "HEAD:.mailmap";
> >  
> > -	err |= read_mailmap_file(map, ".mailmap");
> > +	if (!startup_info->have_repository || !is_bare_repository())
> > +		err |= read_mailmap_file(map, ".mailmap");
> 
> OK.  Do we know at this point that cwd is always/already at the root
> level of the working tree?

I think so. If we're in a non-bare repository, we'd have chdir'd during
the setup/discovery steps. At any rate, this patch could not possibly be
making such a situation _worse_, as we were previously reading it
unconditionally.

If you are proposing that this become:

  if (!startup_info->have_repository) {
	/* no repository (e.g., shortlog reading stdin); use map in cwd */
	err |= read_mailmap_file(map, ".mailmap");
  } else if (get_git_work_tree()) {
        /* we have a work tree; read from the top-level */
	char *map_file = xstrfmt("%s/.mailmap", get_git_work_tree());
	err |= read_mailmap_file(map, map_file);
	free(map_file);
  } else {
        /* bare; do not read filesystem .mailmap */
  }

I could buy that. I suspect it may even be necessary to use a mailmap in
an in-process submodule repository (in which case we should be taking a
"struct repository" argument and checking it in the first two branches
of the conditional). But this is orthogonal to what my patch is doing, I
think. And I'd rather punt on it until there is a known upside (probably
as part of a larger effort to allow mailmaps outside of the_repository).

-Peff
