Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 212E620188
	for <e@80x24.org>; Fri, 12 May 2017 08:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756960AbdELIw7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 04:52:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:50206 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755879AbdELIw4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 04:52:56 -0400
Received: (qmail 2370 invoked by uid 109); 12 May 2017 08:52:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 May 2017 08:52:55 +0000
Received: (qmail 22305 invoked by uid 111); 12 May 2017 08:53:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 May 2017 04:53:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 May 2017 04:52:53 -0400
Date:   Fri, 12 May 2017 04:52:53 -0400
From:   Jeff King <peff@peff.net>
To:     Brian Malehorn <bmalehorn@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] commit.c: skip scissors when computing trailers
Message-ID: <20170512085253.p3oohlbu2utco2tk@sigill.intra.peff.net>
References: <20170512050347.30765-1-bmalehorn@gmail.com>
 <20170512050347.30765-4-bmalehorn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170512050347.30765-4-bmalehorn@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 10:03:47PM -0700, Brian Malehorn wrote:

> "scissors" ("----- >8 -----") can be automatically added to commit
> messages by setting commit.verbose = true. Prevent this from interfering
> with trailer calculations by automatically skipping over scissors,
> instead of (usually) treating them as a comment.

What's the sequence of commands where you end up with a scissors line in
your "commit -v" output and it gets fed to interpret-trailers? Is it
when you run interpret-trailers from a commit-msg hook? Or do we invoke
it as part of "commit -v" itself?

I ask because I think we can probably come up with a more realistic
test, which may impact what the solution looks like (see below).
Grepping for ignore_non_trailer(), it looks like the issue may be the
append_signoff() call in builtin/commit.c? I couldn't get "git commit -s
-v" to fail, though (it handles the signoff with the verbose bits
removed).

> diff --git a/commit.c b/commit.c
> index 041cfa5a9..9a7b41d09 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1701,10 +1701,10 @@ int is_scissors_line(const char *line)
>  /*
>   * Inspect the given string and determine the true "end" of the log message, in
>   * order to find where to put a new Signed-off-by: line.  Ignored are
> - * trailing comment lines and blank lines, and also the traditional
> - * "Conflicts:" block that is not commented out, so that we can use
> - * "git commit -s --amend" on an existing commit that forgot to remove
> - * it.
> + * trailing comment lines and blank lines.  To support "git commit -s
> + * --amend" on an existing commit, we also ignore "Conflicts:".  To
> + * support "git commit -v", we truncate at "---- >8 ----" and similar
> + * scissors lines.
>   *
>   * Returns the number of bytes from the tail to ignore, to be fed as
>   * the second parameter to append_signoff().
> @@ -1723,6 +1723,11 @@ int ignore_non_trailer(const char *buf, size_t len)
>  		else
>  			next_line++;
>  
> +		if (is_scissors_line(&buf[bol])) {
> +			if (!boc)
> +				boc = bol;
> +			break;
> +		}

This unconditionally ignores scissors lines. But that means if you have
any inside your commit message, we may quietly corrupt the commit
message. It would be better to remove the scissors lines only when we
know that we've added them.

And that's part of my question above. If this is a call happening inside
builtin/commit.c, then we definitely know when we've added scissors. But
if it's interpret-trailers being run by a hook, passing the information
down to this function is a little tricky.

Maybe I'm being overly picky. We already do a lot of gross heuristic
stuff here like skipping comments and old-style Conflicts blocks (that
we don't even generate anymore!).

-Peff
