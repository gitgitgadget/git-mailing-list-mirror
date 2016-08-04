Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78D4920226
	for <e@80x24.org>; Thu,  4 Aug 2016 07:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757131AbcHDH4p (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 03:56:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:54633 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756726AbcHDH4o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 03:56:44 -0400
Received: (qmail 13209 invoked by uid 102); 4 Aug 2016 07:56:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Aug 2016 03:56:37 -0400
Received: (qmail 10838 invoked by uid 107); 4 Aug 2016 07:57:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Aug 2016 03:57:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Aug 2016 03:56:32 -0400
Date:	Thu, 4 Aug 2016 03:56:32 -0400
From:	Jeff King <peff@peff.net>
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 8/8] diff: improve positioning of add/delete blocks in
 diffs
Message-ID: <20160804075631.jakbi5dbsbxsqcpr@sigill.intra.peff.net>
References: <cover.1470259583.git.mhagger@alum.mit.edu>
 <7b0680ed7a10fc13acd8d7816a75ed05a5f9e28c.1470259583.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7b0680ed7a10fc13acd8d7816a75ed05a5f9e28c.1470259583.git.mhagger@alum.mit.edu>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 04, 2016 at 12:00:36AM +0200, Michael Haggerty wrote:

> This table shows the number of diff slider groups that were positioned
> differently than the human-generated values, for various repositories.
> "default" is the default "git diff" algorithm. "compaction" is Git 2.9.0
> with the `--compaction-heuristic` option "indent" is an earlier,

s/option/&./

>  static int diff_detect_rename_default;
> +static int diff_indent_heuristic; /* experimental */
>  static int diff_compaction_heuristic; /* experimental */

These two flags are mutually exclusive in the xdiff code, so we should
probably handle that here.

TBH, I do not care that much what:

  [diff]
  compactionHeuristic = true
  indentHeuristic = true

does. But right now:

  git config diff.compactionHeuristic true
  git show --indent-heuristic

still prefers the compaction heuristic, which I think is objectively
wrong.

So perhaps we need a single variable:

  enum {
    DIFF_HEURISTIC_COMPACTION,
    DIFF_HEURISTIC_INDENT
  } diff_heuristic;

and set it in last-one-wins fashion (it would be nice if the config and
command line options were shaped the same way so it's clear to the user
that they are exclusive, but we may have to keep --compaction-heuristic
around for compatibility, as an alias for --diff-heuristic=compaction).

> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index 642cce1..ee3d812 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -45,6 +45,7 @@ my ($diff_new_color) =
>  my $normal_color = $repo->get_color("", "reset");
>  
>  my $diff_algorithm = $repo->config('diff.algorithm');
> +my $diff_indent_heuristic = $repo->config_bool('diff.indentheuristic');
>  my $diff_compaction_heuristic = $repo->config_bool('diff.compactionheuristic');

Nice touch.

Unfortunately the mutual-exclusivity handling will probably bleed over
to here, too.

> +/*
> + * If a line is indented more than this, get_indent() just returns this value.
> + * This avoids having to do absurd amounts of work for data that are not
> + * human-readable text, and also ensures that the output of get_indent fits within
> + * an int.
> + */
> +#define MAX_INDENT 200

Speaking of absurd amounts of work, I was curious if there was a
noticeable performance penalty for using this heuristic (just because
it's a lot more complicated than the others). I couldn't detect any
differences running "git log -p --no-merges -3000" on git.git with no
heuristic, compaction, and indent. There may be other repositories that
behave more pathologically (it looks like having 20 blank lines at the
end of each hunk?), but I'd guess in most cases this will always be
drowned out in the noise of doing the actual diff.

> +#define START_OF_FILE_BONUS 9
> +#define END_OF_FILE_BONUS 46
> +#define TOTAL_BLANK_WEIGHT 4
> +#define PRE_BLANK_WEIGHT 16
> +#define RELATIVE_INDENT_BONUS -1
> +#define RELATIVE_INDENT_HAS_BLANK_BONUS 15
> +#define RELATIVE_OUTDENT_BONUS -19
> +#define RELATIVE_OUTDENT_HAS_BLANK_BONUS 2
> +#define RELATIVE_DEDENT_BONUS -63
> +#define RELATIVE_DEDENT_HAS_BLANK_BONUS 50

I see there is a comment below here mentioning that these are empirical
voodoo, but it might be worth one at the top (or just moving these below
the comment) because the comment looks like it's just associated with
the function (and these are sufficiently bizarre that anybody reading is
going to double-take on them).

> +        return 10 * score - bonus;

I don't mind this not "10" not being a #define constant, but after
reading the exchange between you and Stefan, I think it would be nice to
describe what it is in a comment. The rest of the function is commented
so nicely that this one left me thinking "huh?" upon seeing the "10".

The rest looks sane to me, though I am not sure I have absorbed all the
implications. IMHO the most interesting thing is the actual results,
though.

-Peff
