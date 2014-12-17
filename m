From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v3] remote: add --fetch and --both options to set-url
Date: Wed, 17 Dec 2014 11:08:07 +0100
Message-ID: <54915607.9020304@web.de>
References: <1416916106-19892-1-git-send-email-peter@lekensteyn.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Peter Wu <peter@lekensteyn.nl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 17 11:08:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1BX2-0001W9-SX
	for gcvg-git-2@plane.gmane.org; Wed, 17 Dec 2014 11:08:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127AbaLQKI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2014 05:08:28 -0500
Received: from mout.web.de ([212.227.15.4]:50881 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750894AbaLQKIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2014 05:08:25 -0500
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MSIwN-1YU21G01E3-00TUXI; Wed, 17 Dec 2014 11:08:13
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.3.0
In-Reply-To: <1416916106-19892-1-git-send-email-peter@lekensteyn.nl>
X-Provags-ID: V03:K0:ft+zVcE6iyhPGl4xoFni5Rf0yPfBHRCuipjhE+fF83QqpMRBuBF
 +ffs8ffdWS7p4Zbc9YbvClRBHPOiqzVO5l2/9/HW1Lg7pybmIOJGE0eKNmhY0VpsDBJi9Z/
 DXhtK43El3puiY9x8iFGWRcFqUfrZco81/v6mEz5yHxRAIP+A43g7JMWym+XxjZwfky8TVZ
 UKTRexjlWYfBDd5hYwVAA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261478>

On 11/25/2014 12:48 PM, Peter Wu wrote:
> git remote set-url knew about the '--push' option to update just the
> pushurl, but it does not have a similar option for "update fetch URL and
> leave whatever was in place for the push URL".
>
> This patch adds support for a '--fetch' option which implements that use
> case in a backwards compatible way: if no --both, --push or --fetch
> options are given, then the push URL is modified too if it was not set
> before. This is the case since the push URL is implicitly based on the
> fetch URL.
>
> A '--both' option is added to make the command independent of previous
> pushurl settings. For the --add and --delete set operations, it will
> always set the push and/ or the fetch URLs. For the primary mode of
> operation (without --add or --delete), it will drop pushurl as the
> implicit push URL is the (fetch) URL.
>
> The documentation has also been updated and a missing '--push' option
> is added to the 'git remote -h' command.
>
> Tests are also added to verify the documented behavior.
>
> Signed-off-by: Peter Wu <peter@lekensteyn.nl>
> ---
>
>   v2: fixed test case
>   v3: added --both option, changed --fetch --push behavior, added more tests for
>       --add/--delete cases, refactored to reduce duplication (not special-casing
>       add_mode without oldurl, just skip initially setting oldurl).
>
> Translators note: the help text gained more translatable strings and some
> strings got additional options.
> ---
>   Documentation/git-remote.txt |  17 ++++--
>   builtin/remote.c             | 140 +++++++++++++++++++++++++++----------------
>   t/t5505-remote.sh            | 125 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 228 insertions(+), 54 deletions(-)
>
> diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
> index cb103c8..bdd0305 100644
> --- a/Documentation/git-remote.txt
> +++ b/Documentation/git-remote.txt
> @@ -15,9 +15,9 @@ SYNOPSIS
>   'git remote remove' <name>
>   'git remote set-head' <name> (-a | --auto | -d | --delete | <branch>)
>   'git remote set-branches' [--add] <name> <branch>...
> -'git remote set-url' [--push] <name> <newurl> [<oldurl>]
> -'git remote set-url --add' [--push] <name> <newurl>
> -'git remote set-url --delete' [--push] <name> <url>
> +'git remote set-url' [--both | --fetch | --push] <name> <newurl> [<oldurl>]
> +'git remote set-url' [--both | --fetch | --push] '--add' <name> <newurl>
> +'git remote set-url' [--both | --fetch | --push] '--delete' <name> <url>
>   'git remote' [-v | --verbose] 'show' [-n] <name>...
>   'git remote prune' [-n | --dry-run] <name>...
>   'git remote' [-v | --verbose] 'update' [-p | --prune] [(<group> | <remote>)...]
> @@ -134,7 +134,16 @@ Changes URL remote points to. Sets first URL remote points to matching
>   regex <oldurl> (first URL if no <oldurl> is given) to <newurl>. If
>   <oldurl> doesn't match any URL, error occurs and nothing is changed.
>   +
> -With '--push', push URLs are manipulated instead of fetch URLs.
> +With '--both', both the fetch and push URLs are manipulated.
> ++
> +With '--fetch', only fetch URLs are manipulated.
> ++
> +With '--push', only push URLs are manipulated.
> ++
> +If none of the '--both', '--fetch' or --push' options are given, then
> +'--both' applies only if no push URL was set before. Otherwise '--fetch'
> +is assumed for historical reasons. This default may change in the
> +future to '--both' to avoid surprises depending on the configuration.
>   +
>   With '--add', instead of changing some URL, new URL is added.
>   +
> diff --git a/builtin/remote.c b/builtin/remote.c
> index 7f28f92..a250b23 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -18,9 +18,9 @@ static const char * const builtin_remote_usage[] = {
>   	N_("git remote prune [-n | --dry-run] <name>"),
>   	N_("git remote [-v | --verbose] update [-p | --prune] [(<group> | <remote>)...]"),
>   	N_("git remote set-branches [--add] <name> <branch>..."),
> -	N_("git remote set-url [--push] <name> <newurl> [<oldurl>]"),
> -	N_("git remote set-url --add <name> <newurl>"),
> -	N_("git remote set-url --delete <name> <url>"),
> +	N_("git remote set-url [--both | --fetch | --push] <name> <newurl> [<oldurl>]"),
> +	N_("git remote set-url [--both | --fetch | --push] --add <name> <newurl>"),
> +	N_("git remote set-url [--both | --fetch | --push] --delete <name> <url>"),
>   	NULL
>   };
>   
> @@ -66,9 +66,9 @@ static const char * const builtin_remote_update_usage[] = {
>   };
>   
>   static const char * const builtin_remote_seturl_usage[] = {
> -	N_("git remote set-url [--push] <name> <newurl> [<oldurl>]"),
> -	N_("git remote set-url --add <name> <newurl>"),
> -	N_("git remote set-url --delete <name> <url>"),
> +	N_("git remote set-url [--both | --fetch | --push] <name> <newurl> [<oldurl>]"),
> +	N_("git remote set-url [--both | --fetch | --push] --add <name> <newurl>"),
> +	N_("git remote set-url [--both | --fetch | --push] --delete <name> <url>"),
>   	NULL
>   };
>   
> @@ -1503,21 +1503,35 @@ static int set_branches(int argc, const char **argv)
>   	return set_remote_branches(argv[0], argv + 1, add_mode);
>   }
>   
> +#define MODIFY_TYPE_FETCH       (1 << 0)
> +#define MODIFY_TYPE_PUSH        (1 << 1)
> +#define MODIFY_TYPE_BOTH        (MODIFY_TYPE_FETCH | MODIFY_TYPE_PUSH)
> +#define MODIFY_TYPE_HISTORIC    (MODIFY_TYPE_FETCH | (1 << 2))
> +
>   static int set_url(int argc, const char **argv)
>   {
> -	int i, push_mode = 0, add_mode = 0, delete_mode = 0;
> +	int i, add_mode = 0, delete_mode = 0;
> +	int modify_type = MODIFY_TYPE_HISTORIC;
>   	int matches = 0, negative_matches = 0;
>   	const char *remotename = NULL;
>   	const char *newurl = NULL;
>   	const char *oldurl = NULL;
>   	struct remote *remote;
>   	regex_t old_regex;
> -	const char **urlset;
> -	int urlset_nr;
> -	struct strbuf name_buf = STRBUF_INIT;
> +	struct strbuf name_buf_fetch = STRBUF_INIT;
> +	struct strbuf name_buf_push = STRBUF_INIT;
>   	struct option options[] = {
> -		OPT_BOOL('\0', "push", &push_mode,
> -			 N_("manipulate push URLs")),
> +		OPT_GROUP(""),
> +		OPT_SET_INT('\0', "fetch", &modify_type,
> +			N_("manipulate just fetch URLs"),
> +			MODIFY_TYPE_FETCH),
> +		OPT_SET_INT('\0', "push", &modify_type,
> +			N_("manipulate just push URLs"),
> +			MODIFY_TYPE_PUSH),
> +		OPT_SET_INT('\0', "both", &modify_type,
> +			N_("manipulate both push and fetch URLs"),
> +			MODIFY_TYPE_BOTH),
> +		OPT_GROUP(""),
>   		OPT_BOOL('\0', "add", &add_mode,
>   			 N_("add URL")),
>   		OPT_BOOL('\0', "delete", &delete_mode,
> @@ -1535,7 +1549,8 @@ static int set_url(int argc, const char **argv)
>   
>   	remotename = argv[1];
>   	newurl = argv[2];
> -	if (argc > 3)
> +	/* The old URL is only meaningful for the primary non-set operation. */
> +	if (argc > 3 && !add_mode && !delete_mode)
>   		oldurl = argv[3];
>   
>   	if (delete_mode)
> @@ -1545,47 +1560,72 @@ static int set_url(int argc, const char **argv)
>   		die(_("No such remote '%s'"), remotename);
>   	remote = remote_get(remotename);
>   
> -	if (push_mode) {
> -		strbuf_addf(&name_buf, "remote.%s.pushurl", remotename);
> -		urlset = remote->pushurl;
> -		urlset_nr = remote->pushurl_nr;
> -	} else {
> -		strbuf_addf(&name_buf, "remote.%s.url", remotename);
> -		urlset = remote->url;
> -		urlset_nr = remote->url_nr;
> +	strbuf_addf(&name_buf_fetch, "remote.%s.url", remotename);
> +	strbuf_addf(&name_buf_push, "remote.%s.pushurl", remotename);
> +
> +	if (oldurl && !add_mode) {
> +		/* Old URL specified, or deletion. Demand that one matches. */
> +		if (regcomp(&old_regex, oldurl, REG_EXTENDED))
> +			die(_("Invalid old URL pattern: %s"), oldurl);
> +
> +		if (modify_type & MODIFY_TYPE_FETCH)
> +			for (i = 0; i < remote->url_nr; i++)
> +				if (!regexec(&old_regex, remote->url[i], 0, NULL, 0))
> +					matches++;
> +				else
> +					negative_matches++;
> +		if (delete_mode && !negative_matches && modify_type & MODIFY_TYPE_FETCH)
> +			die(_("Will not delete all non-push URLs"));
> +		if (modify_type & MODIFY_TYPE_PUSH)
> +			for (i = 0; i < remote->pushurl_nr; i++)
> +				if (!regexec(&old_regex, remote->pushurl[i], 0, NULL, 0))
> +					matches++;
> +				else
> +					negative_matches++;
There are 2 warning  "dangling else", line 1570 and 1578
I think we should use:

			for (i = 0; i < remote->pushurl_nr; i++) {
				if (!regexec(&old_regex, remote->pushurl[i], 0, NULL, 0))
					matches++;
				else
					negative_matches++;
			}
