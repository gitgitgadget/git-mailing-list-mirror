From: 0xAX <kuleshovmail@gmail.com>
Subject: Re: [PATCH] exec_cmd: system_path memory leak fix
Date: Sun, 23 Nov 2014 20:01:39 +0600
Message-ID: <87h9xq108c.fsf@gmail.com>
References: <1416750981-24446-1-git-send-email-kuleshovmail@gmail.com> <1416750981-24446-2-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>
To: "git\@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 23 15:05:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XsXmz-0006nC-S9
	for gcvg-git-2@plane.gmane.org; Sun, 23 Nov 2014 15:05:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbaKWOFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Nov 2014 09:05:14 -0500
Received: from mail-la0-f43.google.com ([209.85.215.43]:49890 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbaKWOFN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Nov 2014 09:05:13 -0500
Received: by mail-la0-f43.google.com with SMTP id q1so6486841lam.30
        for <git@vger.kernel.org>; Sun, 23 Nov 2014 06:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=references:from:to:cc:subject:date:in-reply-to:message-id
         :mime-version:content-type;
        bh=UUsKrHYPtW6gDSUY5ZsSBS77eXdy8fgcbCcGizPlLyE=;
        b=gK3r7L25YePkkT2alBusR8X6ePzvwLgDzOUmhnByETjeGPeCUBiCJ0PSfWfy0exDYB
         3eTITN26cMW0uAdLHs16UVWk6xPgZdAfRG87HPLuqwq3o6vn+TFO/vJ72aZHcT1GsUKr
         Fa+DBz7nHEbu1qwFyhwe1VlawUP7V3gq1HTfTsrJ3pCz8hIT/RySCEpwpbz9t4OOveJY
         eK7oGHKOGYGtZzbCAlJS9wPpzOWujP2QkPJ+vDwCQ2PtYcpKgo/SBrE7BO7bRZlXcnNI
         yFs3Qkq51hQN02s34WSNLWGmUt6nKeYfpd2Pv7gkxsTjLAqgj493YfFPA4c3cX3eurP9
         Pq4w==
X-Received: by 10.112.24.130 with SMTP id u2mr15411380lbf.57.1416751511595;
        Sun, 23 Nov 2014 06:05:11 -0800 (PST)
Received: from alex-desktop ([92.46.64.151])
        by mx.google.com with ESMTPSA id nv1sm2742209lbb.38.2014.11.23.06.05.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Nov 2014 06:05:10 -0800 (PST)
In-reply-to: <1416750981-24446-2-git-send-email-kuleshovmail@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260086>


For example some testing with valgrind:

1. pu (952f0aaadff4afca1497450911587a973c8cca02)

valgrind git help
==27034== Memcheck, a memory error detector
==27034== Copyright (C) 2002-2013, and GNU GPL'd, by Julian Seward et al.
==27034== Using Valgrind-3.10.0 and LibVEX; rerun with -h for copyright info
==27034== Command: git help
==27034==
==27034== HERE GIT HELP OUTPUT
==27034==
==27034== HEAP SUMMARY:
==27034==     in use at exit: 65 bytes in 1 blocks
==27034==   total heap usage: 71 allocs, 70 frees, 11,928 bytes allocated
==27034==
==27034== LEAK SUMMARY:
==27034==    definitely lost: 65 bytes in 1 blocks
==27034==    indirectly lost: 0 bytes in 0 blocks
==27034==      possibly lost: 0 bytes in 0 blocks
==27034==    still reachable: 0 bytes in 0 blocks
==27034==         suppressed: 0 bytes in 0 blocks
==27034== Rerun with --leak-check=full to see details of leaked memory
==27034==
==27034== For counts of detected and suppressed errors, rerun with: -v
==27034== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)

2. With patch:

valgrind git help
==28945== Memcheck, a memory error detector
==28945== Copyright (C) 2002-2013, and GNU GPL'd, by Julian Seward et al.
==28945== Using Valgrind-3.10.0 and LibVEX; rerun with -h for copyright info
==28945== Command: git help
==28945==
==28945== HERE git help OUTPUT
==28945==
==28945== HEAP SUMMARY:
==28945==     in use at exit: 0 bytes in 0 blocks
==28945==   total heap usage: 72 allocs, 72 frees, 11,956 bytes allocated
==28945==
==28945== All heap blocks were freed -- no leaks are possible
==28945==
==28945== For counts of detected and suppressed errors, rerun with: -v
==28945== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)

Of course it is very small leak, but i just started to deep in git
source code. Hope i will be useful for community.

Thank you.

0xAX <kuleshovmail@gmail.com> @ 2014-11-23 19:56 ALMT:

