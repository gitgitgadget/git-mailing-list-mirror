From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 2/2] Reduce parse-options.o dependencies
Date: Thu, 11 Aug 2011 06:04:41 -0500
Message-ID: <20110811110441.GD5012@elie.gateway.2wire.net>
References: <1313054138-30885-1-git-send-email-divanorama@gmail.com>
 <1313054138-30885-3-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Barr <davidbarr@google.com>,
	Stephen Boyd <bebarino@gmail.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 11 13:04:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrT4H-0006jb-Jf
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 13:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966Ab1HKLEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 07:04:47 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:64662 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253Ab1HKLEq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 07:04:46 -0400
Received: by iye16 with SMTP id 16so1095310iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 04:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=oYSO8mwzbrv9yy4QDBsOAI3bLrRfdig8HCWbXJEFSpw=;
        b=LD1Cmsc043N8TlWwMgK2E0Zk7+cEPj/pQqZQieYAC7pkJqJfQuUxKErpRi/p1unXpM
         tHfCY40xkPfsZYKDk9q1o+p7OA6eSUGQsIYy1G3Ls865T9CQHUCb4pHIvLXxqAta3yGP
         EW6IIfl7387MKKz2Wbs9YdwF8NF61H/1hwvj0=
Received: by 10.231.200.3 with SMTP id eu3mr9831793ibb.24.1313060686232;
        Thu, 11 Aug 2011 04:04:46 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-69-68.dsl.chcgil.sbcglobal.net [69.209.69.68])
        by mx.google.com with ESMTPS id y14sm1429231ibf.62.2011.08.11.04.04.44
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 04:04:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1313054138-30885-3-git-send-email-divanorama@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179108>

(+cc: Stephen)
Dmitry Ivankov wrote:

> Currently parse-options.o pulls quite a big bunch of dependencies.
> his complicates it's usage in contrib/ because it pulls external
> dependencies and it also increases executables size.
>
> Split off less generic and more internal to git part of
> parse-options.c to parse-options-cb.c.
>
> Move prefix_filename function from setup.c to abspath.c. abspath.o
> and wrapper.o pull each other, so it's unlikely to increase the
> dependencies. It was a dependency of parse-options.o that pulled
> many others.
>
> Now parse-options.o pulls just abspath.o, ctype.o, strbuf.o, usage.o,
> wrapper.o, libc directly and strlcpy.o indirectly.

So, in other words, currently linking to parse-options involves
linking to git's object access machinery and diff machinery, hence
libz, libssl for SHA-1, libpcre, etc.  That is a waste of space,
startup time, and build complexity for simple programs that do not
need access to git's object db.

This patch does two things to address that:

 - option callbacks which freely use the git object db and other
   facilities move to a separate parse-options-cb.o translation
   unit, so simple programs can avoid them;

 - prefix_filename, which is used to support OPTION_FILENAME,
   moves from setup.c to abspath.c, so it can be used without
   pulling in unrelated git machinery.

The result is, as you say, that use of parse-options.o only pulls
in abspath, ctype, strbuf, usage, wrapper, and -lc --- which is to
say, just utility functions --- and you can build a program using
parse-options with a simple commandline like

	cc -o test-program -Wall -W -O2 test-program.c libgit.a

Okay, on to the patch itself (comments sparsely scattered within).

