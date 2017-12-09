Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3CAB1F406
	for <e@80x24.org>; Sat,  9 Dec 2017 12:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751547AbdLIMGZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Dec 2017 07:06:25 -0500
Received: from ikke.info ([178.21.113.177]:47754 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751221AbdLIMGZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Dec 2017 07:06:25 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id C9C844400D4; Sat,  9 Dec 2017 13:06:23 +0100 (CET)
Date:   Sat, 9 Dec 2017 13:06:23 +0100
From:   Kevin Daudt <me@ikke.info>
To:     Hans Jerry Illikainen <hji@dyntopia.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] pull: add config option for verifySignatures
Message-ID: <20171209120623.GC6006@alpha.vpn.ikke.info>
References: <20171209090530.6747-1-hji@dyntopia.com>
 <20171209090530.6747-3-hji@dyntopia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171209090530.6747-3-hji@dyntopia.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 09, 2017 at 09:05:30AM +0000, Hans Jerry Illikainen wrote:
> Verify the signature of the tip commit when `pull.verifySignatures` is
> true.  This option overrides `merge.verifySignatures` on pull, and can
> be disabled with the option `--no-verify-signatures`.

Is there a reason why git pull would need a different behaviour from git
merge? Pull itself is just a convenience command for fetch +
merge/rebase.

One precedent for having a separate configuration option for pull
however is 'pull.ff', so there might be a usecase for it.

I guess your commit message could use a motivation on why you want to
set this differently from 'merge.verifySignature'.

