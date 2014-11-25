From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] change contract between system_path and it's callers
Date: Tue, 25 Nov 2014 13:13:24 -0800
Message-ID: <xmqqfvd7rnkb.fsf@gitster.dls.corp.google.com>
References: <CANCZXo4=D=RPnGeAfcvD0O1hX0B43z1b11gyzjbJYGXzusfFYg@mail.gmail.com>
	<1416939854-29930-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 22:13:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtNQT-0003iy-Hu
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 22:13:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbaKYVN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 16:13:29 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63009 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750875AbaKYVN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 16:13:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EE5D51EEF7;
	Tue, 25 Nov 2014 16:13:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rbz4DXGiSZSm6wjC7DzvtgCVelQ=; b=OkRqZF
	pDjOPwsOR1pBTPEFycB/iAI8uEgveo9bUfRBNkOW2r+7XxaJ/EEWinzSjMx2Z+1U
	1TbyCvHeS+RxMvlA4gL5t1DjUp9L1Ke40bifZCUhweblA5iUwKRIfUFudY9O55sF
	dcNvm2LpTKSMBhLW3uatpQ+IekHTxqqYNGY+0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q2LB5TiP6ei2Q3YWsnx7rhjs8bx8Ti0V
	B5GHvCzNnhZgUefGmyta3YqMv9cOdmARlp788xbkvQFia2zXSF45r6kPKZ6u5tn8
	TShFPxosZnzJQg6urxnUsQvJPEnN+Gpw0FKMmm2cXngtygMuy4967MuBxeBSYOXI
	5XgO4A1Ng6E=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E5AFB1EEF6;
	Tue, 25 Nov 2014 16:13:26 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B5FA61EEF5;
	Tue, 25 Nov 2014 16:13:25 -0500 (EST)
In-Reply-To: <1416939854-29930-1-git-send-email-kuleshovmail@gmail.com>
	(Alexander Kuleshov's message of "Wed, 26 Nov 2014 00:24:14 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E51496A0-74E7-11E4-AAC7-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260241>

Alexander Kuleshov <kuleshovmail@gmail.com> writes:

> Now system_path returns path which is allocated string to callers;
> It prevents memory leaks in some places. All callers of system_path
> are owners of path string and they must release it.
>
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---

Comparing this with what I sent out...

>  builtin/help.c | 10 +++++++---
>  exec_cmd.c     | 17 +++++++++--------
>  exec_cmd.h     |  4 ++--
>  git.c          | 16 ++++++++++++----
>  4 files changed, 30 insertions(+), 17 deletions(-)
>
> @@ -372,7 +373,9 @@ static void show_man_page(const char *git_cmd)
>  static void show_info_page(const char *git_cmd)
>  {
>  	const char *page = cmd_to_page(git_cmd);
> -	setenv("INFOPATH", system_path(GIT_INFO_PATH), 1);
> +	char *git_info_path = system_path(GIT_INFO_PATH);
> +	setenv("INFOPATH", git_info_path, 1);
> +	free(git_info_path);

We are just about to exec; does this warrant the code churn?

>  	execlp("info", "info", "gitman", page, (char *)NULL);
>  	die(_("no info viewer handled the request"));

> @@ -34,8 +34,7 @@ const char *system_path(const char *path)
>  #endif
>  
>  	strbuf_addf(&d, "%s/%s", prefix, path);
> -	path = strbuf_detach(&d, NULL);
> -	return path;
> +	return d.buf;

These happens to be the same with the current strbuf implementation,
but it is a good manner to use strbuf_detach(&d, NULL) here.  We
don't know what other de-initialization tomorrow's implementation of
the strbuf API may have to do in strbuf_detach().

> @@ -68,16 +67,16 @@ void git_set_argv_exec_path(const char *exec_path)
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

Now you are making callers of git_exec_path() responsible for
freeing the result they receive.

git_exec_path() may be called quite a lot, which means we may end up
calling system_path() many times during the life of a process
without freeing its return value, so this change may be worth doing,
but this patch is insufficient, isn't it?

You just added load_command_list() in help.c a new leak or two, for
example.  There probably are other callers of this function but I
don't have time to look at all of them myself right now.

> @@ -95,8 +94,10 @@ void setup_path(void)
>  {
>  	const char *old_path = getenv("PATH");
>  	struct strbuf new_path = STRBUF_INIT;
> +	char* exec_path = git_exec_path();
>  
> -	add_path(&new_path, git_exec_path());
> +	add_path(&new_path, exec_path);
> +	free(exec_path);
>  	add_path(&new_path, argv0_path);

This part by itself is good, provided if we make it the caller's
responsiblity to free string returned by git_exec_path().

> diff --git a/git.c b/git.c
> index 82d7a1c..d01c4f1 100644
> --- a/git.c
> +++ b/git.c
> @@ -95,17 +95,25 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>  			if (*cmd == '=')
>  				git_set_argv_exec_path(cmd + 1);
>  			else {
> -				puts(git_exec_path());
> +				char *exec_path = git_exec_path();
> +				puts(exec_path);
> +				free(exec_path);
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

None of these warrant the code churn, I would say.
