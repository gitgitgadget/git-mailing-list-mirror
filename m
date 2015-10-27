From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/9] clone: allow an explicit argument for parallel submodule clones
Date: Tue, 27 Oct 2015 13:57:17 -0700
Message-ID: <xmqqlhaoni6q.fsf@gitster.mtv.corp.google.com>
References: <1445969753-418-1-git-send-email-sbeller@google.com>
	<1445969753-418-7-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jacob.keller@gmail.com, peff@peff.net,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 21:58:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrBKY-0000I5-BX
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 21:58:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965635AbbJ0U6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 16:58:48 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57736 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965717AbbJ0U5U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 16:57:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C5D3A26027;
	Tue, 27 Oct 2015 16:57:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d+Yra8X+vi7m3c8/1aSF2ppghSM=; b=gGTJt4
	WuDZU42N5zJCJfDXMHCXvr8P354nhnckUTE++rORC7enpbg44LyExDktLTeT0wX2
	r1fp5sz1IpcdOfCikEDqxVjPjB/eNkhpoQsrNckNHtWvSvvaIxAGXGiLLtgWIouJ
	nFPlb23RPpyfrHYdQIImrjt4dWIZ3+XKFC7B4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qewZtl5J4uh/HTYnrInRag2uP7zHMad8
	9s8AAalM4R1rMCNhh6t5UmH16I7UUsd2Qp8RBygfJ3wlsQuR3Oondtu4vznwu9Ny
	ux2I+/DRQm7fpf3KsTjJoa1BK63RKXCYzJ2bnl+vYFDC1UklWkkxmrbmIibvdnaY
	dp2Ugvleyyo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BDA1726026;
	Tue, 27 Oct 2015 16:57:19 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 155AA26025;
	Tue, 27 Oct 2015 16:57:19 -0400 (EDT)
In-Reply-To: <1445969753-418-7-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 27 Oct 2015 11:15:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4FBEB0C2-7CED-11E5-AD87-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280295>

Stefan Beller <sbeller@google.com> writes:

> Just pass it along to "git submodule update", which may pick reasonable
> defaults if you don't specify an explicit number.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  Documentation/git-clone.txt |  5 ++++-
>  builtin/clone.c             | 26 ++++++++++++++++++++------
>  t/t7406-submodule-update.sh | 15 +++++++++++++++
>  3 files changed, 39 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index f1f2a3f..affa52e 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -14,7 +14,7 @@ SYNOPSIS
>  	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository>]
>  	  [--dissociate] [--separate-git-dir <git dir>]
>  	  [--depth <depth>] [--[no-]single-branch]
> -	  [--recursive | --recurse-submodules] [--] <repository>
> +	  [--recursive | --recurse-submodules] [--jobs <n>] [--] <repository>
>  	  [<directory>]
>  
>  DESCRIPTION
> @@ -216,6 +216,9 @@ objects from the source repository into a pack in the cloned repository.
>  	The result is Git repository can be separated from working
>  	tree.
>  
> +-j::
> +--jobs::

Judging from the way how "--depth <depth>" and other options with
parameter are described, I think this should be:

          -j <n>::
          --jobs <n>::

> +	The number of submodules fetched at the same time.

Do we want to say "Defaults to submodule.jobs" somewhere?

>  
>  <repository>::
>  	The (possibly remote) repository to clone from.  See the
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 5864ad1..b8b1d4c 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -50,6 +50,7 @@ static int option_progress = -1;
>  static struct string_list option_config;
>  static struct string_list option_reference;
>  static int option_dissociate;
> +static int max_jobs = -1;
>  
>  static struct option builtin_clone_options[] = {
>  	OPT__VERBOSITY(&option_verbosity),
> @@ -72,6 +73,8 @@ static struct option builtin_clone_options[] = {
>  		    N_("initialize submodules in the clone")),
>  	OPT_BOOL(0, "recurse-submodules", &option_recursive,
>  		    N_("initialize submodules in the clone")),
> +	OPT_INTEGER('j', "jobs", &max_jobs,
> +		    N_("number of submodules cloned in parallel")),
>  	OPT_STRING(0, "template", &option_template, N_("template-directory"),
>  		   N_("directory from which templates will be used")),
>  	OPT_STRING_LIST(0, "reference", &option_reference, N_("repo"),
> @@ -95,10 +98,6 @@ static struct option builtin_clone_options[] = {
>  	OPT_END()
>  };
>  
> -static const char *argv_submodule[] = {
> -	"submodule", "update", "--init", "--recursive", NULL
> -};
> -
>  static const char *get_repo_path_1(struct strbuf *path, int *is_bundle)
>  {
>  	static char *suffix[] = { "/.git", "", ".git/.git", ".git" };
> @@ -674,8 +673,23 @@ static int checkout(void)
>  	err |= run_hook_le(NULL, "post-checkout", sha1_to_hex(null_sha1),
>  			   sha1_to_hex(sha1), "1", NULL);
>  
> -	if (!err && option_recursive)
> -		err = run_command_v_opt(argv_submodule, RUN_GIT_CMD);
> +	if (!err && option_recursive) {
> +		struct argv_array args = ARGV_ARRAY_INIT;
> +		argv_array_pushl(&args, "submodule", "update", "--init", "--recursive", NULL);
> +
> +		if (max_jobs == -1)
> +			if (git_config_get_int("submodule.jobs", &max_jobs))
> +				max_jobs = 1;

This is somewhat an irregular way to handle a configuration
variable.  Usually we instead do:

	* initialize a variable to "unspecified" (e.g. -1);
        * let git_config() callback to overwrite the variable;
        * let parse_options() to overwrite the variable.

so that you can just use the variable at the use site like this
function, knowing that the variable is already set with the correct
precedence order.

Besides, if you really cared what the value of submodule.jobs is,
shouldn't you be calling config_parallel_submodules()?  I'd also
think that you do not want to read that variable here in the first
place (see below)...

> +		if (max_jobs != 1) {
> +			struct strbuf sb = STRBUF_INIT;
> +			strbuf_addf(&sb, "--jobs=%d", max_jobs);
> +			argv_array_push(&args, sb.buf);
> +			strbuf_release(&sb);
> +		}

I am tempted to suggest that you should not pay attention to
"submodule.jobs" in this command at all and just pass through
"--jobs=$max_jobs" that was specified from the command line, as the
spawned "submodule update --init --recursive" would handle
"submodule.jobs" itself.

Once you start allowing "clone.jobs" as a more specific version of
"submodule.jobs", then reading max_jobs first from "clone.jobs" and
then from the command line starts to make sense.  When neither is
specified, you would spawn "submodule update --init --recursive"
without any explicit "-j N" and let it honor its more generic
"submodule.jobs" setting; otherwise, you would run it with "-j N" to
override that more generic "submodule.jobs" setting with either the
value the command line -j given to "clone" or specified by a more
specific "clone.jobs".

> +		err = run_command_v_opt(args.argv, RUN_GIT_CMD);
> +		argv_array_clear(&args);
> +	}

Thanks.
