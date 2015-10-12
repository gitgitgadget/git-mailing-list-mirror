From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add fetch.recurseSubmoduleParallelism config option
Date: Mon, 12 Oct 2015 16:14:46 -0700
Message-ID: <xmqqeggzbrx5.fsf@gitster.mtv.corp.google.com>
References: <1444690350-6486-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, hvoigt@hvoigt.net, jens.lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 01:14:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlmIv-0002U7-QX
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 01:14:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752464AbbJLXOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 19:14:49 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36153 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751777AbbJLXOs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 19:14:48 -0400
Received: by pacex6 with SMTP id ex6so913637pac.3
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 16:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Oqh0XqqVo2+2o+T7UBFVXXO+wIDJs6syUPzd3r1a82w=;
        b=fxGxFVYo5CVbf31i9WYcOveZ969MLqfnrBbNQdo1Dh4Rftxbc9v1gBgimeDQs3El2s
         pSdKFWAkkXMJFnS0bJBPQl5u8ZDbM0MWHC1t5S/XVTdknGprESkCsSTOQeajwxc7DiRs
         1z5GE7pp7TJ87dV9oGKB2rhteArGnmHQc4bdGEi+MRZC0DFRio4B2rY8l+7Vh759Pxjl
         LmOYq0of3OalPn317Pi1rVtUMHHTj1O2ABStS6lGYFaRVPmFiTv8QWGryoUqL/qS/mjB
         LllgiYcinFK1xcbSZr8+NqRS3txQUAXWW1PrBoZafOkwn+qcbw+nGgyKNXz9zkOc6z5R
         Zc6Q==
X-Received: by 10.68.191.200 with SMTP id ha8mr37229433pbc.72.1444691688194;
        Mon, 12 Oct 2015 16:14:48 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:495:58e7:6a27:bf4d])
        by smtp.gmail.com with ESMTPSA id qd5sm10046pbc.73.2015.10.12.16.14.47
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 12 Oct 2015 16:14:47 -0700 (PDT)
In-Reply-To: <1444690350-6486-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 12 Oct 2015 15:52:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279471>

Stefan Beller <sbeller@google.com> writes:

> This allows to configure fetching in parallel without having the annoying
> command line option.

s/annoying//;

I think this is a sane thing to do, but the name of the variable may
want to be bikeshedded a bit.

> This moved the responsibility to determine how many parallel processes
> to start from builtin/fetch to submodule.c as we need a way to communicate
> "The user did not specify the number of parallel processes in the command
> line options" in the builtin fetch. The submodule code takes care of
> the precedence (CLI > config > default)
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  Documentation/config.txt |  6 ++++++
>  builtin/fetch.c          |  2 +-
>  submodule.c              | 14 ++++++++++++++
>  3 files changed, 21 insertions(+), 1 deletion(-)
>  
>  I just monkey tested the code and it worked once! The problem with testing
>  this parallelizing option is that the expected behavior doesn't change
>  except for being faster. And I don't want to add timing tests to the test
>  suite because they are unreliable.
>
>  Any idea how to test this properly?

I agree that a test in t/ would catch bugs in the functionality.  If
your parallel implementation is somehow broken in the future and
stops functioning correctly, fetching all submodules with a single
task and fetching them with N tasks will produce different results
;-).

But it would not help you much in seeing if the parallelism is
really taking place.  Adding t/perf/ tests to show how much benefit
you are getting may be of more value.

The parallel_process API could learn a new "verbose" feature that it
by itself shows some messages like

    "processing the 'frotz' job with N tasks"
    "M tasks finished (N still running)" 

in the output stream from strategic places.  For example, the first
message will come at the end of pp_init(), and the second message
will be appended at the end of buffered output of a task that has
just been finished.  Once you have something like that, you could
check for them in a test in t/.

Just a thought.

>  
>  This applies on top of sb/submodule-parallel-fetch
>  
>  Thanks,
>  Stefan
>  
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 315f271..1172db0 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1140,6 +1140,12 @@ fetch.recurseSubmodules::
>  	when its superproject retrieves a commit that updates the submodule's
>  	reference.
>  
> +fetch.recurseSubmoduleParallelism
> +	This is used to determine how many submodules can be fetched in
> +	parallel. Specifying a positive integer allows up to that number
> +	of submodules being fetched in parallel. Specifying 0 the number
> +	of cpus will be taken as the maximum number.
> +
>  fetch.fsckObjects::
>  	If it is set to true, git-fetch-pack will check all fetched
>  	objects. It will abort in the case of a malformed object or a
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index f28eac6..b1399dc 100644
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
> index c21b265..c85d3ef 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -15,6 +15,7 @@
>  #include "thread-utils.h"
>  
>  static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
> +static int config_fetch_parallel_submodules = -1;
>  static struct string_list changed_submodule_paths;
>  static int initialized_fetch_ref_tips;
>  static struct sha1_array ref_tips_before_fetch;
> @@ -179,6 +180,14 @@ int submodule_config(const char *var, const char *value, void *cb)
>  	else if (!strcmp(var, "fetch.recursesubmodules")) {
>  		config_fetch_recurse_submodules = parse_fetch_recurse_submodules_arg(var, value);
>  		return 0;
> +	} else if (!strcmp(var, "fetch.recursesubmoduleparallelism")) {
> +		char *end;
> +		int ret;
> +		config_fetch_parallel_submodules = strtol(value, &end, 0);
> +		ret = (*end == '\0');
> +		if (!ret)
> +			warning("value for fetch.recurseSubmoduleParallelism not recognized");
> +		return ret;
>  	}
>  	return 0;
>  }
> @@ -759,6 +768,11 @@ int fetch_populated_submodules(const struct argv_array *options,
>  	argv_array_push(&spf.args, "--recurse-submodules-default");
>  	/* default value, "--submodule-prefix" and its value are added later */
>  
> +	if (max_parallel_jobs < 0)
> +		max_parallel_jobs = config_fetch_parallel_submodules;
> +	if (max_parallel_jobs < 0)
> +		max_parallel_jobs = 1;
> +
>  	calculate_changed_submodule_paths();
>  	run_processes_parallel(max_parallel_jobs,
>  			       get_next_submodule,
