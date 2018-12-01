Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE731211B3
	for <e@80x24.org>; Sat,  1 Dec 2018 19:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725734AbeLBG5l (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Dec 2018 01:57:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:56218 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725731AbeLBG5l (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Dec 2018 01:57:41 -0500
Received: (qmail 21076 invoked by uid 109); 1 Dec 2018 19:44:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 01 Dec 2018 19:44:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1510 invoked by uid 111); 1 Dec 2018 19:43:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 01 Dec 2018 14:43:53 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Dec 2018 14:44:24 -0500
Date:   Sat, 1 Dec 2018 14:44:24 -0500
From:   Jeff King <peff@peff.net>
To:     Matthew DeVore <matvore@comcast.net>
Cc:     Matthew DeVore <matvore@google.com>, git@vger.kernel.org,
        gitster@pobox.com, pclouds@gmail.com, jonathantanmy@google.com,
        jeffhost@microsoft.com
Subject: Re: [RFC 2/2] exclude-promisor-objects: declare when option is
 allowed
Message-ID: <20181201194424.GB28918@sigill.intra.peff.net>
References: <cover.1540256910.git.matvore@google.com>
 <931421945c040ba4518d91f7af9f386d0136bd2f.1540256910.git.matvore@google.com>
 <20181121164019.GA24621@sigill.intra.peff.net>
 <19c82fb0-e0d6-0b15-06ab-cfba4d699d94@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <19c82fb0-e0d6-0b15-06ab-cfba4d699d94@comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 30, 2018 at 05:32:47PM -0800, Matthew DeVore wrote:

> > Speaking of which, would this flag work better as a field in
> > setup_revision_opt, which is passed to setup_revisions()? The intent
> > seem to be to influence how we parse command-line arguments, and that's
> > where other similar flags are (e.g., assume_dashdash).
> 
> Good idea. This would solve the problem of mistakenly believing the flag
> matters when it doesn't, since it is in the struct which is used as the
> arguments of the exact function that cares about it. Here's a new patch -
> I'm tweaking e-mail client settings so hopefully this makes it to the list
> without mangling - if not I'll resend it with `git-send-email` later.
> 
> From 941c89fe1e226ed4d210ce35d0d906526b8277ed Mon Sep 17 00:00:00 2001
> From: Matthew DeVore <matvore@google.com>
> Date: Fri, 30 Nov 2018 16:43:32 -0800
> Subject: [PATCH] revisions.c: put promisor option in specialized struct
> 
> Put the allow_exclude_promisor_objects flag in setup_revision_opt. When
> it was in rev_info, it was unclear when it was used, since rev_info is
> passed to functions that don't use the flag. This resulted in
> unnecessary setting of the flag in prune.c, so fix that as well.

Thanks, this looks pretty reasonable overall. Two comments:

>  	repo_init_revisions(the_repository, &revs, NULL);
>  	save_commit_buffer = 0;
> -	revs.allow_exclude_promisor_objects_opt = 1;
> -	setup_revisions(ac, av, &revs, NULL);
> +
> +	memset(&s_r_opt, 0, sizeof(s_r_opt));
> +	s_r_opt.allow_exclude_promisor_objects = 1;
> +	setup_revisions(ac, av, &revs, &s_r_opt);

I wonder if a static initializer for setup_revision_opt is worth it. It
would remove the need for this memset. Probably not a big deal either
way, though.

>  static int handle_revision_opt(struct rev_info *revs, int argc, const char
> **argv,
> -			       int *unkc, const char **unkv)
> +			       int *unkc, const char **unkv,
> +			       int allow_exclude_promisor_objects)

Why not pass in the whole setup_revision_opt struct? We don't need
anything else from it yet, but it seems like the point of that struct is
to pass around preferences like this.

-Peff
