Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCB931F732
	for <e@80x24.org>; Wed, 31 Jul 2019 22:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfGaWeI (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 18:34:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60638 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfGaWeI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 18:34:08 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB5EF15BF94;
        Wed, 31 Jul 2019 18:34:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OC09QW9jcDKMqECH9QfOSOJ/BOE=; b=X8QIZq
        jbuiXRxqlHsQf6yUuE1FVDQjGjp6EIt2AO4g6zgRKQUKEARFw2YZq0Nli+Apqo0y
        B7ibda5Kb6BSH9dDg5Q3hEq2dpgU+ua3pBM4tgR8zDmg3D4C9nYH5uLaM51KS4OF
        RijP9sxhoWyBUWyKFnbUiEFFPcqBpMB1RJ5GQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=swbG4BlT7mOBW7oKPkxyKWM/glhba9cJ
        jCg166jfha2Gv0BWpvJXsGq3Al7NWBpaPNLgF0deAskTMsSC+kx2VGYdQzpTCVFt
        F7syohcMPYCNCEmWiienFM0yUieQ9jzfI0jvsa5148UtSjZyd7/KcIyVykm61mjT
        PdLG/yhNWGk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D1B5215BF93;
        Wed, 31 Jul 2019 18:34:05 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4238A15BF92;
        Wed, 31 Jul 2019 18:34:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Gregory Szorc <gregory.szorc@gmail.com>,
        Eric Wong <e@80x24.org>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] repack: simplify handling of auto-bitmaps and .keep files
References: <20190731053703.GA16709@sigill.intra.peff.net>
        <20190731054055.GC16941@sigill.intra.peff.net>
Date:   Wed, 31 Jul 2019 15:34:04 -0700
In-Reply-To: <20190731054055.GC16941@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 31 Jul 2019 01:40:56 -0400")
Message-ID: <xmqqzhktomub.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4DA1408A-B3E3-11E9-97D5-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Commit 7328482253 (repack: disable bitmaps-by-default if .keep files
> exist, 2019-06-29) taught repack to prefer disabling bitmaps to
> duplicating objects (unless bitmaps were asked for explicitly).
>
> But there's an easier way to do this: if we keep passing the
> --honor-pack-keep flag to pack-objects when auto-enabling bitmaps, then
> pack-objects already makes the same decision (it will disable bitmaps
> rather than duplicate). Better still, pack-objects can actually decide
> to do so based not just on the presence of a .keep file, but on whether
> that .keep file actually impacts the new pack we're making (so if we're
> racing with a push or fetch, for example, their temporary .keep file
> will not block us from generating bitmaps if they haven't yet updated
> their refs).
>
> And because repack uses the --write-bitmap-index-quiet flag, we don't
> have to worry about pack-objects generating confusing warnings when it
> does see a .keep file. We can confirm this by tweaking the .keep test to
> check repack's stderr.

This change is a bit too dense so I'll need to think about it a bit
longer, but in the meantime it is queued alongside the other two.

Thanks.

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/repack.c  | 17 ++---------------
>  t/t7700-repack.sh |  3 ++-
>  2 files changed, 4 insertions(+), 16 deletions(-)
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index db93ca3660..632c0c0a79 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -89,17 +89,6 @@ static void remove_pack_on_signal(int signo)
>  	raise(signo);
>  }
>  
> -static int has_pack_keep_file(void)
> -{
> -	struct packed_git *p;
> -
> -	for (p = get_all_packs(the_repository); p; p = p->next) {
> -		if (p->pack_keep)
> -			return 1;
> -	}
> -	return 0;
> -}
> -
>  /*
>   * Adds all packs hex strings to the fname list, which do not
>   * have a corresponding .keep file. These packs are not to
> @@ -346,13 +335,11 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  
>  	if (write_bitmaps < 0) {
>  		if (!(pack_everything & ALL_INTO_ONE) ||
> -		    !is_bare_repository() ||
> -		    keep_pack_list.nr != 0 ||
> -		    has_pack_keep_file())
> +		    !is_bare_repository())
>  			write_bitmaps = 0;
>  	}
>  	if (pack_kept_objects < 0)
> -		pack_kept_objects = !!write_bitmaps;
> +		pack_kept_objects = write_bitmaps > 0;
>  
>  	if (write_bitmaps && !(pack_everything & ALL_INTO_ONE))
>  		die(_(incremental_bitmap_conflict_error));
> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
> index 54f815b8b9..4e855bc21b 100755
> --- a/t/t7700-repack.sh
> +++ b/t/t7700-repack.sh
> @@ -245,7 +245,8 @@ test_expect_success 'no bitmaps created if .keep files present' '
>  	keep=${pack%.pack}.keep &&
>  	test_when_finished "rm -f \"\$keep\"" &&
>  	>"$keep" &&
> -	git -C bare.git repack -ad &&
> +	git -C bare.git repack -ad 2>stderr &&
> +	test_must_be_empty stderr &&
>  	find bare.git/objects/pack/ -type f -name "*.bitmap" >actual &&
>  	test_must_be_empty actual
>  '
