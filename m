Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2780A20A10
	for <e@80x24.org>; Sat, 30 Sep 2017 06:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751264AbdI3Gtw (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Sep 2017 02:49:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:55322 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750968AbdI3Gtv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2017 02:49:51 -0400
Received: (qmail 8554 invoked by uid 109); 30 Sep 2017 06:49:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 30 Sep 2017 06:49:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11381 invoked by uid 111); 30 Sep 2017 06:50:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 30 Sep 2017 02:50:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 30 Sep 2017 02:49:49 -0400
Date:   Sat, 30 Sep 2017 02:49:49 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 1/5] pretty.c: delimit "%(trailers)" arguments with ","
Message-ID: <20170930064949.23plbzjtw2qupj6b@sigill.intra.peff.net>
References: <20170930062238.87077-1-me@ttaylorr.com>
 <20170930062238.87077-2-me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170930062238.87077-2-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 29, 2017 at 11:22:34PM -0700, Taylor Blau wrote:

> In preparation for adding consistent "%(trailers)" atom options to
> `git-for-each-ref(1)`'s "--format" argument, change "%(trailers)" in pretty.c
> to separate sub-arguments with a ",", instead of a ":".
> 
> Multiple sub-arguments are given either as "%(trailers:unfold,only)" or
> "%(trailers:only,unfold)".
> 
> This change disambiguates between "top-level" arguments, and arguments given to
> the trailers atom itself. It is consistent with the behavior of "%(upstream)"
> and "%(push)" atoms.

Great. I hope we'll eventually unify the pretty.c and ref-filter.c
syntaxes and implementations, so consistency is good. I'm sure there
will be some hackery to keep backwards compatibility in all cases, but
the fewer the better.  The "every option gets its own colon" scheme was
just something I invented, because there was no prior art in pretty.c. I
didn't think to check for similar cases in ref-filter.c.

We should be safe to change this unconditionally, without worrying about
breaking compatibility. These options were added in 58311c66fd (pretty:
support normalization options for %(trailers), 2017-08-15), which hasn't
been in any released version yet.

> ---
>  pretty.c                      | 13 ++++++++-----
>  t/t4205-log-pretty-formats.sh |  4 ++--
>  2 files changed, 10 insertions(+), 7 deletions(-)

I think this needs an update to Documentation/pretty-formats.txt. Maybe:

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 6b4a12f028..40948d925b 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -199,11 +199,13 @@ endif::git-rev-list[]
   than given and there are spaces on its left, use those spaces
 - '%><(<N>)', '%><|(<N>)': similar to '% <(<N>)', '%<|(<N>)'
   respectively, but padding both sides (i.e. the text is centered)
-- %(trailers): display the trailers of the body as interpreted by
-  linkgit:git-interpret-trailers[1]. If the `:only` option is given,
-  omit non-trailer lines from the trailer block.  If the `:unfold`
-  option is given, behave as if interpret-trailer's `--unfold` option
-  was given. E.g., `%(trailers:only:unfold)` to do both.
+- %(trailers[:options]): display the trailers of the body as interpreted
+  by linkgit:git-interpret-trailers[1]. The `trailers` string may be
+  followed by a colon and zero or more comma-separated options. If the
+  `only` option is given, omit non-trailer lines from the trailer block.
+  If the `unfold` option is given, behave as if interpret-trailer's
+  `--unfold` option was given.  E.g., `%(trailers:only,unfold)` to do
+  both.
 
 NOTE: Some placeholders may depend on other options given to the
 revision traversal engine. For example, the `%g*` reflog options will

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index ec5f530102..977472f539 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -588,8 +588,8 @@ test_expect_success '%(trailers:unfold) unfolds trailers' '
 '
 
 test_expect_success ':only and :unfold work together' '
-	git log --no-walk --pretty="%(trailers:only:unfold)" >actual &&
-	git log --no-walk --pretty="%(trailers:unfold:only)" >reverse &&
+	git log --no-walk --pretty="%(trailers:only,unfold)" >actual &&
+	git log --no-walk --pretty="%(trailers:unfold,only)" >reverse &&
 	test_cmp actual reverse &&
 	{
 		grep -v patch.description <trailers | unfold &&

> diff --git a/pretty.c b/pretty.c
> index 0e23fe3c0..68f736912 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1265,11 +1265,14 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
>  
>  	if (skip_prefix(placeholder, "(trailers", &arg)) {
>  		struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
> -		while (*arg == ':') {
> -			if (skip_prefix(arg, ":only", &arg))
> -				opts.only_trailers = 1;
> -			else if (skip_prefix(arg, ":unfold", &arg))
> -				opts.unfold = 1;
> +		if (skip_prefix(arg, ":", &arg)) {
> +			while (*arg != ')') {
> +				skip_prefix(arg, ",", &arg);
> +				if (skip_prefix(arg, "only", &arg))
> +					opts.only_trailers = 1;
> +				else if (skip_prefix(arg, "unfold", &arg))
> +					opts.unfold = 1;
> +			}
>  		}

Do we always make forward progress with this loop condition?

If arg doesn't start with a close-paren, we'll keep looping. But if it's
not a comma or one of the option strings, then skip_prefix() won't move
the pointer forward. So I think "%(trailers:foo)" would loop forever.

The original would complain about that and even almost-right things like
"%(trailers:only-the-lonely", though it's pretty subtle. The atom
parsers in ref-filter.c use string_list_split() which is way more
readable and obvious. But I don't think we can do that here. ref-filter
has a separate parsing step, so it can afford to be slow. Here we're
parsing the pretty format individually for each commit in "git log", and
allocations would be noticeable.

Here's what I came up with:

  static int match_placeholder_arg(const char *to_parse,
  				 const char *candidate,
  				 const char **end)
  {
  	const char *p;
  	if (!skip_prefix(to_parse, candidate, &p))
  		return 0;
  	if (*p == ',') {
  		*end = p + 1;
  		return 1;
  	}
  	if (*p == ')') {
  		*end = p;
  		return 1;
  	}
  	return 0;
  }

  ...

  	if (skip_prefix(placeholder, "(trailers", &arg)) {
  		struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
  		if (*arg == ':') {
  			arg++;
  			for (;;) {
  				if (match_placeholder_arg(arg, "only", &arg))
  					opts.only_trailers = 1;
  				else if (match_placeholder_arg(arg, "unfold", &arg))
  					opts.unfold = 1;
  				else
  					break;
  			}
  		}
  		if (*arg == ')') {
  			format_trailers_from_commit(sb, msg + c->subject_off, &opts);
  			return arg - placeholder + 1;
  		}
  	}

I hate the "for (;;)", but at least it's easy to see that each iteration
either makes progress or breaks out of the loop.

-Peff
