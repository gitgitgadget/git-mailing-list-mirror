From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Extend runtime prefix computation
Date: Fri, 15 Apr 2016 09:43:29 -0700
Message-ID: <xmqqfuumddqm.fsf@gitster.mtv.corp.google.com>
References: <20160415143001.GA67437@dinsnail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	David Abdurachmanov <David.Abdurachmanov@cern.ch>
To: Michael Weiser <michael.weiser@gmx.de>
X-From: git-owner@vger.kernel.org Fri Apr 15 18:43:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ar6qK-0003GE-1b
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 18:43:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836AbcDOQne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 12:43:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56482 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751619AbcDOQnd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 12:43:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E5C0513333;
	Fri, 15 Apr 2016 12:43:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L5/xKKrbs0Wmzo9NSZ2m7c3neNg=; b=XfLOo1
	Y9lwnl8+BufWfKwa/mSc8uC0K3HoDAGm4V4fDo44Z5zMLtEHLH9NClxc48BUCylw
	0AztopsVkPn84oXbZJjUgYeqwjMP/lNL2G1BhD/Y86Kt3P524QwQXs19PQ01BZf3
	najedDIje8BiBcISfZ7dy2bqNGTNbc7TCk2ZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l3X6eYaDtI2GLNJ4qbbhnFroRcdbd5YB
	k89I4TOCqSs42+3NMpAawm6Ijn3doLN/FE3hXDDKPupC+WR2JhwHwb0rSJ4RVAlB
	mY7eWZJi8Ymygl+3XXIAgpmP9jSaZisGRz5exh/3NsZUVuKrQx6KNwJrJPm0qYx+
	0Vq5qse/Bdw=
Received: from pb-smtp2. (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DE21C13332;
	Fri, 15 Apr 2016 12:43:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4061913331;
	Fri, 15 Apr 2016 12:43:31 -0400 (EDT)
In-Reply-To: <20160415143001.GA67437@dinsnail.net> (Michael Weiser's message
	of "Fri, 15 Apr 2016 16:30:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2FDA3304-0329-11E6-9709-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291613>

Michael Weiser <michael.weiser@gmx.de> writes:

> Make git fully relocatable at runtime extending the runtime prefix
> calculation. Handle absolute and relative paths in argv0. Handle no path
> at all in argv0 in a system-specific manner.  Replace assertions with
> initialised variables and checks that lead to fallback to the static
> prefix.

That's a dense description of "what" without saying much about
"why".  Hint: start by describing what case(s) the current code
fails to find the correct runtime prefix.  That would give readers a
better understanding of what problem you are trying to solve.

Missing sign-off.

> diff --git a/exec_cmd.c b/exec_cmd.c
> index 9d5703a..f0db070 100644
> --- a/exec_cmd.c
> +++ b/exec_cmd.c
> @@ -3,30 +3,27 @@
>  #include "quote.h"
>  #include "argv-array.h"
>  #define MAX_ARGS	32
> +#if defined(__APPLE__)
> +#include <mach-o/dyld.h>
> +#endif

We tend to avoid system specific includes in individual *.c files.

Perhaps implement platform specific bits in compat/?  E.g. each
platform specific file in compat/ may implement and export the same
git_extract_argv_path() function, perhaps, so that this file does
not even need to know what platforms it supports?

>  char *system_path(const char *path)
>  {
> -#ifdef RUNTIME_PREFIX
> -	static const char *prefix;
> -#else
>  	static const char *prefix = PREFIX;
> -#endif
>  	struct strbuf d = STRBUF_INIT;
>  
>  	if (is_absolute_path(path))
>  		return xstrdup(path);
>  
>  #ifdef RUNTIME_PREFIX
> -	assert(argv0_path);
> -	assert(is_absolute_path(argv0_path));

Aren't these protecting against future and careless change that
forgets to call extract-argv0-path or make that function return
something that is not an absolute path?

Is it a good idea to drop these checks, and if so why?

> -	if (!prefix &&
> -	    !(prefix = strip_path_suffix(argv0_path, GIT_EXEC_PATH)) &&
> -	    !(prefix = strip_path_suffix(argv0_path, BINDIR)) &&
> -	    !(prefix = strip_path_suffix(argv0_path, "git"))) {
> +	if (!argv0_path ||
> +	    !is_absolute_path(argv0_path) ||
> +	    (!(prefix = strip_path_suffix(argv0_path, GIT_EXEC_PATH)) &&
> +	     !(prefix = strip_path_suffix(argv0_path, BINDIR)) &&
> +	     !(prefix = strip_path_suffix(argv0_path, "git")))) {
>  		prefix = PREFIX;
>  		trace_printf("RUNTIME_PREFIX requested, "
>  				"but prefix computation failed.  "
> @@ -41,6 +38,8 @@ char *system_path(const char *path)
>  const char *git_extract_argv0_path(const char *argv0)
>  {
>  	const char *slash;
> +	char *to_resolve = NULL;
> +	const char *resolved;
>  
>  	if (!argv0 || !*argv0)
>  		return NULL;
> @@ -48,11 +47,56 @@ const char *git_extract_argv0_path(const char *argv0)
>  	slash = find_last_dir_sep(argv0);
>  
>  	if (slash) {
> -		argv0_path = xstrndup(argv0, slash - argv0);
> -		return slash + 1;
> +		/* ... it's either an absolute path */
> +		if (is_absolute_path(argv0)) {
> +			argv0_path = xstrndup(argv0, slash - argv0);
> +			return slash + 1;
> +		}
> +
> +		/* ... or a relative path, in which case we have to make it
> +		 * absolute first and do the whole thing again */
> +		to_resolve = xstrdup(argv0);
> +	} else {
> +		/* argv0 is no path at all, just a name. Resolve it into a
> +		 * path. Unfortunately, this gets system specific. */
> +#if defined(__linux__)
> +		struct stat st;
> +		if (!stat("/proc/self/exe", &st))
> +			to_resolve = xstrdup("/proc/self/exe");
> +#elif defined(__APPLE__)
> +		/* call with len == 0 queries the necessary buffer size */
> +		uint32_t len = 0;
> +		if(_NSGetExecutablePath(NULL, &len) != 0) {
> +			to_resolve = malloc(len);
> +			if (to_resolve) {
> +				/* get the executable path now we have a buffer
> +				 * of proper size */
> +				if(_NSGetExecutablePath(to_resolve, &len) != 0) {
> +					free(to_resolve);
> +					return argv0;
> +				}
> +			}
> +		}
> +#endif
> +
> +		/* if to_resolve is still NULL here, something failed above or
> +		 * we are on an unsupported system. system_path() will warn
> +		 * and fall back to the static prefix */
> +		if (!to_resolve)
> +			return argv0;
>  	}
>  
> -	return argv0;
> +	/* resolve path from absolute to canonical */
> +	resolved = real_path(to_resolve);
> +	free(to_resolve);
> +
> +	slash = find_last_dir_sep(resolved);
> +	if (!slash)
> +		return argv0;
> +
> +	argv0_path = xstrndup(resolved, slash - resolved);
> +	slash = xstrdup(slash + 1);
> +	return slash;
>  }
>  
>  void git_set_argv_exec_path(const char *exec_path)
