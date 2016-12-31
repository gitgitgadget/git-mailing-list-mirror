Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38EF720C1D
	for <e@80x24.org>; Sat, 31 Dec 2016 06:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbcLaGLw (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Dec 2016 01:11:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:33468 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751264AbcLaGLv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2016 01:11:51 -0500
Received: (qmail 9127 invoked by uid 109); 31 Dec 2016 06:11:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 31 Dec 2016 06:11:51 +0000
Received: (qmail 2055 invoked by uid 111); 31 Dec 2016 06:12:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 31 Dec 2016 01:12:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 31 Dec 2016 01:11:46 -0500
Date:   Sat, 31 Dec 2016 01:11:46 -0500
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        David Turner <novalis@novalis.org>
Subject: Re: [PATCH v3 05/23] raceproof_create_file(): new function
Message-ID: <20161231061146.gxlbma6w7odho4c7@sigill.intra.peff.net>
References: <cover.1483153436.git.mhagger@alum.mit.edu>
 <f933f9d3c4c53b42ecc75b7a743ed4bfd390b4c5.1483153436.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f933f9d3c4c53b42ecc75b7a743ed4bfd390b4c5.1483153436.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 31, 2016 at 04:12:45AM +0100, Michael Haggerty wrote:

> Add a function that tries to create a file and any containing
> directories in a way that is robust against races with other processes
> that might be cleaning up empty directories at the same time.
> 
> The actual file creation is done by a callback function, which, if it
> fails, should set errno to EISDIR or ENOENT according to the convention
> of open(). raceproof_create_file() detects such failures, and
> respectively either tries to delete empty directories that might be in
> the way of the file or tries to create the containing directories. Then
> it retries the callback function.

This seems like a nice primitive, and the resulting change in patch 7 is
very pleasant.

At first I was surprised that the callback did not take the more usual
open(2) flags, which might make it easy to reuse a few basic callbacks.
But I see that in most cases the actual opening is deep inside a higher
level construct like the lockfile code, and anything beyond the "void *"
callback parameter that you have would make that really awkward.

> +/*
> + * Callback function for raceproof_create_file(). This function is
> + * expected to do something that makes dirname(path) permanent despite
> + * the fact that other processes might be cleaning up empty
> + * directories at the same time. Usually it will create a file named
> + * path, but alternatively it could create another file in that
> + * directory, or even chdir() into that directory. The function should
> + * return 0 if the action was completed successfully. On error, it
> + * should return a nonzero result and set errno.
> + * raceproof_create_file() treats two errno values specially:
> + *
> + * - ENOENT -- dirname(path) does not exist. In this case,
> + *             raceproof_create_file() tries creating dirname(path)
> + *             (and any parent directories, if necessary) and calls
> + *             the function again.
> + *
> + * - EISDIR -- the file already exists and is a directory. In this
> + *             case, raceproof_create_file() deletes the directory
> + *             (recursively) if it is empty and calls the function
> + *             again.

It took me a minute to figure out why EISDIR is recursive.

If we are trying to create "foo/bar/baz", we can only get EISDIR when
"baz" exists and is a directory. I at first took your recursive to me
that we delete it and "foo/bar" and "foo". Which is just silly and
counterproductive.

But presumably you mean that we delete "foo/bar/baz/xyzzy", etc, up to
"foo/bar/baz", provided they are all empty directories. I think your
comment is probably OK and I was just being thick, but maybe stating it
like:

  ...removes the directory if it is empty (and recursively any empty
  directories it contains) and calls the function again.

would be more clear. That is still leaving the definition of "empty"
implied, but it's hopefully obvious from the context.

> +int raceproof_create_file(const char *path, create_file_fn fn, void *cb)
> +{
> +	/*
> +	 * The number of times we will try to remove empty directories
> +	 * in the way of path. This is only 1 because if another
> +	 * process is racily creating directories that conflict with
> +	 * us, we don't want to fight against them.
> +	 */
> +	int remove_directories_remaining = 1;
> +
> +	/*
> +	 * The number of times that we will try to create the
> +	 * directories containing path. We are willing to attempt this
> +	 * more than once, because another process could be trying to
> +	 * clean up empty directories at the same time as we are
> +	 * trying to create them.
> +	 */
> +	int create_directories_remaining = 3;

We know that 3 is higher than 1, so we would not fight forever between
writing "foo" and "foo/bar". That made me wonder if we could fight with
other code. The obvious one would be try_remove_empty_parents() in
files-backend.c, but it makes only a single attempt at each directory.
So we should "win" against it short of weird cases (like somebody
running "git pack-refs --prune" in a tight loop).

> [...the actual function logic...]

Nice. This looks very straightforward.

-Peff
