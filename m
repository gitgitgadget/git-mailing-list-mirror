Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9435466A
	for <git@vger.kernel.org>; Mon,  8 Jan 2024 17:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sJWbj+Mt"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D83DA1D6077;
	Mon,  8 Jan 2024 12:25:21 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4RuLOc0KInyQpLzuMakF3brifvC+y7BSCxEwvs
	Rln6g=; b=sJWbj+MtVDpg2w1rPaK1I1zFOhTpfJ/Nn8dNTVj4qGrSjgihb6rDEa
	aLI9T0ILzKiN93KuRE62dKKiTzK4uf7KPJOqdZk9P60mK7njuNchyF8oHna4MYo0
	mlKiqEMsuEV9NRbS4tTYOPHc2o5jnrTwB9FgdnYlpprZXavKW8R7I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CFFAB1D6076;
	Mon,  8 Jan 2024 12:25:21 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 37B151D6075;
	Mon,  8 Jan 2024 12:25:21 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Tamino Bauknecht <dev@tb6.eu>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3] fetch: add new config option fetch.all
In-Reply-To: <20240106202352.7253-2-dev@tb6.eu> (Tamino Bauknecht's message of
	"Sat, 6 Jan 2024 21:17:01 +0100")
References: <xmqqa5pjpxm6.fsf@gitster.g> <20240106202352.7253-2-dev@tb6.eu>
Date: Mon, 08 Jan 2024 09:25:20 -0800
Message-ID: <xmqqwmsjlou7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E676F99C-AE4A-11EE-A67F-25B3960A682E-77302942!pb-smtp2.pobox.com

Tamino Bauknecht <dev@tb6.eu> writes:

> This commit introduces the new boolean configuration option fetch.all

"This commit introduces the new boolean" -> "Introduce a boolean"

In general, our log messages are written as if we are giving an
order to explain what should happen to the codebase.

> which allows to fetch all available remotes by default. The config
> option can be overridden by explicitly specifying a remote or by using
> --no-all.
> The behavior for --all is unchanged and calling git-fetch with --all and
> a remote will still result in an error.

Good.

> The config option was also added to the config documentation and new

"The config option was also added to the config" -> "Describe the
configuration variable in the"

> tests cover the expected behavior.
> Additionally, --no-all was added to the command-line documentation of

"--no-all was added to" -> "add --no-all to".

> git-fetch.
>
> Signed-off-by: Tamino Bauknecht <dev@tb6.eu>
> ---

> +fetch.all::
> +	If true, fetch will attempt to update all available remotes.
> +	This behavior can be overridden by passing `--no-all` or by
> +	explicitly specifying one or more remote(s) to fetch from.
> +	Defaults to false.

Good.

> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
> index a1d6633a4f..5e70f6d2e4 100644
> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -1,5 +1,6 @@
> ---all::
> -	Fetch all remotes.
> +--[no-]all::
> +	Fetch all remotes. This overrides the configuration option
> +	`fetch.all`.

