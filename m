Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA458C433DF
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 12:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 986E62071A
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 12:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgFPMgB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:36:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:33000 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgFPMgA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 08:36:00 -0400
Received: (qmail 21473 invoked by uid 109); 16 Jun 2020 12:36:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Jun 2020 12:36:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12719 invoked by uid 111); 16 Jun 2020 12:35:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Jun 2020 08:35:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Jun 2020 08:35:59 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        sandals@crustytoothpaste.net,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/9] remote: respect `core.defaultBranchName`
Message-ID: <20200616123559.GB666057@coredump.intra.peff.net>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
 <06a2cea051c01ebee38c9910425171f112daf41a.1591823971.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <06a2cea051c01ebee38c9910425171f112daf41a.1591823971.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 10, 2020 at 09:19:23PM +0000, Johannes Schindelin via GitGitGadget wrote:

> @@ -2099,7 +2100,10 @@ struct ref *guess_remote_head(const struct ref *head,
>  
>  	/* If refs/heads/master could be right, it is. */
>  	if (!all) {
> -		r = find_ref_by_name(refs, "refs/heads/master");
> +		char *name = git_default_branch_name(0);
> +
> +		r = find_ref_by_name(refs, name);
> +		free(name);
>  		if (r && oideq(&r->old_oid, &head->old_oid))
>  			return copy_ref(r);
>  	}

You'd perhaps want to update the comment above, too.

However, I think we should be a bit more lenient on the "reading" side
default names. Just because "foo" is _my_ default branch name, does not
mean it is the default on the remote side. We cannot know what the other
side's default preference is, but in a world where we have 15 years of
repos that may have been created with "master", it is probably still a
good guess.

I.e., I think this probably ought to check the preferred name, and then
fall back to the existing behavior, like:

  if (!all) {
	  char *name;

          /* try the user's preferred default branch name */
	  name = git_default_branch_name(0);
	  r = find_ref_by_name(refs, name);
	  free(name);
	  if (r && oideq(&r->old_oid, &head->old_oid))
	          return copy_ref(r);

	  /* otherwise, try "master", which is the historical default */
	  r = find_ref_by_name(refs, "refs/heads/master");
	  if (r && oideq(&r->old_oid, &head->old_oid))
	          return copy_ref(r);
  }

That will help minimize fallout when git_default_branch_name() changes,
either by user config or if we switch the baked-in default. In the
latter case, we might also consider hard-coding that as a guess between
the user's preferred name and the historical "master".

Hopefully this would not matter _too_ much either way, as most servers
would support the symref extension these days. But I still think we
should do our best to minimize spots where the user may see a
regression.

-Peff
