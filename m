Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553A1C41513
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 18:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbjHHSZF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 14:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235499AbjHHSYm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 14:24:42 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32622BC22
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 10:36:57 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 80BD41A19FF;
        Tue,  8 Aug 2023 13:36:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lT7LcPyJ5fQYKTGg+m58ffy6Rn/ezyE1EMQNRh
        uJ8QY=; b=a3YLHetju0y0f5lCi5s2T6h/fXBU4pcZ2UJts8SxbT1DjUcFT8aqdj
        AVGUxFN2Cf1zk9OzOeOskMtVJhL3jzROgutTAHwokPkoN/5ErBwamnEUniNGE5Yp
        hhfOObIVVNAmY0ilVCbEo7IWVdrt0PD5F97m/yE1mzZLYXarfLa+c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 773681A19FE;
        Tue,  8 Aug 2023 13:36:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D55B61A19FD;
        Tue,  8 Aug 2023 13:36:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Sebastian Thiel via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Sebastian Thiel <sebastian.thiel@icloud.com>
Subject: Re: [PATCH] fix `git mv existing-dir non-existing-dir`*
References: <pull.1561.git.1691506431114.gitgitgadget@gmail.com>
Date:   Tue, 08 Aug 2023 10:36:54 -0700
In-Reply-To: <pull.1561.git.1691506431114.gitgitgadget@gmail.com> (Sebastian
        Thiel via GitGitGadget's message of "Tue, 08 Aug 2023 14:53:50 +0000")
Message-ID: <xmqqy1il77wp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B4E59AE-3612-11EE-8E23-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Sebastian Thiel via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Sebastian Thiel <sebastian.thiel@icloud.com>
>
> *in some environments.

Please do not chop a single sentence in the middle and mark that
fact with an asterisk nobody understands what it means.

    Subject: [PATCH] mv: handle lstat() failure correctly

perhaps?

> When moving a directory onto another with `gix mv` various checks
> are performed. One of of these validates that the destination is
> not an existing file.
>
> When calling `lstat` on the destination path and it fails as the
> path doesn't exist, some environments seem to overwrite the passed
> in `stat` memory nonetheless.  (I observed this issue on debian 12
> of x86_64, running on OrbStack on ARM, emulated with Rosetta)

Very cleanly written, except "gix" -> "git".

POSIX does not seem to specify what should happen to buf when the
call fails, which I take to mean that its contents can become any
garbage at that point.

> diff --git a/builtin/mv.c b/builtin/mv.c
> index fa84fcb20d8..05e7156034e 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -184,7 +184,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  	int src_dir_nr = 0, src_dir_alloc = 0;
>  	struct strbuf a_src_dir = STRBUF_INIT;
>  	enum update_mode *modes, dst_mode = 0;
> -	struct stat st;
> +	struct stat st, dest_st;
>  	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
>  	struct lock_file lock_file = LOCK_INIT;
>  	struct cache_entry *ce;
> @@ -304,7 +304,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  			goto act_on_entry;
>  		}
>  		if (S_ISDIR(st.st_mode)
> -		    && lstat(dst, &st) == 0) {
> +		    && lstat(dst, &dest_st) == 0) {

This is good.  After this "if (S_ISDIR)" thing, there is another "if
(S_ISDIR)" on the same st.st_mode, so clobbering st like the
original was a stupid thing to do.

>  			bad = _("cannot move directory over file");

What is curious is that dest_st.st_mode, after lstat on dst
succeeds, is never checked, even though the error message claims
that it detected an attempt to move directory over file.  What
should happen when the user did this then?

    $ git mv existing-dir another-existing-dir

Shouldn't it do something similar to

    $ mv D1 D2

which is to move the entire hierarchy of D1 and make it appear at
D2/D1?

Even if the answer to the above question is "yes", that is a
separate bugfix, so let's not get distracted and see how our
test looks like.

>  			goto act_on_entry;
>  		}
> diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
> index 898a9205328..9894bc45ee6 100755
> --- a/t/t7001-mv.sh
> +++ b/t/t7001-mv.sh
> @@ -174,6 +174,12 @@ test_expect_success 'do not move directory over existing directory' '
>  	test_must_fail git mv path2 path0
>  '
>  
> +test_expect_success 'rename directory to non-existing directory' '
> +	mkdir dir-a && touch dir-a/f &&

One command per line, and reserve the use of "touch" to cases where
you care about the timestamps, not existence.  I.e.

	mkdir dir-a &&
	>dir-a/f &&

> +	git add dir-a &&
> +	git mv dir-a non-existing-dir
> +'

OK, there is no guarantee that this would fail on a system whose
lstat() may clobber buf when it notices that the path does not
exist, but it is a good test to have.

Thanks.
