Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 960151F461
	for <e@80x24.org>; Mon,  8 Jul 2019 21:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405098AbfGHVyq (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jul 2019 17:54:46 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64264 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732609AbfGHVyp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jul 2019 17:54:45 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CA2777DC69;
        Mon,  8 Jul 2019 17:54:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OMZ6wb76xHiY0B+C5AGmWNYqKuk=; b=D9+Qeb
        n1idkVJP4COlDuDVVq0OrLRasbjx/jXj1Nk7gsGgu46dX+8H63k6rKj2u4WqKjTr
        qg08LPk+IoRm8J2C2tMZ/33yeoABKC2prNZpihUJdpmO1Yo24cELkbTP7EmEFQdf
        8mKNkUz4pGxqoznBVdPCZIOm9IKw7GuIGDuUo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GbrNK5m8P4Budv/lrv4sVqgOl63vlvaj
        RO5a2TuFthvygPxSCbbsInkNqnD3u+Dv4ODgHn47Aui5KmeO+cmWyR2TodujxNLR
        yLR1T0XC4fitX5qkbAweWP98amJNqxa4xg2E98AFopDjd5809kwbYL7DJwpN3bKp
        NLCrevG14WI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C27BA7DC68;
        Mon,  8 Jul 2019 17:54:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 715B47DC64;
        Mon,  8 Jul 2019 17:54:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] diff: munmap() file contents before running external diff
References: <pull.213.git.gitgitgadget@gmail.com>
        <bef83fc20b9e2048872316e3f396da0cb6775086.1562231781.git.gitgitgadget@gmail.com>
Date:   Mon, 08 Jul 2019 14:54:35 -0700
In-Reply-To: <bef83fc20b9e2048872316e3f396da0cb6775086.1562231781.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 04 Jul 2019
        02:16:22 -0700 (PDT)")
Message-ID: <xmqq8st8xkdg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FACE4B8E-A1CA-11E9-AE22-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When running an external diff from, say, a diff tool, it is safe to
> assume that we want to write the files in question. On Windows, that
> means that there cannot be any other process holding an open handle to
> said files.

Please add "It is not enough to close the file descriptor; having a
region that is still mmapped keeps the file busy" or something like
that at the end.

> So let's make sure that `git diff` itself is not holding any open handle
> to the files in question.
>
> This fixes https://github.com/git-for-windows/git/issues/1315
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  diff.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/diff.c b/diff.c
> index 4d3cf83a27..0afb76bbca 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4206,6 +4206,10 @@ static void run_external_diff(const char *pgm,
>  	argv_array_pushf(&env, "GIT_DIFF_PATH_COUNTER=%d", ++o->diff_path_counter);
>  	argv_array_pushf(&env, "GIT_DIFF_PATH_TOTAL=%d", q->nr);
>  
> +	if (one && one->should_munmap)
> +		diff_free_filespec_data(one);
> +	if (two && two->should_munmap)
> +		diff_free_filespec_data(two);

I wondered if a single diff_filespec instance can be used in two
diff_filepair instances (e.g. file A is in-place modified and also
used to create file C), and if so after showing the diff for file A,
we have problems with showing file C.  But I do not think it should
pose a problem, as "free data after comparing a pair" is what we do
for the in-core codepath in builtin_diff().

We can lose the NULL-ness test for one and two if these "free the
resource once we no longer need it" is done inside "if (one && two)".
After all, once add_external_diff_name()[*1*] does its thing, we do
not need the data for these diff_filespec instances, right?

Also, just like builtin_diff() unconditionally frees the resources
held by diff_filespec instances, shouldn't this function do so, even
the ones that are not marked with should_munmap?


>  	if (run_command_v_opt_cd_env(argv.argv, RUN_USING_SHELL, NULL, env.argv))
>  		die(_("external diff died, stopping at %s"), name);
