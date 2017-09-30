Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E830E20A10
	for <e@80x24.org>; Sat, 30 Sep 2017 07:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752862AbdI3HVr (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Sep 2017 03:21:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:55352 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752414AbdI3HVq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2017 03:21:46 -0400
Received: (qmail 10004 invoked by uid 109); 30 Sep 2017 07:21:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 30 Sep 2017 07:21:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11463 invoked by uid 111); 30 Sep 2017 07:22:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 30 Sep 2017 03:22:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 30 Sep 2017 03:21:43 -0400
Date:   Sat, 30 Sep 2017 03:21:43 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 4/5] ref-filter.c: use trailer_opts to format trailers
Message-ID: <20170930072143.h4mbd5c4hskvcrl3@sigill.intra.peff.net>
References: <20170930062238.87077-1-me@ttaylorr.com>
 <20170930062238.87077-5-me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170930062238.87077-5-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 29, 2017 at 11:22:37PM -0700, Taylor Blau wrote:

> In preparation to support additional sub-arguments given to the "%(trailers)"
> atom, use 'format_trailers_from_commit' in order to format trailers in the
> desired manner.

This isn't just in preparation, is it? It looks like the options are
here (which I think is fine, but the commit message probably needs
updated).

> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  Documentation/git-for-each-ref.txt |  6 +++++-
>  ref-filter.c                       | 31 ++++++++++++++++++++---------
>  t/t6300-for-each-ref.sh            | 40 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 67 insertions(+), 10 deletions(-)

This patch didn't apply for me on top of the others. I get:

  Applying: ref-filter.c: use trailer_opts to format trailers
  error: patch failed: ref-filter.c:178
  error: ref-filter.c: patch does not apply
  Patch failed at 0004 ref-filter.c: use trailer_opts to format trailers

And then with "am -3":

  Applying: ref-filter.c: use trailer_opts to format trailers
  error: sha1 information is lacking or useless (ref-filter.c).
  error: could not build fake ancestor
  Patch failed at 0004 ref-filter.c: use trailer_opts to format trailers

Did it get corrupted in transit, or did you hand-edit it?

> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index 03e187a10..b7325a25d 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -213,7 +213,11 @@ line is 'contents:body', where body is all of the lines after the first
>  blank line.  The optional GPG signature is `contents:signature`.  The
>  first `N` lines of the message is obtained using `contents:lines=N`.
>  Additionally, the trailers as interpreted by linkgit:git-interpret-trailers[1]
> -are obtained as 'contents:trailers'.
> +are obtained as 'contents:trailers'. Non-trailer lines from the trailer block
> +can be omitted with 'trailers:only'. Whitespace-continuations can be removed
> +from trailers so that each trailer appears on a line by itself with its full
> +content with 'trailers:unfold'. Both can be used together as
> +'trailers:unfold,only'.

I know you copied the single-quote formatting from the existing line,
but this may be a good opportunity to switch to backticks, which is what
we usually prefer these days for literal phrases.

> diff --git a/ref-filter.c b/ref-filter.c
> index 84f14093c..8573acbed 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -178,9 +178,23 @@ static void subject_atom_parser(struct used_atom *atom, const char *arg)
>  
>  static void trailers_atom_parser(struct used_atom *atom, const char *arg)
>  {
> -	if (arg)
> -		die(_("%%(trailers) does not take arguments"));
> +	struct string_list params = STRING_LIST_INIT_DUP;
> +	int i;
> +
> +	if (arg) {
> +		string_list_split(&params, arg, ',', -1);
> +		for (i = 0; i < params.nr; i++) {
> +			const char *s = params.items[i].string;
> +			if (!strcmp(s, "unfold"))
> +				atom->u.contents.trailer_opts.unfold = 1;
> +			else if (!strcmp(s, "only"))
> +				atom->u.contents.trailer_opts.only_trailers = 1;
> +			else
> +				die(_("unknown %%(trailers) argument: %s"), s);
> +		}
> +	}
>  	atom->u.contents.option = C_TRAILERS;
> +	string_list_clear(&params, 0);
>  }

This looks good (and so much nicer than the contortions from pretty.c).
The error behavior matches what we currently do for %(align), which
makes sense.

The trailer_opts should be zero-initialized to start with due to us
calling memset on the whole used_atom struct.

>  static void contents_atom_parser(struct used_atom *atom, const char *arg)
> @@ -1035,7 +1049,7 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
>  			name++;
>  		if (strcmp(name, "subject") &&
>  		    strcmp(name, "body") &&
> -		    strcmp(name, "trailers") &&
> +		    !starts_with(name, "trailers") &&
>  		    !starts_with(name, "contents"))
>  			continue;
>  		if (!subpos)
> @@ -1060,13 +1074,12 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
>  			append_lines(&s, subpos, contents_end - subpos, atom->u.contents.nlines);
>  			v->s = strbuf_detach(&s, NULL);
>  		} else if (atom->u.contents.option == C_TRAILERS) {
> -			struct trailer_info info;
> +			struct strbuf s = STRBUF_INIT;
>  
> -			/* Search for trailer info */
> -			trailer_info_get(&info, subpos);
> -			v->s = xmemdupz(info.trailer_start,
> -					info.trailer_end - info.trailer_start);
> -			trailer_info_release(&info);
> +			/* Format the trailer info according to the trailer_opts given */
> +			format_trailers_from_commit(&s, subpos, &atom->u.contents.trailer_opts);
> +
> +			v->s = strbuf_detach(&s, NULL);

And this all looks straightforward and correct.

> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index 2a9fcf713..2bd0c5da7 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh

The tests are basically an adaptation of the ones from 58311c66fd
(pretty: support normalization options for %(trailers), 2017-08-15),
which make sense.

One thing I did notice:

> @@ -610,6 +613,43 @@ test_expect_success 'set up trailers for next test' '
>  	EOF
>  '
>  
> +test_expect_success '%(trailers:unfold) unfolds trailers' '
> +  git for-each-ref --format="%(trailers:unfold)" refs/heads/master >actual &&
> +  {
> +    unfold <trailers
> +    echo
> +  } >expect &&
> +  test_cmp expect actual
> +'

This looks like two-space indentation, when it should be a tab.

> +test_expect_success '%(trailers:only) shows only "key: value" trailers' '
> +	git for-each-ref --format="%(trailers:only)" refs/heads/master >actual &&
> +	{
> +		grep -v patch.description <trailers &&
> +		echo
> +	} >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '%(trailers:only) and %(trailers:unfold) work together' '
> +	git for-each-ref --format="%(trailers:only,unfold)" refs/heads/master >actual &&
> +	git for-each-ref --format="%(trailers:unfold,only)" refs/heads/master >reverse &&
> +	test_cmp actual reverse &&
> +	{
> +		grep -v patch.description <trailers | unfold &&
> +		echo
> +	} >expect &&
> +	test_cmp expect actual
> +'

These ones are tabs. GOod.


> +test_expect_success '%(trailers) rejects unknown trailers arguments' '
> +	cat >expect <<-EOF &&
> +	fatal: unknown %(trailers) argument: unsupported
> +	EOF
> +  test_must_fail git for-each-ref --format="%(trailers:unsupported)" 2>actual &&
> +  test_cmp expect actual
> +'

But this one is mixed. :)

-Peff
