From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] fetch: make --prune configurable
Date: Mon, 08 Jul 2013 11:36:01 -0700
Message-ID: <7vk3l0zypa.fsf@alter.siamese.dyndns.org>
References: <1373288217-20580-1-git-send-email-mschub@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 20:36:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwGIG-000764-W5
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 20:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752199Ab3GHSgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 14:36:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60971 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751648Ab3GHSgG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 14:36:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 138CB2CE44;
	Mon,  8 Jul 2013 18:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jyHeCcv5l0jdNpFuD6kvkc6+y9s=; b=Wf/8K+
	e/b5ipEC5YtDF6XReO/s63wPQg5DY9RiaGOeoiERDjYk+LovesiEzwx2Zt5eV6Ts
	pY9tHtb+i7W7H5JGW5y9piX1+T5CAAiVS7FqLmad6QCHvOnRaL8YBFJPW8pStpK4
	0OfSkoavG1QBLKh6iZZt3yXvy0fDk90VfqVME=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nQ5xZVLLg6HxKabLso1ZrE247HdtFaFh
	EqcIGyOs4i6mW/GMepobD353GvsIEEF6PV6cHY5WWmgBXz6QODwfX0shUfNUER9v
	VwlEoqwMQj7GH+2l6Ni+G6CArU1yi7IJCrYXK1z7l8daWjmu8oESMsLkyxduDFKD
	qiNDMYvvdQw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0651F2CE43;
	Mon,  8 Jul 2013 18:36:05 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D2AD2CE3E;
	Mon,  8 Jul 2013 18:36:03 +0000 (UTC)
