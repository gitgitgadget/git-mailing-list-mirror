Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1C5C433EF
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 23:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2CD2610E8
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 23:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345387AbhIBXoE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 19:44:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52928 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244285AbhIBXoD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 19:44:03 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F950F01A1;
        Thu,  2 Sep 2021 19:43:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+feCSMB0VpCN8qvrEedVKIHsoaF9ePodgAGLPp
        6HaRQ=; b=uAVwxyPd3iSRYO9BAlY8l62qIMjTIik9xDCJfhuUu9DMAuR176aZbB
        tV+NHOrqKZ5NxZJ0KuB8m+M0xwdqUuHWVYKWwHT6OZtxD+ZTqk2G/Dex0bnOtK1f
        auyIcMEf+YH00YbMXjq+mMJGDGSdl7M3Iy7Gyt8U48YPXDUpxnr3E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1BEF5F01A0;
        Thu,  2 Sep 2021 19:43:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BF5B4F019F;
        Thu,  2 Sep 2021 19:43:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org, Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v6 5/6] bisect--helper: reimplement `bisect_run` shell
References: <20210902090421.93113-1-mirucam@gmail.com>
        <20210902090421.93113-6-mirucam@gmail.com>
Date:   Thu, 02 Sep 2021 16:43:02 -0700
In-Reply-To: <20210902090421.93113-6-mirucam@gmail.com> (Miriam Rubio's
        message of "Thu, 2 Sep 2021 11:04:20 +0200")
Message-ID: <xmqqtuj2h7cp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 83613ACC-0C47-11EC-A8F5-D601C7D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miriam Rubio <mirucam@gmail.com> writes:

> From: Tanushree Tumane <tanushreetumane@gmail.com>
>
> Reimplement the `bisect_run()` shell function
> in C and also add `--bisect-run` subcommand to
> `git bisect--helper` to call it from git-bisect.sh.
>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
> Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> ---
>  builtin/bisect--helper.c | 97 ++++++++++++++++++++++++++++++++++++++++
>  git-bisect.sh            | 62 +------------------------
>  2 files changed, 98 insertions(+), 61 deletions(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 1e118a966a..8e9ed9c318 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -18,6 +18,7 @@ static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
>  static GIT_PATH_FUNC(git_path_head_name, "head-name")
>  static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
>  static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
> +static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
>  
>  static const char * const git_bisect_helper_usage[] = {
>  	N_("git bisect--helper --bisect-reset [<commit>]"),
> @@ -31,6 +32,7 @@ static const char * const git_bisect_helper_usage[] = {
>  	N_("git bisect--helper --bisect-replay <filename>"),
>  	N_("git bisect--helper --bisect-skip [(<rev>|<range>)...]"),
>  	N_("git bisect--helper --bisect-visualize"),
> +	N_("git bisect--helper --bisect-run <cmd>..."),
>  	NULL
>  };
>  
> @@ -144,6 +146,19 @@ static int append_to_file(const char *path, const char *format, ...)
>  	return res;
>  }
>  
> +static int print_file_to_stdout(const char *path)
> +{
> +	int fd = open(path, O_RDONLY);
> +	int ret = 0;
> +
> +	if (fd < 0)
> +		return error_errno(_("cannot open file '%s' for reading"), path);
> +	if (copy_fd(fd, 1) < 0)
> +		ret = error_errno(_("failed to read '%s'"), path);
> +	close(fd);
> +	return ret;
> +}
> +
>  static int check_term_format(const char *term, const char *orig_term)
>  {
>  	int res;
> @@ -1075,6 +1090,79 @@ static int bisect_visualize(struct bisect_terms *terms, const char **argv, int a
>  	return res;
>  }
>  
> +static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
> +{
> +	int res = BISECT_OK;
> +	struct strbuf command = STRBUF_INIT;
> +	struct strvec args = STRVEC_INIT;
> +	struct strvec run_args = STRVEC_INIT;
> +	const char *new_state;
> +	int temporary_stdout_fd, saved_stdout;
> +
> +	if (bisect_next_check(terms, NULL))
> +		return BISECT_FAILED;
> +
> +	if (argc)
> +		sq_quote_argv(&command, argv);
> +	else {
> +		error(_("bisect run failed: no command provided."));
> +		return BISECT_FAILED;
> +	}
> +	strvec_push(&run_args, command.buf);
> +
> +	while (1) {
> +		strvec_clear(&args);
> +
> +		printf(_("running %s\n"), command.buf);
> +		res = run_command_v_opt(run_args.v, RUN_USING_SHELL);
> +
> +		if (res < 0 || 128 <= res) {
> +			error(_("bisect run failed: exit code %d from"
> +				" '%s' is < 0 or >= 128"), res, command.buf);
> +			strbuf_release(&command);
> +			return res;
> +		}
> +
> +		if (res == 125)
> +			new_state = "skip";
> +		else
> +			new_state = res > 0 ? terms->term_bad : terms->term_good;

It is easier to follow the code if you spelled out this part as

		else if (!res)
			new_state = terms->term_good;
		else
			new_state = terms->term_bad;

because that would consistently handle the three cases.  Of course
you _could_ do

		new_state = (res == 125)
			  ? "skip"
			  : (res > 0)
			  ? terms->term_bad
			  : terms->term_good;

instead, but that would be harder to read.


> +		temporary_stdout_fd = open(git_path_bisect_run(), O_CREAT | O_WRONLY | O_TRUNC, 0666);

Can this open fail, and if it fails, what do we want to do?

> +		saved_stdout = dup(1);
> +		dup2(temporary_stdout_fd, 1);
> +
> +		res = bisect_state(terms, &new_state, 1);
> +
> +		dup2(saved_stdout, 1);
> +		close(saved_stdout);
> +		close(temporary_stdout_fd);

Hmph, now you lost me.  Whose output are we working around here with
the redirection?  

	... goes and looks ...

Ahh, OK.  bisect_next_all() to bisect_checkout() all assume that
they only need to write to the standard output, so we need to do
this dance (unless we are willing to update the bisect.c functions
to accept FILE * as parameter, that is).

However, they use not just write(2) but stdio to do their output,
no?  Don't we need to fflush(stdout) around the redirection dance,
one to empty the output that was associated with the real standard
output stream before asking bisect_state() to write to fd #1 via
stdio, and one more time to flush out what bisect_state() wrote to
the stdio after the call returns before closing the fd we opened to
the BISECT_RUN file?

> +		print_file_to_stdout(git_path_bisect_run());

OK.  So this corresponds to the "write bisect-state to ./git/BISECT_RUN
and then cat it" in the scripted version.

> +		if (res == BISECT_ONLY_SKIPPED_LEFT)
> +			error(_("bisect run cannot continue any more"));
> +		else if (res == BISECT_INTERNAL_SUCCESS_MERGE_BASE) {
> +			printf(_("bisect run success"));
> +			res = BISECT_OK;
> +		} else if (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
> +			printf(_("bisect found first bad commit"));
> +			res = BISECT_OK;
> +		} else if (res) {
> +			error(_("bisect run failed:'git bisect--helper --bisect-state"
> +			" %s' exited with error code %d"), args.v[0], res);
> +		} else {
> +			continue;
> +		}
> +
> +		strbuf_release(&command);
> +		strvec_clear(&args);
> +		strvec_clear(&run_args);
> +		return res;
> +	}
> +}

OK, the "res to diag" and clearing the resources at the end of the
function looks good to me.

Thanks.
