From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 2/2] submodule: port init from shell to C
Date: Wed, 20 Jan 2016 13:01:38 -0800
Message-ID: <xmqq60yo55jh.fsf@gitster.mtv.corp.google.com>
References: <1453255396-31942-3-git-send-email-sbeller@google.com>
	<1453260274-31005-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, j6t@kdbg.org, sunshine@sunshineco.com,
	Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 22:01:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLzt0-0003bc-HM
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 22:01:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbcATVBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 16:01:43 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62071 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751112AbcATVBl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 16:01:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E51633CA6F;
	Wed, 20 Jan 2016 16:01:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FXtKw1kYgfY7igUBNqmVtBlfBjU=; b=IB3aPQ
	6mkc+2A15NoCssPn+VklJDE9Szk6hvTttQUbftIQb/Zp9SA0ttuIQT8U/O88jpkZ
	CfaUEIm4jyqe/Uiukf4YRTFb1juEmxo/c0dESaLxg82D0i5nu8nvhkj8lTjYzRa4
	s/JlvYEgORtWKtIRG25jLx7aq8dN+YJNmF9aY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KdMiFbCAVLP0wTHXRjrEVH4gTW1jkayK
	ZFaCasXsX5dIShDJYCwhSYnpi2NdIisUAfnrK6dU43ZnWCG6NW9kSCwHrYitIC7Y
	gkVSxdk6RTJPQ/BqAq5Vpg17VRGM9/Ts8limaHCIg87Gzr2Cruxdn5aHyUM6GI5g
	Xy8TadqVOYI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DAF7A3CA6E;
	Wed, 20 Jan 2016 16:01:40 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1F0B23CA6D;
	Wed, 20 Jan 2016 16:01:40 -0500 (EST)
In-Reply-To: <1453260274-31005-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 19 Jan 2016 19:24:34 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0069CA3E-BFB9-11E5-950B-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284467>

Stefan Beller <sbeller@google.com> writes:

> By having the `init` functionality in C, we can reference it easier
> from other parts in the code.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

How faithful a conversion is this aiming to be?  For example, one
thing I noticed is that some messages that were originally given
with "say" and sent to the standard output, which is emitted to the
standard error with this rewrite.  I didn't read both patches
carefully, so there may be other discrepancies I didn't spot.

