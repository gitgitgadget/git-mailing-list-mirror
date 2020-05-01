Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E62C47253
	for <git@archiver.kernel.org>; Fri,  1 May 2020 18:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E852824967
	for <git@archiver.kernel.org>; Fri,  1 May 2020 18:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IhpqvKXZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbgEAS1R (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 14:27:17 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62877 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730019AbgEAS1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 14:27:16 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 99FDCC3687;
        Fri,  1 May 2020 14:27:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wNtYfJWu05scAoetsDxx8/6/Tl8=; b=IhpqvK
        XZibsB3Hm5k91Wkxo18T0dbGKNHXrsUViUHm9xN25ljM0vgpO/W/Mb+kalUwXbaK
        MKS3YRAhSSbdvBtGo1An0Xz8Hs9UMdGEZR7No0XEdAs1Ot9OlOhoIlLn0SZ5Z+kK
        hd0v0m9qArFIUK9Yxg15uLuZ+7lMIFE3IotoI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hCG0ycND3CzmCppDZurkOrj06bX7SNNd
        RROb9ONJXN9j4dCGxC+2rt/Jpp4yFbIMQdBt91EacfkvgvYyUBDRL/GZQvrriBK4
        NBmvq0GoxGSwuL0uiJc6au6E+QUtwgWKWwcXsaaNmml73dTEyXzhkf+3RlD537fr
        wxK4StrbKos=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 917F4C3686;
        Fri,  1 May 2020 14:27:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D1F08C3685;
        Fri,  1 May 2020 14:27:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com, peff@peff.net,
        heba.waly@gmail.com, liu.denton@gmail.com
Subject: Re: [PATCH v2] submodule: port subcommand 'set-url' from shell to C
References: <20200501073232.18409-1-shouryashukla.oo@gmail.com>
Date:   Fri, 01 May 2020 11:27:06 -0700
In-Reply-To: <20200501073232.18409-1-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Fri, 1 May 2020 13:02:32 +0530")
Message-ID: <xmqq5zdfmryd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5D5CB9A4-8BD9-11EA-B947-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 1a4b391c88..59334d4286 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2246,6 +2246,60 @@ static int module_config(int argc, const char **argv, const char *prefix)
>  	usage_with_options(git_submodule_helper_usage, module_config_options);
>  }
>  
> +struct set_url_cb {
> +	const char *prefix;
> +	unsigned int flags;
> +};
> +
> +#define SET_URL_CB_INIT { NULL, 0 }

Is any of the above even necessary?  I cannot see the place
info.prefix is used (I can see where it is set, but the only other
appearance of string 'prefix' is a call to sync_submodule() and
info.prefix is not used there at all), and info.flags is assigned
OPT_QUIET and passed to sync_submodule().  If you must have a
variable, a single "unsigned int" local variable in the function
would be sufficient, but it is unclear if even that is needed.

Worse yet, it claims to have something to do with a callback API by
having _cb suffix, but nobody calls anything with the data here.