>
> Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
> ---
>  Makefile           |    3 +-
>  abspath.c          |   28 ++++++++++++
>  parse-options-cb.c |  125 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  parse-options.c    |  121 --------------------------------------------------
>  setup.c            |   28 ------------
>  5 files changed, 155 insertions(+), 150 deletions(-)
>  create mode 100644 parse-options-cb.c
> 
> diff --git a/Makefile b/Makefile
> index 62ad0c2..7d47bdb 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -642,6 +642,7 @@ LIB_OBJS += pack-revindex.o
>  LIB_OBJS += pack-write.o
>  LIB_OBJS += pager.o
>  LIB_OBJS += parse-options.o
> +LIB_OBJS += parse-options-cb.o
>  LIB_OBJS += patch-delta.o
>  LIB_OBJS += patch-ids.o
>  LIB_OBJS += path.o
> @@ -2204,7 +2205,7 @@ test-delta$X: diff-delta.o patch-delta.o
>  
>  test-line-buffer$X: vcs-svn/lib.a
>  
> -test-parse-options$X: parse-options.o
> +test-parse-options$X: parse-options.o parse-options-cb.o
>  
>  test-string-pool$X: vcs-svn/lib.a
>  
> diff --git a/abspath.c b/abspath.c
> index 37287f8..f04ac18 100644
> --- a/abspath.c
> +++ b/abspath.c
> @@ -139,3 +139,31 @@ const char *absolute_path(const char *path)
>  	}
>  	return buf;
>  }
> +
> +/*
> + * Unlike prefix_path, this should be used if the named file does
> + * not have to interact with index entry; i.e. name of a random file
> + * on the filesystem.
> + */
> +const char *prefix_filename(const char *pfx, int pfx_len, const char *arg)
> +{
> +	static char path[PATH_MAX];
> +#ifndef WIN32
> +	if (!pfx_len || is_absolute_path(arg))
> +		return arg;
> +	memcpy(path, pfx, pfx_len);
> +	strcpy(path + pfx_len, arg);
> +#else
> +	char *p;
> +	/* don't add prefix to absolute paths, but still replace '\' by '/' */
> +	if (is_absolute_path(arg))
> +		pfx_len = 0;
> +	else if (pfx_len)
> +		memcpy(path, pfx, pfx_len);
> +	strcpy(path + pfx_len, arg);
> +	for (p = path + pfx_len; *p; p++)
> +		if (*p == '\\')
> +			*p = '/';
> +#endif
> +	return path;
> +}
> diff --git a/parse-options-cb.c b/parse-options-cb.c
> new file mode 100644
> index 0000000..c248f66
> --- /dev/null
> +++ b/parse-options-cb.c
> @@ -0,0 +1,125 @@
> +#include "git-compat-util.h"
> +#include "parse-options.h"
> +#include "cache.h"

Style: Files in git tend to use only one of "git-compat-util.h",
"cache.h", or "builtin.h" and put it at the top.  So in this case, it
should probably use just "cache.h".

