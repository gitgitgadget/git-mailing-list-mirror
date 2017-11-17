Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26D30202A0
	for <e@80x24.org>; Fri, 17 Nov 2017 05:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756670AbdKQFJA (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 00:09:00 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60216 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756652AbdKQFI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Nov 2017 00:08:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CE3A2A6059;
        Fri, 17 Nov 2017 00:08:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AnJ6oQpRUnzpTJC58Xhzs5VQdk4=; b=nOIvC0
        kNbyV+/jy+gNYLaTOl8guYEr137Ba24vHBf6LowkTjncyQpwpMYrBRE1/bkXB0RN
        eJr1ncU7HXV/Pf7KbbtY6dnQ1T2ZWAgxZ3GcOy0CVesjYwBH+GJ4tjyOfYV1zQLQ
        pcE71cqdTLoYWT0jmlW37Ypoe4LOwPPxxv3v8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZZLv/DihonISwOHATlYPy9ll5GtB3/E8
        m/WxdFh3FJhS+vj+yz6GFRYMFrNmDsX63/Hzafns464OxBfpsf5zWLPu0GZrQDei
        /KbyBR8sf0N1cshBVIV8Trj/Yway7+4bnzPguKNU/q2WCE2nXmxeoJUZGIjCWUnb
        bV/qlVQxsFo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C450FA6055;
        Fri, 17 Nov 2017 00:08:57 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1BAABA6052;
        Fri, 17 Nov 2017 00:08:57 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dan Jacques <dnj@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] exec_cmd: RUNTIME_PREFIX on some POSIX systems
References: <20171116170523.28696-1-dnj@google.com>
        <20171116170523.28696-2-dnj@google.com>
Date:   Fri, 17 Nov 2017 14:08:55 +0900
In-Reply-To: <20171116170523.28696-2-dnj@google.com> (Dan Jacques's message of
        "Thu, 16 Nov 2017 12:05:23 -0500")
Message-ID: <xmqqh8ttsd94.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A20E7E2-CB55-11E7-9614-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dan Jacques <dnj@google.com> writes:

> Enable Git to resolve its own binary location using a variety of
> OS-specific and generic methods, including:
>
> - procfs via "/proc/self/exe" (Linux)
> - _NSGetExecutablePath (Darwin)
> - argv0, if absolute (all, including Windows).
>
> This is used to enable RUNTIME_PREFIX support for non-Windows systems,
> notably Linux and Darwin. When configured with RUNTIME_PREFIX, Git will
> do a best-effort resolution of its executable path and automatically use
> this as its "exec_path" for relative helper and data lookups, unless
> explicitly overridden.

Yay.

> Git will also always export and consume its resolved "exec_path" using
> the EXEC_PATH_ENVIRONMENT regardless of whether the user has overridden
> it, simplifying future lookups and ensuring consistency in Git tooling
> execution.

The "regardless of whether the user has overridden it" part sounded
alarming and made me wince twice.  I think you meant

 - If the user already has GIT_EXEC_PATH in the environment pointing
   somewhere, when we end up calling git_set_exec_path() to export
   the variable, the value we have at hand to be exported is what
   originally came from the user, bypassing the auto-detection logic
   this patch adds.

 - If the user did not have GIT_EXEC_PATH, the auto-detection logic
   is exercised, and the result is exported when git_set_exec_path()
   is called.  Any program that is spawned by us as a subprocess
   will inherit the same GIT_EXEC_PATH we detected.

As I have multiple installations of various versions of Git, I find
the latter somewhat disturbing.  

Suppose that I designate one stable version of Git and install it at
$HOME/git-stable/{bin,libexec,...}/, and want that version to always
be used in my hooks and other helper scripts that are spawned by
Git, even when I am trying out a newer version of Git that is under
testing.

My hooks would be running $HOME/git-stable/bin/git subcommand" (or
more realistically, it would do "PATH=$HOME/git-stable/bin:$PATH"
upfront), but with this patch (and with runtime-prefix layout) they
would use GIT_EXEC_PATH that was discovered and exported by the
version of Git under testing that invoked the hook, leading to an
inconsistent and hard to debug behaviour, no?

On the other hand, as long as existing GIT_EXEC_PATH is passed-thru
(i.e. the first point above), I think that is a sensible thing to
do.

> When building with a runtime prefix, Git's PERL libraries are now
> installed to a consistently-named directory. This path is resolved and
> exported to Git's delegate PERL invocations using the GITPERLLIB
> environment variable. This enables Git's delegate PERL scripts to import
> Git's own PERL libraries from a path relative to the executable.