> +static int module_set_url(int argc, const char **argv, const char *prefix)
> +{
> +	struct set_url_cb info = SET_URL_CB_INIT;

And this is the only place where SET_URL_CB_INIT is used.

I think all of the above should be discarded.

> +	int quiet = 0;

This is a good initialization, as parse_options() may not even see
any option related to this variable.

> +	const char *newurl = NULL;
> +	const char *path = NULL;

These are unnecessary, as we will _always_ assign to them before
doing anything else.  It is sufficient to say:

	const char *newurl, *path;

> +	struct strbuf entry = STRBUF_INIT;
> +

Why is this called entry?  All other occurences of string 'entry' in
thsi file always refer to a cache_entry.  Read on for a better name.

> +	struct option module_set_url_options[] = {
> +		OPT__QUIET(&quiet, N_("Suppress output for setting url of a submodule")),
> +		OPT_END()
> +	};

I think you are copying what other functions do, but for a local
variable to this function, I do not see the need to call this array
with such a long name.  Calling it "set_url_options[]" or even just
"options[]" is sufficient, because there is no other "struct option"
involved in this function.

> +	const char *const git_submodule_helper_usage[] = {
> +		N_("git submodule--helper set-url [--quiet] [<path>] [<newurl>]"),
> +		NULL
> +	};

Likewise.  "usage[]" should be plenty clear.

> +	argc = parse_options(argc, argv, NULL, module_set_url_options,
> +			     git_submodule_helper_usage, 0);

And this would become

	argc = parse_options(argc, argv, NULL, options,	usage, 0);

without losing any clarity.

> +	info.prefix = prefix;
> +	if (quiet)
> +		info.flags |= OPT_QUIET;

Drop these three lines.

> +	path = argv[0];
> +	newurl = argv[1];

Wait.  If path is NULL, it is likely that argv[1] is an
out-of-bounds access.

> +	if(!path || !newurl){

Style.

	if (!path || !newurl) {

> +		usage_with_options(git_submodule_helper_usage,module_set_url_options);

This would become a short-and-sweet

		usage_with_options(usage, options);

Note that we require a SP after that comma.

> +		return 1;

OK.  This follows a (bit unnatural) convention used throughout this
file that module_<action> helpers signal a failure with positive 1,
and signal a success with 0.

> +	}
> +

Taking all these together,

	if (argc != 3) {
		usage_with_options(usage, options);
                return 1;
	}
        path = argv[0];
        newurl = argv[1];

If you feel paranoid, you can check these two are not NULL, too,
i.e.

        if (argc != 3 || !(path = argv[0]) || !(newurl = argv[1])) {
		usage_with_options(usage, options);
		return 1;
	}

I have no strong preference either way.  Perhaps the latter is more
concise and more careful at the same time, so some people may prefer
it.

> +	strbuf_addstr(&entry, "submodule.");
> +	strbuf_addstr(&entry, path);
> +	strbuf_addstr(&entry, ".url");

The strbuf is to hold a configuration variable name and has nothing
to do with a cache entry.  Perhaps

	strbuf_addf(&config_name, "submodule.%s.url", path);

> +	/* Setting the new URL in .gitmodules */
> +	config_set_in_gitmodules_file_gently(entry.buf, newurl);  

It is dubious the comment above this call (and above the next call
to sync) adds any value.  The function name and its parameters tells
us enough, especially if you rename the strbuf variable and in a
single strbuf_addf(), which makes it pretty clear what the variable
contains (i.e. "submodule.<path>.url" variable in the .gitmodules
file).

> +	/* Syncing the updated URL */
> +	sync_submodule(path, prefix, info.flags);

This will become

	sync_submodule(path, prefix, quiet ? OPT_QUIET : 0);

So, there was no need for 'flags' variable, let alone set_url_cb
structure, at all.

> +	return 0;
> +}
> +
>  #define SUPPORT_SUPER_PREFIX (1<<0)
>  
>  struct cmd_struct {
> @@ -2276,6 +2330,7 @@ static struct cmd_struct commands[] = {
>  	{"is-active", is_active, 0},
>  	{"check-name", check_name, 0},
>  	{"config", module_config, 0},
> +	{"set-url", module_set_url, 0},
>  };
>  
>  int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 89f915cae9..ea72d5a5f5 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -783,11 +783,13 @@ cmd_set_branch() {
>  # $@ = requested path, requested url
>  #
>  cmd_set_url() {
> +
>  	while test $# -ne 0
>  	do
>  		case "$1" in
>  		-q|--quiet)
>  			GIT_QUIET=1
> +			shift
>  			;;
>  		--)
>  			shift
> @@ -800,30 +802,9 @@ cmd_set_url() {
>  			break
>  			;;
>  		esac
> -		shift
>  	done

Why any of the above change?  It may not change the behaviour from
the current implementation, but why do we even want to touch it?

> -	then
> -		usage
> -	fi
> -
> -	# we can't use `git submodule--helper name` here because internally, it
> -	# hashes the path so a trailing slash could lead to an unintentional no match
> -	name="$(git submodule--helper list "$1" | cut -f2)"
> -	if test -z "$name"
> -	then
> -		exit 1
> -	fi
> -
> -	url="$2"
> -	if test -z "$url"
> -	then
> -		exit 1
> -	fi
> -

The loss of these lines is a good change ;-)  Very pleased to see
fewer lines of shell script.

Thanks.
