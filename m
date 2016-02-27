From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 2/2] Revert "rev-parse: remove restrictions on some
 options"
Date: Sat, 27 Feb 2016 12:25:11 +0000
Message-ID: <20160227122511.GR1766@serenity.lan>
References: <20160226232507.GA9404@sigill.intra.peff.net>
 <20160226232957.GB9552@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 27 13:28:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZdyk-0002pl-Jz
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 13:28:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756319AbcB0MZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 07:25:26 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:40455 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756183AbcB0MZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 07:25:25 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id C7645CDA5E8;
	Sat, 27 Feb 2016 12:25:24 +0000 (GMT)
X-Quarantine-ID: <VmYuAymPvsj9>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1.001
X-Spam-Level: 
X-Spam-Status: No, score=-1.001 tagged_above=-9999 required=5
	tests=[ALL_TRUSTED=-1, BAYES_20=-0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VmYuAymPvsj9; Sat, 27 Feb 2016 12:25:23 +0000 (GMT)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 86226CDA5BA;
	Sat, 27 Feb 2016 12:25:12 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20160226232957.GB9552@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287694>

On Fri, Feb 26, 2016 at 06:29:57PM -0500, Jeff King wrote:
> This reverts commit 68889b416d5b6a5cf7d280a428281d635fe9b292.
[snip]
> The original patch was not spurred by an actual bug report,
> but by an observation[1] that was essentially "eh, this
> looks unnecessarily restrictive". It _is_ restrictive, but
> it turns out to be necessarily so. :)

The aim of the original series was to improve the documentation, so I
don't think it's unreasonable to consider this a regression and revert
the functional change.  Although I think we can improve the behaviour
slightly (see below).

> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
> index b6c6326..0f2bb9b 100644
> --- a/Documentation/git-rev-parse.txt
> +++ b/Documentation/git-rev-parse.txt
> @@ -28,7 +28,8 @@ OPTIONS
>  Operation Modes
>  ~~~~~~~~~~~~~~~
>  
> -Each of these options must appear first on the command line.
> +Each of these options must appear first on the command line; they do not
> +need to be run in a git repository.
>  
>  --parseopt::
>  	Use 'git rev-parse' in option parsing mode (see PARSEOPT section below).
> @@ -38,6 +39,18 @@ Each of these options must appear first on the command line.
>  	section below). In contrast to the `--sq` option below, this
>  	mode does only quoting. Nothing else is done to command input.
>  
> +--local-env-vars::
> +	List the GIT_* environment variables that are local to the
> +	repository (e.g. GIT_DIR or GIT_WORK_TREE, but not GIT_EDITOR).
> +	Only the names of the variables are listed, not their value,
> +	even if they are set.

I think we should add:

	No other arguments may be supplied.

> +--resolve-git-dir <path>::
> +	Check if <path> is a valid repository or a gitfile that
> +	points at a valid repository, and print the location of the
> +	repository.  If <path> is a gitfile then the resolved path
> +	to the real repository is printed.

Again I think this should say that only the `path` argument may be
supplied.

>  --git-path <path>::
>  	Resolve "$GIT_DIR/<path>" and takes other path relocation
>  	variables such as $GIT_OBJECT_DIRECTORY,
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index cf8487b..ccc0328 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -518,6 +518,21 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  	if (argc > 1 && !strcmp("--sq-quote", argv[1]))
>  		return cmd_sq_quote(argc - 2, argv + 2);
>  
> +	if (argc == 2 && !strcmp("--local-env-vars", argv[1])) {

Maybe:

	if (argc > 1 && !strcmp("--local-env-vars", argv[1])) {
		if (argc != 2)
			die("--local-env-vars must be the only argument");

since the behaviour of:

	$ git rev-parse --local-env-vars --
	--local-env-vars
	--

is quite surprising.

> +		int i;
> +		for (i = 0; local_repo_env[i]; i++)
> +			printf("%s\n", local_repo_env[i]);
> +		return 0;
> +	}
> +
> +	if (argc > 2 && !strcmp(argv[1], "--resolve-git-dir")) {

This is less bad, but again it might be nice to provide a better error
if the path argument isn't supplied.

> +		const char *gitdir = resolve_gitdir(argv[2]);
> +		if (!gitdir)
> +			die("not a gitdir '%s'", argv[2]);
> +		puts(gitdir);
> +		return 0;
> +	}
> +
>  	if (argc > 1 && !strcmp("-h", argv[1]))
>  		usage(builtin_rev_parse_usage);
>  
> @@ -706,12 +721,6 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  				add_ref_exclusion(&ref_excludes, arg + 10);
>  				continue;
>  			}
> -			if (!strcmp(arg, "--local-env-vars")) {

What about leaving this in and replacing the body of the if statement
with:

	die("--local-env-vars must be the first argument");

?  I expect this will significantly reduce debugging time if anyone is
relying on the current behaviour.

> -				int i;
> -				for (i = 0; local_repo_env[i]; i++)
> -					printf("%s\n", local_repo_env[i]);
> -				continue;
> -			}
>  			if (!strcmp(arg, "--show-toplevel")) {
>  				const char *work_tree = get_git_work_tree();
>  				if (work_tree)
> @@ -767,16 +776,6 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  				puts(prefix_filename(pfx, strlen(pfx), get_git_common_dir()));
>  				continue;
>  			}
> -			if (!strcmp(arg, "--resolve-git-dir")) {
> -				const char *gitdir = argv[++i];
> -				if (!gitdir)
> -					die("--resolve-git-dir requires an argument");
> -				gitdir = resolve_gitdir(gitdir);
> -				if (!gitdir)
> -					die("not a gitdir '%s'", argv[i]);
> -				puts(gitdir);
> -				continue;
> -			}
>  			if (!strcmp(arg, "--is-inside-git-dir")) {
>  				printf("%s\n", is_inside_git_dir() ? "true"
>  						: "false");
> diff --git a/t/t1515-rev-parse-outside-repo.sh b/t/t1515-rev-parse-outside-repo.sh
> index ae33093..3ec2971 100755
> --- a/t/t1515-rev-parse-outside-repo.sh
> +++ b/t/t1515-rev-parse-outside-repo.sh
> @@ -27,14 +27,14 @@ test_expect_success 'rev-parse --sq-quote' '
>  	test_cmp expect actual
>  '
>  
> -test_expect_failure 'rev-parse --local-env-vars' '
> +test_expect_success 'rev-parse --local-env-vars' '
>  	git rev-parse --local-env-vars >actual &&
>  	# we do not want to depend on the complete list here,
>  	# so just look for something plausible
>  	grep ^GIT_DIR actual
>  '
>  
> -test_expect_failure 'rev-parse --resolve-git-dir' '
> +test_expect_success 'rev-parse --resolve-git-dir' '
>  	git init --separate-git-dir repo dir &&
>  	test_must_fail git rev-parse --resolve-git-dir . &&
>  	echo "$(pwd)/repo" >expect &&
> -- 
> 2.7.2.767.g705917e
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
