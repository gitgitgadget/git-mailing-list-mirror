Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD54C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 21:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236509AbiCBV7y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 16:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235068AbiCBV7x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 16:59:53 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE06EC3373
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 13:59:09 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5272D17B372;
        Wed,  2 Mar 2022 16:59:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2xomM6qOdkPI
        z0mK60CIBpn73ELt6mWyOejTSxBTrh4=; b=Modj0LiZ93ZwXrzB2Abn1nnbpa1k
        vvN032k71LCNZESFJzLW7telSN0Yk2iqV+bWa1JCQZ1FEhtYXSp71nHWC5l0AB9Y
        Q19D4EBZIiQSYbvj4BWAEgmTlNQPYopbqsPp4u1MSX44sbg2a3vhguLyKlA2I+U8
        bX7JDIh87oVsD5Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4BAD517B371;
        Wed,  2 Mar 2022 16:59:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7DE5817B36C;
        Wed,  2 Mar 2022 16:59:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 08/10] test-lib-functions: add and use a "test_hook"
 wrapper
References: <cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com>
        <patch-08.10-d4102e9b929-20220302T131859Z-avarab@gmail.com>
Date:   Wed, 02 Mar 2022 13:59:04 -0800
In-Reply-To: <patch-08.10-d4102e9b929-20220302T131859Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 2 Mar
 2022 14:22:27
        +0100")
Message-ID: <xmqq1qzkhv87.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FA716654-9A73-11EC-8E4B-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> @@ -430,7 +430,7 @@ test_expect_success 'status succeeds with sparse in=
dex' '
> =20
>  		# This one modifies outside the sparse-checkout definition
>  		# and hence we expect to expand the sparse-index.
> -		write_script .git/hooks/fsmonitor-test <<-\EOF &&
> +		test_hook --clobber fsmonitor-test <<-\EOF &&
>  			printf "last_update_token\0"
>  			printf "dir1a/modified\0"
>  		EOF

These look almost trivial (the --setup part is somewhat trickier
than the rest), thanks to the use of write_script.

It would have been even cleaner if we jumped from "unindented
cat && chmod +x" directly to "use write_script" in one of the
earlier steps, which would have reduced the need for the last step
in the series.

> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 85385d2ede7..0bef5913100 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -551,6 +551,58 @@ write_script () {
>  	chmod +x "$1"
>  }
> =20
> +# Usage: test_hook [options] <hook-name> <<-\EOF
> +#
> +#   -C <dir>:
> +#	Run all git commands in directory <dir>
> +#   --setup
> +#	Setup a hook for subsequent tests, i.e. don't remove it in a
> +#	"test_when_finished"
> +#   --clobber
> +#	Overwrite an existing <hook-name>, if it exists. Implies
> +#	--setup (i.e. the "test_when_finished" is assumed to have been
> +#	set up already).

OK.

We aspire to make everybody use test_hook, so the fact that we have
to clobber means somebody else made the right choice to either use
or not use --setup to create it, and we do not have to (re)arrange
it to be removed later, hence it makes perfect sense for --clobber
to imply --setup.

Looking good.


> +test_hook () {
> +	setup=3D &&
> +	clobber=3D &&
> +	indir=3D &&
> +	while test $# !=3D 0
> +	do
> +		case "$1" in
> +		-C)
> +			indir=3D"$2" &&
> +			shift
> +			;;
> +		--setup)
> +			setup=3Dt
> +			;;
> +		--clobber)
> +			clobber=3Dt
> +			;;
> +		-*)
> +			BUG "invalid argument: $1"
> +			;;
> +		*)
> +			break
> +			;;
> +		esac &&
> +		shift
> +	done &&
> +
> +	git_dir=3D$(git -C "$indir" rev-parse --absolute-git-dir) &&
> +	hook_dir=3D"$git_dir/hooks" &&
> +	hook_file=3D"$hook_dir/$1" &&
> +	if test -z "$clobber"
> +	then
> +		test_path_is_missing "$hook_file"
> +	fi &&
> +	if test -z "$setup$clobber"
> +	then
> +		test_when_finished "rm \"$hook_file\""
> +	fi &&
> +	write_script "$hook_file"
> +}
> +
>  # Use test_set_prereq to tell that a particular prerequisite is availa=
ble.
>  # The prerequisite can later be checked for in two ways:
>  #
