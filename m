From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5 3/3] submodule: Reimplement `module_clone` shell function in C
Date: Thu, 03 Sep 2015 15:07:48 -0700
Message-ID: <xmqq8u8ni2bv.fsf@gitster.mtv.corp.google.com>
References: <1441230146-26921-1-git-send-email-sbeller@google.com>
	<1441230146-26921-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: sunshine@sunshineco.com, git@vger.kernel.org, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de, peff@peff.net
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 00:08:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXcfq-0006xS-LD
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 00:08:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757808AbbICWH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 18:07:57 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34075 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757700AbbICWH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 18:07:56 -0400
Received: by padhy16 with SMTP id hy16so496172pad.1
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 15:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=1F4tXdQF1NinXMlXF9iP2oj3yzTgvWgqnX7lD2xBiOo=;
        b=ssSFVo7kEFyAZ41LdPhSwB1m1usH4ZgNGIerziI5TaxIvBlC2n/zt3uajxzbzrmamc
         zEJvCvot6F158CVdlv4kwP0Phr9wF1pXhT7H6MFWXlv35/mso5H0KHjGZ/TDHBkyA6Zm
         wMm61QNXArWTBSDvfSpwM92GLBJXDmc5XG7GniqR8hIdR+rbLHOXM3xefT+eIy+nzTrI
         auC/3iWIgJMuPTWpGDCdUn/3jb8M9liiLPgFLst3T21C0crOKgT3n9SoqU3ahKcSWG9b
         03620Om7tg7M3pwDGXF5KNFupI0hxHzG3DMWFnY3+Vjlh6ZwWl5C26Bd8qVCKidVx4Vb
         Fmzw==
X-Received: by 10.68.203.42 with SMTP id kn10mr382822pbc.43.1441318076139;
        Thu, 03 Sep 2015 15:07:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:71da:b56c:f873:e611])
        by smtp.gmail.com with ESMTPSA id qe3sm124185pbc.73.2015.09.03.15.07.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 03 Sep 2015 15:07:54 -0700 (PDT)
In-Reply-To: <1441230146-26921-4-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Wed, 2 Sep 2015 14:42:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277273>

Stefan Beller <sbeller@google.com> writes:

