Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 135611FA7B
	for <e@80x24.org>; Wed, 14 Jun 2017 06:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750828AbdFNGPv (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 02:15:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:39723 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750745AbdFNGPv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 02:15:51 -0400
Received: (qmail 1601 invoked by uid 109); 14 Jun 2017 06:15:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jun 2017 06:15:51 +0000
Received: (qmail 8644 invoked by uid 111); 14 Jun 2017 06:15:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jun 2017 02:15:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Jun 2017 02:15:48 -0400
Date:   Wed, 14 Jun 2017 02:15:48 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de,
        jrnieder@gmail.com
Subject: Re: [PATCH v2 5/6] setup: teach discover_git_directory to respect
 the commondir
Message-ID: <20170614061548.uqxtbmwizfdyivv7@sigill.intra.peff.net>
References: <20170612213406.83247-1-bmwill@google.com>
 <20170613210321.152978-1-bmwill@google.com>
 <20170613210321.152978-6-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170613210321.152978-6-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2017 at 02:03:20PM -0700, Brandon Williams wrote:

> Currently 'discover_git_directory' only looks at the gitdir to determine
> if a git directory was discovered.  This causes a problem in the event
> that the gitdir which was discovered was in fact a per-worktree git
> directory and not the common git directory.  This is because the
> repository config, which is checked to verify the repository's format,
> is stored in the commondir and not in the per-worktree gitdir.  Correct
> this behavior by checking the config stored in the commondir.
> 
> It will also be of use for callers to have access to the commondir, so
> lets also return that upon successfully discovering a git directory.

This makes sense, and I agree is the correct path forward for handling
the config code's needs.

> diff --git a/cache.h b/cache.h
> index fd45b8c55..a4176436d 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -530,7 +530,8 @@ extern void setup_work_tree(void);
>   * appended to gitdir. The return value is either NULL if no repository was
>   * found, or pointing to the path inside gitdir's buffer.
>   */
> -extern const char *discover_git_directory(struct strbuf *gitdir);
> +extern const char *discover_git_directory(struct strbuf *commondir,
> +					  struct strbuf *gitdir);

Does the docstring above the function need updating? What happens when
you are not in a worktree? Are both strbufs filled out with the same
value?

That's what I'd assume (and what it looks like looking at the code), but
it's probably worth being explicit.

We also return a pointer. I think this still points into the gitdir
strbuf. Which I guess is reasonable, though probably should be
documented.

Given that the callers only ever look at whether it's non-NULL, it
probably would be better to just return a true/false value. This might
be a good time to do that, because the function signature is changing
already (so if we switch to the usual "0 is success", a newly added call
won't silently do the wrong thing).

> @@ -983,6 +987,7 @@ const char *discover_git_directory(struct strbuf *gitdir)
>  		warning("ignoring git dir '%s': %s",
>  			gitdir->buf + gitdir_offset, err.buf);
>  		strbuf_release(&err);
> +		strbuf_setlen(commondir, commondir_offset);
>  		return NULL;
>  	}

I'd have expected these resetting setlens to be paired between gitdir
and commondir. And indeed, they should be; this is the same case that
Dscho fixed in the first patch of his series.

I kind of wonder if one of you should take ownership and do a combined
series.

-Peff