Sounds good.

> Small incidental formatting cleanup of "exec_cmd.c".

We usually frown upon these because they often gets distracting, but
I didn't find the ones in this patch too bad.

> diff --git a/Makefile b/Makefile
> index ee9d5eb11..80db01706 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -296,7 +296,8 @@ all::
>  # Define PERL_PATH to the path of your Perl binary (usually /usr/bin/perl).
>  #
>  # Define NO_PERL_MAKEMAKER if you cannot use Makefiles generated by perl's
> -# MakeMaker (e.g. using ActiveState under Cygwin).
> +# MakeMaker (e.g. using ActiveState under Cygwin, or building with a fixed
> +# runtime prefix).

Windows folks may want to comment (either positively or negatively)
as they are the only ones that are currently using runtime-prefix
layout, especially on this part:

> @@ -1547,6 +1547,14 @@ else
>  endif
>  ifdef RUNTIME_PREFIX
>  	COMPAT_CFLAGS += -DRUNTIME_PREFIX
> +
> +	# Control PERL library location so it can be referenced by relocatable
> +	# code.
> +	NO_PERL_MAKEMAKER = YesPlease
> +endif


> diff --git a/cache.h b/cache.h
> index cb7fb7c00..9ef59f1cc 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -445,6 +445,8 @@ static inline enum object_type object_type(unsigned int mode)
>  #define GIT_ICASE_PATHSPECS_ENVIRONMENT "GIT_ICASE_PATHSPECS"
>  #define GIT_QUARANTINE_ENVIRONMENT "GIT_QUARANTINE_PATH"
>  #define GIT_OPTIONAL_LOCKS_ENVIRONMENT "GIT_OPTIONAL_LOCKS"
> +#define GIT_PERL_LIB_ENVIRONMENT "GITPERLLIB"
> +#define GIT_TEXT_DOMAIN_DIR_ENVIRONMENT "GIT_TEXTDOMAINDIR"

This is a nice touch.  The other day I noticed that we stopped
defining these when we start using a new enviornment variable, which
should be rectified (this is not within the scope of this patch--I
am just welcoming this change that fixes the existing issue a bit
without getting distracing).

> diff --git a/common-main.c b/common-main.c
> index 6a689007e..6516a1f89 100644
> --- a/common-main.c
> +++ b/common-main.c
> @@ -32,12 +32,12 @@ int main(int argc, const char **argv)
>  	 */
>  	sanitize_stdfds();
>  
> +	git_resolve_executable_dir(argv[0]);
> +
>  	git_setup_gettext();
>  
>  	attr_start();
>  
> -	git_extract_argv0_path(argv[0]);
> -

I presume that this is because we may need to know where to find the
locale stuff before calling git_setup_gettext(); makes sense.

> diff --git a/exec_cmd.c b/exec_cmd.c
> index ce192a2d6..10ca7a75a 100644
> --- a/exec_cmd.c
> +++ b/exec_cmd.c
> @@ -2,53 +2,187 @@
>  #include "exec_cmd.h"
>  #include "quote.h"
>  #include "argv-array.h"
> +
> +#if defined(RUNTIME_PREFIX) && defined(HAVE_NS_GET_EXECUTABLE_PATH)
> +#include <mach-o/dyld.h>
> +#endif
> +
>  #define MAX_ARGS	32
>  
>  static const char *argv_exec_path;
>  
> +static const char *system_prefix(void);
> +
>  #ifdef RUNTIME_PREFIX
> -static const char *argv0_path;
> +
> +/**
> + * When using a runtime prefix, Git dynamically resolves paths relative to its
> + * executable.
> + *
> + * The method for determining the path of the executable is highly
> + * platform-specific.
> + */
> +
> +/**
> + * Path to the current Git executable. Resolved on startup by
> + * 'git_resolve_executable_dir'.
> + */
> +static const char *executable_dirname;

OK, so that is a more appropriate name for the variable that is a
logical successor of argv0_path.  I wonder if the file-scope static
variable argv_exec_path we see above would want to move to somewhere
closer to one of these "platform specific methods", though.