In-Reply-To: <1373288217-20580-1-git-send-email-mschub@elegosoft.com> (Michael
	Schubert's message of "Mon, 8 Jul 2013 14:56:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3E588858-E7FD-11E2-B69E-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229884>

Michael Schubert <mschub@elegosoft.com> writes:

> $gmane/201715 brought up the idea to fetch --prune by default.

When you can summarize it in a few lines, e.g.

    Without "git fetch --prune", remote-tracking branches for a branch
    the other side already has removed will stay forever.  Some people
    want to always run "git fetch --prune".

please refrain from forcing people to go to the web while reading
logs.

> Since --prune is a "potentially destructive operation" (Git doesn't
> keep reflogs for deleted references yet), we don't want to prune
> without users consent.
>
> To accommodate users who want to either prune always or when fetching
> from a particular remote, add two new configuration variables
> "fetch.prune" and "remote.<name>.prune":
>
>  - "fetch.prune" allows to enable prune for all fetch operations.
>
>  - "remote.<name>.prune" allows to change the behaviour per remote.
>

Add:

    "git fetch --no-prune" from the command line will defeat the
    configured default for safety.

(I didn't check if your patch already does so, though).

Other than that, the log message looks good.

Thanks for starting to work on this.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index b4d4887..74e8026 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1067,6 +1067,10 @@ fetch.unpackLimit::
>  	especially on slow filesystems.  If not set, the value of
>  	`transfer.unpackLimit` is used instead.
>  
> +fetch.prune::
> +	If true, fetch will automatically behave as if the `--prune`
> +	option was given on the command line.
> +
>  format.attach::
>  	Enable multipart/mixed attachments as the default for
>  	'format-patch'.  The value can also be a double quoted string
> @@ -2010,6 +2014,11 @@ remote.<name>.vcs::
>  	Setting this to a value <vcs> will cause Git to interact with
>  	the remote with the git-remote-<vcs> helper.
>  
> +remote.<name>.prune::
> +	When set to true, fetching from this remote by default will also
> +	remove any remote-tracking branches which no longer exist on the
> +	remote (as if the `--prune` option was give on the command line).

We may want to say something about interaction between the two
variables.  E.g. fetch.prune=true, remote.origin.prune=false would
hopefully not to prune when you are fetching from your 'origin', and
fetch.prune=false, remote.origin.prune=true would.

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index d784b2e..3953317 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -30,7 +30,14 @@ enum {
>  	TAGS_SET = 2
>  };
>  
> -static int all, append, dry_run, force, keep, multiple, prune, update_head_ok, verbosity;
> +enum {
> +	PRUNE_UNSET = 0,
> +	PRUNE_DEFAULT = 1,
> +	PRUNE_FORCE = 2
> +};
> +
> +static int prune = PRUNE_DEFAULT;

I find this unconventional in that usually _UNSET means "the user
hasn't explicitly said anything about what she wants" (hence
typically a variable is initialized to that value).  Also I am not
sure what "FORCE" means.

If this were 

enum {
	PRUNE_UNSET = -1,
	PRUNE_NO = 0,
	PRUNE_YES = 1
};

then I would understand, but at that point, that is a typical
setting for a boolean variable, so we could just use -1/0/1.

> +static int all, append, dry_run, force, keep, multiple, update_head_ok, verbosity;
>  static int progress = -1, recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
>  static int tags = TAGS_DEFAULT, unshallow;
>  static const char *depth;
> @@ -54,6 +61,17 @@ static int option_parse_recurse_submodules(const struct option *opt,
>  	return 0;
>  }
>  
> +static int git_fetch_config(const char *k, const char *v, void *cb)
> +{
> +	if (!strcmp(k, "fetch.prune")) {
> +		int boolval = git_config_bool(k, v);
> +		if (boolval)
> +			prune = PRUNE_FORCE;
> +		return 0;

This is not good, is it?  Imagine fetch.prune=true in ~/.gitconfig
and fetch.prune=false in $GIT_DIR/config; I'd expect the more
specific one to set "prune" back to non-FORCE value.

As you do not have transport available before you process
parse_options(), I think you need two variables, "prune" that is
used to determine what happens (same as in the code before your
patch) and a new one "fetch_prune_config" that records what we read
from the fetch.prune configuration.

So I _suspect_ the interaction between the configuration parser and
the command line option parser should look more like this, in order
to implement the correct order of precedence:

	static int fetch_prune_config = -1; /* unspecified */
        static int prune = -1; /* unspecified */
	#define PRUNE_BY_DEFAULT 0

	...

        /* set "fetch_prune_config" */
	git_config(git_fetch_config);
	--> git_fetch_config():
		if (!strcmp(k, "fetch.prune")) {
			fetch_prune_config = git_config_bool(k, v);
			return 0;
		}

	...

        /* set "prune" */
        parse_options();

        --> fetch_one();
		transport_get();

                if (prune < 0) {
			/* no command line request; combine configs */
			if (0 <= transport->remote->prune)
				prune = transport->remote->prune;
			else if (0 <= fetch_prune_config)
                        	prune = fetch_prune_config;
			else
                        	prune = PRUNE_BY_DEFAULT;
		}

You would need to update make_remote() to initialise its .prune
member with -1 (unspecified).

You also need to change OPT_BOOLEAN() to OPT_BOOL() for the command
line processing for "prune", as the former is a "count up" that is
useful for things like "-v", "-v -v", etc.

> +	}
> +	return git_default_config(k, v, cb);

What kind of random configuration are we expecting to read from and
affect our execution by falling back to the default config?

>  static struct option builtin_fetch_options[] = {
>  	OPT__VERBOSITY(&verbosity),
>  	OPT_BOOLEAN(0, "all", &all,
> @@ -770,7 +788,7 @@ static int do_fetch(struct transport *transport,
>  		retcode = 1;
>  		goto cleanup;
>  	}
> -	if (prune) {
> +	if (prune == PRUNE_FORCE || (transport->remote->prune && prune)) {

I cannot offhand see how this is correct with your code (without the
above "you need two variables" suggestion).  It reads to me:

	If fetch.prune is set, we set it to PRUNE_FORCE in the
        configuration parser, and in that case we ignore everything
        else and go ahead to prune.

which does not sound right.  fetch.prune=yes remote.$name.prune=no
should not prune, fetch.prune=yes with --no-prune from the command
line should not prune, etc.  But I may be misreading this complex
boolean expression in the patch.

And with the suggested change, this can stay 

	if (prune)

without having to do any mental gymnastics here.

> @@ -882,8 +900,10 @@ static void add_options_to_argv(struct argv_array *argv)
>  {
>  	if (dry_run)
>  		argv_array_push(argv, "--dry-run");
> -	if (prune)
> +	if (prune == PRUNE_FORCE)
>  		argv_array_push(argv, "--prune");
> +	else if (prune == PRUNE_UNSET)
> +		argv_array_push(argv, "--no-prune");
>  	if (update_head_ok)
>  		argv_array_push(argv, "--update-head-ok");
>  	if (force)

And I think this hunk can go with the suggested change.

> @@ -1007,6 +1027,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  	for (i = 1; i < argc; i++)
>  		strbuf_addf(&default_rla, " %s", argv[i]);
>  
> +	git_config(git_fetch_config, NULL);
> +
>  	argc = parse_options(argc, argv, prefix,
>  			     builtin_fetch_options, builtin_fetch_usage, 0);
>  
> diff --git a/remote.c b/remote.c
> index 6f57830..e6f2acb 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -404,6 +404,8 @@ static int handle_config(const char *key, const char *value, void *cb)
>  		remote->skip_default_update = git_config_bool(key, value);
>  	else if (!strcmp(subkey, ".skipfetchall"))
>  		remote->skip_default_update = git_config_bool(key, value);
> +	else if (!strcmp(subkey, ".prune"))
> +		remote->prune = git_config_bool(key, value);
>  	else if (!strcmp(subkey, ".url")) {
>  		const char *v;
>  		if (git_config_string(&v, key, value))
> diff --git a/remote.h b/remote.h
> index cf56724..4db3498 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -40,6 +40,7 @@ struct remote {
>  	int fetch_tags;
>  	int skip_default_update;
>  	int mirror;
> +	int prune;
>  
>  	const char *receivepack;
>  	const char *uploadpack;
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index fde6891..f3d63ca 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -497,6 +497,44 @@ test_expect_success "should be able to fetch with duplicate refspecs" '
>  	)
>  '
>  
> +test_expect_success 'fetch should prune when fetch.prune is true' '
> +  cd "$D" &&
> +  git branch somebranch &&
> +  (
> +    cd one &&
> +    git fetch &&
> +    test -f .git/refs/remotes/origin/somebranch
> +  ) &&
> +  git branch -d somebranch &&
> +  (
> +    cd one &&
> +    git config fetch.prune true &&
> +    git fetch --no-prune &&
> +    test -f .git/refs/remotes/origin/somebranch &&
> +    git fetch &&
> +    ! test -f .git/refs/remotes/origin/somebranch
> +  )
> +'

OK, "fetch.prune < --no-prune" and  "fetch.prune alone" are tested
with this.  "fetch.prune=no" with "--prune" is not tested.

> +test_expect_success 'fetch should prune when remote.<name>.prune is true' '
> +  cd "$D" &&
> +  git branch somebranch &&
> +  (
> +    cd one &&
> +    git fetch &&
> +    test -f .git/refs/remotes/origin/somebranch

Depending on the success/failure of the previous test, we do not
know what value fetch.prune is set in this repository.  What are we
testing here?  By using "test_unconfig" to clear the variables you
care about before starting each test, you would make it clear what
exactly you are testing.

There are at least 9 combinations of settings we should be testing.
A naive matrix:

	fetch.prune		set to false or not set, set to true
        remote.origin.prune	set to false or not set, set to true
	command line		--no-prune, --prune, (neither)

will give us 12 combinations (for completeness, you may want to test
fetch.prune that is not set at all and fetch.prune explicitly set to
false separately, but let's not go overboard), but we presumably
have been testing cases where neither fetch.prune or remote.*.prune
is set, so we would need to only test cases where at least one of
the configuration variables is set (that would make 3 cases),
multiplied with the command line combinations.


> +  ) &&
> +  git branch -d somebranch &&
> +  (
> +    cd one &&
> +    git config remote.origin.prune true &&
> +    git fetch --no-prune &&
> +    test -f .git/refs/remotes/origin/somebranch &&
> +    git fetch &&
> +    ! test -f .git/refs/remotes/origin/somebranch
> +  )
> +'
> +
>  test_expect_success 'all boundary commits are excluded' '
>  	test_commit base &&
>  	test_commit oneside &&
