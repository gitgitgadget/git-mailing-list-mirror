Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931E9C433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 21:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EB34611C8
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 21:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346685AbhIXVIq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 17:08:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:54896 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233217AbhIXVIk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 17:08:40 -0400
Received: (qmail 19543 invoked by uid 109); 24 Sep 2021 21:07:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Sep 2021 21:07:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13453 invoked by uid 111); 24 Sep 2021 21:07:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Sep 2021 17:07:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Sep 2021 17:07:05 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        The Grey Wolf <greywolf@starwolf.com>,
        "Randall S . Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH] config: add an includeIf.env{Exists,Bool,Is,Match}
Message-ID: <YU49+Y+nRhl1mgof@coredump.intra.peff.net>
References: <YUzvhLUmvsdF5w+r@coredump.intra.peff.net>
 <patch-1.1-1fe6f60d2bf-20210924T005553Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-1fe6f60d2bf-20210924T005553Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 24, 2021 at 02:58:04AM +0200, Ævar Arnfjörð Bjarmason wrote:

> Add an "includeIf" directive that's conditional on the value of an
> environment variable. This has been suggested at least a couple of
> times[1][2] as a proposed mechanism to drive dynamic includes, and to
> e.g. match based on TERM=xterm in the user's environment.

Thanks. I think this is a reasonable thing to have (not surprising,
since both of those suggestion references point to me!), and it's not
much of a burden to carry, even if it isn't all that commonly used.

I probably would have started with a smaller set of variants (just
equality, with a missing variable presented as an empty string). But I
don't think the bool/glob/exists variants are a lot of extra code or
complexity.

> I initially tried to implement just an "env" keyword, but found that
> splitting them up was both easier to implement and to explain to
> users. I.e. an "env" will need to handle an optional "=" for matching
> the value, and should the semantics be if the variable exists? If it's
> boolean?
> 
> By splitting them up we present a less ambiguous interface to users,
> and make it easy to extend this in the future. I didn't see any point
> in implementing a "/i" variant, that only makes sense for "gitdir"'s
> matching of FS paths.

I had thought to extend with the operator, like:

  # equality
  [includeIf "env:FOO==value"]
  # regex
  [includeIf "env:FOO=~v[a]l"]

But as you note, "=" is somewhat problematic, and without that we can't
use the "usual" operators. Plus there's no usual operator for globbing. ;)
So embedding it in the name is fine by me (and mostly a bikeshed thing
anyway).

I agree we don't really need a "/i" variant here.

> I would like syntax that used a "=" better, i.e. "envIs:TERM=xterm"
> instead of the "envIs:TERM:xterm" implemented here, but the problem
> with that is that it isn't possible to specify those sorts of config
> keys on the command-line:
> 
>     $ git -c includeIf.someVerb:FOO:BAR.path=bar status --short
>     $ git -c includeIf.someVerb:FOO=BAR.path=bar status --short
>     error: invalid key: includeIf.someVerb:FOO
>     fatal: unable to parse command-line config
>     $

Yeah, it's annoying that it doesn't work, and it's nice to think about
that when designing the syntax. OTOH, I kind of wonder how often folks
would write such a thing anyway. For one-offs like this, you'd just do
an unconditional include (or set the actual variables you care about)
anyway. This kind of conditional stuff is much more likely to appear in
an actual file.

Plus we will be stuck with whatever syntax we design here forever.
Whereas we may eventually provide a split version of "-c" that can
handle names with equals, at which point our syntax decision here will
just be a historical wart. In fact, we already have "--config-env" that
can do this.

>  Documentation/config.txt  | 35 ++++++++++++++++++++
>  config.c                  | 61 +++++++++++++++++++++++++++++++++--
>  t/t1305-config-include.sh | 67 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 161 insertions(+), 2 deletions(-)

The patch itself looks correct to me. Everything below is bikeshedding
(as if the parts above were not!), but you may or may not find some of
it compelling.

> +`envExists`::
> [...]
> +`envMatch`::

As I said, these four variants seem OK. Two other variants we might
consider:

  - regex vs glob; I think globbing is probably fine for now and regex
    would be overkill. We might want to reconsider the use of the word
    "match" though, since I assumed it to be a regex at first.

  - negation; for the TERM example discussed recently, I wonder if TERM
    != xterm would be a more natural fit. I had imagined "!=" as the
    operator, but in your scheme, it would probably be "!envIs", etc.

> +There is no way to match an environment variable name with any of the
> +`env*` directives if that variable name contains a ":" character. Such
> +names are allowed by POSIX, but it is assumed that nobody will need to
> +match such a variable name in practice.

That seems like a perfectly reasonable restriction.

Should we allow whitespace around key names and values? E.g.:

  [includeIf "env: FOO: bar"]

is IMHO more readable (even more so if we had infix operators like
"==").

