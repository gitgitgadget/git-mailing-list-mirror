Received: from 7of9.schinagl.nl (7of9.schinagl.nl [185.238.129.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BA91CA9E
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 06:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.238.129.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712299850; cv=none; b=dT+1WgHsN8BEzw/078Z+ynkbA+IQtn4ghygT6ejqIXbs5909GuvGUlegSu4ngCd3hpvUyXD+AryRBvpMHjddawMfkTolsJM9Pg3PNDeoanHwbcv4JuzYY912GYEsthmXnznNXXGJtmI0t36sHewElkxA6SDgxDSexxd0Ut8e5M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712299850; c=relaxed/simple;
	bh=HZHZbwuPLx3NVo8gJmhUvJO1S/MHVvAl0REa3QvNw4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QXfxHgYNYhB/7EDuyRAi1B55i28bDcYxihZkRnHcKs3FaRhodvVvs7921mLrxhtJ8AnO93Ugcy8pX1lP0D5MikdlmXbokK1j8jVYdK1/q/lEjPlJEGcRHc49dmXfNT9K1TJ/6qEenYVe9dEB62YnIBuZY78Ee3zkoiCvoNaOWjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl; spf=pass smtp.mailfrom=schinagl.nl; dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b=BcblKZ3C; arc=none smtp.client-ip=185.238.129.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b="BcblKZ3C"
Received: from [10.2.12.77] (unknown [10.2.12.77])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by 7of9.schinagl.nl (Postfix) with ESMTPSA id CCD921A15508;
	Fri,  5 Apr 2024 08:50:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
	t=1712299839; bh=HZHZbwuPLx3NVo8gJmhUvJO1S/MHVvAl0REa3QvNw4g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=BcblKZ3C6he150TBB1Sq0MGraEXl09mkjshHHpRBkBWhYLqF1ikxyjg6/bzti/Ebz
	 cLP86PvOKlbkcT3EWNx++n3ZAZXQi3mfHTXa8u28BGiAFOy7XQvZI4CUh2WHQAotTO
	 AYlKVbYFoGxxasU6QJQSaAiwUY0B/iD8KJC5KFrk=
Message-ID: <864b0f22-b07b-469b-8fc2-56940fd89a8b@schinagl.nl>
Date: Fri, 5 Apr 2024 08:50:38 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] bisect: Introduce skip-when to automatically skip commits
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 Christian Couder <christian.couder@gmail.com>,
 Stefan Haller <lists@haller-berlin.de>
References: <20240330081026.362962-2-oliver@schinagl.nl>
Content-Language: nl
From: Olliver Schinagl <oliver@schinagl.nl>
In-Reply-To: <20240330081026.362962-2-oliver@schinagl.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey all,

I've also got my work on a branch in my repo, if that helps to look at 
things, https://gitlab.com/olliver/git/-/tree/skip_bisect

Also included is a script to be used as an example. I opted to use `git 
show`, which is nice because it works both on commits, but also on notes.

Anyway, any thoughts on the bellow before I send the full series?

Olliver


On 30-03-2024 09:10, Olliver Schinagl wrote:
> Before I go dig myself in deeper, I'd like some feedback and opinions on
> whether this is the correct direction.
>
> If I got it right, do say so, as then I can start adding some tests and
> update the documentation.
>
> Olliver
>
> ---
>
> In some situations, it is needed to skip certain commits when bisecting,
> because the compile doesn't work, or tests are known to fail.
>
> For this purpose, we introduce the `--skip-when` flag which takes a
> script as an input and is expected to return exit code 125 if a commit
> is to be skipped, which uses a regular `git bisect skip` and the commit
> thus ends up on the skipped pile.
>
> In addition we also offer a git-hook, to make this as predictable and
> painless as possible.
>
> The script can do whatever it wants to to determine if a commit is to be
> skipped; From comparing the hash against a known list, to checking git
> notes for a keyword or, as the included example, the commit body.
>
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> ---
>   bisect.c                                 |  2 +
>   builtin/bisect.c                         | 93 +++++++++++++++++++++++-
>   templates/hooks--bisect-skip_when.sample | 10 +++
>   3 files changed, 101 insertions(+), 4 deletions(-)
>   create mode 100755 templates/hooks--bisect-skip_when.sample
>
> diff --git a/bisect.c b/bisect.c
> index 60aae2fe50..185909cca9 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -476,6 +476,7 @@ static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
>   static GIT_PATH_FUNC(git_path_bisect_ancestors_ok, "BISECT_ANCESTORS_OK")
>   static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
>   static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
> +static GIT_PATH_FUNC(git_path_bisect_skip_when, "BISECT_SKIP_WHEN")
>   static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
>   static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
>   static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
> @@ -1179,6 +1180,7 @@ int bisect_clean_state(void)
>   	unlink_or_warn(git_path_bisect_log());
>   	unlink_or_warn(git_path_bisect_names());
>   	unlink_or_warn(git_path_bisect_run());
> +	unlink_or_warn(git_path_bisect_skip_when());
>   	unlink_or_warn(git_path_bisect_terms());
>   	unlink_or_warn(git_path_bisect_first_parent());
>   	/*
> diff --git a/builtin/bisect.c b/builtin/bisect.c
> index 9891cf2604..6870142b85 100644
> --- a/builtin/bisect.c
> +++ b/builtin/bisect.c
> @@ -4,6 +4,7 @@
>   #include "environment.h"
>   #include "gettext.h"
>   #include "hex.h"
> +#include "hook.h"
>   #include "object-name.h"
>   #include "oid-array.h"
>   #include "parse-options.h"
> @@ -14,19 +15,21 @@
>   #include "revision.h"
>   #include "run-command.h"
>   #include "strvec.h"
> +#include "wrapper.h"
>   
>   static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
>   static GIT_PATH_FUNC(git_path_bisect_ancestors_ok, "BISECT_ANCESTORS_OK")
>   static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
> +static GIT_PATH_FUNC(git_path_bisect_skip_when, "BISECT_SKIP_WHEN")
>   static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
>   static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
>   static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
>   static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
>   
>   #define BUILTIN_GIT_BISECT_START_USAGE \
> -	N_("git bisect start [--term-(new|bad)=<term> --term-(old|good)=<term>]" \
> -	   "    [--no-checkout] [--first-parent] [<bad> [<good>...]] [--]" \
> -	   "    [<pathspec>...]")
> +	N_("git bisect start [--term-(new|bad)=<term> --term-(old|good)=<term>]\n" \
> +	   "                 [--no-checkout] [--first-parent] [--skip-when=<script>]\n" \
> +	   "                 [<bad> [<good>...]] [--] [<pathspec>...]")
>   #define BUILTIN_GIT_BISECT_STATE_USAGE \
>   	N_("git bisect (good|bad) [<rev>...]")
>   #define BUILTIN_GIT_BISECT_TERMS_USAGE \
> @@ -89,6 +92,7 @@ static const char vocab_bad[] = "bad|new";
>   static const char vocab_good[] = "good|old";
>   
>   static int bisect_autostart(struct bisect_terms *terms);
> +static enum bisect_error bisect_skip(struct bisect_terms *terms, int argc, const char **argv);
>   
>   /*
>    * Check whether the string `term` belongs to the set of strings
> @@ -680,14 +684,74 @@ static enum bisect_error bisect_next(struct bisect_terms *terms, const char *pre
>   	return res;
>   }
>   
> +static int get_skip_when(const char **skip_when)
> +{
> +	struct strbuf str = STRBUF_INIT;
> +	FILE *fp = NULL;
> +	int res = 0;
> +
> +	fp = fopen(git_path_bisect_skip_when(), "r");
> +	if (!fp) {
> +		res = -1;
> +		goto finish;
> +	}
> +
> +	strbuf_getline_lf(&str, fp);
> +	*skip_when = strbuf_detach(&str, NULL);
> +
> +finish:
> +	if (fp)
> +		fclose(fp);
> +	strbuf_release(&str);
> +
> +	return res;
> +}
> +
>   static enum bisect_error bisect_auto_next(struct bisect_terms *terms, const char *prefix)
>   {
> +	int no_checkout = ref_exists("BISECT_HEAD");
> +	enum bisect_error res;
> +	struct object_id oid;
> +
>   	if (bisect_next_check(terms, NULL)) {
>   		bisect_print_status(terms);
>   		return BISECT_OK;
>   	}
>   
> -	return bisect_next(terms, prefix);
> +	res = bisect_next(terms, prefix);
> +	if (res)
> +		return res;
> +
> +	if (!read_ref(no_checkout ? "BISECT_HEAD" : "HEAD", &oid)) {
> +		struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
> +		char *rev = oid_to_hex(&oid);
> +		const char *skip_when = NULL;
> +		int ret = 0;
> +
> +		get_skip_when(&skip_when);
> +		if (skip_when != NULL) {
> +			struct child_process cmd = CHILD_PROCESS_INIT;
> +
> +			cmd.use_shell = 1;
> +			cmd.no_stdin = 1;
> +			strvec_pushl(&cmd.args, skip_when, rev, NULL);
> +
> +			printf(_("running '%s'\n"), skip_when);
> +			ret = run_command(&cmd);
> +		}
> +
> +		strvec_push(&opt.args, rev);
> +		if ((ret == 125) ||
> +		    (run_hooks_opt("bisect-skip_when", &opt) == 125)) {
> +			struct strvec argv = STRVEC_INIT;
> +
> +			printf(_("auto skipping commit [%s]...\n"), rev);
> +			sq_dequote_to_strvec("skip", &argv);
> +			res = bisect_skip(terms, argv.nr, argv.v);
> +		}
> +	}
> +
> +	return res;
>   }
>   
>   static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
> @@ -703,6 +767,7 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
>   	struct strbuf start_head = STRBUF_INIT;
>   	struct strbuf bisect_names = STRBUF_INIT;
>   	struct object_id head_oid;
> +	char *skip_when = NULL;
>   	struct object_id oid;
>   	const char *head;
>   
> @@ -727,6 +792,15 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
>   			no_checkout = 1;
>   		} else if (!strcmp(arg, "--first-parent")) {
>   			first_parent_only = 1;
> +		} else if (!strcmp(arg, "--skip-when")) {
> +			i++;
> +
> +			if (argc <= i)
> +				return error(_("'' is not a valid skip-when script"));
> +
> +			skip_when = xstrdup(argv[i]);
> +		} else if (skip_prefix(arg, "--skip-when=", &arg)) {
> +			skip_when = xstrdup(arg);
>   		} else if (!strcmp(arg, "--term-good") ||
>   			 !strcmp(arg, "--term-old")) {
>   			i++;
> @@ -867,11 +941,22 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
>   		goto finish;
>   	}
>   
> +	if (skip_when) {
> +		if (access(skip_when, X_OK)) {
> +			res = error(_("%s: no such path in the working tree.\n"), skip_when);
> +			goto finish;
> +		}
> +		write_to_file(git_path_bisect_skip_when(), "%s\n", skip_when);
> +	}
> +
>   	res = bisect_append_log_quoted(argv);
>   	if (res)
>   		res = BISECT_FAILED;
>   
>   finish:
> +	if (skip_when)
> +		free(skip_when);
> +
>   	string_list_clear(&revs, 0);
>   	string_list_clear(&states, 0);
>   	strbuf_release(&start_head);
> diff --git a/templates/hooks--bisect-skip_when.sample b/templates/hooks--bisect-skip_when.sample
> new file mode 100755
> index 0000000000..ff3960841f
> --- /dev/null
> +++ b/templates/hooks--bisect-skip_when.sample
> @@ -0,0 +1,10 @@
> +#!/bin/sh
> +#
> +# usage: ${0} <commit_object_name>
> +# expected to exit with 125 when the commit should be skipped
> +
> +if git cat-file commit "${1:-HEAD}" | grep -q "^GIT_BISECT_SKIP=1$"; then
> +	exit 125
> +fi
> +
> +exit 0


