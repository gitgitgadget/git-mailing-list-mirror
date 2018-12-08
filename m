Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17C0520A1E
	for <e@80x24.org>; Sat,  8 Dec 2018 07:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbeLHHQh (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 02:16:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:34672 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726084AbeLHHQg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 02:16:36 -0500
Received: (qmail 14095 invoked by uid 109); 8 Dec 2018 07:16:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 08 Dec 2018 07:16:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5570 invoked by uid 111); 8 Dec 2018 07:16:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 08 Dec 2018 02:16:05 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Dec 2018 02:16:34 -0500
Date:   Sat, 8 Dec 2018 02:16:34 -0500
From:   Jeff King <peff@peff.net>
To:     George King <george.w.king@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Difficulty with parsing colorized diff output
Message-ID: <20181208071634.GA18272@sigill.intra.peff.net>
References: <799879BD-A2F0-487C-AA05-8054AC62C5BD@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <799879BD-A2F0-487C-AA05-8054AC62C5BD@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 07, 2018 at 07:09:58PM -0500, George King wrote:

> My goal is to detect SGR color sequences, e.g. '\x1b[32m', that exist
> in the source text, and have my highlighter print escaped
> representations of those. For example, I have checked in files that
> are expected test outputs for tools that emit color codes, and diffs
> of those get very confusing.
> 
> Figuring out which color codes are from the source text and which were
> added by git is proving very difficult. The obvious solution is to
> turn git diff coloring off, but as far as I can see this also turns
> off all coloring for logs, which is undesirable.

Another gotcha that I don't think you've hit yet: whitespace
highlighting can color arbitrary parts of the line.

Try this, for example:

  printf 'foo\n' >old
  printf '\t \tfoo\n' >new
  git diff --no-index old new

So I'm not sure what you want to do can ever be completely robust. That
said, I'm not opposed to making Git's color output more regular. It
seems like a reasonable cleanup on its own.

(For the Git project itself, we long ago realized that putting raw color
codes into the source is a big pain when working with diffs, and we
instead use tools like t/test-lib-functions.sh's test_decode_color).

> * Context lines do not begin with reset code, but do end with a reset
> code. It would be preferable in my opinion if they had both (like
> every other line), or none at all.

Context lines do have both. It's just that the default color for context
lines is empty. ;)

But yes, I think it might be reasonable to recognize when an opening
color is empty, and turn the closing reset into a noop in that case (or
I guess you are also advocating the opposite: turn an empty color into a
noop \x1b[m or similar).

I think most of the coloring, including context lines, is coming from
diff.c:emit_diff_symbol_from_struct(). Instead of unconditionally
calling:

  context = diff_get_color_opt(o, DIFF_CONTEXT);
  reset = diff_get_color_opt(o, DIFF_RESET);

I suspect we could have a helper like this:

  static const char *diff_get_reset(const char *color)
  {
	if (!color || !*color)
		return "";
	return diff_colors[DIFF_RESET];
  }
  ...
  context = diff_get_color_opt(o, DIFF_CONTEXT);
  reset = diff_get_reset(context);

> * Added lines have excess codes after the plus sign. The entire prefix
> is, `\x1b[32m+\x1b[m\x1b[32m` translating to GREEN PLUS RESET GREEN.
> Emitting codes after the plus sign makes the parsing more complex and
> idiosyncratic.

Yeah, I've run into this one, too (when working on diff-highlight, which
similarly tries to pass-through Git's existing colors).

It's unfortunately not quite trivial, due to some interactions with
whitespace coloring. See this old patch:

  https://public-inbox.org/git/20101109220136.GA5617@sigill.intra.peff.net/

and the followup:

  https://public-inbox.org/git/20101118064050.GA12825@sigill.intra.peff.net/

> * Add a config feature to turn on log coloring while leaving diff coloring off.

Yes, the fact that --pretty log coloring is tied to diffs is mostly a
historical artifact. I think it would be OK to introduce a color.log
config option that defaults to the value of color.diff if unset. That
would be backwards compatible, but allow you to set them independently
if you wanted to.

-Peff
