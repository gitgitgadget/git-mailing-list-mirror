From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH/RFC] rewrite `git_default_config()` using config-set API
 functions
Date: Mon, 21 Jul 2014 14:59:35 +0100
Message-ID: <53CD1CC7.1020004@ramsay1.demon.co.uk>
References: <1405941145-12120-1-git-send-email-tanayabh@gmail.com> <53CCFD02.6010704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 21 15:59:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9E80-0006n2-Eb
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 15:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755123AbaGUN7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2014 09:59:40 -0400
Received: from mdfmta005.mxout.tch.inty.net ([91.221.169.46]:59375 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754974AbaGUN7j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2014 09:59:39 -0400
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id DD79918CB35;
	Mon, 21 Jul 2014 14:59:47 +0100 (BST)
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id 8060218CB0F;
	Mon, 21 Jul 2014 14:59:47 +0100 (BST)
Received: from [192.168.254.7] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta005.tch.inty.net (Postfix) with ESMTP;
	Mon, 21 Jul 2014 14:59:46 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53CCFD02.6010704@gmail.com>
X-MDF-HostID: 18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253966>

On 21/07/14 12:44, Tanay Abhra wrote:
> Use `git_config_get_*()` family instead of `git_config()` to take advantage of
> the config-set API which provides a cleaner control flow.
> 
> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
> ---
> Consider this as a proof of concept as the others callers have to be rewritten
> as well.
> I think that it is not so buggy as it passes all the tests.
> After the first six patches in the series which you have already seen there are
> five or four left which can rewritten without touching git_default_config().
> 
> Thus, this rewrite will serve as the base for rewriting other git_config()
> callers which pass control to git_default_config() at the end of the function.
> Also there are more than thirty direct callers to git_default_config()
> (i.e git_config(git_default_config, NULL)), so this rewrite solves them
> in one sweep.
> 
> Slight behaviour change, config_error_nonbool() has been replaced with
> die("Missing value for '%s'", var);.
> The original code also alerted the file name and the line number which we lose here.
> 
> Cheers,
> Tanay Abhra.
> 
>  advice.c |  18 ++--
>  advice.h |   2 +-
>  cache.h  |   2 +-
>  config.c | 287 ++++++++++++++++++++-------------------------------------------
>  ident.c  |  15 ++--
>  5 files changed, 104 insertions(+), 220 deletions(-)
> 

[snip]


> diff --git a/config.c b/config.c
> index fe9f399..72196a9 100644
> --- a/config.c
> +++ b/config.c
> @@ -666,88 +666,47 @@ int git_config_pathname(const char **dest, const char *var, const char *value)
>  	return 0;
>  }
> 
> -static int git_default_core_config(const char *var, const char *value)
> +static void git_default_core_config(void)
>  {
> +	const char *value = NULL;
>  	/* This needs a better name */
> -	if (!strcmp(var, "core.filemode")) {
> -		trust_executable_bit = git_config_bool(var, value);
> -		return 0;
> -	}
> -	if (!strcmp(var, "core.trustctime")) {
> -		trust_ctime = git_config_bool(var, value);
> -		return 0;
> -	}
> -	if (!strcmp(var, "core.checkstat")) {
> +	git_config_get_bool("core.filemode", &trust_executable_bit);
> +	git_config_get_bool("core.trustctime", &trust_ctime);
> +
> +	if (!git_config_get_value("core.checkstat", &value)) {
>  		if (!strcasecmp(value, "default"))
>  			check_stat = 1;
>  		else if (!strcasecmp(value, "minimal"))
>  			check_stat = 0;
>  	}
> 
> -	if (!strcmp(var, "core.quotepath")) {
> -		quote_path_fully = git_config_bool(var, value);
> -		return 0;
> -	}
> -
> -	if (!strcmp(var, "core.symlinks")) {
> -		has_symlinks = git_config_bool(var, value);
> -		return 0;
> -	}
> -
> -	if (!strcmp(var, "core.ignorecase")) {
> -		ignore_case = git_config_bool(var, value);
> -		return 0;
> -	}
> -
> -	if (!strcmp(var, "core.attributesfile"))
> -		return git_config_pathname(&git_attributes_file, var, value);
> -
> -	if (!strcmp(var, "core.bare")) {
> -		is_bare_repository_cfg = git_config_bool(var, value);
> -		return 0;
> -	}
> -
> -	if (!strcmp(var, "core.ignorestat")) {
> -		assume_unchanged = git_config_bool(var, value);
> -		return 0;
> -	}
> -
> -	if (!strcmp(var, "core.prefersymlinkrefs")) {
> -		prefer_symlink_refs = git_config_bool(var, value);
> -		return 0;
> -	}
> -
> -	if (!strcmp(var, "core.logallrefupdates")) {
> -		log_all_ref_updates = git_config_bool(var, value);
> -		return 0;
> -	}
> +	git_config_get_bool("core.quotepath", &quote_path_fully);
> +	git_config_get_bool("core.symlinks", &has_symlinks);
> +	git_config_get_bool("core.ignorecase", &ignore_case);
> +	git_config_get_pathname("core.attributesfile", &git_attributes_file);
> +	git_config_get_bool("core.bare", &is_bare_repository_cfg);
> +	git_config_get_bool("core.ignorestat", &assume_unchanged);
> +	git_config_get_bool("core.prefersymlinkrefs", &prefer_symlink_refs);
> +	git_config_get_bool("core.logallrefupdates", &log_all_ref_updates);
> +	git_config_get_bool("core.warnambiguousrefs", &warn_ambiguous_refs);
> 
> -	if (!strcmp(var, "core.warnambiguousrefs")) {
> -		warn_ambiguous_refs = git_config_bool(var, value);
> -		return 0;
> +	int abbrev;

declaration after statement.

> +	if (!git_config_get_int("core.abbrev", &abbrev)) {
> +		if (abbrev >= minimum_abbrev && abbrev <= 40)
> +			default_abbrev = abbrev;
>  	}
> 
> -	if (!strcmp(var, "core.abbrev")) {
> -		int abbrev = git_config_int(var, value);
> -		if (abbrev < minimum_abbrev || abbrev > 40)
> -			return -1;
> -		default_abbrev = abbrev;
> -		return 0;
> -	}
> -
> -	if (!strcmp(var, "core.loosecompression")) {
> -		int level = git_config_int(var, value);
> +	int level;

ditto.

> +	if (!git_config_get_int("core.loosecompression", &level)) {
>  		if (level == -1)
>  			level = Z_DEFAULT_COMPRESSION;
>  		else if (level < 0 || level > Z_BEST_COMPRESSION)
>  			die("bad zlib compression level %d", level);
>  		zlib_compression_level = level;
>  		zlib_compression_seen = 1;
> -		return 0;
>  	}
> 
> -	if (!strcmp(var, "core.compression")) {
> -		int level = git_config_int(var, value);
> +	if (!git_config_get_int("core.compression", &level)) {
>  		if (level == -1)
>  			level = Z_DEFAULT_COMPRESSION;
>  		else if (level < 0 || level > Z_BEST_COMPRESSION)
> @@ -756,57 +715,39 @@ static int git_default_core_config(const char *var, const char *value)
>  		core_compression_seen = 1;
>  		if (!zlib_compression_seen)
>  			zlib_compression_level = level;
> -		return 0;
>  	}
> 
> -	if (!strcmp(var, "core.packedgitwindowsize")) {
> +	if (!git_config_get_ulong("core.packedgitwindowsize", (long unsigned int*)&packed_git_window_size)) {
>  		int pgsz_x2 = getpagesize() * 2;
> -		packed_git_window_size = git_config_ulong(var, value);
> 
>  		/* This value must be multiple of (pagesize * 2) */
>  		packed_git_window_size /= pgsz_x2;
>  		if (packed_git_window_size < 1)
>  			packed_git_window_size = 1;
>  		packed_git_window_size *= pgsz_x2;
> -		return 0;
> -	}
> -
> -	if (!strcmp(var, "core.bigfilethreshold")) {
> -		big_file_threshold = git_config_ulong(var, value);
> -		return 0;
>  	}
> 
> -	if (!strcmp(var, "core.packedgitlimit")) {
> -		packed_git_limit = git_config_ulong(var, value);
> -		return 0;
> -	}
> +	git_config_get_ulong("core.bigfilethreshold", &big_file_threshold);
> +	git_config_get_ulong("core.packedgitlimit", (long unsigned int*)&packed_git_limit);
> +	git_config_get_ulong("core.deltabasecachelimit", (long unsigned int*)&delta_base_cache_limit);
> 
> -	if (!strcmp(var, "core.deltabasecachelimit")) {
> -		delta_base_cache_limit = git_config_ulong(var, value);
> -		return 0;
> -	}
> -
> -	if (!strcmp(var, "core.autocrlf")) {
> +	if (!git_config_get_value("core.autocrlf", &value)) {
>  		if (value && !strcasecmp(value, "input")) {
>  			if (core_eol == EOL_CRLF)
> -				return error("core.autocrlf=input conflicts with core.eol=crlf");
> +				die("core.autocrlf=input conflicts with core.eol=crlf");
>  			auto_crlf = AUTO_CRLF_INPUT;
> -			return 0;
> -		}
> -		auto_crlf = git_config_bool(var, value);
> -		return 0;
> +		} else
> +			auto_crlf = git_config_bool("core.autocrlf", value);
>  	}
> 
> -	if (!strcmp(var, "core.safecrlf")) {
> -		if (value && !strcasecmp(value, "warn")) {
> +	if (!git_config_get_value("core.safecrlf", &value)) {
> +		if (value && !strcasecmp(value, "warn"))
>  			safe_crlf = SAFE_CRLF_WARN;
> -			return 0;
> -		}
> -		safe_crlf = git_config_bool(var, value);
> -		return 0;
> +		else
> +			safe_crlf = git_config_bool("core.safecrlf", value);
>  	}
> 
> -	if (!strcmp(var, "core.eol")) {
> +	if (!git_config_get_value("core.eol", &value)) {
>  		if (value && !strcasecmp(value, "lf"))
>  			core_eol = EOL_LF;
>  		else if (value && !strcasecmp(value, "crlf"))
> @@ -816,108 +757,74 @@ static int git_default_core_config(const char *var, const char *value)
>  		else
>  			core_eol = EOL_UNSET;
>  		if (core_eol == EOL_CRLF && auto_crlf == AUTO_CRLF_INPUT)
> -			return error("core.autocrlf=input conflicts with core.eol=crlf");
> -		return 0;
> +			die("core.autocrlf=input conflicts with core.eol=crlf");
>  	}
> 
> -	if (!strcmp(var, "core.notesref")) {
> -		notes_ref_name = xstrdup(value);
> -		return 0;
> -	}
> -
> -	if (!strcmp(var, "core.pager"))
> -		return git_config_string(&pager_program, var, value);
> -
> -	if (!strcmp(var, "core.editor"))
> -		return git_config_string(&editor_program, var, value);
> +	git_config_get_string("core.notesref", (const char**)&notes_ref_name);
> +	git_config_get_string("core.pager", &pager_program);
> +	git_config_get_string("core.editor", &editor_program);
> 
> -	if (!strcmp(var, "core.commentchar")) {
> -		const char *comment;
> -		int ret = git_config_string(&comment, var, value);
> -		if (ret)
> -			return ret;
> -		else if (!strcasecmp(comment, "auto"))
> +	const char *comment;

ditto. I gave up here.

ATB,
Ramsay Jones
