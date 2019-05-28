Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 957DD1F462
	for <e@80x24.org>; Tue, 28 May 2019 01:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfE1Bvh (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 May 2019 21:51:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:39302 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727271AbfE1Bvh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 May 2019 21:51:37 -0400
Received: (qmail 20366 invoked by uid 109); 28 May 2019 01:51:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 May 2019 01:51:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9093 invoked by uid 111); 28 May 2019 01:52:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 27 May 2019 21:52:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 May 2019 21:51:33 -0400
Date:   Mon, 27 May 2019 21:51:33 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] bundle verify: error out if called without an object
 database
Message-ID: <20190528015133.GA29724@sigill.intra.peff.net>
References: <pull.226.git.gitgitgadget@gmail.com>
 <f0545e872344dd25e11db7fe095cde1578b26748.1558987152.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0545e872344dd25e11db7fe095cde1578b26748.1558987152.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 27, 2019 at 12:59:14PM -0700, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The deal with bundles is: they really are thin packs, with very little
> sugar on top. So we really need a repository (or more appropriately, an
> object database) to work with, when asked to verify a bundle.
> 
> Let's error out with a useful error message if `git bundle verify` is
> called without such an object database to work with.

I think this is going in the right direction, but I think there are a
few subtle bits worth thinking about.

As Gábor noted in the earlier thread, if the bundle doesn't have any
prerequisites, this _used_ to work before b1ef400eec (setup_git_env:
avoid blind fall-back to ".git", 2016-10-20). I don't know if anybody
cares about that case or not, but we could do something like:

  if (p->nr)
	verify_prerequisites();

  /* otherwise, fall through to the printing portions */

and then just check for a repository in verify_prerequisites(), which is
the only part that needs to look at the repository object at all.

If we _are_ OK just forbidding the operation entirely outside of a
repository, then should we be doing this check in cmd_bundle() instead?
We already have checks there for "create" and "unbundle".

Likewise:

> diff --git a/bundle.c b/bundle.c
> index b45666c49b..b5d21cd80f 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -142,6 +142,9 @@ int verify_bundle(struct repository *r,
>  	int i, ret = 0, req_nr;
>  	const char *message = _("Repository lacks these prerequisite commits:");
>  
> +	if (!r || !r->objects || !r->objects->odb)
> +		return error(_("need a repository to verify a bundle"));

Those other checks are done with startup_info->have_repository. I don't
think that makes sense here (we were passed in a repository object to
operate on, so the global might or might not match). Doing it at that
higher level means that other callers of verify_bundle() are not
protected, but I think may be OK. The top-level commands are generally
responsible for setting up the repository and bailing if the requested
operation does not make sense without one.

If we do want to leave the check at this level, I'm a little
uncomfortable with how intimate this check is with the parts of "struct
repository". For instance, who sets of r->objects and r->objects->odb,
and is it possible for us to have a working repo struct that has those
as NULL (i.e., where they could be lazily filled in)? Even if it works
now, it seems like a subtle thing that could easily be broken during
later refactoring.

Instead, could we have cmd_bundle() pass in NULL when instead of
the_repository when there's no repo? That seems like a much easier
pattern in general for low-level code to decide when it has no repo
available (though I suspect many code paths would have to be adjusted to
handle a NULL repository argument).

-Peff
