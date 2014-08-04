From: Fabian Ruch <bafain@gmail.com>
Subject: Re: [PATCH v1 03/19] rebase -i: reword executes pre-commit hook on
 interim commit
Date: Mon, 04 Aug 2014 20:51:42 +0200
Message-ID: <53DFD63E.8040806@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1406589435.git.bafain@gmail.com> <1bb7c0b9aed60f7c65bf812ac42b2f1ad8fd3f82.1406589435.git.bafain@gmail.com> <20140801234708.GA20040@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 04 20:52:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XENMR-0005km-7H
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 20:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbaHDSvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 14:51:51 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:34454 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896AbaHDSvu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 14:51:50 -0400
Received: by mail-wi0-f169.google.com with SMTP id n3so6702267wiv.0
        for <git@vger.kernel.org>; Mon, 04 Aug 2014 11:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=UnuSV+/yYVuLW3r4R/eyTJjazn7OIGxnzqY9+EMmKls=;
        b=BV0TqrPW7r9Q1hn1IW/9T3tYmAQLMs2Yjv0qGKAvCZtoJ//vJQlISwmbTiWit73emx
         KuYB/XNfhXX/qXETP5sAK0lJah8q4RWyxvizDi0ckmaSB/jAdr9h8vJzLO1b5PQtRtWD
         3vbkFZzNsAOxD2LAZZwcuJzSeSdjzAlZioESd8K5SKuvdNImMvMafyxL1aV6nmNtPICI
         UI4qGZLKWugFk4Z9SJkPVl5ZL1O0UDw5QrcB7CJO652ToER9WdFtlKR5GEuf19mpeSuA
         hHJWbO0AyNpwtEXl0Ud6OVAyXhgRZ7fOYRx27VEvHAa5zQaUOTH5rDWYyl/tzt/jHKoB
         hIbQ==
X-Received: by 10.180.92.73 with SMTP id ck9mr33188872wib.54.1407178304680;
        Mon, 04 Aug 2014 11:51:44 -0700 (PDT)