> +#include "commit.h"
> +#include "color.h"
> +#include "string-list.h"
> +
> +/*----- some often used options -----*/
> +
> +int parse_opt_abbrev_cb(const struct option *opt, const char *arg, int unset)
> +{
> +	int v;
> +
> +	if (!arg) {
> +		v = unset ? 0 : DEFAULT_ABBREV;
> +	} else {
> +		v = strtol(arg, (char **)&arg, 10);
> +		if (*arg)
> +			return opterror(opt, "expects a numerical value", 0);
> +		if (v && v < MINIMUM_ABBREV)
> +			v = MINIMUM_ABBREV;
> +		else if (v > 40)
> +			v = 40;
> +	}
> +	*(int *)(opt->value) = v;
> +	return 0;
> +}
> +
> +int parse_opt_approxidate_cb(const struct option *opt, const char *arg,
> +			     int unset)
> +{
> +	*(unsigned long *)(opt->value) = approxidate(arg);
> +	return 0;
> +}
> +
> +int parse_opt_color_flag_cb(const struct option *opt, const char *arg,
> +			    int unset)
> +{
> +	int value;
> +
> +	if (!arg)
> +		arg = unset ? "never" : (const char *)opt->defval;
> +	value = git_config_colorbool(NULL, arg, -1);
> +	if (value < 0)
> +		return opterror(opt,
> +			"expects \"always\", \"auto\", or \"never\"", 0);
> +	*(int *)opt->value = value;
> +	return 0;
> +}
> +
> +int parse_opt_verbosity_cb(const struct option *opt, const char *arg,
> +			   int unset)
> +{
> +	int *target = opt->value;
> +
> +	if (unset)
> +		/* --no-quiet, --no-verbose */
> +		*target = 0;
> +	else if (opt->short_name == 'v') {
> +		if (*target >= 0)
> +			(*target)++;
> +		else
> +			*target = 1;
> +	} else {
> +		if (*target <= 0)
> +			(*target)--;
> +		else
> +			*target = -1;
> +	}
> +	return 0;
> +}
> +
> +int parse_opt_with_commit(const struct option *opt, const char *arg, int unset)
> +{
> +	unsigned char sha1[20];
> +	struct commit *commit;
> +
> +	if (!arg)
> +		return -1;
> +	if (get_sha1(arg, sha1))
> +		return error("malformed object name %s", arg);
> +	commit = lookup_commit_reference(sha1);
> +	if (!commit)
> +		return error("no such commit %s", arg);
> +	commit_list_insert(commit, opt->value);
> +	return 0;
> +}
> +
> +int parse_opt_tertiary(const struct option *opt, const char *arg, int unset)
> +{
> +	int *target = opt->value;
> +	*target = unset ? 2 : 1;
> +	return 0;
> +}
> +
> +int parse_options_concat(struct option *dst, size_t dst_size, struct option *src)
> +{
> +	int i, j;
> +
> +	for (i = 0; i < dst_size; i++)
> +		if (dst[i].type == OPTION_END)
> +			break;
> +	for (j = 0; i < dst_size; i++, j++) {
> +		dst[i] = src[j];
> +		if (src[j].type == OPTION_END)
> +			return 0;
> +	}
> +	return -1;
> +}
> +
> +int parse_opt_string_list(const struct option *opt, const char *arg, int unset)
> +{
> +	struct string_list *v = opt->value;
> +
> +	if (unset) {
> +		string_list_clear(v, 0);
> +		return 0;
> +	}
> +
> +	if (!arg)
> +		return -1;
> +
> +	string_list_append(v, xstrdup(arg));
> +	return 0;
> +}
> diff --git a/parse-options.c b/parse-options.c
> index 7b061af..503ab5d 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -3,7 +3,6 @@
>  #include "cache.h"
>  #include "commit.h"
>  #include "color.h"
> -#include "string-list.h"
>  
>  static int parse_options_usage(struct parse_opt_ctx_t *ctx,
>  			       const char * const *usagestr,
> @@ -584,123 +583,3 @@ static int parse_options_usage(struct parse_opt_ctx_t *ctx,
>  	return usage_with_options_internal(ctx, usagestr, opts, 0, err);
>  }
>  
> -
> -/*----- some often used options -----*/
> -#include "cache.h"
> -
> -int parse_opt_abbrev_cb(const struct option *opt, const char *arg, int unset)
[... snip code moved verbatim ...]
> -}
> diff --git a/setup.c b/setup.c
> index 5ea5502..3463819 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -40,34 +40,6 @@ char *prefix_path(const char *prefix, int len, const char *path)
>  	return sanitized;
>  }
>  
> -/*
> - * Unlike prefix_path, this should be used if the named file does
> - * not have to interact with index entry; i.e. name of a random file
> - * on the filesystem.
> - */
> -const char *prefix_filename(const char *pfx, int pfx_len, const char *arg)
> -{
> -	static char path[PATH_MAX];
> -#ifndef WIN32
> -	if (!pfx_len || is_absolute_path(arg))
> -		return arg;
> -	memcpy(path, pfx, pfx_len);
> -	strcpy(path + pfx_len, arg);
> -#else
> -	char *p;
> -	/* don't add prefix to absolute paths, but still replace '\' by '/' */
> -	if (is_absolute_path(arg))
> -		pfx_len = 0;
> -	else if (pfx_len)
> -		memcpy(path, pfx, pfx_len);
> -	strcpy(path + pfx_len, arg);
> -	for (p = path + pfx_len; *p; p++)
> -		if (*p == '\\')
> -			*p = '/';
> -#endif
> -	return path;
> -}
> -
>  int check_filename(const char *prefix, const char *arg)
>  {
>  	const char *name;
> -- 
> 1.7.3.4
> 

Except for the commit message, and with or without the #include tweak
mentioned above,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.  This seems to be in pretty good shape (and as mentioned before,
gets closer to fulfillment of a longstanding wish :)).
