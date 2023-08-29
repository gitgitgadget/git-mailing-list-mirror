Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EDDC71153
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 17:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238046AbjH2RmU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 13:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238206AbjH2RmS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 13:42:18 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F22FD
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 10:42:12 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 720203603E;
        Tue, 29 Aug 2023 13:42:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Jxy9aUeA0Z1+O21qJjt/Ev44BzEaw5ivRVeq+k
        6pV8w=; b=s3JGuCFm+GTrpdQsTEHz+rKIQIBgsOyAzZXbM3Gj8SgGezg0sievet
        J90zHc98vwyp78RAS+nSyRl28XURvstDDD6lp7lGJpYKXyM3hwle6Vw8BlYrdNnj
        dkfhfT3bB3j/GvbLWqEOI2EAUkxQvgfWdmzw+8rza7KMg4+csMRA0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6B95E3603D;
        Tue, 29 Aug 2023 13:42:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D7BA03603C;
        Tue, 29 Aug 2023 13:42:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] builtin/pack-objects.c: support `--max-pack-size`
 with `--cruft`
References: <cover.1693262936.git.me@ttaylorr.com>
        <b6d945197faaef8243bddf78f672a340404e6ac4.1693262936.git.me@ttaylorr.com>
Date:   Tue, 29 Aug 2023 10:42:06 -0700
In-Reply-To: <b6d945197faaef8243bddf78f672a340404e6ac4.1693262936.git.me@ttaylorr.com>
        (Taylor Blau's message of "Mon, 28 Aug 2023 18:49:07 -0400")
Message-ID: <xmqqr0nld9u9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5FF34D0E-4693-11EE-BA06-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> When pack-objects learned the `--cruft` option back in b757353676
> (builtin/pack-objects.c: --cruft without expiration, 2022-05-20), we
> explicitly forbade `--cruft` with `--max-pack-size`.
>
> At the time, there was no specific rationale given in the patch for not
> supporting the `--max-pack-size` option with `--cruft`. (As best I can
> remember, it's because we were trying to push users towards only ever
> having a single cruft pack, but I cannot be sure).

I am reasonably sure it was the case but then I do not recall we
ever discussing how the second cruft pack gets consolidated into one
by combining it with the existing one.

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 868efe7e0f..a046994a43 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1190,8 +1190,7 @@ static void write_pack_file(void)
>  		unsigned char hash[GIT_MAX_RAWSZ];
>  		char *pack_tmp_name = NULL;
>  
> -		if (pack_to_stdout)
> -			f = hashfd_throughput(1, "<stdout>", progress_state);
> +		if (pack_to_stdout) f = hashfd_throughput(1, "<stdout>", progress_state);
>  		else
>  			f = create_tmp_packfile(&pack_tmp_name);

An unintended change, I am sure ;-)

It is very surprising that absolutely no real change is needed to
allow cruft packs to honor the settings, other than removing the
seemingly artificial inter-option-compatibility roadblocks (all
hunks for it omitted above as they were trivially obvious).  I am
sure the first hunk to fold an "if" statement onto a single line is
not what makes the feature to actually work ;-)

> diff --git a/t/t5329-pack-objects-cruft.sh b/t/t5329-pack-objects-cruft.sh
> index 45667d4999..fc5fedbe9b 100755
> --- a/t/t5329-pack-objects-cruft.sh
> +++ b/t/t5329-pack-objects-cruft.sh
> @@ -573,23 +573,54 @@ test_expect_success 'cruft repack with no reachable objects' '
>  	)
>  '
>  
> -test_expect_success 'cruft repack ignores --max-pack-size' '
> +write_blob () {
> +	test-tool genrandom "$@" >in &&
> +	git hash-object -w -t blob in
> +}
> +
> +find_pack () {
> +	for idx in $(ls $packdir/pack-*.idx)
> +	do
> +		git show-index <$idx >out &&
> +		if grep -q "$1" out
> +		then
> +			echo $idx
> +		fi || return 1
> +	done
> +}
> +
> +test_expect_success 'cruft repack with --max-pack-size' '
>  	git init max-pack-size &&
>  	(
>  		cd max-pack-size &&
>  		test_commit base &&
> +
>  		# two cruft objects which exceed the maximum pack size
> -		test-tool genrandom foo 1048576 | git hash-object --stdin -w &&
> -		test-tool genrandom bar 1048576 | git hash-object --stdin -w &&
> +		foo=$(write_blob foo 1048576) &&
> +		bar=$(write_blob bar 1048576) &&
> +		test-tool chmtime --get -1000 \
> +			"$objdir/$(test_oid_to_path $foo)" >foo.mtime &&
> +		test-tool chmtime --get -2000 \
> +			"$objdir/$(test_oid_to_path $bar)" >bar.mtime &&
>  		git repack --cruft --max-pack-size=1M &&
>  		find $packdir -name "*.mtimes" >cruft &&
> -		test_line_count = 1 cruft &&
> -		test-tool pack-mtimes "$(basename "$(cat cruft)")" >objects &&
> -		test_line_count = 2 objects
> +		test_line_count = 2 cruft &&
> +
> +		foo_mtimes="$(basename $(find_pack $foo) .idx).mtimes" &&
> +		bar_mtimes="$(basename $(find_pack $bar) .idx).mtimes" &&
> +		test-tool pack-mtimes $foo_mtimes >foo.actual &&
> +		test-tool pack-mtimes $bar_mtimes >bar.actual &&
> +
> +		echo "$foo $(cat foo.mtime)" >foo.expect &&
> +		echo "$bar $(cat bar.mtime)" >bar.expect &&
> +
> +		test_cmp foo.expect foo.actual &&
> +		test_cmp bar.expect bar.actual &&
> +		test "$foo_mtimes" != "$bar_mtimes"
>  	)
>  '
>  
> -test_expect_success 'cruft repack ignores pack.packSizeLimit' '
> +test_expect_success 'cruft repack with pack.packSizeLimit' '
>  	(
>  		cd max-pack-size &&
>  		# repack everything back together to remove the existing cruft
> @@ -599,9 +630,12 @@ test_expect_success 'cruft repack ignores pack.packSizeLimit' '
>  		# ensure the same post condition is met when --max-pack-size
>  		# would otherwise be inferred from the configuration
>  		find $packdir -name "*.mtimes" >cruft &&
> -		test_line_count = 1 cruft &&
> -		test-tool pack-mtimes "$(basename "$(cat cruft)")" >objects &&
> -		test_line_count = 2 objects
> +		test_line_count = 2 cruft &&
> +		for pack in $(cat cruft)
> +		do
> +			test-tool pack-mtimes "$(basename $pack)" >objects &&
> +			test_line_count = 1 objects || return 1
> +		done
>  	)
>  '