Received: from client.googlemail.com (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id fq7sm8530578wic.14.2014.08.04.11.51.43
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 04 Aug 2014 11:51:43 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140801234708.GA20040@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254764>

Hi,

Jeff King writes:
> On Tue, Jul 29, 2014 at 01:18:03AM +0200, Fabian Ruch wrote:
> 
>> Specify the git-commit option `--no-verify` to disable the pre-commit
>> hook when editing the log message. Because `--no-verify` also skips
>> the commit-msg hook, execute the hook from within
>> git-rebase--interactive after the commit is created. Fortunately, the
>> commit message is still available in `$GIT_DIR/COMMIT_EDITMSG` after
>> git-commit terminates. Caveat: In case the commit-msg hook finds the
>> new log message ill-formatted, the user is only notified of the
>> failed commit-msg hook but the log message is used for the commit
>> anyway. git-commit ought to offer more fine-grained control over
>> which hooks are executed.
> 
> Thanks for a nice explanation of the tradeoff. Have you looked at adding
> an option to git-commit? We already have --no-post-rewrite. I think you
> would just need:
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 5ed6036..f7af220 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -102,6 +102,7 @@ static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
>  static int no_post_rewrite, allow_empty_message;
>  static char *untracked_files_arg, *force_date, *ignore_submodule_arg;
>  static char *sign_commit;
> +static int no_pre_commit;
>  
>  /*
>   * The default commit message cleanup mode will remove the lines
> @@ -661,7 +662,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  	/* This checks and barfs if author is badly specified */
>  	determine_author_info(author_ident);
>  
> -	if (!no_verify && run_commit_hook(use_editor, index_file, "pre-commit", NULL))
> +	if (!no_verify && !no_pre_commit &&
> +	    run_commit_hook(use_editor, index_file, "pre-commit", NULL))
>  		return 0;
>  
>  	if (squash_message) {
> @@ -1604,6 +1606,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  			 N_("terminate entries with NUL")),
>  		OPT_BOOL(0, "amend", &amend, N_("amend previous commit")),
>  		OPT_BOOL(0, "no-post-rewrite", &no_post_rewrite, N_("bypass post-rewrite hook")),
> +		OPT_BOOL(0, "no-pre-commit", &no_pre_commit, N_("bypass pre-commit hook")),
>  		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, N_("mode"), N_("show untracked files, optional modes: all, normal, no. (Default: all)"), PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
>  		/* end commit contents options */
>  
> 
> though I would also not be opposed to some more uniform hook selection
> mechanism (e.g., "--no-verify=pre-commit" or something).

While the --no-verify= mechanism doesn't add a new option to the
git-commit interface but lets one refine the --no-verify option, users
might find it weird to have an argument to name disabled hooks but then
not be able to disable all hooks that way.

To have that uniform hook selection without duplicating code, we might
want to have something like --bypass-hook= right away. This would cover
--no-post-rewrite as well and add support for disabling
prepare-commit-msg and post-commit, whose execution cannot be controlled
via the git-commit interface at the moment.

Since the hook selection wouldn't have to change, the options parsing
code seems to be simpler (--bypass-hook= would have to support several
occurrences with different arguments which could be implemented as an
OPT_CALLBACK?) and git-commit decided to have --no- options for hook
selection so far, I would lean towards your patch from above.

I know you didn't say anything otherwise, I just wanted to expand a
little. You find an amended version of your patch below that documents
--no-verify as a synonym for --no-pre-commit and --no-commit-msg, and
adds tests.

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 5e2221c..813aa78 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -98,12 +98,27 @@ static char *edit_message, *use_message;
>  static char *fixup_message, *squash_message;
>  static int all, also, interactive, patch_interactive, only, amend, signoff;
>  static int edit_flag = -1; /* unspecified */
> -static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
> +static int quiet, verbose, allow_empty, dry_run, renew_authorship;
>  static int no_post_rewrite, allow_empty_message;
>  static char *untracked_files_arg, *force_date, *ignore_submodule_arg;
>  static char *sign_commit;
>  
>  /*
> + * The verify variable is interpreted as a bitmap of enabled commit
> + * verification hooks according to the legend below.
> + *
> + * By default, the pre-commit and commit-msg hooks are enabled. This
> + * is represented by both the PRE_COMMIT and COMMIT_MSG bits being
> + * set.
> + *
> + * The bitmap is changed through the command line options
> + * --no-verify, --no-pre-commit and --no-commit-msg.
> + */
> +#define PRE_COMMIT (1<<0)
> +#define COMMIT_MSG (1<<1)
> +static int verify = PRE_COMMIT | COMMIT_MSG;
> +
> +/*
>   * The default commit message cleanup mode will remove the lines
>   * beginning with # (shell comments) and leading and trailing
>   * whitespaces (empty lines or containing only whitespaces)
> @@ -667,7 +682,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  	/* This checks and barfs if author is badly specified */
>  	determine_author_info(author_ident);
>  
> -	if (!no_verify && run_commit_hook(use_editor, index_file, "pre-commit", NULL))
> +	if (verify & PRE_COMMIT &&
> +	    run_commit_hook(use_editor, index_file, "pre-commit", NULL))
>  		return 0;
>  
>  	if (squash_message) {
> @@ -968,7 +984,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  		}
>  	}
>  
> -	if (!no_verify &&
> +	if (verify & COMMIT_MSG &&
>  	    run_commit_hook(use_editor, index_file, "commit-msg", git_path(commit_editmsg), NULL)) {
>  		return 0;
>  	}
> @@ -1597,7 +1613,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  		OPT_BOOL(0, "interactive", &interactive, N_("interactively add files")),
>  		OPT_BOOL('p', "patch", &patch_interactive, N_("interactively add changes")),
>  		OPT_BOOL('o', "only", &only, N_("commit only specified files")),
> -		OPT_BOOL('n', "no-verify", &no_verify, N_("bypass pre-commit hook")),
> +		OPT_NEGBIT('n', "no-verify", &verify,
> +			   N_("synonym for --no-pre-commit --no-commit-msg"),
> +			   PRE_COMMIT | COMMIT_MSG),
>  		OPT_BOOL(0, "dry-run", &dry_run, N_("show what would be committed")),
>  		OPT_SET_INT(0, "short", &status_format, N_("show status concisely"),
>  			    STATUS_FORMAT_SHORT),
> @@ -1610,6 +1628,12 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  		OPT_BOOL('z', "null", &s.null_termination,
>  			 N_("terminate entries with NUL")),
>  		OPT_BOOL(0, "amend", &amend, N_("amend previous commit")),
> +		OPT_NEGBIT(0, "no-pre-commit", &verify,
> +			   N_("bypass pre-commit hook"),
> +			   PRE_COMMIT),
> +		OPT_NEGBIT(0, "no-commit-msg", &verify,
> +			   N_("bypass commit-msg hook"),
> +			   COMMIT_MSG),
>  		OPT_BOOL(0, "no-post-rewrite", &no_post_rewrite, N_("bypass post-rewrite hook")),
>  		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, N_("mode"), N_("show untracked files, optional modes: all, normal, no. (Default: all)"), PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
>  		/* end commit contents options */

Since all of the hook options are motivated by internal usage from
git-rebase, perhaps they should be configured as PARSE_OPT_HIDDEN. Any
thoughts on this?

    Fabian
