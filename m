Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B575D1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 16:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934514AbeGJQXf (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 12:23:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:53870 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933359AbeGJQXe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 12:23:34 -0400
Received: (qmail 24750 invoked by uid 109); 10 Jul 2018 16:23:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Jul 2018 16:23:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28248 invoked by uid 111); 10 Jul 2018 16:23:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 10 Jul 2018 12:23:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jul 2018 12:23:32 -0400
Date:   Tue, 10 Jul 2018 12:23:32 -0400
From:   Jeff King <peff@peff.net>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 5/9] gpg-interface: introduce an abstraction for
 multiple gpg formats
Message-ID: <20180710162332.GD23624@sigill.intra.peff.net>
References: <cover.1531208187.git.henning.schild@siemens.com>
 <93d74df91b9f5c68dfd8a03f576d7428491976c0.1531208187.git.henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <93d74df91b9f5c68dfd8a03f576d7428491976c0.1531208187.git.henning.schild@siemens.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 10, 2018 at 10:52:27AM +0200, Henning Schild wrote:

> Create a struct that holds the format details for the supported formats.
> At the moment that is still just "openpgp". This commit prepares for the
> introduction of more formats, that might use other programs and match
> other signatures.

Great, this looks like a good incremental step.

>  static char *configured_signing_key;
> -static const char *gpg_format = "openpgp";
> -static const char *gpg_program = "gpg";
> +struct gpg_format_data {
> +	const char *format;
> +	const char *program;
> +	const char *extra_args_verify[1];
> +	const char *sigs[2];
> +};

These magic numbers are at a weird distance from where we fill them in:

> +struct gpg_format_data gpg_formats[] = {
> +	{ .format = "openpgp", .program = "gpg",
> +	  .extra_args_verify = { "--keyid-format=long" },
> +	  .sigs = { PGP_SIGNATURE, PGP_MESSAGE }
> +	},
> +};

I'm not sure if we can easily do any better in C, though. Declaring the
struct with an open-ended "[]" would make the compiler unhappy. We could
do something like:

  struct gpg_format_data {
	...
	const char **extra_args_verify;
  };
  ...
  static const char *openpgp_verify_args[] = {
	"--key-id-format=long"
  };
  ...
  static struct gpg_format_data gpg_formats[] = {
	{ ...
	  .extra_args_verify = openpgp_verify_args
	}
  };

I'm not sure if that's more horrible or less. It's worse to write in the
first place, but it's slightly easier to maintain going forward. I
dunno.

> +enum gpgformats { PGP_FMT };

Looks like we use this only for indexing the gpg_formats array. I know
that C guarantees 0-indexing, but if we're depending on it, it might be
worth writing out "PGP_FMT = 0" explicitly. And probably adding a
comment that this needs to remain in sync with the array.

The other alternative is that we could simply use
get_format_data("openpgp"), though that does add a minor runtime cost.

> +struct gpg_format_data gpg_formats[] = {
> +	{ .format = "openpgp", .program = "gpg",
> +	  .extra_args_verify = { "--keyid-format=long" },
> +	  .sigs = { PGP_SIGNATURE, PGP_MESSAGE }
> +	},
> +};

This array should be marked static, I think.

> +static struct gpg_format_data *get_format_data(const char *str)
> +{
> +	int i;
> +	for (i = 0; i < ARRAY_SIZE(gpg_formats); i++)
> +		if (!strcasecmp(gpg_formats[i].format, str))
> +			return gpg_formats + i;
> +	return NULL;
> +}

This looks much nicer than the assert()-ing version from v1.

> +static struct gpg_format_data *get_format_data_by_sig(const char *sig)
> +{
> +	int i, j;
> +	for (i = 0; i < ARRAY_SIZE(gpg_formats); i++)
> +		for (j = 0; j < ARRAY_SIZE(gpg_formats[i].sigs); j++)
> +			if (gpg_formats[i].sigs[j] && 
> +			    !strncmp(gpg_formats[i].sigs[j], sig,
> +				     strlen(gpg_formats[i].sigs[j])))
> +				return gpg_formats + i;
> +	return NULL;
> +}

This might be a little more readable with:

  starts_with(sig, gpg_formats[i].sigs[j])

instead of the strncmp. It may also be more efficient, as we don't have
to compute the strlen of the prefix for each non-matching line (the
compiler _might_ be smart enough to realize these are all string
literals, but it's pretty buried).

I also wondered if our prefix matching here is overly loose. We have to
do a prefix match, since "sig" isn't terminated at the line buffer. So I
think we'd match:

  --- BEGIN PGP MESSAGE --- AND SOME OTHER STUFF ---

on a line. But I think that's no different than the current code. If we
care, I guess we could look for '\n' or '\0' immediately after.

>  static int is_gpg_start(const char *line)
>  {
> -	return starts_with(line, PGP_SIGNATURE) ||
> -		starts_with(line, PGP_MESSAGE);
> +	return (get_format_data_by_sig(line) != NULL);
>  }

I don't know if we've ever discussed this style explicitly, but we'd
usually omit the unnecessary parentheses for the return here.

> @@ -140,18 +173,14 @@ int git_gpg_config(const char *var, const char *value, void *cb)
>  	}
>  
>  	if (!strcmp(var, "gpg.format")) {
> -		if (strcasecmp(value, "openpgp"))
> +		if (!get_format_data(value))
>  			return error("malformed value for %s: %s", var, value);
>  		return git_config_string(&gpg_format, var, value);
>  	}

Much nicer than v1.

> @@ -165,12 +194,16 @@ const char *get_signing_key(void)
>  int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key)
>  {
>  	struct child_process gpg = CHILD_PROCESS_INIT;
> +	struct gpg_format_data *fmt;
>  	int ret;
>  	size_t i, j, bottom;
>  	struct strbuf gpg_status = STRBUF_INIT;
>  
> +	fmt = get_format_data(gpg_format);
> +	if (!fmt)
> +		BUG("bad gpg_format '%s'", gpg_format);

This makes sense as a BUG, because we would already have validated it
when parsing gpg.format earlier. That does make me wonder if we should
simply be storing a "struct gpg_format_data" instead of a string,
though. I.e., at the top-level:

  /* default to signing with openpgp */
  static struct gpg_format_data *gpg_format = &gpg_formats[0];

> @@ -223,10 +257,18 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
>  		return -1;
>  	}
>  
> +	fmt = get_format_data_by_sig(signature);
> +	assert(fmt);

Is this assert() right? The signature data comes from the user. I guess
to get here we'll already have matched their signature via
is_gpg_start(), and this is just a cross-check? If so, then it's OK to
assert, but a BUG() with a descriptive message would be better still.

I also wonder if whoever parses the signature should get back a
gpg_format_data and just pass it in here, so we don't have to reparse.
That's what my earlier series did. It requires tweaking the function
signatures, but IMHO the result was a lot more obvious.

> +	argv_array_pushl(&gpg.args,
> +			 fmt->program, NULL);

If you're just pushing one thing, you don't need pushl(). You can just:

  argv_array_push(&gpg.args, fmt->program);

> +	for (i = 0; i < ARRAY_SIZE(fmt->extra_args_verify); i++)
> +		if (fmt->extra_args_verify[i])
> +			argv_array_pushl(&gpg.args,
> +					 fmt->extra_args_verify[i], NULL);

Likewise here. Though if you made extra_args_verify a NULL-terminated
list, this whole loop could become:

  argv_array_pushv(&gpg.args, fmt->extra_args_verify);

It's not _that_ much code, but I think using NULL-terminated lists in a
situation like this is more idiomatic for our code base.

-Peff
