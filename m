From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] submodule: Port resolve_relative_url from shell to C
Date: Thu, 10 Dec 2015 07:48:12 +0100
Message-ID: <5669202C.2090100@kdbg.org>
References: <1449709654-30189-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, jens.lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Dec 10 07:48:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6v1c-00070J-A6
	for gcvg-git-2@plane.gmane.org; Thu, 10 Dec 2015 07:48:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753067AbbLJGsU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2015 01:48:20 -0500
Received: from bsmtp5.bon.at ([195.3.86.187]:57476 "EHLO bsmtp5.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752953AbbLJGsT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2015 01:48:19 -0500
Received: from bsmtp8.bon.at (unknown [192.168.181.108])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 3pGQmx1rHsz5vLS
	for <git@vger.kernel.org>; Thu, 10 Dec 2015 07:48:17 +0100 (CET)
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3pGQmt1sJYz5tlC;
	Thu, 10 Dec 2015 07:48:14 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 23D2153B1;
	Thu, 10 Dec 2015 07:48:13 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <1449709654-30189-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282212>

Am 10.12.2015 um 02:07 schrieb Stefan Beller:
> This reimplements the helper function `resolve_relative_url` in shell
> in C. This functionality is needed in C for introducing the groups
> feature later on. When using groups, the user should not need to run
> `git submodule init`, but it should be implicit at all appropriate places,
> which are all in C code. As the we would not just call out to `git
> submodule init`, but do a more fine grained structure there, we actually
> need all the init functionality in C before attempting the groups
> feature. To get the init functionality in C, rewriting the
> resolve_relative_url subfunction is a major step.

I see lots of '/', but no is_dir_sep() in the C version. Did you 
consider that local URLs can use a backslash as path separator on 
Windows? In the shell version, this did not matter because bash converts 
the backslashes to forward slashes for us. But when rewritten in C, this 
does not happen.

Valid URLs are

   D:\foo\bar.git
   \\server\share\foo\bar
   ..\..\foo\bar

and all of them with some or all backslashes replaced by forward slashes.

See also connect.c:url_is_local_not_ssh, which ensures that the first 
example above is considered a local path with a drive letter, not a 
remote ssh path.

>
> This also improves the performance:
> (Best out of 3) time ./t7400-submodule-basic.sh
> Before:
> real	0m9.575s
> user	0m2.683s
> sys	0m6.773s
> After:
> real	0m9.293s
> user	0m2.691s
> sys	0m6.549s
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
>   This applies on origin/master, and I'd carry as its own feature branch
>   as I am nowhere near done with the groups feature after reading Jens feedback.
>   (It took me a while to identify this as a next best step.)
>
>   Thanks,
>   Stefan
>
>   builtin/submodule--helper.c | 120 ++++++++++++++++++++++++++++++++++++++++++++
>   git-submodule.sh            |  81 ++----------------------------
>   2 files changed, 124 insertions(+), 77 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index f4c3eff..f48b5b5 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -9,6 +9,125 @@
>   #include "submodule-config.h"
>   #include "string-list.h"
>   #include "run-command.h"
> +#include "remote.h"
> +#include "refs.h"
> +
> +static const char *get_default_remote(void)
> +{
> +	char *dest = NULL;
> +	unsigned char sha1[20];
> +	int flag;
> +	struct strbuf sb = STRBUF_INIT;
> +	const char *refname = resolve_ref_unsafe("HEAD", 0, sha1, &flag);
> +
> +	if (!refname)
> +		die("No such ref: HEAD");
> +
> +	refname = shorten_unambiguous_ref(refname, 0);
> +	strbuf_addf(&sb, "branch.%s.remote", refname);
> +	if (git_config_get_string(sb.buf, &dest))
> +		return "origin";
> +	else
> +		return xstrdup(dest);
> +}
> +
> +/*
> + * The function takes at most 2 arguments. The first argument is the
> + * URL that navigates to the submodule origin repo. When relative, this URL
> + * is relative to the superproject origin URL repo. The second up_path
> + * argument, if specified, is the relative path that navigates
> + * from the submodule working tree to the superproject working tree.
> + *
> + * The output of the function is the origin URL of the submodule.
> + *
> + * The output will either be an absolute URL or filesystem path (if the
> + * superproject origin URL is an absolute URL or filesystem path,
> + * respectively) or a relative file system path (if the superproject
> + * origin URL is a relative file system path).
> + *
> + * When the output is a relative file system path, the path is either
> + * relative to the submodule working tree, if up_path is specified, or to
> + * the superproject working tree otherwise.
> + */
> +static const char *relative_url(const char *url, const char *up_path)
> +{
> +	int is_relative = 0;
> +	size_t len;
> +	char *remoteurl = NULL;
> +	char *sep = "/";
> +	const char *out;
> +	struct strbuf sb = STRBUF_INIT;
> +	const char *remote = get_default_remote();
> +	strbuf_addf(&sb, "remote.%s.url", remote);
> +
> +	if (git_config_get_string(sb.buf, &remoteurl))
> +		/* the repository is its own authoritative upstream */
> +		remoteurl = xgetcwd();
> +
> +	if (strip_suffix(remoteurl, "/", &len))
> +		remoteurl[len] = '\0';
> +
> +	if (strchr(remoteurl, ':') || skip_prefix(remoteurl, "/", &out))
> +		is_relative = 0;
> +	else if (skip_prefix(remoteurl, "./", &out) ||
> +		    skip_prefix(remoteurl, "../", &out))
> +		is_relative = 1;
> +	else {
> +		is_relative = 1;
> +		strbuf_reset(&sb);
> +		strbuf_addf(&sb, "./%s", remoteurl);
> +		remoteurl = strbuf_detach(&sb, NULL);
> +	}
> +
> +	while (url) {
> +		if (skip_prefix(url, "../", &out)) {
> +			char *rfind;
> +			url = out;
> +
> +			rfind = strrchr(remoteurl, '/');
> +			if (rfind)
> +				*rfind = '\0';
> +			else {
> +				rfind = strrchr(remoteurl, ':');
> +				if (rfind) {
> +					*rfind = '\0';
> +					sep = ":";
> +				} else {
> +					if (is_relative || !strcmp(".", remoteurl))
> +						die(N_("cannot strip one component off url '%s'"), remoteurl);
> +					else
> +						remoteurl = ".";
> +				}
> +			}
> +		} else if (skip_prefix(url, "./", &out))
> +			url = out;
> +		else
> +			break;
> +	}
> +	strbuf_reset(&sb);
> +	strbuf_addf(&sb, "%s%s%s", remoteurl, sep, url);
> +
> +	if (!skip_prefix(sb.buf, "./", &out))
> +		out = sb.buf;
> +	out = xstrdup(out);
> +
> +	strbuf_reset(&sb);
> +	strbuf_addf(&sb, "%s%s", is_relative && up_path ? up_path : "", out);
> +
> +	free((char*)out);
> +	return strbuf_detach(&sb, NULL);
> +}
> +
> +static int resolve_relative_url(int argc, const char **argv, const char *prefix)
> +{
> +	if (argc == 2)
> +		printf("%s\n", relative_url(argv[1], NULL));
> +	else if (argc == 3)
> +		printf("%s\n", relative_url(argv[1], argv[2]));
> +	else
> +		die("BUG: resolve_relative_url only accepts one or two arguments");
> +	return 0;
> +}
>
>   struct module_list {
>   	const struct cache_entry **entries;
> @@ -264,6 +383,7 @@ static struct cmd_struct commands[] = {
>   	{"list", module_list},
>   	{"name", module_name},
>   	{"clone", module_clone},
> +	{"resolve_relative_url", resolve_relative_url},
>   };
>
>   int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 9bc5c5f..6a7a3e4 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -46,79 +46,6 @@ prefix=
>   custom_name=
>   depth=
>
> -# The function takes at most 2 arguments. The first argument is the
> -# URL that navigates to the submodule origin repo. When relative, this URL
> -# is relative to the superproject origin URL repo. The second up_path
> -# argument, if specified, is the relative path that navigates
> -# from the submodule working tree to the superproject working tree.
> -#
> -# The output of the function is the origin URL of the submodule.
> -#
> -# The output will either be an absolute URL or filesystem path (if the
> -# superproject origin URL is an absolute URL or filesystem path,
> -# respectively) or a relative file system path (if the superproject
> -# origin URL is a relative file system path).
> -#
> -# When the output is a relative file system path, the path is either
> -# relative to the submodule working tree, if up_path is specified, or to
> -# the superproject working tree otherwise.
> -resolve_relative_url ()
> -{
> -	remote=$(get_default_remote)
> -	remoteurl=$(git config "remote.$remote.url") ||
> -		remoteurl=$(pwd) # the repository is its own authoritative upstream
> -	url="$1"
> -	remoteurl=${remoteurl%/}
> -	sep=/
> -	up_path="$2"
> -
> -	case "$remoteurl" in
> -	*:*|/*)
> -		is_relative=
> -		;;
> -	./*|../*)
> -		is_relative=t
> -		;;
> -	*)
> -		is_relative=t
> -		remoteurl="./$remoteurl"
> -		;;
> -	esac
> -
> -	while test -n "$url"
> -	do
> -		case "$url" in
> -		../*)
> -			url="${url#../}"
> -			case "$remoteurl" in
> -			*/*)
> -				remoteurl="${remoteurl%/*}"
> -				;;
> -			*:*)
> -				remoteurl="${remoteurl%:*}"
> -				sep=:
> -				;;
> -			*)
> -				if test -z "$is_relative" || test "." = "$remoteurl"
> -				then
> -					die "$(eval_gettext "cannot strip one component off url '\$remoteurl'")"
> -				else
> -					remoteurl=.
> -				fi
> -				;;
> -			esac
> -			;;
> -		./*)
> -			url="${url#./}"
> -			;;
> -		*)
> -			break;;
> -		esac
> -	done
> -	remoteurl="$remoteurl$sep${url%/}"
> -	echo "${is_relative:+${up_path}}${remoteurl#./}"
> -}
> -
>   # Resolve a path to be relative to another path.  This is intended for
>   # converting submodule paths when git-submodule is run in a subdirectory
>   # and only handles paths where the directory separator is '/'.
> @@ -281,7 +208,7 @@ cmd_add()
>   		die "$(gettext "Relative path can only be used from the toplevel of the working tree")"
>
>   		# dereference source url relative to parent's url
> -		realrepo=$(resolve_relative_url "$repo") || exit
> +		realrepo=$(git submodule--helper resolve_relative_url "$repo") || exit
>   		;;
>   	*:*|/*)
>   		# absolute url
> @@ -485,7 +412,7 @@ cmd_init()
>   			# Possibly a url relative to parent
>   			case "$url" in
>   			./*|../*)
> -				url=$(resolve_relative_url "$url") || exit
> +				url=$(git submodule--helper resolve_relative_url "$url") || exit
>   				;;
>   			esac
>   			git config submodule."$name".url "$url" ||
> @@ -1190,9 +1117,9 @@ cmd_sync()
>   			# guarantee a trailing /
>   			up_path=${up_path%/}/ &&
>   			# path from submodule work tree to submodule origin repo
> -			sub_origin_url=$(resolve_relative_url "$url" "$up_path") &&
> +			sub_origin_url=$(git submodule--helper resolve_relative_url "$url" "$up_path") &&
>   			# path from superproject work tree to submodule origin repo
> -			super_config_url=$(resolve_relative_url "$url") || exit
> +			super_config_url=$(git submodule--helper resolve_relative_url "$url") || exit
>   			;;
>   		*)
>   			sub_origin_url="$url"
>
