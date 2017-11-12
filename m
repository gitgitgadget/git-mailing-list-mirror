Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FA9E201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 14:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751139AbdKLOzk (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 09:55:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:53964 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750994AbdKLOzj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 09:55:39 -0500
Received: (qmail 1536 invoked by uid 109); 12 Nov 2017 14:55:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 12 Nov 2017 14:55:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15141 invoked by uid 111); 12 Nov 2017 14:55:52 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (62.189.9.201)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Sun, 12 Nov 2017 09:55:52 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Nov 2017 14:55:36 +0000
Date:   Sun, 12 Nov 2017 14:55:36 +0000
From:   Jeff King <peff@peff.net>
To:     Haaris <hsed@unimetic.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] config: added --expiry-date type support
Message-ID: <20171112145535.gb4nafdhhdslknex@sigill.intra.peff.net>
References: <0102015fb02bb5be-02c77f83-5a20-4ca1-8bab-5e9519cbd758-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0102015fb02bb5be-02c77f83-5a20-4ca1-8bab-5e9519cbd758-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 12, 2017 at 12:19:35PM +0000, Haaris wrote:

> ---

Hi, and welcome to the list. Thanks for working on this (for those of
you on the list, this was one of the tasks at the hackathon this
weekend).

Kevin already mentioned a few things about the commit message, which I
agree with.

>  builtin/config.c       | 11 ++++++++++-
>  config.c               |  9 +++++++++
>  config.h               |  1 +
>  t/t1300-repo-config.sh | 25 +++++++++++++++++++++++++

It's great that there are new tests. We'll probably need some
documentation, too (especially users will need to know what the output
format means).

> @@ -80,6 +81,7 @@ static struct option builtin_config_options[] = {
>  	OPT_BIT(0, "int", &types, N_("value is decimal number"), TYPE_INT),
>  	OPT_BIT(0, "bool-or-int", &types, N_("value is --bool or --int"), TYPE_BOOL_OR_INT),
>  	OPT_BIT(0, "path", &types, N_("value is a path (file or directory name)"), TYPE_PATH),
> +	OPT_BIT(0, "expiry-date", &types, N_("value is an expiry date"), TYPE_EXPIRY_DATE),
>  	OPT_GROUP(N_("Other")),
>  	OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL byte")),
>  	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),

We seem to use both "expire" and "expiry" throughout the code and in
user-facing bits (e.g., "gc.reflogExpire" and "gc.logExpiry"). I don't
have a real preference for one versus the other. I just mention it since
whatever we choose here will be locked in to the interface forever.

> @@ -159,6 +161,12 @@ static int format_config(struct strbuf *buf, const char *key_, const char *value
>  				return -1;
>  			strbuf_addstr(buf, v);
>  			free((char *)v);
> +		} else if (types == TYPE_EXPIRY_DATE) {
> +			timestamp_t *t = malloc(sizeof(*t));
> +			if(git_config_expiry_date(&t, key_, value_) < 0)
> +				return -1;
> +			strbuf_addf(buf, "%"PRItime, *t);
> +			free((timestamp_t *)t);
>  		} else if (value_) {

Since we only need the timestamp variable within this block, we don't
need to use a pointer. We can just do something like:

  } else if (types == TYPE_EXPIRY_DATE) {
	timestamp_t t;
	if (git_config_expiry_date(&t, key_, value_) < 0)
		return -1;
	strbuf_addf(buf, "%"PRItime", t);
  }

Note that your new git_config_expiry_date would want to take just a
regular pointer, rather than a pointer-to-pointer. I suspect you picked
that up from git_config_pathname(). It needs the double pointer because
it's storing a string (which is itself a pointer), but we don't need
that here.

> @@ -273,12 +281,13 @@ static char *normalize_value(const char *key, const char *value)
>  	if (!value)
>  		return NULL;
>  
> -	if (types == 0 || types == TYPE_PATH)
> +	if (types == 0 || types == TYPE_PATH || types == TYPE_EXPIRY_DATE)
>  		/*
>  		 * We don't do normalization for TYPE_PATH here: If
>  		 * the path is like ~/foobar/, we prefer to store
>  		 * "~/foobar/" in the config file, and to expand the ~
>  		 * when retrieving the value.
> +		 * Also don't do normalization for expiry dates.
>  		 */
>  		return xstrdup(value);

This makes sense. The expiration values we get from the user are
typically relative (like "2.weeks"), so it wouldn't make sense to store
the absolute value we get from applying that relative offset to the
current time.

> diff --git a/config.c b/config.c
> index 903abf9533b18..caa2fd5fb6915 100644
> --- a/config.c
> +++ b/config.c
> @@ -990,6 +990,15 @@ int git_config_pathname(const char **dest, const char *var, const char *value)
>  	return 0;
>  }
>  
> +int git_config_expiry_date(timestamp_t **timestamp, const char *var, const char *value)
> +{
> +	if (!value)
> +		return config_error_nonbool(var);
> +	if (!!parse_expiry_date(value, *timestamp))
> +		die(_("failed to parse date_string in: '%s'"), value);
> +	return 0;
> +}

I was surprised that we don't already have a function that does this,
since we parse expiry config elsewhere. We do, but it's just local to
builtin/reflog.c. So perhaps as a preparatory step we should add this
function and convert reflog.c to use it, dropping its custom
parse_expire_cfg_value().

What's the purpose of the "!!" before parse_expiry_date()? The usual
idiom for that to normalize a non-zero value into "1", but we don't care
here. I think just:

  if (parse_expiry_date(value, timestamp))
	die(...);

would be sufficient.

> diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
> index 364a537000bbb..59a35be89e511 100755
> --- a/t/t1300-repo-config.sh
> +++ b/t/t1300-repo-config.sh
> @@ -901,6 +901,31 @@ test_expect_success 'get --path barfs on boolean variable' '
>  	test_must_fail git config --get --path path.bool
>  '
>  
> +test_expect_success 'get --expiry-date' '
> +	cat >.git/config <<-\EOF &&
> +	[date]
> +	valid1 = "Fri Jun 4 15:46:55 2010"
> +	valid2 = "2017/11/11 11:11:11PM"
> +	valid3 = "2017/11/10 09:08:07 PM"
> +	valid4 = "never"
> +	invalid1 = "abc"
> +	EOF
> +	cat >expect <<-\EOF &&
> +	1275666415
> +	1510441871
> +	1510348087
> +	0
> +	EOF
> +	{
> +		git config --expiry-date date.valid1 &&
> +		git config --expiry-date date.valid2 &&
> +		git config --expiry-date date.valid3 &&
> +		git config --expiry-date date.valid4
> +	} >actual &&
> +	test_cmp expect actual &&
> +	test_must_fail git config --expiry-date date.invalid1
> +'

This looks good to me. It would be nice if we could test a relative
value (which after all is what we'd expect to see in such a variable).
But there's no way to do it in a robust way, since it will always be
racy with the current timestamp.

We do have routines that let you make dates relative to a specific time,
but they're accessible only from t/helper/test-date, not git itself.

I don't think it's that big a deal, though. We're not testing the time
code here (which is tested elsewhere with test-date), but just that we're
passing the dates through to be parsed.

-Peff
