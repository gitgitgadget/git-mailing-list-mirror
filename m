From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 4/7] commit: fix patch hunk editing with "commit -p -m"
Date: Wed, 19 Mar 2014 08:32:24 +0100
Message-ID: <53294808.8030106@web.de>
References: <xmqqmwgoejwq.fsf@gitster.dls.corp.google.com> <1395136856-17225-1-git-send-email-benoit.pierre@gmail.com> <1395136856-17225-4-git-send-email-benoit.pierre@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Benoit Pierre <benoit.pierre@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 08:32:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQAzQ-0007r8-VS
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 08:32:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755897AbaCSHch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 03:32:37 -0400
Received: from mout.web.de ([212.227.15.14]:49745 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753250AbaCSHcg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 03:32:36 -0400
Received: from [10.0.2.15] ([217.41.18.1]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0M8hwt-1XLjmc3Ycl-00wEjd; Wed, 19 Mar 2014 08:32:35
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131104 Icedove/17.0.10
In-Reply-To: <1395136856-17225-4-git-send-email-benoit.pierre@gmail.com>
X-Provags-ID: V03:K0:6jqPYnEGKpnmpUJjQksgTgI5QRjLCWFhuScqKu07hZL3xtclgKm
 pjXVezGQOfMVO97pbKJKBPxfRoi339ENtSAen9TE2hY7EgtmwenkyYb0x5qGOV8RvjlYpaQ
 VH+CnSRuD2ahSG6wunCvI/zPdwVQfh8rY0FT+yQ3zhqvE7v1XGJdZMPFGivLYJJAKn5wMUS
 7wKHx8VUAe2zSOAmIhD2w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244415>

On 03/18/2014 11:00 AM, Benoit Pierre wrote:
> Don't change git environment: move the GIT_EDITOR=":" override to the
> hook command subprocess, like it's already done for GIT_INDEX_FILE.
>
> Signed-off-by: Benoit Pierre <benoit.pierre@gmail.com>
> ---
>   builtin/checkout.c      |  8 ++++----
>   builtin/clone.c         |  4 ++--
>   builtin/commit.c        | 35 ++++++++++++++++++++++++++++-------
>   builtin/gc.c            |  2 +-
>   builtin/merge.c         |  6 +++---
>   commit.h                |  3 +++
>   run-command.c           | 44 ++++++++++++++++++++++++++++++++------------
>   run-command.h           |  6 +++++-
>   t/t7514-commit-patch.sh |  4 ++--
>   9 files changed, 80 insertions(+), 32 deletions(-)
>
[]
> index 3914d9c..75abc47 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -760,13 +760,11 @@ char *find_hook(const char *name)
>   	return path;
>   }
>
> -int run_hook(const char *index_file, const char *name, ...)
> +int run_hook_ve(const char *const *env, const char *name, va_list args)
>   {
>   	struct child_process hook;
>   	struct argv_array argv = ARGV_ARRAY_INIT;
> -	const char *p, *env[2];
> -	char index[PATH_MAX];
(Please see below)
> -	va_list args;
> +	const char *p;
>   	int ret;
>
>   	p = find_hook(name);
> @@ -775,23 +773,45 @@ int run_hook(const char *index_file, const char *name, ...)
>
>   	argv_array_push(&argv, p);
>
> -	va_start(args, name);
>   	while ((p = va_arg(args, const char *)))
>   		argv_array_push(&argv, p);
> -	va_end(args);
>
>   	memset(&hook, 0, sizeof(hook));
>   	hook.argv = argv.argv;
> +	hook.env = env;
>   	hook.no_stdin = 1;
>   	hook.stdout_to_stderr = 1;
> -	if (index_file) {
> -		snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
> -		env[0] = index;
> -		env[1] = NULL;
> -		hook.env = env;
> -	}
>
>   	ret = run_command(&hook);
>   	argv_array_clear(&argv);
>   	return ret;
>   }
> +
> +int run_hook_le(const char *const *env, const char *name, ...)
> +{
> +	va_list args;
> +	int ret;
> +
> +	va_start(args, name);
> +	ret = run_hook_ve(env, name, args);
> +	va_end(args);
> +
> +	return ret;
> +}
> +
> +int run_hook_with_custom_index(const char *index_file, const char *name, ...)
> +{
> +	const char *hook_env[3] =  { NULL };
> +	char index[PATH_MAX];
Sorry being late with the review.

Recently some effort has been put to replace the
  "PATH_MAX/snprintf() combo" with code using strbuf.

So I think for new developed code it could make sense to avoid PATH_MAX 
from the start.
To my knowledge mkpathdup() from path.c can be used,
(or are there better ways ?)
and the whole function will look like below (not tested)

> +	va_list args;
> +	int ret;
> +
> +	snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
> +	hook_env[0] = index;
> +
> +	va_start(args, name);
> +	ret = run_hook_ve(hook_env, name, args);
> +	va_end(args);
> +
> +	return ret;
> +}

int run_hook_with_custom_index(const char *index_file, const char *name, 
...)
{
	const char *hook_env[3] =  { NULL };
	char index = mkpathdup("GIT_INDEX_FILE=%s", index_file);
	va_list args;
	int ret;

	hook_env[0] = index;

	va_start(args, name);
	ret = run_hook_ve(hook_env, name, args);
	va_end(args);

	free(index);
	return ret;
}




> diff --git a/run-command.h b/run-command.h
> index 6b985af..88460f9 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -47,7 +47,11 @@ int run_command(struct child_process *);
>
>   extern char *find_hook(const char *name);
>   LAST_ARG_MUST_BE_NULL
> -extern int run_hook(const char *index_file, const char *name, ...);
> +extern int run_hook_le(const char *const *env, const char *name, ...);
> +extern int run_hook_ve(const char *const *env, const char *name, va_list args);
> +
> +LAST_ARG_MUST_BE_NULL
> +extern int run_hook_with_custom_index(const char *index_file, const char *name, ...);
>
>   #define RUN_COMMAND_NO_STDIN 1
>   #define RUN_GIT_CMD	     2	/*If this is to be git sub-command */
> diff --git a/t/t7514-commit-patch.sh b/t/t7514-commit-patch.sh
> index 41dd37a..998a210 100755
> --- a/t/t7514-commit-patch.sh
> +++ b/t/t7514-commit-patch.sh
> @@ -15,7 +15,7 @@ test_expect_success 'setup (initial)' '
>   	git commit -m commit1
>   '
>
> -test_expect_failure 'edit hunk "commit -p -m message"' '
> +test_expect_success 'edit hunk "commit -p -m message"' '
>   	test_when_finished "rm -f editor_was_started" &&
>   	rm -f editor_was_started &&
>   	echo more >>file &&
> @@ -23,7 +23,7 @@ test_expect_failure 'edit hunk "commit -p -m message"' '
>   	test -r editor_was_started
>   '
>
> -test_expect_failure 'edit hunk "commit --dry-run -p -m message"' '
> +test_expect_success 'edit hunk "commit --dry-run -p -m message"' '
>   	test_when_finished "rm -f editor_was_started" &&
>   	rm -f editor_was_started &&
>   	echo more >>file &&
>