> @@ -119,6 +120,140 @@ static int module_name(int argc, const char **argv, const char *prefix)
>  
>  	return 0;
>  }
> +static int clone_submodule(const char *path, const char *gitdir, const char *url,
> +			   const char *depth, const char *reference, int quiet)
> +{
> +	struct child_process cp;
> +	child_process_init(&cp);
> +
> +	argv_array_push(&cp.args, "clone");
> +	argv_array_push(&cp.args, "--no-checkout");
> +	if (quiet)
> +		argv_array_push(&cp.args, "--quiet");
> +	if (depth && *depth)
> +		argv_array_pushl(&cp.args, "--depth", depth, NULL);
> +	if (reference && *reference)
> +		argv_array_pushl(&cp.args, "--reference", reference, NULL);
> +	if (gitdir && *gitdir)
> +		argv_array_pushl(&cp.args, "--separate-git-dir", gitdir, NULL);
> +
> +	argv_array_push(&cp.args, url);
> +	argv_array_push(&cp.args, path);
> +
> +	cp.git_cmd = 1;
> +	cp.env = local_repo_env;
> +
> +	cp.no_stdin = 1;
> +	cp.no_stdout = 1;
> +	cp.no_stderr = 1;

Output from "git clone" is not shown, regardless of --quiet option?

> +	return run_command(&cp);
> +}
> +
> +static int module_clone(int argc, const char **argv, const char *prefix)
> +{
> +	const char *path = NULL, *name = NULL, *url = NULL;
> +	const char *reference = NULL, *depth = NULL;
> +	int quiet = 0;
> +	FILE *submodule_dot_git;
> +	char *sm_gitdir, *cwd, *p;
> +	struct strbuf rel_path = STRBUF_INIT;
> +	struct strbuf sb = STRBUF_INIT;
> +
> +	struct option module_clone_options[] = {
> +		OPT_STRING(0, "prefix", &prefix,
> +			   N_("path"),
> +			   N_("alternative anchor for relative paths")),
> +		OPT_STRING(0, "path", &path,
> +			   N_("path"),
> +			   N_("where the new submodule will be cloned to")),
> +		OPT_STRING(0, "name", &name,
> +			   N_("string"),
> +			   N_("name of the new submodule")),
> +		OPT_STRING(0, "url", &url,
> +			   N_("string"),
> +			   N_("url where to clone the submodule from")),
> +		OPT_STRING(0, "reference", &reference,
> +			   N_("string"),
> +			   N_("reference repository")),
> +		OPT_STRING(0, "depth", &depth,
> +			   N_("string"),
> +			   N_("depth for shallow clones")),
> +		OPT__QUIET(&quiet, "Suppress output for cloning a submodule"),
> +		OPT_END()
> +	};
> +
> +	const char *const git_submodule_helper_usage[] = {
> +		N_("git submodule--helper clone [--prefix=<path>] [--quiet] "
> +		   "[--reference <repository>] [--name <name>] [--url <url>]"
> +		   "[--depth <depth>] [--] [<path>...]"),
> +		NULL
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, module_clone_options,
> +			     git_submodule_helper_usage, 0);
> +
> +	strbuf_addf(&sb, "%s/modules/%s", get_git_dir(), name);

The original says

	base_name=$(dirname "$name")

before doing this %s/modules/%s concatenation.  I do not think we
intended to allow a slash in submodule name, so this difference may
be showing that the original was doing an unnecessary thing.

> +	sm_gitdir = strbuf_detach(&sb, NULL);
> +
> +	if (!file_exists(sm_gitdir)) {
> +		if (safe_create_leading_directories_const(sm_gitdir) < 0)
> +			die(_("could not create directory '%s'"), sm_gitdir);
> +		if (clone_submodule(path, sm_gitdir, url, depth, reference, quiet))
> +			die(_("clone of '%s' into submodule path '%s' failed"),
> +			    url, path);
> +	} else {
> +		if (safe_create_leading_directories_const(path) < 0)
> +			die(_("could not create directory '%s'"), path);
> +		strbuf_addf(&sb, "%s/index", sm_gitdir);
> +		if (unlink(sb.buf) < 0)
> +			die_errno(_("failed to delete '%s'"), sm_gitdir);

The original says "we do not care if it failed" with

	rm -f "$gitdir/index"

I think the intention of the original is "we do not care if it
failed because it did not exist." in which case unconditional
die_errno() here may be something we do not want?

> +		strbuf_reset(&sb);
> +	}
> +
> +	/* Write a .git file in the submodule to redirect to the superproject. */
> +	if (safe_create_leading_directories_const(path) < 0)
> +		die(_("could not create directory '%s'"), path);
> +
> +	if (path && *path)
> +		strbuf_addf(&sb, "%s/.git", path);
> +	else
> +		strbuf_addf(&sb, ".git");
> +
> +	if (safe_create_leading_directories_const(sb.buf) < 0)
> +		die(_("could not create leading directories of '%s'"), sb.buf);
> +	submodule_dot_git = fopen(sb.buf, "w");
> +	if (!submodule_dot_git)
> +		die_errno(_("cannot open file '%s'"), sb.buf);
> +
> +	fprintf(submodule_dot_git, "gitdir: %s\n",
> +		relative_path(sm_gitdir, path, &rel_path));
> +	if (fclose(submodule_dot_git))
> +		die(_("could not close file %s"), sb.buf);
> +	strbuf_reset(&sb);
> +	strbuf_reset(&rel_path);

The original seems to go quite a length to make sure symbolic links
do not fool the comparison between $gitdir and $sm_path, and also it
makes sure one is not a subpath of the other.  Do we need the same
level of carefulness, or is textual relative_path() enough?

> +	cwd = xgetcwd();
> +	/* Redirect the worktree of the submodule in the superproject's config */
> +	if (!is_absolute_path(sm_gitdir)) {
> +		strbuf_addf(&sb, "%s/%s", cwd, sm_gitdir);
> +		free(sm_gitdir);
> +		sm_gitdir = strbuf_detach(&sb, NULL);
> +	}
> +
> +	strbuf_addf(&sb, "%s/%s", cwd, path);
> +	p = git_pathdup_submodule(path, "config");
> +	if (!p)
> +		die(_("could not get submodule directory for '%s'"), path);
> +	git_config_set_in_file(p, "core.worktree",
> +			       relative_path(sb.buf, sm_gitdir, &rel_path));
> +	strbuf_release(&sb);
> +	strbuf_release(&rel_path);
> +	free(sm_gitdir);
> +	free(cwd);
> +	free(p);
> +	return 0;
> +}
>  
>  struct cmd_struct {
>  	const char *cmd;


> diff --git a/git-submodule.sh b/git-submodule.sh
> index 2be8da2..7cfdc2c 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -301,7 +227,7 @@ cmd_add()
>  			shift
>  			;;
>  		--depth=*)
> -			depth=$1
> +			depth="$1"

This seems to be an unrelated change.

Otherwise looks quite straight-forward.

Thanks.
