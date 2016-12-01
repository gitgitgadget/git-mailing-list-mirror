Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D22C31FF40
	for <e@80x24.org>; Thu,  1 Dec 2016 04:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755894AbcLAE3a (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 23:29:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:49547 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753591AbcLAE3a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 23:29:30 -0500
Received: (qmail 16086 invoked by uid 109); 1 Dec 2016 04:29:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 04:29:29 +0000
Received: (qmail 29071 invoked by uid 111); 1 Dec 2016 04:30:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Nov 2016 23:30:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Nov 2016 23:29:27 -0500
Date:   Wed, 30 Nov 2016 23:29:27 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jonathantanmy@google.com,
        gitster@pobox.com
Subject: Re: [PATCH v6 1/6] submodules: add helper functions to determine
 presence of submodules
Message-ID: <20161201042926.mr2qdta7hviizcya@sigill.intra.peff.net>
References: <1479840397-68264-1-git-send-email-bmwill@google.com>
 <1480555714-186183-1-git-send-email-bmwill@google.com>
 <1480555714-186183-2-git-send-email-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1480555714-186183-2-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 30, 2016 at 05:28:29PM -0800, Brandon Williams wrote:

> +/*
> + * Determine if a submodule has been populated at a given 'path'
> + */
> +int is_submodule_populated(const char *path)
> +{
> +	int ret = 0;
> +	struct stat st;
> +	char *gitdir = xstrfmt("%s/.git", path);
> +
> +	if (!stat(gitdir, &st))
> +		ret = 1;
> +
> +	free(gitdir);
> +	return ret;
> +}

I don't know if it's worth changing or not, but this could be a bit
shorter:

  int is_submodule_populated(const char *path)
  {
	return !access(mkpath("%s/.git", path), F_OK);
  }

There is a file_exists() helper, but it uses lstat(), which I think you
don't want (because you'd prefer to bail on a broken .git symlink). But
access(F_OK) does what you want, I think.

mkpath() is generally an unsafe function because it uses a static
buffer, but it's handy and safe for handing values to syscalls like
this.

I say "I don't know if it's worth it" because what you've written is
fine, and while more lines, it's fairly obvious and safe.

-Peff
