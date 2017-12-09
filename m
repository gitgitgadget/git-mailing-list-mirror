Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A00F1F406
	for <e@80x24.org>; Sat,  9 Dec 2017 12:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751335AbdLIMFk (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Dec 2017 07:05:40 -0500
Received: from ikke.info ([178.21.113.177]:47662 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751221AbdLIMFj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Dec 2017 07:05:39 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id E15AE4400D4; Sat,  9 Dec 2017 13:05:37 +0100 (CET)
Date:   Sat, 9 Dec 2017 13:05:37 +0100
From:   Kevin Daudt <me@ikke.info>
To:     Hans Jerry Illikainen <hji@dyntopia.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] merge: add config option for verifySignatures
Message-ID: <20171209120537.GA6006@alpha.vpn.ikke.info>
References: <20171209090530.6747-1-hji@dyntopia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171209090530.6747-1-hji@dyntopia.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Hans Jerry,

Thank you for your contribution. I have soem remarks below.

On Sat, Dec 09, 2017 at 09:05:28AM +0000, Hans Jerry Illikainen wrote:
> Verify the signature of the tip commit when `merge.verifySignatures` is
> true.  This can be overridden with `--no-verify-signatures`.
> 
> Signed-off-by: Hans Jerry Illikainen <hji@dyntopia.com>

I miss the motivation in the commit message. I imagine something like:

    git merge --verify-signatures can be used to verify that the tip
    commit of the branch being merged in is properly signed, but it's
    cumbersome to have to specify that every time.
    
    Add a configuration option that enables this behaviour by default,
    which can be overridden by --no-verify-signatures.


> ---
>  Documentation/merge-config.txt     |  7 +++++++
>  builtin/merge.c                    |  2 ++
>  t/t7612-merge-verify-signatures.sh | 43 ++++++++++++++++++++++++++++++++++++--
>  3 files changed, 50 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
> index df3ea3779..76571cd3b 100644
> --- a/Documentation/merge-config.txt
> +++ b/Documentation/merge-config.txt
> @@ -26,6 +26,13 @@ merge.ff::
>  	allowed (equivalent to giving the `--ff-only` option from the
>  	command line).
>  
> +merge.verifySignatures::
> +	Verify that the tip commit of the side branch being merged is
> +	signed with a valid key, i.e. a key that has a valid uid: in the
> +	default trust model, this means the signing key has been signed
> +	by a trusted key. If the tip commit of the side branch is not
> +	signed with a valid key, the merge is aborted.
> +

This is a verbatim copy of the explenation of --verify-signatures. Would
it be an idea to refer to the explenation of merge --verify-signatures?

>  include::fmt-merge-msg-config.txt[]
>  
>  merge.renameLimit::
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 612dd7bfb..30264cfd7 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -567,6 +567,8 @@ static int git_merge_config(const char *k, const char *v, void *cb)
>  
>  	if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat"))
>  		show_diffstat = git_config_bool(k, v);
> +	else if (!strcmp(k, "merge.verifysignatures"))
> +		verify_signatures = git_config_bool(k, v);
>  	else if (!strcmp(k, "pull.twohead"))
>  		return git_config_string(&pull_twohead, k, v);
>  	else if (!strcmp(k, "pull.octopus"))
> diff --git a/t/t7612-merge-verify-signatures.sh b/t/t7612-merge-verify-signatures.sh
> index 8ae69a61c..f1a74a683 100755
> --- a/t/t7612-merge-verify-signatures.sh
> +++ b/t/t7612-merge-verify-signatures.sh
> @@ -39,23 +39,62 @@ test_expect_success GPG 'merge unsigned commit with verification' '
>  	test_i18ngrep "does not have a GPG signature" mergeerror
>  '
>  
> +test_expect_success GPG 'merge unsigned commit with merge.verifySignatures=true' '
> +	test_config merge.verifySignatures true &&
> +	test_must_fail git merge --ff-only side-unsigned 2>mergeerror &&
> +	test_i18ngrep "does not have a GPG signature" mergeerror
> +'
> +
>  test_expect_success GPG 'merge commit with bad signature with verification' '
>  	test_must_fail git merge --ff-only --verify-signatures $(cat forged.commit) 2>mergeerror &&
>  	test_i18ngrep "has a bad GPG signature" mergeerror
>  '
>  
> +test_expect_success GPG 'merge commit with bad signature with merge.verifySignatures=true' '
> +	test_config merge.verifySignatures true &&
> +	test_must_fail git merge --ff-only $(cat forged.commit) 2>mergeerror &&
> +	test_i18ngrep "has a bad GPG signature" mergeerror
> +'
> +
>  test_expect_success GPG 'merge commit with untrusted signature with verification' '
>  	test_must_fail git merge --ff-only --verify-signatures side-untrusted 2>mergeerror &&
>  	test_i18ngrep "has an untrusted GPG signature" mergeerror
>  '
>  
> +test_expect_success GPG 'merge commit with untrusted signature with merge.verifySignatures=true' '
> +	test_config merge.verifySignatures true &&
> +	test_must_fail git merge --ff-only side-untrusted 2>mergeerror &&
> +	test_i18ngrep "has an untrusted GPG signature" mergeerror
> +'
> +
>  test_expect_success GPG 'merge signed commit with verification' '
>  	git merge --verbose --ff-only --verify-signatures side-signed >mergeoutput &&
> -	test_i18ngrep "has a good GPG signature" mergeoutput
> +	test_i18ngrep "has a good GPG signature" mergeoutput &&
> +	git checkout initial

This looks like a clean up step. If so, it's better to add
`test_when_finished 'git checkout initial'` at the beginning to clearly
mark it as a clean up step and make sure it's run even when the test
fails. Same counts for the other occurances.

> +'
> +
> +test_expect_success GPG 'merge signed commit with merge.verifySignatures=true' '
> +	test_config merge.verifySignatures true &&
> +	git merge --verbose --ff-only side-signed >mergeoutput &&
> +	test_i18ngrep "has a good GPG signature" mergeoutput &&
> +	git checkout initial
>  '
>  
>  test_expect_success GPG 'merge commit with bad signature without verification' '
> -	git merge $(cat forged.commit)
> +	git merge $(cat forged.commit) &&
> +	git checkout initial
> +'
> +
> +test_expect_success GPG 'merge commit with bad signature with merge.verifySignatures=false' '
> +	test_config merge.verifySignatures false &&
> +	git merge $(cat forged.commit) &&
> +	git checkout initial
> +'
> +
> +test_expect_success GPG 'merge commit with bad signature with merge.verifySignatures=true and --no-verify-signatures' '
> +	test_config merge.verifySignatures true &&
> +	git merge --no-verify-signatures $(cat forged.commit) &&
> +	git checkout initial
>  '
>  
>  test_done

Kevin.
