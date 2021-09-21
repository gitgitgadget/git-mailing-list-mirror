Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63204C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 01:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 340F461050
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 01:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhIUB1i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 21:27:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:51332 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229829AbhIUBZh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 21:25:37 -0400
Received: (qmail 2881 invoked by uid 109); 21 Sep 2021 01:24:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Sep 2021 01:24:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25964 invoked by uid 111); 21 Sep 2021 01:24:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 20 Sep 2021 21:24:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 20 Sep 2021 21:24:08 -0400
From:   Jeff King <peff@peff.net>
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 2/2] pretty: colorize pattern matches in commit
 messages
Message-ID: <YUk0OEXg36QXrkDm@coredump.intra.peff.net>
References: <20210921003050.641393-1-someguy@effective-light.com>
 <20210921003050.641393-2-someguy@effective-light.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210921003050.641393-2-someguy@effective-light.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 20, 2021 at 08:30:50PM -0400, Hamza Mahfooz wrote:

> Teach the pretty-printer code to highlight matches from the
> "--grep=<pattern>", "--author=<pattern>" and "--committer=<pattern>"
> options (to view the last one, you may have to ask for --pretty=fuller).
> 
> Also, it must be noted that we are effectively greping the content twice,
> however it only slows down "git log --author=^H" on this repository by
> around 1-2% (compared to v2.33.0), so it should be a small enough slow
> down to justify the addition of the feature.

This might or might not be related, but one thing I noticed is that your
earlier patch causes us to grep a lot more lines than we mean to (even
if we are looking for "author" lines, it greps every header line). That
might contribute to the slowdown. Likewise, it calls strip_timestamp()
on every line, even if it does not start with "author").

> +static inline void strbuf_add_with_color(struct strbuf *sb, const char *color,
> +					 char *buf, size_t buflen)
> +{
> +	strbuf_addstr(sb, color);
> +	strbuf_add(sb, buf, buflen);
> +	if (*color)
> +		strbuf_addstr(sb, GIT_COLOR_RESET);
> +}

You could take "buf" as a "const char *" here. That doesn't matter too
much for now, but see below.

> +static void append_line_with_color(struct strbuf *sb, struct grep_opt *opt,
> +				   const char *line, size_t linelen,
> +				   int color, enum grep_context ctx,
> +				   enum grep_header_field field)
> +{
> +	char *buf, *eol;
> +	const char *line_color, *match_color;
> +	regmatch_t match;
> +	int eflags = 0;
> +
> +	if (!opt || !want_color(color) || opt->invert) {
> +		strbuf_add(sb, line, linelen);
> +		return;
> +	}
> +
> +	buf = (char *)line;
> +	eol = buf + linelen;

OK, so we got rid of the copy of "line", which is nice. But we are
casting away const-ness, which is a potential red flag (is somebody
going to modify this string, even though we promised our caller we would
not?). We'd probably want a comment to explain why we are doing so, and
why it is OK (e.g., if somebody in the call stack modifies it
temporarily).

More on this in a moment.

> +	while (grep_next_match(opt, buf, eol, ctx, &match, field, eflags)) {
> +		if (match.rm_so == match.rm_eo)
> +			break;
> +
> +		strbuf_grow(sb, strlen(line_color) + strlen(match_color) +
> +			    (2 * strlen(GIT_COLOR_RESET)));
> +		strbuf_add_with_color(sb, line_color, buf, match.rm_so);
> +		strbuf_add_with_color(sb, match_color, buf + match.rm_so,
> +				      match.rm_eo - match.rm_so);

As Eric mentioned, these strbuf_grow() calls can go away. The whole
point of strbuf is that we do not have to clutter the code with manual
size computations, because it will do the right thing automatically.

Sometimes you can get extra performance by pre-sizing the strbuf, but:

  1. I'd be surprised if we did in this case. We're writing into a
     strbuf that will receive the whole per-commit output, so any growth
     cost due to a couple of short strings here would be amortized
     anyway.

  2. The computation here doesn't represent the needed growth anyway.
     When we call strbuf_add_with_color(), it's going to add not just
     the colors but all of the data for the line itself.

So at best it's doing nothing, and at worst it is making the code harder
to understand.

> +	if (eflags) {
> +		strbuf_grow(sb, strlen(line_color) + strlen(GIT_COLOR_RESET));
> +		strbuf_add_with_color(sb, line_color, buf, eol - buf);
> +	} else
> +		strbuf_add(sb, buf, eol - buf);
> +}

Ditto here (we grow for the colors, but also end up adding "eol - buf"
bytes).

-Peff
