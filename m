Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82CC21FEB3
	for <e@80x24.org>; Sat,  7 Jan 2017 00:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034631AbdAGAzF (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 19:55:05 -0500
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:47298 "EHLO
        homiemail-a18.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S939894AbdAGAzE (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Jan 2017 19:55:04 -0500
Received: from homiemail-a18.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a18.g.dreamhost.com (Postfix) with ESMTP id 5B4D4258065;
        Fri,  6 Jan 2017 16:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:cc:date:in-reply-to:references:content-type
        :mime-version:content-transfer-encoding; s=novalis.org; bh=sqJ6T
        w5wsfomufkcU+09+w1k79Q=; b=gSUiEorhT/sM+XWtm/tn7V1lh8ULDH3p9RHkc
        dKbmQdGrYCVVqUj7kzB3b2yMqdGRUrcWZCXBfZMB2xl/gsQcSfGCc/wJwDwGe/Ft
        APPN0X18RCEy5y9iwgZt6L8BU6TDsaXza0+NHxhRadwffL5+3p8o4ozIDLORluMA
        MqXD7Y=
Received: from [172.31.11.72] (gzac10-107-1.nje.twosigma.com [208.77.214.155])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a18.g.dreamhost.com (Postfix) with ESMTPSA id EB439258062;
        Fri,  6 Jan 2017 16:55:02 -0800 (PST)
Message-ID: <1483750501.31165.9.camel@frank>
Subject: Re: [PATCH] submodule update --init: displays correct path from
 submodule
From:   David Turner <novalis@novalis.org>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Date:   Fri, 06 Jan 2017 19:55:01 -0500
In-Reply-To: <20170107001953.3196-1-sbeller@google.com>
References: <20170107001953.3196-1-sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(for the test)
Signed-off-by: David Turner <dturner@twosigma.com>

TIL: super-prefix!


On Fri, 2017-01-06 at 16:19 -0800, Stefan Beller wrote:
> In the submodule helper we did not correctly handled the display path
> for initializing submodules when both the submodule is inside a
> subdirectory as well as the command being invoked from a subdirectory
> (as viewed from the superproject).
> 
> This was broken in 3604242f080, which was written at a time where
> there was no super-prefix available, so we abused the --prefix option
> for the same purpose and could get only one case right (the call from
> within a subdirectory, not the submodule being in a subdirectory).
> 
> Test-provided-by: David Turner <novalis@novalis.org>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> 
>   applies on sb/submodule-embed-gitdir as that contains 89c862655
>   (submodule helper: support super prefix)
> 
>  builtin/submodule--helper.c | 13 +++++++------
>  git-submodule.sh            |  2 +-
>  t/t7406-submodule-update.sh | 17 +++++++++++++++++
>  3 files changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 242d9911a6..7b3f9fc293 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -305,32 +305,36 @@ static int module_list(int argc, const char **argv, const char *prefix)
>  
>  		utf8_fprintf(stdout, "%s\n", ce->name);
>  	}
>  	return 0;
>  }
>  
>  static void init_submodule(const char *path, const char *prefix, int quiet)
>  {
>  	const struct submodule *sub;
>  	struct strbuf sb = STRBUF_INIT;
>  	char *upd = NULL, *url = NULL, *displaypath;
>  
>  	/* Only loads from .gitmodules, no overlay with .git/config */
>  	gitmodules_config();
>  
> -	if (prefix) {
> -		strbuf_addf(&sb, "%s%s", prefix, path);
> +	if (prefix && get_super_prefix())
> +		die("BUG: cannot have prefix and superprefix");
> +	else if (prefix)
> +		displaypath = xstrdup(relative_path(path, prefix, &sb));
> +	else if (get_super_prefix()) {
> +		strbuf_addf(&sb, "%s%s", get_super_prefix(), path);
>  		displaypath = strbuf_detach(&sb, NULL);
>  	} else
>  		displaypath = xstrdup(path);
>  
>  	sub = submodule_from_path(null_sha1, path);
>  
>  	if (!sub)
>  		die(_("No url found for submodule path '%s' in .gitmodules"),
>  			displaypath);
>  
>  	/*
>  	 * Copy url setting when it is not set yet.
>  	 * To look up the url in .git/config, we must not fall back to
>  	 * .gitmodules, so look it up directly.
>  	 */
> @@ -391,33 +395,30 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
>  	}
>  	strbuf_release(&sb);
>  	free(displaypath);
>  	free(url);
>  	free(upd);
>  }
>  
>  static int module_init(int argc, const char **argv, const char *prefix)
>  {
>  	struct pathspec pathspec;
>  	struct module_list list = MODULE_LIST_INIT;
>  	int quiet = 0;
>  	int i;
>  
>  	struct option module_init_options[] = {
> -		OPT_STRING(0, "prefix", &prefix,
> -			   N_("path"),
> -			   N_("alternative anchor for relative paths")),
>  		OPT__QUIET(&quiet, N_("Suppress output for initializing a submodule")),
>  		OPT_END()
>  	};
>  
>  	const char *const git_submodule_helper_usage[] = {
>  		N_("git submodule--helper init [<path>]"),
>  		NULL
>  	};
>  
>  	argc = parse_options(argc, argv, prefix, module_init_options,
>  			     git_submodule_helper_usage, 0);
>  
>  	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
>  		return 1;
>  
> @@ -1117,31 +1118,31 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
>  
>  struct cmd_struct {
>  	const char *cmd;
>  	int (*fn)(int, const char **, const char *);
>  	unsigned option;
>  };
>  
>  static struct cmd_struct commands[] = {
>  	{"list", module_list, 0},
>  	{"name", module_name, 0},
>  	{"clone", module_clone, 0},
>  	{"update-clone", update_clone, 0},
>  	{"relative-path", resolve_relative_path, 0},
>  	{"resolve-relative-url", resolve_relative_url, 0},
>  	{"resolve-relative-url-test", resolve_relative_url_test, 0},
> -	{"init", module_init, 0},
> +	{"init", module_init, SUPPORT_SUPER_PREFIX},
>  	{"remote-branch", resolve_remote_submodule_branch, 0},
>  	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
>  };
>  
>  int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
>  {
>  	int i;
>  	if (argc < 2)
>  		die(_("submodule--helper subcommand must be "
>  		      "called with a subcommand"));
>  
>  	for (i = 0; i < ARRAY_SIZE(commands); i++) {
>  		if (!strcmp(argv[1], commands[i].cmd)) {
>  			if (get_super_prefix() &&
>  			    !(commands[i].option & SUPPORT_SUPER_PREFIX))
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 9285b5c43d..4e47ff8ad8 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -362,31 +362,31 @@ cmd_init()
>  			;;
>  		--)
>  			shift
>  			break
>  			;;
>  		-*)
>  			usage
>  			;;
>  		*)
>  			break
>  			;;
>  		esac
>  		shift
>  	done
>  
> -	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper init ${GIT_QUIET:+--quiet} ${prefix:+--prefix "$prefix"} "$@"
> +	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper init ${GIT_QUIET:+--quiet}  "$@"
>  }
>  
>  #
>  # Unregister submodules from .git/config and remove their work tree
>  #
>  cmd_deinit()
>  {
>  	# parse $args after "submodule ... deinit".
>  	deinit_all=
>  	while test $# -ne 0
>  	do
>  		case "$1" in
>  		-f|--force)
>  			force=$1
>  			;;
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index 64f322c4cc..725bbed1f8 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -128,30 +128,47 @@ done.
>  Cloning into '$pwd/recursivesuper/super/submodule'...
>  done.
>  EOF
>  
>  test_expect_success 'submodule update --init --recursive from subdirectory' '
>  	git -C recursivesuper/super reset --hard HEAD^ &&
>  	(cd recursivesuper &&
>  	 mkdir tmp &&
>  	 cd tmp &&
>  	 git submodule update --init --recursive ../super >../../actual 2>../../actual2
>  	) &&
>  	test_i18ncmp expect actual &&
>  	test_i18ncmp expect2 actual2
>  '
>  
> +cat <<EOF >expect2
> +Submodule 'foo/sub' ($pwd/withsubs/../rebasing) registered for path 'sub'
> +EOF
> +
> +test_expect_success 'submodule update --init from and of subdirectory' '
> +	git init withsubs &&
> +	(cd withsubs &&
> +	 mkdir foo &&
> +	 git submodule add "$(pwd)/../rebasing" foo/sub &&
> +	 (cd foo &&
> +	  git submodule deinit -f sub &&
> +	  git submodule update --init sub 2>../../actual2
> +	 )
> +	) &&
> +	test_i18ncmp expect2 actual2
> +'
> +
>  apos="'";
>  test_expect_success 'submodule update does not fetch already present commits' '
>  	(cd submodule &&
>  	  echo line3 >> file &&
>  	  git add file &&
>  	  test_tick &&
>  	  git commit -m "upstream line3"
>  	) &&
>  	(cd super/submodule &&
>  	  head=$(git rev-parse --verify HEAD) &&
>  	  echo "Submodule path ${apos}submodule$apos: checked out $apos$head$apos" > ../../expected &&
>  	  git reset --hard HEAD~1
>  	) &&
>  	(cd super &&
>  	  git submodule update > ../actual 2> ../actual.err