> Signed-off-by: 0xAX <kuleshovmail@gmail.com>
> ---
>  exec_cmd.c | 25 ++++++++++++++++---------
>  exec_cmd.h |  4 ++--
>  git.c      | 12 +++++++++---
>  3 files changed, 27 insertions(+), 14 deletions(-)
>
> diff --git a/exec_cmd.c b/exec_cmd.c
> index 698e752..08f8f80 100644
> --- a/exec_cmd.c
> +++ b/exec_cmd.c
> @@ -6,7 +6,7 @@
>  static const char *argv_exec_path;
>  static const char *argv0_path;
>
> -const char *system_path(const char *path)
> +char *system_path(const char *path)
>  {
>  #ifdef RUNTIME_PREFIX
>  	static const char *prefix;
> @@ -14,9 +14,10 @@ const char *system_path(const char *path)
>  	static const char *prefix = PREFIX;
>  #endif
>  	struct strbuf d = STRBUF_INIT;
> +	char *new_path = NULL;
>
>  	if (is_absolute_path(path))
> -		return path;
> +		return strdup(path);
>
>  #ifdef RUNTIME_PREFIX
>  	assert(argv0_path);
> @@ -32,10 +33,13 @@ const char *system_path(const char *path)
>  				"Using static fallback '%s'.\n", prefix);
>  	}
>  #endif
> -
>  	strbuf_addf(&d, "%s/%s", prefix, path);
> -	path = strbuf_detach(&d, NULL);
> -	return path;
> +	new_path = malloc((strlen(prefix) + strlen(path)) + 2);
> +	sprintf(new_path, "%s/%s", prefix, path);
> +
> +	strbuf_release(&d);
> +
> +	return new_path;
>  }
>
>  const char *git_extract_argv0_path(const char *argv0)
> @@ -68,16 +72,16 @@ void git_set_argv_exec_path(const char *exec_path)
>
>
>  /* Returns the highest-priority, location to look for git programs. */
> -const char *git_exec_path(void)
> +char *git_exec_path(void)
>  {
>  	const char *env;
>
>  	if (argv_exec_path)
> -		return argv_exec_path;
> +		return strdup(argv_exec_path);
>
>  	env = getenv(EXEC_PATH_ENVIRONMENT);
>  	if (env && *env) {
> -		return env;
> +		return strdup(env);
>  	}
>
>  	return system_path(GIT_EXEC_PATH);
> @@ -96,7 +100,9 @@ void setup_path(void)
>  	const char *old_path = getenv("PATH");
>  	struct strbuf new_path = STRBUF_INIT;
>
> -	add_path(&new_path, git_exec_path());
> +	char *exec_path = git_exec_path();
> +
> +	add_path(&new_path, exec_path);
>  	add_path(&new_path, argv0_path);
>
>  	if (old_path)
> @@ -107,6 +113,7 @@ void setup_path(void)
>  	setenv("PATH", new_path.buf, 1);
>
>  	strbuf_release(&new_path);
> +	free(exec_path);
>  }
>
>  const char **prepare_git_cmd(const char **argv)
> diff --git a/exec_cmd.h b/exec_cmd.h
> index e4c9702..03c8599 100644
> --- a/exec_cmd.h
> +++ b/exec_cmd.h
> @@ -3,12 +3,12 @@
>
>  extern void git_set_argv_exec_path(const char *exec_path);
>  extern const char *git_extract_argv0_path(const char *path);
> -extern const char *git_exec_path(void);
> +extern char *git_exec_path(void);
>  extern void setup_path(void);
>  extern const char **prepare_git_cmd(const char **argv);
>  extern int execv_git_cmd(const char **argv); /* NULL terminated */
>  LAST_ARG_MUST_BE_NULL
>  extern int execl_git_cmd(const char *cmd, ...);
> -extern const char *system_path(const char *path);
> +extern char *system_path(const char *path);
>
>  #endif /* GIT_EXEC_CMD_H */
> diff --git a/git.c b/git.c
> index 82d7a1c..499dc2a 100644
> --- a/git.c
> +++ b/git.c
> @@ -99,13 +99,19 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>  				exit(0);
>  			}
>  		} else if (!strcmp(cmd, "--html-path")) {
> -			puts(system_path(GIT_HTML_PATH));
> +			char *git_html_path = system_path(GIT_HTML_PATH);
> +			puts(git_html_path);
> +			free(git_html_path);
>  			exit(0);
>  		} else if (!strcmp(cmd, "--man-path")) {
> -			puts(system_path(GIT_MAN_PATH));
> +			char *git_man_path = system_path(GIT_MAN_PATH);
> +			puts(git_man_path);
> +			free(git_man_path);
>  			exit(0);
>  		} else if (!strcmp(cmd, "--info-path")) {
> -			puts(system_path(GIT_INFO_PATH));
> +			char *git_info_path = system_path(GIT_INFO_PATH);
> +			puts(git_info_path);
> +			free(git_info_path);
>  			exit(0);
>  		} else if (!strcmp(cmd, "-p") || !strcmp(cmd, "--paginate")) {
>  			use_pager = 1;

--
Best regards.
0xAX
