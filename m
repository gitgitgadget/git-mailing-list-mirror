Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1345A1F576
	for <e@80x24.org>; Thu,  8 Feb 2018 10:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751055AbeBHKeE (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 05:34:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:44888 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750882AbeBHKeD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 05:34:03 -0500
Received: (qmail 7867 invoked by uid 109); 8 Feb 2018 10:33:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 08 Feb 2018 10:33:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7557 invoked by uid 111); 8 Feb 2018 10:34:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 08 Feb 2018 05:34:41 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Feb 2018 05:33:56 -0500
Date:   Thu, 8 Feb 2018 05:33:56 -0500
From:   Jeff King <peff@peff.net>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com, bmwill@google.com,
        avarab@gmail.com
Subject: Re: [PATCH v1] dir.c: don't flag the index as dirty for changes to
 the untracked cache
Message-ID: <20180208103356.GA30524@sigill.intra.peff.net>
References: <20180205195619.31064-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180205195619.31064-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 05, 2018 at 02:56:19PM -0500, Ben Peart wrote:

> diff --git a/dir.c b/dir.c
> index 7c4b45e30e..da93374f0c 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -2297,7 +2297,8 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
>  				 dir->untracked->gitignore_invalidated,
>  				 dir->untracked->dir_invalidated,
>  				 dir->untracked->dir_opened);
> -		if (dir->untracked == istate->untracked &&
> +		if (getenv("GIT_TEST_UNTRACKED_CACHE") &&

A minor nit, but please use something like:

  if (git_env_bool("GIT_TEST_UNTRACKED_CACHE", 0) && ...

so that:

  GIT_TEST_UNTRACKED_CACHE=false

does what one might expect, and not the opposite.

Two other thoughts:

  - it may be worth memo-izing it with a static variable to avoid
    repeatedly calling the possibly-slow getenv()

  - I agree with the sentiment elsewhere that something like
    GIT_FORCE_UNTRACKED_CACHE is probably a better name

(The idea itself seems sound to me, but it's not really my area).

-Peff
