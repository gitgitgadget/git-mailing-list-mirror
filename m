From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 1/4] submodule: implement `module_list` as a builtin
 helper
Date: Wed, 5 Aug 2015 20:31:29 +0200
Message-ID: <55C25681.3010208@web.de>
References: <1438733070-15805-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, hvoigt@hvoigt.net
To: Stefan Beller <sbeller@google.com>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 05 20:31:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZN3To-0008DD-Kw
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 20:31:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755AbbHESbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 14:31:52 -0400
Received: from mout.web.de ([212.227.15.3]:55326 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752619AbbHESbv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 14:31:51 -0400
Received: from [192.168.178.41] ([79.211.101.152]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0Mbudy-1Z5vnh0tYk-00JKZF; Wed, 05 Aug 2015 20:31:47
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <1438733070-15805-1-git-send-email-sbeller@google.com>
X-Provags-ID: V03:K0:aQqvgjDa0ArPm2gEnIfFpZ0qOaDLB0UCZnifcl1WcOReeaRoZ8t
 0oYiu7viA7uexKAHrDF1tsOCOBoOWcnAfId7dY2Sr2Nk2STdc+seiOeMUWc7qRjCRNal3ep
 ALkzd1hbsIQxBHfLdPm5eQH9wdSF61c1uE7Tew3ZDefoxAd++BgUV5TXl4NtD9qhLXqjyUc
 /4U/8pYqDt3ba9qvzcVnw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WmpBdwtuXgc=:cRkZEYG8G+wEZC9S1aDyup
 1tm5eBYDyPw1EOTazr7VK/9SOxt3jGFx331JAl819hQot+YJWVdFIsJchfg1djYLqJSx8Sj5r
 3jL3Mv1hjamtLd04vUGUBqxq46hID1SedwgpYbxNDEaKwIOo0reAkC0hhWX1PwpW77gnoGrL0
 5OHQc4q1FvRJyw0+P0FbDfG5hKw3sGA7xrYJH9rNVX443mU0qe837rWAxO/sIdnlJZsPvWMOS
 KA/ZdAAoVe+JB5XvpK28RUV9HqpUlkRTxv4y1D7yH2FKO5dchNL1QWy9oAqtOMFdo6V4dlL08
 fn4rIYWyoTmiU1sAaJgus3XvDJHAwUoKlQZDvdMtNnXIRgfKHHhTZFyy6jyUT9O1PEiGgkfqq
 0Rf58C31d659lYwOGLuKGcer6jHWgaTfuMTl84+OEToBf6RHrc9HcwJ2iqkMJcnWmw5qd0LGt
 z0anx3vEupz7qOmnx9Alvk1fFSbE0Y4nSPr16J9TS37qib1IfdV0EJt3rW7PJAZqiSxRpXbdL
 PTGE3JWZ8TB6XAOjnMWRUT5uc96tZ16LZzIA0m92YwYFvtW3fvnMJYX1j2v0aLM8rpsseMh8P
 xOGzNH+PmdTNyETAL+SU2fQr1OwUzO8Zo312OJ0nW4C1VKvh6wSaIB3X2TGyILWUcJNKjWhI/
 1WJdXVkqv5t8Nibdc75p8Y2ALGyELeuZVqVZ4KpIUTj/OVmyYl1rGyeu0DD4uxZh7h9Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275385>

Am 05.08.2015 um 02:04 schrieb Stefan Beller:
> Most of the submodule operations work on a set of submodules.
> Calculating and using this set is usually done via:
>
>         module_list "$@" | {
>             while read mode sha1 stage sm_path
>             do
>                  # the actual operation
>             done
>         }
>
> Currently the function `module_list` is implemented in the
> git-submodule.sh as a shell script wrapping a perl script.
> The rewrite is in C, such that it is faster and can later be
> easily adapted when other functions are rewritten in C.
>
> git-submodule.sh similar to the builtin commands will navigate
> to the top most directory of the repository and keeping the
> subdirectories as a variable. As the helper is called from
> within the git-submodule.sh script, we are already navigated
> to the root level, but the path arguments are stil relative
> to the subdirectory we were in when calling git-submodule.sh.
> That's why there is a `--prefix` option pointing to an alternative
> path where to anchor relative path arguments.

Great you are working on this! I'll try to help, but you might
see some latency as my Git time budget is currently very limited.

I think this patch is definitely going into the right direction.
The whole test suite runs 3 seconds faster for me with this
applied: best of three is 3:16 without and 3:13 with this patch.
That's quite an improvement, especially as only parts of the test
suite deal with submodules! (And I expect Windows users to profit
even more, considered how expensive forking is there)

Acked-by: Jens Lehmann <Jens.Lehmann@web.de>

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> The same as yesterday evening, just an entry added to .gitignore.
>
> So we'll have a "git submodule--helper module_list" here.
>
>   .gitignore                  |   1 +
>   Makefile                    |   1 +
>   builtin.h                   |   1 +
>   builtin/submodule--helper.c | 111 ++++++++++++++++++++++++++++++++++++++++++++
>   git-submodule.sh            |  54 +++------------------
>   git.c                       |   1 +
>   6 files changed, 121 insertions(+), 48 deletions(-)
>   create mode 100644 builtin/submodule--helper.c
>
> diff --git a/.gitignore b/.gitignore
> index a685ec1..2a69ba0 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -155,6 +155,7 @@
>   /git-status
>   /git-stripspace
>   /git-submodule
> +/git-submodule--helper
>   /git-svn
>   /git-symbolic-ref
>   /git-tag
> diff --git a/Makefile b/Makefile
> index 7efedbe..460d17a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -899,6 +899,7 @@ BUILTIN_OBJS += builtin/shortlog.o
>   BUILTIN_OBJS += builtin/show-branch.o
>   BUILTIN_OBJS += builtin/show-ref.o
>   BUILTIN_OBJS += builtin/stripspace.o
> +BUILTIN_OBJS += builtin/submodule--helper.o
>   BUILTIN_OBJS += builtin/symbolic-ref.o
>   BUILTIN_OBJS += builtin/tag.o
>   BUILTIN_OBJS += builtin/unpack-file.o
> diff --git a/builtin.h b/builtin.h
> index 839483d..924e6c4 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -119,6 +119,7 @@ extern int cmd_show(int argc, const char **argv, const char *prefix);
>   extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
>   extern int cmd_status(int argc, const char **argv, const char *prefix);
>   extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
> +extern int cmd_submodule__helper(int argc, const char **argv, const char *prefix);
>   extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
>   extern int cmd_tag(int argc, const char **argv, const char *prefix);
>   extern int cmd_tar_tree(int argc, const char **argv, const char *prefix);
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> new file mode 100644
> index 0000000..cb18ddf
> --- /dev/null
> +++ b/builtin/submodule--helper.c
> @@ -0,0 +1,111 @@
> +#include "builtin.h"
> +#include "cache.h"
> +#include "parse-options.h"
> +#include "quote.h"
> +#include "pathspec.h"
> +#include "dir.h"
> +#include "utf8.h"
> +
> +static char *ps_matched;
> +static const struct cache_entry **ce_entries;
> +static int ce_alloc, ce_used;
> +static struct pathspec pathspec;
> +static const char *alternative_path;
> +
> +static void module_list_compute(int argc, const char **argv,
> +				const char *prefix,
> +				struct pathspec *pathspec)
> +{
> +	int i;
> +	char *max_prefix;
> +	int max_prefix_len;
> +	parse_pathspec(pathspec, 0,
> +		       PATHSPEC_PREFER_FULL |
> +		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
> +		       prefix, argv);
> +
> +	/* Find common prefix for all pathspec's */
> +	max_prefix = common_prefix(pathspec);
> +	max_prefix_len = max_prefix ? strlen(max_prefix) : 0;
> +
> +	if (pathspec->nr)
> +		ps_matched = xcalloc(1, pathspec->nr);
> +
> +
> +	if (read_cache() < 0)
> +		die("index file corrupt");
> +
> +	for (i = 0; i < active_nr; i++) {
> +		const struct cache_entry *ce = active_cache[i];
> +
> +		if (!match_pathspec(pathspec, ce->name, ce_namelen(ce),
> +				    max_prefix_len, ps_matched,
> +				    S_ISGITLINK(ce->ce_mode) | S_ISDIR(ce->ce_mode)))
> +			continue;
> +
> +		if (S_ISGITLINK(ce->ce_mode)) {
> +			ALLOC_GROW(ce_entries, ce_used + 1, ce_alloc);
> +			ce_entries[ce_used++] = ce;
> +		}
> +	}
> +}
> +
> +static int module_list(int argc, const char **argv, const char *prefix)
> +{
> +	int i;
> +	struct string_list already_printed = STRING_LIST_INIT_NODUP;
> +
> +	struct option module_list_options[] = {
> +		OPT_STRING(0, "prefix", &alternative_path,
> +			   N_("path"),
> +			   N_("alternative anchor for relative paths")),
> +		OPT_END()
> +	};
> +
> +	static const char * const git_submodule_helper_usage[] = {
> +		N_("git submodule--helper module_list [--prefix=<path>] [<path>...]"),
> +		NULL
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, module_list_options,
> +			     git_submodule_helper_usage, 0);
> +
> +	module_list_compute(argc, argv, alternative_path
> +					? alternative_path
> +					: prefix, &pathspec);
> +
> +	if (ps_matched && report_path_error(ps_matched, &pathspec, prefix)) {
> +		printf("#unmatched\n");
> +		return 1;
> +	}
> +
> +	for (i = 0; i < ce_used; i++) {
> +		const struct cache_entry *ce = ce_entries[i];
> +
> +		if (string_list_has_string(&already_printed, ce->name))
> +			continue;
> +
> +		if (ce_stage(ce)) {
> +			printf("%06o %s U\t", ce->ce_mode, sha1_to_hex(null_sha1));
> +		} else {
> +			printf("%06o %s %d\t", ce->ce_mode, sha1_to_hex(ce->sha1), ce_stage(ce));
> +		}
> +
> +		utf8_fprintf(stdout, "%s\n", ce->name);
> +
> +		string_list_insert(&already_printed, ce->name);
> +	}
> +	return 0;
> +}
> +
> +int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
> +{
> +	if (argc < 2)
> +		goto usage;
> +
> +	if (!strcmp(argv[1], "module_list"))
> +		return module_list(argc - 1, argv + 1, prefix);
> +
> +usage:
> +	usage("git submodule--helper module_list\n");
> +}
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 36797c3..af9ecef 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -145,48 +145,6 @@ relative_path ()
>   	echo "$result$target"
>   }
>
> -#
> -# Get submodule info for registered submodules
> -# $@ = path to limit submodule list
> -#
> -module_list()
> -{
> -	eval "set $(git rev-parse --sq --prefix "$wt_prefix" -- "$@")"
> -	(
> -		git ls-files -z --error-unmatch --stage -- "$@" ||
> -		echo "unmatched pathspec exists"
> -	) |
> -	@@PERL@@ -e '
> -	my %unmerged = ();
> -	my ($null_sha1) = ("0" x 40);
> -	my @out = ();
> -	my $unmatched = 0;
> -	$/ = "\0";
> -	while (<STDIN>) {
> -		if (/^unmatched pathspec/) {
> -			$unmatched = 1;
> -			next;
> -		}
> -		chomp;
> -		my ($mode, $sha1, $stage, $path) =
> -			/^([0-7]+) ([0-9a-f]{40}) ([0-3])\t(.*)$/;
> -		next unless $mode eq "160000";
> -		if ($stage ne "0") {
> -			if (!$unmerged{$path}++) {
> -				push @out, "$mode $null_sha1 U\t$path\n";
> -			}
> -			next;
> -		}
> -		push @out, "$_\n";
> -	}
> -	if ($unmatched) {
> -		print "#unmatched\n";
> -	} else {
> -		print for (@out);
> -	}
> -	'
> -}
> -
>   die_if_unmatched ()
>   {
>   	if test "$1" = "#unmatched"
> @@ -532,7 +490,7 @@ cmd_foreach()
>   	# command in the subshell (and a recursive call to this function)
>   	exec 3<&0
>
> -	module_list |
> +	git submodule--helper module_list --prefix "$wt_prefix"|
>   	while read mode sha1 stage sm_path
>   	do
>   		die_if_unmatched "$mode"
> @@ -592,7 +550,7 @@ cmd_init()
>   		shift
>   	done
>
> -	module_list "$@" |
> +	git submodule--helper module_list --prefix "$wt_prefix" "$@" |
>   	while read mode sha1 stage sm_path
>   	do
>   		die_if_unmatched "$mode"
> @@ -674,7 +632,7 @@ cmd_deinit()
>   		die "$(eval_gettext "Use '.' if you really want to deinitialize all submodules")"
>   	fi
>
> -	module_list "$@" |
> +	git submodule--helper module_list --prefix "$wt_prefix" "$@" |
>   	while read mode sha1 stage sm_path
>   	do
>   		die_if_unmatched "$mode"
> @@ -790,7 +748,7 @@ cmd_update()
>   	fi
>
>   	cloned_modules=
> -	module_list "$@" | {
> +	git submodule--helper module_list --prefix "$wt_prefix" "$@" | {
>   	err=
>   	while read mode sha1 stage sm_path
>   	do
> @@ -1222,7 +1180,7 @@ cmd_status()
>   		shift
>   	done
>
> -	module_list "$@" |
> +	git submodule--helper module_list --prefix "$wt_prefix" "$@" |
>   	while read mode sha1 stage sm_path
>   	do
>   		die_if_unmatched "$mode"
> @@ -1299,7 +1257,7 @@ cmd_sync()
>   		esac
>   	done
>   	cd_to_toplevel
> -	module_list "$@" |
> +	git submodule--helper module_list --prefix "$wt_prefix" "$@" |
>   	while read mode sha1 stage sm_path
>   	do
>   		die_if_unmatched "$mode"
> diff --git a/git.c b/git.c
> index 55c327c..deecba0 100644
> --- a/git.c
> +++ b/git.c
> @@ -469,6 +469,7 @@ static struct cmd_struct commands[] = {
>   	{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
>   	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
>   	{ "stripspace", cmd_stripspace },
> +	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP },
>   	{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
>   	{ "tag", cmd_tag, RUN_SETUP },
>   	{ "unpack-file", cmd_unpack_file, RUN_SETUP },
>
