Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60F401F406
	for <e@80x24.org>; Sat,  9 Dec 2017 12:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751408AbdLIMGQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Dec 2017 07:06:16 -0500
Received: from ikke.info ([178.21.113.177]:47730 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751221AbdLIMGP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Dec 2017 07:06:15 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id A53C84400D4; Sat,  9 Dec 2017 13:06:14 +0100 (CET)
Date:   Sat, 9 Dec 2017 13:06:14 +0100
From:   Kevin Daudt <me@ikke.info>
To:     Hans Jerry Illikainen <hji@dyntopia.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] t: add tests for pull --verify-signatures
Message-ID: <20171209120614.GB6006@alpha.vpn.ikke.info>
References: <20171209090530.6747-1-hji@dyntopia.com>
 <20171209090530.6747-2-hji@dyntopia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171209090530.6747-2-hji@dyntopia.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 09, 2017 at 09:05:29AM +0000, Hans Jerry Illikainen wrote:
> Add tests for `pull --verify-signatures` with untrusted, bad and no
> signatures.  Previously the only test for `--verify-signatures` was to
> make sure that `pull --rebase --verify-signatures` result in a warning
> (t5520-pull.sh).

Nice!

Same thing regarding the `git checkout initial` commands counts
here too.

> 
> Signed-off-by: Hans Jerry Illikainen <hji@dyntopia.com>
> ---
>  t/t5573-pull-verify-signatures.sh | 78 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100755 t/t5573-pull-verify-signatures.sh
> 
> diff --git a/t/t5573-pull-verify-signatures.sh b/t/t5573-pull-verify-signatures.sh
> new file mode 100755
> index 000000000..700247910
> --- /dev/null
> +++ b/t/t5573-pull-verify-signatures.sh
> @@ -0,0 +1,78 @@
> +#!/bin/sh
> +
> +test_description='pull signature verification tests'
> +. ./test-lib.sh
> +. "$TEST_DIRECTORY/lib-gpg.sh"
> +
> +test_expect_success GPG 'create repositories with signed commits' '
> +	echo 1 >a && git add a &&
> +	test_tick && git commit -m initial &&
> +	git tag initial &&
> +
> +	git clone . signed &&
> +	(
> +		cd signed &&
> +		echo 2 >b && git add b &&
> +		test_tick && git commit -S -m "signed"
> +	) &&
> +
> +	git clone . unsigned &&
> +	(
> +		cd unsigned &&
> +		echo 3 >c && git add c &&
> +		test_tick && git commit -m "unsigned"
> +	) &&
> +
> +	git clone . bad &&
> +	(
> +		cd bad &&
> +		echo 4 >d && git add d &&
> +		test_tick && git commit -S -m "bad" &&
> +		git cat-file commit HEAD >raw &&
> +		sed -e "s/bad/forged bad/" raw >forged &&
> +		git hash-object -w -t commit forged >forged.commit &&
> +		git checkout $(cat forged.commit)
> +	) &&
> +
> +	git clone . untrusted &&
> +	(
> +		cd untrusted &&
> +		echo 5 >e && git add e &&
> +		test_tick && git commit -SB7227189 -m "untrusted"
> +	)
> +'
> +
> +test_expect_success GPG 'pull unsigned commit with --verify-signatures' '
> +	test_must_fail git pull --ff-only --verify-signatures unsigned 2>pullerror &&
> +	test_i18ngrep "does not have a GPG signature" pullerror
> +'
> +
> +test_expect_success GPG 'pull commit with bad signature with --verify-signatures' '
> +	test_must_fail git pull --ff-only --verify-signatures bad 2>pullerror &&
> +	test_i18ngrep "has a bad GPG signature" pullerror
> +'
> +
> +test_expect_success GPG 'pull commit with untrusted signature with --verify-signatures' '
> +	test_must_fail git pull --ff-only --verify-signatures untrusted 2>pullerror &&
> +	test_i18ngrep "has an untrusted GPG signature" pullerror
> +'
> +
> +test_expect_success GPG 'pull signed commit with --verify-signatures' '
> +	git pull --verify-signatures signed >pulloutput &&
> +	test_i18ngrep "has a good GPG signature" pulloutput &&
> +	git checkout initial
> +'
> +
> +test_expect_success GPG 'pull commit with bad signature without verification' '
> +	git pull --ff-only bad 2>pullerror &&
> +	git checkout initial
> +'
> +
> +test_expect_success GPG 'pull commit with bad signature with --no-verify-signatures' '
> +	test_config merge.verifySignatures true &&
> +	test_config pull.verifySignatures true &&
> +	git pull --ff-only --no-verify-signatures bad 2>pullerror &&
> +	git checkout initial
> +'
> +
> +test_done
> -- 
> 2.11.0
> 
