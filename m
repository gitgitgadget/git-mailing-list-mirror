Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7E1D1F803
	for <e@80x24.org>; Wed,  9 Jan 2019 19:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbfAITyb (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 14:54:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:59650 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727123AbfAITya (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 14:54:30 -0500
Received: (qmail 26575 invoked by uid 109); 9 Jan 2019 19:54:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Jan 2019 19:54:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25076 invoked by uid 111); 9 Jan 2019 19:54:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 09 Jan 2019 14:54:29 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Jan 2019 14:54:28 -0500
Date:   Wed, 9 Jan 2019 14:54:28 -0500
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio Hamano C <gitster@pobox.com>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: Make "git log --count" work like "git rev-list"
Message-ID: <20190109195428.GA12645@sigill.intra.peff.net>
References: <CAHk-=wg0NUNFjZumgC-9f=kmU3L4T+qOAgXwiDAfPaNtuFfvFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wg0NUNFjZumgC-9f=kmU3L4T+qOAgXwiDAfPaNtuFfvFg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 05, 2019 at 02:46:37PM -0800, Linus Torvalds wrote:

> "git log" is really the human-facing useful command that long long ago
> used to scripted around "git rev-list".
> 
> In fact, if you want to use the old scripting code, you can still
> approximate "git log" with something like
> 
>    git rev-list --pretty HEAD | less
> 
> but you'd be silly to do that, since "git log" is clearly a much nicer
> interface and is what people should use.
> 
> Except I find myself still occasionally using "git rev-list" simply
> because "git log" doesn't do one odd little quirk: commit counting.

I suspect it's more than that one little quirk. E.g., "git log" does not
do anything useful with "--objects" or "--use-bitmap-index", and perhaps
some others. I'm not at all opposed to bringing the feature-sets more
inline (where it makes sense -- I'm not sure what "log --objects" would
do), but I hope that we can generally do so by pushing features into
revision.c, and not just re-implementing them.

The counting part may have to be specific to each command, since it
depends on the loop around get_revision(). But I wonder if we can push
the logic into a helper function (and ditto for the printing code).

> So if you want to count the number of non-merge commits since the last
> kernel version, you'd have to do something like
> 
>    git rev-list --count --no-merges v4.20..
> 
> because while "git log" actually silently _accepts_ the "--count"
> argument, it doesn't do anything about it.

Yeah, silently ignoring "--count" is just awful. I agree we should make
it do the sensible thing here. For something like "log --objects", we
should probably flag an error.

> diff --git a/builtin/log.c b/builtin/log.c
> index e8e51068bd..62bef62f8a 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -411,6 +411,17 @@ static int cmd_log_walk(struct rev_info *rev)
>  	if (close_file)
>  		fclose(rev->diffopt.file);
>  
> +	if (rev->count) {
> +		if (rev->left_right && rev->cherry_mark)
> +			printf("%d\t%d\t%d\n", rev->count_left, rev->count_right, rev->count_same);
> +		else if (rev->left_right)
> +			printf("%d\t%d\n", rev->count_left, rev->count_right);
> +		else if (rev->cherry_mark)
> +			printf("%d\t%d\n", rev->count_left + rev->count_right, rev->count_same);
> +		else
> +			printf("%d\n", rev->count_left + rev->count_right);
> +	}

OK, this makes sense, and is lifted from rev-list.

> diff --git a/log-tree.c b/log-tree.c
> index 10680c139e..49ff485320 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -913,6 +913,16 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
>  	struct log_info log;
>  	int shown, close_file = opt->diffopt.close_file;
>  
> +	if (opt->count) {
> +		if (commit->object.flags & PATCHSAME)
> +			opt->count_same++;
> +		else if (commit->object.flags & SYMMETRIC_LEFT)
> +			opt->count_left++;
> +		else
> +			opt->count_right++;
> +		return 1;
> +	}

And the logic here make sense, but I wonder if this is the best place to
put it.

We call log_tree_commit() from lots of places besides git-log, but
presumably none of would set opt->count recreationally, so that's
probably not a big deal.

But does this catch all of the limiting that git-log would do? I notice
that it happens before the call to log_tree_diff(), which conditionally
returns a "shown" flag. So you get weird results with some options. For
example:

  # works, because pathspec limiting happens early
  git log --count builtin/log.c

  # doesn't work, because --follow disables pruning
  git log --follow --count builtin/log.c

I know "--follow" is a bit hacky in general, but I think there are other
cases where log_tree_diff() may decide not to show a commit (maybe
without --root, though I guess that's the default these days).

Unfortunately I'm not sure of an easy fix. We'd have to tell the log
code "figure out if you're going to show the commit, but don't actually
show anything", which means respecting the count flag virtually
everywhere that would produce output.

I dunno. Certainly respecting "--count" even for the simple cases is an
improvement over the status quo. Maybe it would be enough to give a
warning in the manpage that it may not work with exotic options.

-Peff