"configuration option" -> "configuration variable".

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index a284b970ef..5a0b249c07 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -102,6 +102,7 @@ static struct string_list negotiation_tip = STRING_LIST_INIT_NODUP;
>  
>  struct fetch_config {
>  	enum display_format display_format;
> +	int all;
>  	int prune;
>  	int prune_tags;
>  	int show_forced_updates;
> @@ -115,6 +116,11 @@ static int git_fetch_config(const char *k, const char *v,
>  {
>  	struct fetch_config *fetch_config = cb;
>  
> +	if (!strcmp(k, "fetch.all")) {
> +		fetch_config->all = git_config_bool(k, v);
> +		return 0;
> +	}
> +
>  	if (!strcmp(k, "fetch.prune")) {
>  		fetch_config->prune = git_config_bool(k, v);
>  		return 0;
> @@ -2121,6 +2127,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  {
>  	struct fetch_config config = {
>  		.display_format = DISPLAY_FORMAT_FULL,
> +		.all = -1,
>  		.prune = -1,
>  		.prune_tags = -1,
>  		.show_forced_updates = 1,

Not incorrect per-se, but I find it misleading, as there is no
reason to initialize it to -1.  If left initialized to 0 (which
would be the default), and if we do not see "fetch.all", it will be
left to 0, which is the default value, and that is what you want.

> @@ -2132,7 +2139,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  	const char *bundle_uri;
>  	struct string_list list = STRING_LIST_INIT_DUP;
>  	struct remote *remote = NULL;
> -	int all = 0, multiple = 0;
> +	int all = -1, multiple = 0;
>  	int result = 0;
>  	int prune_tags_ok = 1;
>  	int enable_auto_gc = 1;
> @@ -2148,7 +2155,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  
>  	struct option builtin_fetch_options[] = {
>  		OPT__VERBOSITY(&verbosity),
> -		OPT_BOOL(0, "all", &all,
> +		OPT_COUNTUP(0, "all", &all,

I do not think this change from BOOL to COUNTUP is warranted.  Does
it trigger an error if you feed a variable that is initialized to -1
to OPT_BOOL()?  If not, "initialize to -1 and let OPT_BOOL() set
either 0 or 1 when seeing a command line option" pattern would be
preferrable.

The idea is to initialize the "all" variable to -1 (unspecified) and
then if there is a command line option set it to either 0 or 1.
After the command line option parsing returns, we can tell:

    -1: there was not --all and there was not --no-all.  We need to
        look at the configuration variable.
     0: there was --no-all.  Ignore the configuration.
     1: there was --all.  Ignore the configuration.

Use of COUNTUP can leave the variable set to say 2 or 3.  There are
legitimate uses of COUNTUP (e.g., expressing verbosity levels via
multiple use of "-v -v"), but you want "--all" and "--all --all"
behave identically, so COUNTUP is not a good fit here.

> @@ -2337,11 +2344,18 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  	    fetch_bundle_uri(the_repository, bundle_uri, NULL))
>  		warning(_("failed to fetch bundles from '%s'"), bundle_uri);
>  

OK.  The following has to be a bit unusual and different from the
usual "we initialize a variable to its default, read into it from
the config, and then overwrite it from the command line option"
pattern because we want to ignore configured value upon factors
other than the command line option that corresponds to the
configuration variable (namely, even if --all or --no-all does not
appear on the command line, a remote makes the fetch.all
configuration ignored, without triggering an error).

> -	if (all) {
> +	if (all > 0) {

Hence, we need to catch only the case where "--all" was given
explicitly (i.e., all == -1 is not handled here).  Good.

>  		if (argc == 1)
>  			die(_("fetch --all does not take a repository argument"));
>  		else if (argc > 1)
>  			die(_("fetch --all does not make sense with refspecs"));
> +	}
> +
> +	if (all > 0 || (config.all > 0 && !argc && all < 0)) {

Here, you can say config.all (not "config.all > 0") if you
initialized the .all member to 0 (remove the ".all = -1"
initialization, in other words).

> +		/*
> +		 * Only use fetch.all config option if no remotes were
> +		 * explicitly given and if no --no-all was passed
> +		 */
>  		(void) for_each_remote(get_one_remote_for_fetch, &list);
>  
>  		/* do not do fetch_multiple() of one */

But I suspect that it is easier to understand if you added this

	if (all < 0)
               	/* no --[no-]all given. */
		all = (!argc) ? config.all : 0;

before all of the above, and leave the rest of the original
untouched.  In other words, when there is no command line option
"--[no-]all", we take "fetch.all" into consideration only when there
is no explicit remote.  If there is an explicit remote and there is
no "--[no-]all", we can explicitly set all to 0 here.

And the remainder of the existing logic will work fine with all == 0
or all == 1 so we do not have to touch it.

> diff --git a/t/t5514-fetch-multiple.sh b/t/t5514-fetch-multiple.sh
> index a95841dc36..63cd730718 100755
> --- a/t/t5514-fetch-multiple.sh
> +++ b/t/t5514-fetch-multiple.sh
> @@ -24,6 +24,15 @@ setup_repository () {
>  	)
>  }
>  
> +setup_test_clone () {
> +	test_dir="$1" &&
> +	git clone one "$test_dir" &&
> +	for r in one two three
> +	do
> +		git -C "$test_dir" remote add "$r" "../$r" || return 1
> +	done
> +}
> +
>  test_expect_success setup '
>  	setup_repository one &&
>  	setup_repository two &&
> @@ -209,4 +218,156 @@ test_expect_success 'git fetch --multiple --jobs=0 picks a default' '
>  	 git fetch --multiple --jobs=0)
>  '
>  
> +create_fetch_all_expect () {
> +	cat >expect <<-\EOF || return 1

I saw there already was a comment on "|| return 1", which I agree
with.


Thanks.