>  static const char *system_prefix(void)
>  {
>  	static const char *prefix;
>  
> -	assert(argv0_path);
> -	assert(is_absolute_path(argv0_path));
> +	assert(executable_dirname);
> +	assert(is_absolute_path(executable_dirname));
>  
>  	if (!prefix &&
> -	    !(prefix = strip_path_suffix(argv0_path, GIT_EXEC_PATH)) &&
> -	    !(prefix = strip_path_suffix(argv0_path, BINDIR)) &&
> -	    !(prefix = strip_path_suffix(argv0_path, "git"))) {
> +	    !(prefix = strip_path_suffix(executable_dirname, GIT_EXEC_PATH)) &&
> +	    !(prefix = strip_path_suffix(executable_dirname, BINDIR)) &&
> +	    !(prefix = strip_path_suffix(executable_dirname, "git"))) {
>  		prefix = PREFIX;
>  		trace_printf("RUNTIME_PREFIX requested, "
> -				"but prefix computation failed.  "
> -				"Using static fallback '%s'.\n", prefix);
> +			     "but prefix computation failed.  "
> +			     "Using static fallback '%s'.\n",
> +			     prefix);
>  	}
>  	return prefix;
>  }
>  
> -void git_extract_argv0_path(const char *argv0)
> +/*
> + * Resolves the executable path from argv[0], only if it is absolute.
> + *
> + * Returns 0 on success, -1 on failure.
> + */
> +static int git_get_exec_path_from_argv0(struct strbuf *buf, const char *argv0)
>  {
>  	const char *slash;
>  
>  	if (!argv0 || !*argv0)
> -		return;
> +		return -1;
>  
>  	slash = find_last_dir_sep(argv0);
> +	if (slash) {
> +		trace_printf("Determined executable path from argv0: %s\n",
> +			     argv0);
> +		strbuf_add_absolute_path(buf, argv0);
> +		return 0;
> +	}
> +	return -1;
> +}
> +
> +#ifdef PROCFS_EXECUTABLE_PATH
> +/*
> + * Resolves the executable path by examining a procfs symlink.
> + *
> + * Returns 0 on success, -1 on failure.
> + */
> +static int git_get_exec_path_procfs(struct strbuf *buf)
> +{
> +	char *path = realpath(PROCFS_EXECUTABLE_PATH, NULL);

I think this is our first use of realpath(), which is XSI.

    http://pubs.opengroup.org/onlinepubs/9699919799/functions/realpath.html

I'd assume it is available on any platform on which we would want to
use PROCFS_EXECUTABLE_PATH, so this probably is OK.

> +	if (path) {
> +		trace_printf("Determined executable path from procfs: %s\n",
> +			     path);
> +		strbuf_addstr(buf, path);
> +		free(path);
> +		return 0;
> +	}
> +	return -1;
> +}
> +#endif /* PROCFS_EXECUTABLE_PATH */