> 
> Signed-off-by: Hans Jerry Illikainen <hji@dyntopia.com>
> ---
>  Documentation/config.txt          |  8 ++++++++
>  builtin/pull.c                    | 25 +++++++++++++++++++++++++
>  t/t5520-pull.sh                   | 18 ++++++++++++++++++
>  t/t5573-pull-verify-signatures.sh | 32 ++++++++++++++++++++++++++++++++
>  4 files changed, 83 insertions(+)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index c1598ee70..0cd2bc597 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2596,6 +2596,14 @@ pull.ff::
>  	allowed (equivalent to giving the `--ff-only` option from the
>  	command line). This setting overrides `merge.ff` when pulling.
>  
> +pull.verifySignatures::
> +	Verify that the tip commit of the side branch being merged is
> +	signed with a valid key, i.e. a key that has a valid uid: in the
> +	default trust model, this means the signing key has been signed
> +	by a trusted key. If the tip commit of the side branch is not
> +	signed with a valid key, the merge is aborted. This setting
> +	overrides `merge.verifySignatures` when pulling.
> +
>  pull.rebase::
>  	When true, rebase branches on top of the fetched branch, instead
>  	of merging the default branch from the default remote when "git
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 166b777ed..791365915 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -300,6 +300,28 @@ static const char *config_get_ff(void)
>  }
>  
>  /**
> + * If pull.verifySignatures is unset, returns NULL. If pull.verifySignatures is
> + * "true", returns "--verify-signatures". If pull.verifySignatures is "false",
> + * returns "--no-verify-signatures". Otherwise, die with an error.
> + */
> +static const char *config_get_verify_signatures(void)
> +{
> +	const char *value;
> +
> +	if (git_config_get_value("pull.verifysignatures", &value))
> +		return NULL;
> +
> +	switch (git_parse_maybe_bool(value)) {
> +	case 0:
> +		return "--no-verify-signatures";
> +	case 1:
> +		return "--verify-signatures";
> +	default:
> +		die(_("Invalid value for pull.verifysignatures: %s"), value);
> +	}
> +}
> +
> +/**
>   * Returns the default configured value for --rebase. It first looks for the
>   * value of "branch.$curr_branch.rebase", where $curr_branch is the current
>   * branch, and if HEAD is detached or the configuration key does not exist,
> @@ -849,6 +871,9 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>  	if (!opt_ff)
>  		opt_ff = xstrdup_or_null(config_get_ff());
>  
> +	if (!opt_verify_signatures)
> +		opt_verify_signatures = xstrdup_or_null(config_get_verify_signatures());
> +
>  	if (opt_rebase < 0)
>  		opt_rebase = config_get_rebase();
>  
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 59c4b778d..cdf1fd213 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -416,6 +416,15 @@ test_expect_success "pull --rebase warns on --verify-signatures" '
>  	test_i18ngrep "ignoring --verify-signatures for rebase" err
>  '
>  
> +test_expect_success "pull --rebase warns on pull.verifySignatures=true" '
> +	test_config pull.verifySignatures true &&
> +	git reset --hard before-rebase &&
> +	git pull --rebase . copy 2>err &&
> +	test "$(git rev-parse HEAD^)" = "$(git rev-parse copy)" &&
> +	test new = "$(git show HEAD:file2)" &&
> +	test_i18ngrep "ignoring --verify-signatures for rebase" err
> +'
> +
>  test_expect_success "pull --rebase does not warn on --no-verify-signatures" '
>  	git reset --hard before-rebase &&
>  	git pull --rebase --no-verify-signatures . copy 2>err &&
> @@ -424,6 +433,15 @@ test_expect_success "pull --rebase does not warn on --no-verify-signatures" '
>  	test_i18ngrep ! "verify-signatures" err
>  '
>  
> +test_expect_success "pull --rebase does not warn on pull.verifySignatures=false" '
> +	test_config pull.verifySignatures false &&
> +	git reset --hard before-rebase &&
> +	git pull --rebase . copy 2>err &&
> +	test "$(git rev-parse HEAD^)" = "$(git rev-parse copy)" &&
> +	test new = "$(git show HEAD:file2)" &&
> +	test_i18ngrep ! "verify-signatures" err
> +'
> +
>  # add a feature branch, keep-merge, that is merged into master, so the
>  # test can try preserving the merge commit (or not) with various
>  # --rebase flags/pull.rebase settings.
> diff --git a/t/t5573-pull-verify-signatures.sh b/t/t5573-pull-verify-signatures.sh
> index 700247910..d1e8263d9 100755
> --- a/t/t5573-pull-verify-signatures.sh
> +++ b/t/t5573-pull-verify-signatures.sh
> @@ -47,22 +47,54 @@ test_expect_success GPG 'pull unsigned commit with --verify-signatures' '
>  	test_i18ngrep "does not have a GPG signature" pullerror
>  '
>  
> +test_expect_success GPG 'pull unsigned commit with pull.verifySignatures=true' '
> +	test_config pull.verifySignatures true &&
> +	test_must_fail git pull --ff-only unsigned 2>pullerror &&
> +	test_i18ngrep "does not have a GPG signature" pullerror
> +'
> +
>  test_expect_success GPG 'pull commit with bad signature with --verify-signatures' '
>  	test_must_fail git pull --ff-only --verify-signatures bad 2>pullerror &&
>  	test_i18ngrep "has a bad GPG signature" pullerror
>  '
>  
> +test_expect_success GPG 'pull commit with bad signature with pull.verifySignatures=true' '
> +	test_config pull.verifySignatures true &&
> +	test_must_fail git pull --ff-only bad 2>pullerror &&
> +	test_i18ngrep "has a bad GPG signature" pullerror
> +'
> +
>  test_expect_success GPG 'pull commit with untrusted signature with --verify-signatures' '
>  	test_must_fail git pull --ff-only --verify-signatures untrusted 2>pullerror &&
>  	test_i18ngrep "has an untrusted GPG signature" pullerror
>  '
>  
> +test_expect_success GPG 'pull commit with untrusted signature with pull.verifySignatures=true' '
> +	test_config pull.verifySignatures true &&
> +	test_must_fail git pull --ff-only untrusted 2>pullerror &&
> +	test_i18ngrep "has an untrusted GPG signature" pullerror
> +'
> +
> +test_expect_success GPG 'pull commit with untrusted signature with pull.verifySignatures=true and merge.verifySignatures=false' '
> +	test_config merge.verifySignatures false &&
> +	test_config pull.verifySignatures true &&
> +	test_must_fail git pull --ff-only untrusted 2>pullerror &&
> +	test_i18ngrep "has an untrusted GPG signature" pullerror
> +'
> +
>  test_expect_success GPG 'pull signed commit with --verify-signatures' '
>  	git pull --verify-signatures signed >pulloutput &&
>  	test_i18ngrep "has a good GPG signature" pulloutput &&
>  	git checkout initial
>  '
>  
> +test_expect_success GPG 'pull signed commit with pull.verifySignatures=true' '
> +	test_config pull.verifySignatures true &&
> +	git pull signed >pulloutput &&
> +	test_i18ngrep "has a good GPG signature" pulloutput &&
> +	git checkout initial
> +'
> +
>  test_expect_success GPG 'pull commit with bad signature without verification' '
>  	git pull --ff-only bad 2>pullerror &&
>  	git checkout initial
> -- 
> 2.11.0
> 
