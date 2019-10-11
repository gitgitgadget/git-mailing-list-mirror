Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A8EC1F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 06:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfJKGCl (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 02:02:41 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61302 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfJKGCl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 02:02:41 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 57DEE9A483;
        Fri, 11 Oct 2019 02:02:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+hHYBWatnRyHuVAp+Nzzmm5hDiI=; b=ezRAqq
        XH6l/F5maX0zKByg/Nuzk8IxG5W9Qa1ulfmMT/E403s393Gesl6cHNzM5+XV/Lj8
        nBmC5KDZXhtP+oewa8iNWitScKLGCnChncQflTE79wF5PTI9dwF4XiJYoG/xpHUk
        doE2E15zjM4LMsxkg8a/PYBHCRb2R7N4pC7iA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hqglwQyMzc0DaPn4NJPd0aV3Y2wO2p0d
        mBWwat7q571/FcLrv1V2cZHPh3+DRMn78dXKVa2jEE0uVHXtrRfBSImkB/2B34md
        nHUmUo9zMTMtwzVK4SP1o0qxmi3+2lGVbnYwnk+46cdLwdynqsnNuQ8aehxkL8od
        jgeyh6WVw7s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4FF8D9A482;
        Fri, 11 Oct 2019 02:02:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7F02B9A481;
        Fri, 11 Oct 2019 02:02:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakob Jarmar <jakob.j@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] stash: avoid recursive hard reset on submodules
References: <CA+xNDHtVc7pJr=SdihKDKiLE9TE_TcpEWWmPq+N9+fFcfM36wA@mail.gmail.com>
        <20191011001114.GB640501@OJAN-PAAVO.localdomain>
Date:   Fri, 11 Oct 2019 15:02:34 +0900
In-Reply-To: <20191011001114.GB640501@OJAN-PAAVO.localdomain> (Jakob Jarmar's
        message of "Fri, 11 Oct 2019 02:11:14 +0200")
Message-ID: <xmqqeezjhlad.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B94FFF92-EBEC-11E9-A52C-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakob Jarmar <jakob.j@gmail.com> writes:

> git stash push does not recursively stash submodules, but if
> submodule.recurse is set, it may recursively reset --hard them. Having
> only the destructive action recurse is likely to be surprising
> behaviour, and unlikely to be desirable, so the easiest fix should be to
> ensure that the call to git reset --hard never recurses into submodules.
>
> This matches the behavior of check_changes_tracked_files, which ignores
> submodules.

Makes sense.  Can we demonstrate an existing breakage and the fix in
a new test or two in perhaps t3906-stash-submodule.sh?

Thanks.

>
> Signed-off-by: Jakob Jarmar <jakob@jarmar.se>
> ---
>
> Sorry for sending a patch with messed up whitespace. This one should be
> correct.
>
>  builtin/stash.c     | 2 +-
>  git-legacy-stash.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/stash.c b/builtin/stash.c
> index b5a301f24d..c986c258f2 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -1383,7 +1383,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
>  			struct child_process cp = CHILD_PROCESS_INIT;
>  			cp.git_cmd = 1;
>  			argv_array_pushl(&cp.args, "reset", "--hard", "-q",
> -					 NULL);
> +					 "--no-recurse-submodules", NULL);
>  			if (run_command(&cp)) {
>  				ret = -1;
>  				goto done;
> diff --git a/git-legacy-stash.sh b/git-legacy-stash.sh
> index f60e9b3e87..07ad4a5459 100755
> --- a/git-legacy-stash.sh
> +++ b/git-legacy-stash.sh
> @@ -370,7 +370,7 @@ push_stash () {
>  			git diff-index -p --cached --binary HEAD -- "$@" |
>  			git apply --index -R
>  		else
> -			git reset --hard -q
> +			git reset --hard -q --no-recurse-submodules
>  		fi
>  
>  		if test "$keep_index" = "t" && test -n "$i_tree"