> +/*
> + * Resolves the absolute path of the current executable by employing
> + * one or more platform-specific methods.
> + *
> + * Returns 0 on success, -1 on failure.
> + */
> +static int git_get_exec_path(struct strbuf *buf, const char *argv0)
> +{
> +	if (
> +#ifdef PROCFS_EXECUTABLE_PATH
> +		git_get_exec_path_procfs(buf) &&
> +#endif /* PROCFS_EXECUTABLE_PATH */
> +#ifdef HAVE_NS_GET_EXECUTABLE_PATH
> +		git_get_exec_path_darwin(buf) &&
> +#endif /* HAVE_NS_GET_EXECUTABLE_PATH */
> +		git_get_exec_path_from_argv0(buf, argv0)) {

The contract between this caller and these platform-specific helpers
is for the callee to return 0 when they succeed, and -1 when they
punt with "I dunno", so the &&-cascade stops after the first one
that returns 0.  I wonder why argv0 (i.e. the full-path case) is not
the first one to try, though---isn't that one the simplest?

Also, I wonder if this caller gets simpler to read and understand if
each of these "platform specific" ones are done like so:

	#ifdef FOO_EXECUTABLE_PATH
	static int git_get_exec_path_foo(struct strbuf *buf)
	{
		...
	}
	#else /* FOO_EXECUTABLE_PATH */
	#define git_get_exec_path_foo(buf) (-1)
	#endif

Then the caller can lose the ifdef/endif that is noisier than the
actual calls we see above, i.e.

	if (!git_get_exec_path_from_argv0(buf, argv0) ||
	    !git_get_exec_path_procfs(buf) ||
            !git_get_exec_path_darwin(buf)) {
		/* at least one of them found what we wanted */
		... do the success case ...
	} else {
		... oops, we failed to find ...
	}

> +void git_resolve_executable_dir(const char *argv0)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	char *resolved;
> +	const char *slash;
> +	const char *path;
> +
> +	path = getenv(EXEC_PATH_ENVIRONMENT);
> +	if (path) {
> +		trace_printf("Determined executable path from ENV: %s\n", path);
> +		executable_dirname = path;
> +	} else {
> +		if (git_get_exec_path(&buf, argv0)) {
> +			trace_printf(
> +				"Could not determine executable path from: %s\n",
> +				argv0);
> +			strbuf_release(&buf);
> +			return;
> +		}
> +
> +		resolved = strbuf_detach(&buf, NULL);
> +		slash = find_last_dir_sep(resolved);
> +		if (slash)
> +			resolved[slash - resolved] = '\0';
> +
> +		executable_dirname = resolved;
> +	}
>  
> -	if (slash)
> -		argv0_path = xstrndup(argv0, slash - argv0);
> +	trace_printf("Determined executable dir: %s\n", executable_dirname);
>  }

OK.

> -void git_set_argv_exec_path(const char *exec_path)
> +void git_set_exec_path(const char *exec_path)
>  {
>  	argv_exec_path = exec_path;
>  	/*

I wonder if we want to clean up this part of the system, in that
git_exec_path() is the only user of argv_exec_path which is now a
gross misnomer (the way you figured out exec_path may not be based
on argv at all).  Once resolve-executable-dir is called and we have
a value in executable_dirname, this argv_exec_path variable feels
more or less redundant.  But perhaps that is outside the scope of
this patch.  I dunno.

> @@ -101,12 +234,14 @@ static void add_path(struct strbuf *out, const char *path)
>  	}
>  }
>  
> -void setup_path(void)
> +void setup_path_and_env(void)
>  {
> +	const char *exec_path = git_exec_path();
>  	const char *old_path = getenv("PATH");
>  	struct strbuf new_path = STRBUF_INIT;
>  
> -	add_path(&new_path, git_exec_path());
> +	git_set_exec_path(exec_path);
> +	add_path(&new_path, exec_path);
>  
>  	if (old_path)
>  		strbuf_addstr(&new_path, old_path);
> @@ -116,6 +251,20 @@ void setup_path(void)
>  	setenv("PATH", new_path.buf, 1);
>  
>  	strbuf_release(&new_path);
> +
> +	/*
> +	 * If RUNTIME_PREFIX is set, the relative PERL library and locale paths
> +	 * must be exported for invoked programs to inherit the calculated
> +	 * runtime path.
> +	 *
> +	 * When RUNTIME_PREFIX is defined, Git's PERL include path is always
> +	 * "$(PREFIX)/lib" (by setting NO_PERL_MAKEMAKER).
> +	 */
> +#ifdef RUNTIME_PREFIX
> +	setenv(GIT_TEXT_DOMAIN_DIR_ENVIRONMENT, system_path(GIT_LOCALE_PATH),
> +	       1);
> +	setenv(GIT_PERL_LIB_ENVIRONMENT, system_path("lib"), 1);
> +#endif /* RUNTIME_PREFIX */
>  }

So..., now this function exports textdomain and perllib environment
when we are compiled with runtime-prefix, and exports GIT_EXEC_PATH
even when we are *not* compiled with runtime-prefix (by calling the
git_set_exec_path() function that does the exporting)?  That makes
the worry I expressed in an earlier part of the message even worse,
as I assumed this gratuitous exporting would be in effect only when
runtime-prefix is in use.  I hope I am mistaken...

> @@ -125,7 +274,8 @@ const char **prepare_git_cmd(struct argv_array *out, const char **argv)
>  	return out->argv;
>  }
>  
> -int execv_git_cmd(const char **argv) {
> +int execv_git_cmd(const char **argv)
> +{
>  	struct argv_array nargv = ARGV_ARRAY_INIT;
>  
>  	prepare_git_cmd(&nargv, argv);
> @@ -140,8 +290,7 @@ int execv_git_cmd(const char **argv) {
>  	return -1;
>  }
>  
> -
> -int execl_git_cmd(const char *cmd,...)
> +int execl_git_cmd(const char *cmd, ...)
>  {
>  	int argc;
>  	const char *argv[MAX_ARGS + 1];

These two are good changes (reducing the inter-function spacing
might not be in that "we'd probably prefer there wasn't an extra
blank line from the beginning, but it is not worth a patch noise to
remove it" sense).  Even though they are somewhat distracting,
seeing them after finishing reading the real changes is much less
bad than having to see distracting changes in the middle of real
changes during a review.

Thanks.
