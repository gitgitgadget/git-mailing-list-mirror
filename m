Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721BCC47253
	for <git@archiver.kernel.org>; Fri,  1 May 2020 15:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C761208DB
	for <git@archiver.kernel.org>; Fri,  1 May 2020 15:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="D5HyPFpr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbgEAPcz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 11:32:55 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63846 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728886AbgEAPcz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 11:32:55 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 04BCCC2273;
        Fri,  1 May 2020 11:32:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iNhL5oery1GKyfMocOTufyQeMwU=; b=D5HyPF
        prvROG4kdLoIhHxsnPvy6w2QP/r7rZk6AIwVVW8MMXWxGmlvZG6m7MtEhX6CvGv4
        RqkJsGT7rTXLGt59a7XRWrI8N85SZ8E5qPPbKALxN1exPIwM7U+UTFKsr+Z8FMCc
        hlDsNTVTwYZNUhhKvC+xtth8PW99SxGozavmk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=D5I2MdZVO0QoA1itCkM1FTBSpihXmOg6
        knZ86x6G4jlQILi4tfjKT4L9GfNuVbhC1BRl12KQpiOIeTZr1DmnUoqjxKHDlM6u
        BbkmE+mMsmHaJ2gqMtyxvN5yAQXJ27XLOF+KvlE2hMFgUrWqOn83/yBb6D0smErM
        nCKUQD1QanM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EF758C2272;
        Fri,  1 May 2020 11:32:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2D20CC226F;
        Fri,  1 May 2020 11:32:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org,
        Harri =?utf-8?B?TWVodMOkbMOk?= <harri.mehtala@finago.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] restore: default to HEAD when combining --worktree and --staged
References: <20200501082746.23943-1-sunshine@sunshineco.com>
        <20200501082746.23943-3-sunshine@sunshineco.com>
Date:   Fri, 01 May 2020 08:32:44 -0700
In-Reply-To: <20200501082746.23943-3-sunshine@sunshineco.com> (Eric Sunshine's
        message of "Fri, 1 May 2020 04:27:46 -0400")
Message-ID: <xmqqimhfoelf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 01B7EC4E-8BC1-11EA-BA3D-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> The default restore source for --worktree is the index, and the default
> source for --staged is HEAD. However, when combining --worktree and
> --staged in the same invocation, git-restore requires the source to be
> specified explicitly via --source since it would otherwise be ambiguous
> ("should it restore from the index or from HEAD?"). This requirement
> makes it cumbersome to restore a file in both the worktree and the
> index.
>
> However, HEAD is also a reasonably intuitive default restore source when
> --worktree and --staged are combined. After all, if a user is asking to
> throw away all local changes to a file (on disk and in the index)
> without specifying a restore source explicitly -- and the user expects
> the file to be restored from _somewhere_ -- then it is likely that the
> user expects them to be restored from HEAD, which is an intuitive and
> logical place to find a recent unadulterated copy of the file.
>
> Therefore, make HEAD the default restore source when --worktree and
> --staged are combined.

The mention in the second paragraph that you are dealing with the
case where you are updating both the index and the working tree is
acceptable.  It explains why HEAD is a reasonable default in that
case.  But the third paragraph is totally redundant.  

I also found that these two paragraphs a bit too long, and by the
time I finished reading them I forgot that you mentioned that HEAD
is the default when --staged is given.  It ended up giving me "ok,
you made the default to HEAD when both are given; but what about the
case when only --staged is given?" reaction X-<.

    ... This requirement makes it cumbersome to restore a file in
    both the worktree and the index.

    As we are *not* going to restore the index and the working tree
    from two different sources, we need to pick a single default
    when both options are given, and the default used for restoring
    the index, HEAD, is a reasonable one in this case, too.  Another
    plausible source might be the index, but that does not make any
    sense to the user who explicitly gave the `--staged` option.

    So, make HEAD the default source when --staged is given, whether
    --worktree is used at the same time.

perhaps?

> +By default, the restore source for `--worktree` is the index, and the
> +restore source for `--staged` is `HEAD`. When combining `--worktree` and
> +`--staged`, the restore source is `HEAD`. `--source` can be used to specify
> +a different commit as the restore source.

Clear enough, but I wonder if we can simplify it even further.

    By default, if `--staged` is given, the contents are restored
    from `HEAD`.  Otherwise, the contents are restored from the
    index.

because `--worktree` is the default for the command when neither
`--staged` or `--worktree` is given.

> @@ -40,10 +40,10 @@ OPTIONS
>  	tree. It is common to specify the source tree by naming a
>  	commit, branch or tag associated with it.
>  +
> -If not specified, the default restore source for the working tree is
> -the index, and the default restore source for the index is
> +If not specified, the default restore source for `--worktree` is
> +the index, and the default restore source for `--staged` is

Likewise.

>  `HEAD`. When both `--staged` and `--worktree` are specified,
> -`--source` must also be specified.
> +the default restore source is `HEAD`.
>  
>  -p::
>  --patch::
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 7a01d00f53..500c3e23ff 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1604,14 +1604,11 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>  	}
>  	if (opts->checkout_index < 0 || opts->checkout_worktree < 0)
>  		BUG("these flags should be non-negative by now");
> -	if (opts->checkout_index > 0 && opts->checkout_worktree > 0 &&
> -	    !opts->from_treeish)
> -		die(_("--source required when using --worktree and --staged"));
>  	/*
> -	 * convenient shortcut: "git restore --staged" equals
> -	 * "git restore --staged --source HEAD"
> +	 * convenient shortcut: "git restore --staged [--worktree]" equals
> +	 * "git restore --staged [--worktree] --source HEAD"
>  	 */

Good.


> -	if (!opts->from_treeish && opts->checkout_index && !opts->checkout_worktree)
> +	if (!opts->from_treeish && opts->checkout_index)
>  		opts->from_treeish = "HEAD";

This succinctly tells the gist of this change.  

When source is not given, the default is HEAD when we are updating
the index, regardless of any other condition.

Good.

> diff --git a/t/t2070-restore.sh b/t/t2070-restore.sh
> index 19efa21fdb..89e5a142c9 100755
> --- a/t/t2070-restore.sh
> +++ b/t/t2070-restore.sh
> @@ -69,9 +69,15 @@ test_expect_success 'restore --staged uses HEAD as source' '
>  	test_cmp expected actual
>  '
>  
> -test_expect_success 'restore --worktree --staged requires --source' '
> -	test_must_fail git restore --worktree --staged first.t 2>err &&
> -	test_i18ngrep "source required when using --worktree and --staged" err
> +test_expect_success 'restore --worktree --staged uses HEAD as source' '
> +	test_when_finished git reset --hard &&
> +	git show HEAD:./first.t >expected &&
> +	echo dirty >>first.t &&
> +	git add first.t &&
> +	git restore --worktree --staged first.t &&
> +	git show :./first.t >actual &&
> +	test_cmp expected actual &&
> +	test_cmp expected first.t
>  '

Quite straight-forward and makes sense.
