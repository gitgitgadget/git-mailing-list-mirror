Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEB4C433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 16:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77DF964DD6
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 16:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbhBIQxE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 11:53:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:55060 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233182AbhBIQwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 11:52:16 -0500
Received: (qmail 27001 invoked by uid 109); 9 Feb 2021 16:51:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 09 Feb 2021 16:51:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7613 invoked by uid 111); 9 Feb 2021 16:51:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 09 Feb 2021 11:51:21 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 9 Feb 2021 11:51:21 -0500
From:   Jeff King <peff@peff.net>
To:     Andrew Klotz via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Andrew Klotz <agc.klotz@gmail.com>
Subject: Re: [PATCH v2] config: improve error message for boolean config
Message-ID: <YCK9iRyQGTl+5J4g@coredump.intra.peff.net>
References: <pull.841.git.git.1600395427.gitgitgadget@gmail.com>
 <pull.841.v2.git.git.1612833909210.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.841.v2.git.git.1612833909210.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 09, 2021 at 01:25:08AM +0000, Andrew Klotz via GitGitGadget wrote:

> Currently invalid boolean config values return messages about 'bad
> numeric', which is slightly misleading when the error was due to a
> boolean value. We can improve the developer experience by returning a
> boolean error message when we know the value is neither a bool text or
> int.

Thanks for keeping at this. The goal makes sense. The implementation
looks OK to me, but I had a few really tiny comments.

> before with an invalid boolean value of `non-boolean`, its unclear what
> numeric is referring to:
> ```
> fatal: bad numeric config value 'non-boolean' for 'commit.gpgsign': invalid unit
> ```
> 
> now the error message mentions `non-boolean` is a bad boolean value:
> ```
> fatal: bad boolean config value 'non-boolean' for 'commit.gpgsign'
> ```

Our commit messages aren't generally formatted as markdown. So this
looks a little nicer using indentation (which also happens to generate
nice markdown output):

  numeric is referring to:

      fatal: bad numeric config value 'non-boolean' for 'commit.gpgsign': invalid unit

  now the error message mentions `non-boolean` is a bad boolean value:

      fatal: bad boolean config value 'non-boolean' for 'commit.gpgsign'

Not worth a re-roll on its own, though.

> +NORETURN
> +static void die_bad_bool(const char *name, const char *value)
> +{
> +	if (!strcmp(name, "GIT_TEST_GETTEXT_POISON"))
> +		/*
> +		 * We explicitly *don't* use _() here since it would
> +		 * cause an infinite loop with _() needing to call
> +		 * use_gettext_poison().
> +		 */
> +		die("bad boolean config value '%s' for '%s'", value, name);
> +	else
> +		die(_("bad boolean config value '%s' for '%s'"), value, name);
> +}

The duplication is ugly, but I think it's the least-bad solution (and I
still dream that GETTEXT_POISON may one day go away :) ).

> @@ -1102,8 +1116,11 @@ int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
>  
>  int git_config_bool(const char *name, const char *value)
>  {
> -	int discard;
> -	return !!git_config_bool_or_int(name, value, &discard);
> +	int v = git_parse_maybe_bool(value);
> +	if (0 <= v)
> +		return v;
> +	else
> +		die_bad_bool(name, value);

I had to look at this a minute to be sure we always returned a value.
But the compiler knows that die_bad_bool() doesn't return, and that we
always take one of the two conditionals.

I do think it might be easier to read as:

  int v = git_parse_maybe_bool(value);
  if (v < 0)
          die_bad_bool(name, value);
  return v;

but I admit that's nit-picking.

> diff --git a/t/t0205-gettext-poison.sh b/t/t0205-gettext-poison.sh
> index f9fa16ad8363..b66d34c6f2bc 100755
> --- a/t/t0205-gettext-poison.sh
> +++ b/t/t0205-gettext-poison.sh
> @@ -33,7 +33,7 @@ test_expect_success 'eval_gettext: our eval_gettext() fallback has poison semant
>  
>  test_expect_success "gettext: invalid GIT_TEST_GETTEXT_POISON value doesn't infinitely loop" "
>  	test_must_fail env GIT_TEST_GETTEXT_POISON=xyz git version 2>error &&
> -	grep \"fatal: bad numeric config value 'xyz' for 'GIT_TEST_GETTEXT_POISON': invalid unit\" error
> +	grep \"fatal: bad boolean config value 'xyz' for 'GIT_TEST_GETTEXT_POISON'\" error
>  "

Do we want a separate test in t1300 that doesn't rely on GETTEXT_POISON
continuing to hang around (the idea has been thrown around elsewhere of
it maybe going away entirely)?

-Peff
