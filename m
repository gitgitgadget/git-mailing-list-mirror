Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73F461F45A
	for <e@80x24.org>; Wed, 14 Aug 2019 17:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731044AbfHNROO (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Aug 2019 13:14:14 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:53049 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731040AbfHNRON (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Aug 2019 13:14:13 -0400
X-Originating-IP: 157.45.7.170
Received: from localhost (unknown [157.45.7.170])
        (Authenticated sender: me@yadavpratyush.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id E0B981C0007;
        Wed, 14 Aug 2019 17:14:07 +0000 (UTC)
Date:   Wed, 14 Aug 2019 22:44:04 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Matthieu Moy <git@matthieu-moy.fr>
Cc:     git@vger.kernel.org, matthieu.moy@univ-lyon1.fr,
        corentin.bompard@etu.univ-lyon1.fr, gitster@pobox.com,
        nathan.berbezier@etu.univ-lyon1.fr,
        pablo.chabanne@etu.univ-lyon1.fr
Subject: Re: [PATCH] pull, fetch: add --set-upstream option
Message-ID: <20190814171404.zqtd4xctjobgpzby@localhost.localdomain>
References: <86zhoil3yw.fsf@univ-lyon1.fr>
 <20190814134629.21096-1-git@matthieu-moy.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814134629.21096-1-git@matthieu-moy.fr>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matthieu,

This is not really a review. Just some minor nitpicks I spotted while 
reading through.

On 14/08/19 03:46PM, Matthieu Moy wrote:
> From: Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>
> 
> Add the --set-upstream option to git pull/fetch
> which lets the user set the upstream configuration
> (branch.<current-branch-name>.merge and
> branch.<current-branch-name>.remote) for the current branch.
> 
> A typical use-case is:
> 
>     git clone http://example.com/my-public-fork
>     git remote add main http://example.com/project-main-repo
>     git pull --set-upstream main master
> 
> or, instead of the last line:
> 
>     git fetch --set-upstream main master
>     git merge # or git rebase
> 
> This functionality is analog to push --set-upstream.
> 
> Signed-off-by: Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>
> Signed-off-by: Nathan BERBEZIER <nathan.berbezier@etu.univ-lyon1.fr>
> Signed-off-by: Pablo CHABANNE <pablo.chabanne@etu.univ-lyon1.fr>
> Signed-off-by: Matthieu Moy <git@matthieu-moy.fr>
> Patch-edited-by: Matthieu Moy <git@matthieu-moy.fr>
> ---
> This is a followup on
> https://public-inbox.org/git/86zhoil3yw.fsf@univ-lyon1.fr/. It's
> initially a student project, but students didn't get time to complete
> it. Still, I think the feature is interesting, and I finally get time
> to fix the remarks made up to now. This now looks good to me, but
> obviously needs other pairs of eyes.
> 
> Thanks,
> 
>  Documentation/fetch-options.txt |   7 ++
>  builtin/fetch.c                 |  48 ++++++++-
>  builtin/pull.c                  |   6 ++
>  t/t5553-set-upstream.sh         | 178 ++++++++++++++++++++++++++++++++
>  4 files changed, 238 insertions(+), 1 deletion(-)
>  create mode 100755 t/t5553-set-upstream.sh
> 
> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
> index 3c9b4f9e09..99df1f3d4e 100644
> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -169,6 +169,13 @@ ifndef::git-pull[]
>  	Disable recursive fetching of submodules (this has the same effect as
>  	using the `--recurse-submodules=no` option).
>  
> +--set-upstream::
> +	If the remote is fetched successfully, pull and add upstream
> +	(tracking) reference, used by argument-less
> +	linkgit:git-pull[1] and other commands. For more information,
> +	see `branch.<name>.merge` and `branch.<name>.remote` in
> +	linkgit:git-config[1].
> +
>  --submodule-prefix=<path>::
>  	Prepend <path> to paths printed in informative messages
>  	such as "Fetching submodule foo".  This option is used
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 717dd14e89..5557ae1c04 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -23,6 +23,7 @@
>  #include "packfile.h"
>  #include "list-objects-filter-options.h"
>  #include "commit-reach.h"
> +#include "branch.h"
>  
>  #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)
>  
> @@ -50,7 +51,7 @@ static int fetch_prune_tags_config = -1; /* unspecified */
>  static int prune_tags = -1; /* unspecified */
>  #define PRUNE_TAGS_BY_DEFAULT 0 /* do we prune tags by default? */
>  
> -static int all, append, dry_run, force, keep, multiple, update_head_ok, verbosity, deepen_relative;
> +static int all, append, dry_run, force, keep, multiple, update_head_ok, verbosity, deepen_relative, set_upstream;

This line is getting pretty long. I think it is a good idea to split it 
into two.

>  static int progress = -1;
>  static int enable_auto_gc = 1;
>  static int tags = TAGS_DEFAULT, unshallow, update_shallow, deepen;
> @@ -123,6 +124,8 @@ static struct option builtin_fetch_options[] = {
>  	OPT__VERBOSITY(&verbosity),
>  	OPT_BOOL(0, "all", &all,
>  		 N_("fetch from all remotes")),
> +	OPT_BOOL(0, "set-upstream", &set_upstream,
> +		 N_("set upstream for git pull/fetch")),
>  	OPT_BOOL('a', "append", &append,
>  		 N_("append to .git/FETCH_HEAD instead of overwriting")),
>  	OPT_STRING(0, "upload-pack", &upload_pack, N_("path"),
> @@ -1367,6 +1370,49 @@ static int do_fetch(struct transport *transport,
>  		retcode = 1;
>  		goto cleanup;
>  	}
> +
> +	if (set_upstream) {
> +		struct branch *branch = branch_get("HEAD");
> +		struct ref *rm;
> +		struct ref *source_ref = NULL;
> +
> +		/*
> +		 * We're setting the upstream configuration for the current branch. The
> +		 * relevent upstream is the fetched branch that is meant to be merged with
> +		 * the current one, i.e. the one fetched to FETCH_HEAD.
> +		 *
> +		 * When there are several such branches, consider the request ambiguous and
> +		 * err on the safe side by doing nothing and just emit a warning.
> +		 */

The comment lines cross the 80 column boundary. The usual convention in 
this project is to try to keep lines below 80 columns. For strings IMO 
an exception can be allowed because breaking them up makes it harder to 
grep for them. But comments are the easiest to format.

Are you using a tab size of 4? That might explain why your line breaks 
are just after the 80 col boundary. The coding guidelines say you should 
make your tab characters 8 columns wide.

> +		for (rm = ref_map; rm; rm = rm->next) {
> +			if (!rm->peer_ref) {
> +				if (source_ref) {
> +					warning(_("multiple branch detected, incompatible with --set-upstream"));
> +					goto skip;
> +				} else {
> +					source_ref = rm;
> +				}
> +			}
> +		}
> +		if (source_ref) {
> +			if (!strcmp(source_ref->name, "HEAD") || 

This line has a trailing space.

> +				starts_with(source_ref->name, "refs/heads/")) {
> +				install_branch_config(0, branch->name,
> +							 transport->remote->name,
> +							 source_ref->name);

In other places around this code, multi line function calls are aligned 
with the opening parenthesis. It is a good idea to follow that 
convention.

So this should change to something like:

				install_branch_config(0, branch->name,
						      transport->remote->name,
						      source_ref->name);
 
Maybe this discrepancy is because you are using the wrong tab size?

> +			} else if (starts_with(source_ref->name, "refs/remotes/")) {
> +				warning(_("not setting upstream for a remote remote-tracking branch"));
> +			} else if (starts_with(source_ref->name, "refs/tags/")) {
> +				warning(_("not setting upstream for a remote tag"));
> +			} else {
> +				warning(_("unknown branch type"));
> +			}

No need to wrap single line if statements in braces.

> +		} else {
> +			warning(_("no source branch found.\n"
> +				"you need to specify exactly one branch with the --set-upstream option."));
> +		}
> +	}
> + skip:
>  	free_refs(ref_map);
>  
>  	/* if neither --no-tags nor --tags was specified, do automated tag
> diff --git a/builtin/pull.c b/builtin/pull.c
> index f1eaf6e6ed..d25ff13a60 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -129,6 +129,7 @@ static char *opt_refmap;
>  static char *opt_ipv4;
>  static char *opt_ipv6;
>  static int opt_show_forced_updates = -1;
> +static char *set_upstream;
>  
>  static struct option pull_options[] = {
>  	/* Shared options */
> @@ -243,6 +244,9 @@ static struct option pull_options[] = {
>  		PARSE_OPT_NOARG),
>  	OPT_BOOL(0, "show-forced-updates", &opt_show_forced_updates,
>  		 N_("check for forced-updates on all updated branches")),
> +	OPT_PASSTHRU(0, "set-upstream", &set_upstream, NULL,
> +		N_("set upstream for git pull/fetch"),
> +		PARSE_OPT_NOARG),
>  
>  	OPT_END()
>  };
> @@ -556,6 +560,8 @@ static int run_fetch(const char *repo, const char **refspecs)
>  		argv_array_push(&args, "--show-forced-updates");
>  	else if (opt_show_forced_updates == 0)
>  		argv_array_push(&args, "--no-show-forced-updates");
> +	if (set_upstream)
> +		argv_array_push(&args, set_upstream);
>  
>  	if (repo) {
>  		argv_array_push(&args, repo);
> diff --git a/t/t5553-set-upstream.sh b/t/t5553-set-upstream.sh
> new file mode 100755
> index 0000000000..bd1a94f494
> --- /dev/null
> +++ b/t/t5553-set-upstream.sh
> @@ -0,0 +1,178 @@
> +#!/bin/sh
> +
> +test_description='"git fetch/pull --set-upstream" basic tests.'
> +. ./test-lib.sh
> +
> +check_config () {
> +	printf "%s\n" "$2" "$3" >"expect.$1" &&
> +	{
> +		git config "branch.$1.remote" && git config "branch.$1.merge"
> +	} >"actual.$1" &&
> +	test_cmp "expect.$1" "actual.$1"
> +}
> +
> +check_config_missing () {
> +	test_expect_code 1 git config "branch.$1.remote" &&
> +	test_expect_code 1 git config "branch.$1.merge"
> +}
> +
> +clear_config () {
> +	for branch in "$@"; do
> +		test_might_fail git config --unset-all "branch.$branch.remote"
> +		test_might_fail git config --unset-all "branch.$branch.merge"
> +	done
> +}
> +
> +ensure_fresh_upstream () {
> +	rm -rf parent && git init --bare parent
> +}
> +
> +test_expect_success 'setup bare parent fetch' '
> +	ensure_fresh_upstream &&
> +	git remote add upstream parent
> +'
> +
> +test_expect_success 'setup commit on master and other fetch' '
> +	test_commit one &&
> +	git push upstream master &&
> +	git checkout -b other &&
> +	test_commit two &&
> +	git push upstream other
> +'
> +
> +#tests for fetch --set-upstream

Add a space after the '#'. Same in other comments below.

> +
> +test_expect_success 'fetch --set-upstream does not set upstream w/o branch' '
> +	clear_config master other &&
> +	git checkout master &&
> +	git fetch --set-upstream upstream &&
> +	check_config_missing master &&
> +	check_config_missing other
> +'
> +
> +test_expect_success 'fetch --set-upstream upstream master sets branch master but not other' '
> +	clear_config master other &&
> +	git fetch --set-upstream upstream master &&
> +	check_config master upstream refs/heads/master &&
> +	check_config_missing other
> +'
> +
> +test_expect_success 'fetch --set-upstream upstream other sets branch other' '
> +	clear_config master other &&
> +	git fetch --set-upstream upstream other &&
> +	check_config master upstream refs/heads/other &&
> +	check_config_missing other
> +'
> +
> +test_expect_success 'fetch --set-upstream master:other does not set the branch other2' '
> +	clear_config other2 &&
> +	git fetch --set-upstream upstream master:other2 &&
> +	check_config_missing other2
> +'
> +
> +test_expect_success 'fetch --set-upstream http://nosuchdomain.example.com fails with invalid url' '
> +	# master explicitly not cleared, we check that it is not touched from previous value
> +	clear_config other other2 &&
> +	test_must_fail git fetch --set-upstream http://nosuchdomain.example.com &&
> +	check_config master upstream refs/heads/other &&
> +	check_config_missing other &&
> +	check_config_missing other2
> +'
> +
> +test_expect_success 'fetch --set-upstream with valid URL sets upstream to URL' '
> +	clear_config other other2 &&
> +	url="file://'"$PWD"'" &&
> +	git fetch --set-upstream "$url" &&
> +	check_config master "$url" HEAD &&
> +	check_config_missing other &&
> +	check_config_missing other2
> +'
> +
> +#tests for pull --set-upstream
> +
> +test_expect_success 'setup bare parent pull' '
> +	git remote rm upstream &&
> +	ensure_fresh_upstream &&
> +	git remote add upstream parent
> +'
> +
> +test_expect_success 'setup commit on master and other pull' '
> +	test_commit three &&
> +	git push --tags upstream master &&
> +	test_commit four &&
> +	git push upstream other
> +'
> +
> +test_expect_success 'pull --set-upstream upstream master sets branch master but not other' '
> +	clear_config master other &&
> +	git pull --set-upstream upstream master &&
> +	check_config master upstream refs/heads/master &&
> +	check_config_missing other
> +'
> +
> +test_expect_success 'pull --set-upstream master:other2 does not set the branch other2' '
> +	clear_config other2 &&
> +	git pull --set-upstream upstream master:other2 &&
> +	check_config_missing other2
> +'
> +
> +test_expect_success 'pull --set-upstream upstream other sets branch master' '
> +	clear_config master other &&
> +	git pull --set-upstream upstream other &&
> +	check_config master upstream refs/heads/other &&
> +	check_config_missing other
> +'
> +
> +test_expect_success 'pull --set-upstream upstream tag does not set the tag' '
> +	clear_config three &&
> +	git pull --tags --set-upstream upstream three &&
> +	check_config_missing three
> +'
> +
> +test_expect_success 'pull --set-upstream http://nosuchdomain.example.com fails with invalid url' '
> +	# master explicitly not cleared, we check that it is not touched from previous value
> +	clear_config other other2 three &&
> +	test_must_fail git pull --set-upstream http://nosuchdomain.example.com &&
> +	check_config master upstream refs/heads/other &&
> +	check_config_missing other &&
> +	check_config_missing other2 &&
> +	check_config_missing three
> +'
> +
> +test_expect_success 'pull --set-upstream upstream HEAD sets branch HEAD' '
> +	clear_config master other &&
> +	git pull --set-upstream upstream HEAD &&
> +	check_config master upstream HEAD &&
> +	git checkout other &&
> +	git pull --set-upstream upstream HEAD &&
> +	check_config other upstream HEAD
> +'
> +
> +test_expect_success 'pull --set-upstream upstream with more than one branch does nothing' '
> +	clear_config master three &&
> +	git pull --set-upstream upstream master three &&
> +	check_config_missing master &&
> +	check_config_missing three
> +'
> +
> +test_expect_success 'pull --set-upstream with valid URL sets upstream to URL' '
> +	clear_config master other other2 &&
> +	git checkout master &&
> +	url="file://'"$PWD"'" &&
> +	git pull --set-upstream "$url" &&
> +	check_config master "$url" HEAD &&
> +	check_config_missing other &&
> +	check_config_missing other2
> +'
> +
> +test_expect_success 'pull --set-upstream with valid URL and branch sets branch' '
> +	clear_config master other other2 &&
> +	git checkout master &&
> +	url="file://'"$PWD"'" &&
> +	git pull --set-upstream "$url" master &&
> +	check_config master "$url" refs/heads/master &&
> +	check_config_missing other &&
> +	check_config_missing other2
> +'
> +
> +test_done
> -- 
> 2.20.1.98.gecbdaf0
> 

-- 
Regards,
Pratyush Yadav
