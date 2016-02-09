From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv9 3/6] fetching submodules: respect `submodule.fetchJobs` config option
Date: Tue, 09 Feb 2016 13:12:13 -0800
Message-ID: <xmqqd1s537wy.fsf@gitster.mtv.corp.google.com>
References: <1455051274-15256-1-git-send-email-sbeller@google.com>
	<1455051274-15256-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jrnieder@gmail.com, git@vger.kernel.org, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 22:12:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTFa8-0002TR-6S
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 22:12:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932708AbcBIVMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 16:12:16 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53412 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752997AbcBIVMP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 16:12:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F1B074312F;
	Tue,  9 Feb 2016 16:12:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ojSJgFXnPMZ9GISPSSqcS5xodkM=; b=TvuDup
	MCfHKLQ/ZU2e/IflvWmGp2oPocFrxjMx5aiD4UOudukOXRYxG/q7LpIhX1a6yu2G
	yM7pOAUk0Xg9qbVBkh38Dx4P/tC/Ad7XkvwE/x4svLxNcGSAaDp2POKVIVGcABM7
	7bdUixSygYfMVqMWz8DWwWY5cq6trKLnbS/tQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YTtXjeHGhXcb+5vOYhIn0PTY0x3oWg5v
	2kxUSPdtumRR+Xq34xCE+/IUdhNQewBR25AXiB5oGSU6X/EH9RbU4pAzY2U92AbC
	Qv1d243k0Y0NIyWwaZGHEecGrKXENX0aDw3irkiG8+q/6FXM+S/TrAczktHkq+JO
	17vshUx7ZI4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E8AEB4312E;
	Tue,  9 Feb 2016 16:12:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3E7BC4312D;
	Tue,  9 Feb 2016 16:12:14 -0500 (EST)
In-Reply-To: <1455051274-15256-4-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 9 Feb 2016 12:54:31 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CAA4417C-CF71-11E5-A7F3-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285868>

Stefan Beller <sbeller@google.com> writes:

> This allows to configure fetching and updating in parallel
> without having the command line option.
>
> This moved the responsibility to determine how many parallel processes
> to start from builtin/fetch to submodule.c as we need a way to communicate
> "The user did not specify the number of parallel processes in the command
> line options" in the builtin fetch. The submodule code takes care of
> the precedence (CLI > config > default).
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

This got a lot simpler to read, I think, even though this comes with
a better error checking ;-)

Thanks.

>  Documentation/config.txt    |  6 ++++++
>  builtin/fetch.c             |  2 +-
>  submodule.c                 | 17 ++++++++++++++++-
>  submodule.h                 |  1 +
>  t/t5526-fetch-submodules.sh | 14 ++++++++++++++
>  5 files changed, 38 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 2d06b11..3b02732 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2646,6 +2646,12 @@ submodule.<name>.ignore::
>  	"--ignore-submodules" option. The 'git submodule' commands are not
>  	affected by this setting.
>  
> +submodule.fetchJobs::
> +	Specifies how many submodules are fetched/cloned at the same time.
> +	A positive integer allows up to that number of submodules fetched
> +	in parallel. A value of 0 will give some reasonable default.
> +	If unset, it defaults to 1.
> +
>  tag.sort::
>  	This variable controls the sort ordering of tags when displayed by
>  	linkgit:git-tag[1]. Without the "--sort=<value>" option provided, the
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 586840d..5aa1c2d 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -37,7 +37,7 @@ static int prune = -1; /* unspecified */
>  static int all, append, dry_run, force, keep, multiple, update_head_ok, verbosity;
>  static int progress = -1, recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
>  static int tags = TAGS_DEFAULT, unshallow, update_shallow;
> -static int max_children = 1;
> +static int max_children = -1;
>  static const char *depth;
>  static const char *upload_pack;
>  static struct strbuf default_rla = STRBUF_INIT;
> diff --git a/submodule.c b/submodule.c
> index b83939c..fd763f5 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -15,6 +15,7 @@
>  #include "thread-utils.h"
>  
>  static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
> +static int parallel_jobs = 1;
>  static struct string_list changed_submodule_paths;
>  static int initialized_fetch_ref_tips;
>  static struct sha1_array ref_tips_before_fetch;
> @@ -169,7 +170,13 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
>  
>  int submodule_config(const char *var, const char *value, void *cb)
>  {
> -	if (starts_with(var, "submodule."))
> +	if (!strcmp(var, "submodule.fetchjobs")) {
> +		unsigned long val;
> +		if (!git_parse_ulong(value, &val) || 0 > val || val >= INT_MAX)
> +			die(_("Error parsing submodule.fetchJobs %s"), value);
> +		parallel_jobs = val;
> +		return 0;
> +	} else if (starts_with(var, "submodule."))
>  		return parse_submodule_config_option(var, value);
>  	else if (!strcmp(var, "fetch.recursesubmodules")) {
>  		config_fetch_recurse_submodules = parse_fetch_recurse_submodules_arg(var, value);
> @@ -751,6 +758,9 @@ int fetch_populated_submodules(const struct argv_array *options,
>  	argv_array_push(&spf.args, "--recurse-submodules-default");
>  	/* default value, "--submodule-prefix" and its value are added later */
>  
> +	if (max_parallel_jobs < 0)
> +		max_parallel_jobs = parallel_jobs;
> +
>  	calculate_changed_submodule_paths();
>  	run_processes_parallel(max_parallel_jobs,
>  			       get_next_submodule,
> @@ -1097,3 +1107,8 @@ void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
>  	strbuf_release(&rel_path);
>  	free((void *)real_work_tree);
>  }
> +
> +int parallel_submodules(void)
> +{
> +	return parallel_jobs;
> +}
> diff --git a/submodule.h b/submodule.h
> index cbc0003..95babc5 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -41,5 +41,6 @@ int find_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_nam
>  		struct string_list *needs_pushing);
>  int push_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name);
>  void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
> +int parallel_submodules(void);
>  
>  #endif
> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
> index 1241146..954d0e4 100755
> --- a/t/t5526-fetch-submodules.sh
> +++ b/t/t5526-fetch-submodules.sh
> @@ -471,4 +471,18 @@ test_expect_success "don't fetch submodule when newly recorded commits are alrea
>  	test_i18ncmp expect.err actual.err
>  '
>  
> +test_expect_success 'fetching submodules respects parallel settings' '
> +	git config fetch.recurseSubmodules true &&
> +	(
> +		cd downstream &&
> +		GIT_TRACE=$(pwd)/trace.out git fetch --jobs 7 &&
> +		grep "7 tasks" trace.out &&
> +		git config submodule.fetchJobs 8 &&
> +		GIT_TRACE=$(pwd)/trace.out git fetch &&
> +		grep "8 tasks" trace.out &&
> +		GIT_TRACE=$(pwd)/trace.out git fetch --jobs 9 &&
> +		grep "9 tasks" trace.out
> +	)
> +'
> +
>  test_done
