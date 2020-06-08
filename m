Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3793C433E0
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 22:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 845DF206D5
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 22:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UdzqxJEw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgFHWHB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 18:07:01 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58157 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgFHWHB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 18:07:01 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E3DB8CC1F9;
        Mon,  8 Jun 2020 18:06:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TXo536u1/q5xlhUSXtyAg64mbQA=; b=UdzqxJ
        EwWOsUwQOauFR06kHvHSu//ykSVmb3NcimwL5ZPv1QYaMZ1VAVeQ0H5BrkmRYd+e
        AquZn/BvviXQr9/vWXD/VnbHmQ1z/Hn/vjHbwYMrs7q1m9Tcgwf49HvRjaBIK+uN
        g0mv2qeU47u4f18wqPnD6jB7MGnSFxz5n2q1I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Mp4MRk6KvIWslJEVWeRV5zrW2+Ano/uq
        EHjaufj9OjmlU+Cc5Q93eOIG/xxL7QuoRo8opabVZLZM00UtPLAHnt8YuP4qsJy0
        If4sdamhClh5mPziFch2xO/lSBIClRyOALeK6qpioFUzHvs9f5PQDnQUm7YT5cse
        12RfTiiLVvg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DC142CC1F8;
        Mon,  8 Jun 2020 18:06:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 27AA1CC1F7;
        Mon,  8 Jun 2020 18:06:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Jonathan =?utf-8?Q?M=C3=BCller?= <jonathanmueller.dev@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: Re: [PATCH 8/8] worktree: make "move" refuse to move atop missing registered worktree
References: <20200608062356.40264-1-sunshine@sunshineco.com>
        <20200608062356.40264-9-sunshine@sunshineco.com>
Date:   Mon, 08 Jun 2020 15:06:53 -0700
In-Reply-To: <20200608062356.40264-9-sunshine@sunshineco.com> (Eric Sunshine's
        message of "Mon, 8 Jun 2020 02:23:56 -0400")
Message-ID: <xmqqeeqpjjpe.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5D4DF54A-A9D4-11EA-9CE6-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> -	if (file_exists(dst.buf))
> -		die(_("target '%s' already exists"), dst.buf);
> +	check_candidate_path(dst.buf, force, worktrees, "move");

OK.  Moving to a location that is already occupied by an existing
file or a directory, even if that file or directory is not one of
the existing worktree, used to die here, but check_candidate_path()
performs that check and dies with almost the same message (it does
not say 'target'), so there is no loss of safety here.  The check
done in the check_candidate_path() helper is even better in that it
allows an existing directory as long as it is empty.

> diff --git a/t/t2403-worktree-move.sh b/t/t2403-worktree-move.sh
> index 939d18d728..7035c9d72e 100755
> --- a/t/t2403-worktree-move.sh
> +++ b/t/t2403-worktree-move.sh
> @@ -112,6 +112,27 @@ test_expect_success 'move locked worktree (force)' '
>  	git worktree move --force --force flump ploof
>  '
>  
> +test_expect_success 'refuse to move worktree atop existing path' '
> +	> bobble &&

Style?

> +	git worktree add --detach beeble &&
> +	test_must_fail git worktree move beeble bobble
> +'
> +
> +test_expect_success 'move atop existing but missing worktree' '
> +	git worktree add --detach gnoo &&
> +	git worktree add --detach pneu &&
> +	rm -fr pneu &&
> +	test_must_fail git worktree move gnoo pneu &&
> +	git worktree move --force gnoo pneu &&
> +
> +	git worktree add --detach nu &&
> +	git worktree lock nu &&
> +	rm -fr nu &&
> +	test_must_fail git worktree move pneu nu &&
> +	test_must_fail git worktree --force move pneu nu &&
> +	git worktree move --force --force pneu nu
> +'
> +
>  test_expect_success 'move a repo with uninitialized submodule' '
>  	git init withsub &&
>  	(

Thanks.