I think you would want to do this in three steps:

 - A faithful rewrite from shell to C;

 - s/printf/fprintf(stderr, / for some messages; and finally

 - Hiding of some messages under --quiet.

in the above order.

Thanks.

>  builtin/submodule--helper.c | 115 ++++++++++++++++++++++++++++++++++++++++++--
>  git-submodule.sh            |  39 +--------------
>  2 files changed, 111 insertions(+), 43 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 1484b36..4684f16 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -221,6 +221,115 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
>  	return 0;
>  }
>  
> +static int git_submodule_config(const char *var, const char *value, void *cb)
> +{
> +	return parse_submodule_config_option(var, value);
> +}
> +
> +static void init_submodule(const char *path, const char *prefix, int quiet)
> +{
> +	const struct submodule *sub;
> +	struct strbuf sb = STRBUF_INIT;
> +	char *url = NULL;
> +	const char *upd = NULL;
> +	const char *displaypath = relative_path(xgetcwd(), prefix, &sb);;
> +
> +	/* Only loads from .gitmodules, no overlay with .git/config */
> +	gitmodules_config();
> +
> +	sub = submodule_from_path(null_sha1, path);
> +
> +	/*
> +	 * Copy url setting when it is not set yet.
> +	 * To look up the url in .git/config, we must not fall back to
> +	 * .gitmodules, so look it up directly.
> +	 */
> +	strbuf_reset(&sb);
> +	strbuf_addf(&sb, "submodule.%s.url", sub->name);
> +	if (git_config_get_string(sb.buf, &url)) {
> +		url = xstrdup(sub->url);
> +
> +		if (!url)
> +			die(_("No url found for submodule path '%s' in .gitmodules"),
> +				displaypath);
> +
> +		/* Possibly a url relative to parent */
> +		if (starts_with_dot_dot_slash(url) ||
> +		    starts_with_dot_slash(url)) {
> +			char *remoteurl;
> +			char *remote = get_default_remote();
> +			struct strbuf remotesb = STRBUF_INIT;
> +			strbuf_addf(&remotesb, "remote.%s.url", remote);
> +			free(remote);
> +
> +			if (git_config_get_string(remotesb.buf, &remoteurl))
> +				/*
> +				 * The repository is its own
> +				 * authoritative upstream
> +				 */
> +				remoteurl = xgetcwd();
> +			url = relative_url(remoteurl, url, NULL);
> +			strbuf_release(&remotesb);
> +		}
> +
> +		if (git_config_set(sb.buf, url))
> +			die(_("Failed to register url for submodule path '%s'"),
> +			    displaypath);
> +		if (!quiet)
> +			fprintf(stderr, _("Submodule '%s' (%s) registered for path '%s'\n"),
> +				sub->name, url, displaypath);
> +		free(url);
> +	}
> +
> +	/* Copy "update" setting when it is not set yet */
> +	strbuf_reset(&sb);
> +	strbuf_addf(&sb, "submodule.%s.update", sub->name);
> +	if (git_config_get_string_const(sb.buf, &upd) && sub->update) {
> +		upd = sub->update;
> +		if (strcmp(sub->update, "checkout") &&
> +		    strcmp(sub->update, "rebase") &&
> +		    strcmp(sub->update, "merge") &&
> +		    strcmp(sub->update, "none")) {
> +			fprintf(stderr, _("warning: unknown update mode '%s' suggested for submodule '%s'\n"),
> +				upd, sub->name);
> +			upd = "none";
> +		}
> +		if (git_config_set(sb.buf, upd))
> +			die(_("Failed to register update mode for submodule path '%s'"), displaypath);
> +	}
> +	strbuf_release(&sb);
> +}
> +
> +static int module_init(int argc, const char **argv, const char *prefix)
> +{
> +	int quiet = 0;
> +	int i;
> +
> +	struct option module_init_options[] = {
> +		OPT_STRING(0, "prefix", &prefix,
> +			   N_("path"),
> +			   N_("alternative anchor for relative paths")),
> +		OPT__QUIET(&quiet, "Suppress output for initialzing a submodule"),
> +		OPT_END()
> +	};
> +
> +	const char *const git_submodule_helper_usage[] = {
> +		N_("git submodule--helper init [<path>]"),
> +		NULL
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, module_init_options,
> +			     git_submodule_helper_usage, 0);
> +
> +	if (argc == 0)
> +		die(_("Pass at least one submodule"));
> +
> +	for (i = 0; i < argc; i++)
> +		init_submodule(argv[i], prefix, quiet);
> +
> +	return 0;
> +}
> +
>  struct module_list {
>  	const struct cache_entry **entries;
>  	int alloc, nr;
> @@ -466,11 +575,6 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>  	return 0;
>  }
>  
> -static int git_submodule_config(const char *var, const char *value, void *cb)
> -{
> -	return parse_submodule_config_option(var, value);
> -}
> -
>  struct submodule_update_clone {
>  	/* states */
>  	int count;
> @@ -716,6 +820,7 @@ static struct cmd_struct commands[] = {
>  	{"update-clone", update_clone},
>  	{"resolve-relative-url", resolve_relative_url},
>  	{"resolve-relative-url-test", resolve_relative_url_test},
> +	{"init", module_init}
>  };
>  
>  int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 615ef9b..6fce0dc 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -398,45 +398,8 @@ cmd_init()
>  	while read mode sha1 stage sm_path
>  	do
>  		die_if_unmatched "$mode"
> -		name=$(git submodule--helper name "$sm_path") || exit
> -
> -		displaypath=$(relative_path "$sm_path")
> -
> -		# Copy url setting when it is not set yet
> -		if test -z "$(git config "submodule.$name.url")"
> -		then
> -			url=$(git config -f .gitmodules submodule."$name".url)
> -			test -z "$url" &&
> -			die "$(eval_gettext "No url found for submodule path '\$displaypath' in .gitmodules")"
> -
> -			# Possibly a url relative to parent
> -			case "$url" in
> -			./*|../*)
> -				url=$(git submodule--helper resolve-relative-url "$url") || exit
> -				;;
> -			esac
> -			git config submodule."$name".url "$url" ||
> -			die "$(eval_gettext "Failed to register url for submodule path '\$displaypath'")"
>  
> -			say "$(eval_gettext "Submodule '\$name' (\$url) registered for path '\$displaypath'")"
> -		fi
> -
> -		# Copy "update" setting when it is not set yet
> -		if upd="$(git config -f .gitmodules submodule."$name".update)" &&
> -		   test -n "$upd" &&
> -		   test -z "$(git config submodule."$name".update)"
> -		then
> -			case "$upd" in
> -			checkout | rebase | merge | none)
> -				;; # known modes of updating
> -			*)
> -				echo >&2 "warning: unknown update mode '$upd' suggested for submodule '$name'"
> -				upd=none
> -				;;
> -			esac
> -			git config submodule."$name".update "$upd" ||
> -			die "$(eval_gettext "Failed to register update mode for submodule path '\$displaypath'")"
> -		fi
> +		git submodule--helper init ${GIT_QUIET:+--quiet} "$sm_path" || exit
>  	done
>  }