> +static int include_by_env_exists(const char *cond, size_t cond_len)
> +{
> +	char *cfg = xstrndup(cond, cond_len);
> +	int ret = !!getenv(cfg);
> +	free(cfg);
> +	return ret;
> +}

Having to xstrndup() in each one of these is ugly. But doing it in the
caller would be even uglier, as we don't discover cond/cond_len until we
match via skip_prefix() in the big if/else chain. And certainly it's not
new to your patch anyway, just something I noticed.

BTW, I notice you used xmemdupz() in one case later on. I generally
prefer it to xstrndup() because it's more straight-forward: the string
is this long, and it needs to be NUL-terminated. Whereas xstrndup() is
_mostly_ equivalent, but will produce a smaller string if there are
embedded NULs. We would not expect them in this case, so I don't think
it matters functionally. It just seemed funny to me to see them mixed.

(I actually suspect 99% or more of xstrndup() calls should just be
xmemdupz(), and I'd be happy to consolidate and drop one of them, but it
would be finicky looking at each one to see if that's really true).

> +static int include_by_env_match(const char *cond, size_t cond_len, int glob,
> +				int *err)
> +{
> +	const char *eq;
> +	const char *value;
> +	const char *env;
> +	char *cfg = xstrndup(cond, cond_len);
> +	char *key = NULL;
> +	int ret = 0;
> +
> +	eq = strchr(cfg, ':');
> +	if (!eq) {
> +		*err = error(_("'%s:%.*s' missing a ':' to match the value"),
> +			     glob ? "envMatch" : "envIs", (int)(cond_len),
> +			     cond);

You made a string out of (cond, cond_len) already, so you could just use
"cfg" here in the error (what you have isn't wrong, but I always find
%.*s hard to read).

> +	key = xmemdupz(cfg, eq - cfg);

And this is the mixed xstrndup()/xmemdupz() case I mentioned. :)

>  static int include_condition_is_true(const struct config_options *opts,
> -				     const char *cond, size_t cond_len)
> +				     const char *cond, size_t cond_len,
> +				     int *err)

OK, we need to return not just "true" or "not true" from the return now,
so we stuff it into an out-parameter. We could use a tri-state instead.
Our if-else would already propagate it:

> @@ -301,6 +350,14 @@ static int include_condition_is_true(const struct config_options *opts,
>  		return include_by_gitdir(opts, cond, cond_len, 1);
>  	else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, &cond_len))
>  		return include_by_branch(cond, cond_len);
> +	else if (skip_prefix_mem(cond, cond_len, "envExists:", &cond, &cond_len))
> +		return include_by_env_exists(cond, cond_len);
> +	else if (skip_prefix_mem(cond, cond_len, "envBool:", &cond, &cond_len))
> +		return include_by_env_bool(cond, cond_len);
> +	else if (skip_prefix_mem(cond, cond_len, "envIs:", &cond, &cond_len))
> +		return include_by_env_match(cond, cond_len, 0, err);
> +	else if (skip_prefix_mem(cond, cond_len, "envMatch:", &cond, &cond_len))
> +		return include_by_env_match(cond, cond_len, 1, err);

But it would mess up this:

>  	if (!parse_config_key(var, "includeif", &cond, &cond_len, &key) &&
> -	    (cond && include_condition_is_true(inc->opts, cond, cond_len)) &&
> +	    (cond && include_condition_is_true(inc->opts, cond, cond_len, &ret)) &&
>  	    !strcmp(key, "path"))
>  		ret = handle_path_include(value, inc);

So the out-parameter seems like a reasonable path.

I did find it interesting that there are no other error-cases in the
existing conditions. They mostly just evaluate to false (including if we
don't recognize the condition at all). But in the cases you're catching
here, it really is syntactic nonsense.

I guess you could define "there is no colon" as "the value we'd parse
after it is assumed to be the empty string" which makes the error case
go away. I'm not sure it really matters all that much either way in
practice.

> +test_expect_success 'conditional include, envExists:*' '
> +	echo value >expect &&
> +	git config -f envExists.cfg some.key $(cat expect) &&
> +
> +	test_must_fail git -c includeIf.envExists:VAR.path="$PWD/envExists.cfg" config some.key 2>err &&
> +	test_must_be_empty err &&

The tests all look sane to me. We do define some exit codes for
git-config here, so:

  test_expect_code 1 git -c ...

would be tighter (and you could probably just ditch the empty-err check
then).

Obviously avoiding the "=" question is beneficial here for testing via
"-c".  As I said earlier, I think it's more realistic to expect these in
actual files, but I think testing them either way is fine. If you did
test them in a file, though, you could use a relative path in the
include. Plus all three invocations could use the same file, so you
don't have to repeat it over and over. I.e.:

  test_config includeIf.envExists:VAR.path envExists.cfg &&

  test_expect_code 1 git config some.key &&

  VAR= git config some.key >actual &&
  test_cmp expect actual &&

  VAR=0 git config some.key >actual &&
  test_cmp expect actual

should work.

-Peff
