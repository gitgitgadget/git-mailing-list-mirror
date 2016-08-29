Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBC5B1FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 18:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754207AbcH2S1S (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 14:27:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54495 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753566AbcH2S1R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 14:27:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A00733A0D1;
        Mon, 29 Aug 2016 14:27:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=S/mvGypxtb8724Bi78tLuA7iaWk=; b=bY7wvm
        uBcm4wKB5NulV+HtErqaEFe4slO0+v9qiIsvfcGm/2JrYAKrhG2VOQtkztNBQbF6
        cX+L+AEEj5W0a0o+2F1H42/jF+dhU/XJRuBIwc7+KUul7pX5FMp//Lj+slJEDnFX
        0iLlq8Uz9ooDC+Tdb4KLqprgZAm7WDBSM4Huk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RSPwvr9BOES5SLRSV2j/noNNVAZcvupP
        jHRuOjsRNZ/uXBjbZB1Sr1TyAV/IUEfCmAe+AHa+MHKgE5jwQbaCuGlKI8AaWAcT
        elH3TMIYc/NBxqhATpN+q0j+vU5+/YGf0jmPHw83QuVY9ZDIC1IVvRD5GQ8mYCWO
        lcAPar0bhL0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9770A3A0D0;
        Mon, 29 Aug 2016 14:27:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0AAB03A0CE;
        Mon, 29 Aug 2016 14:27:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Simon Ruderich <simon@ruderich.org>, git@vger.kernel.org,
        Mike Hommey <mh@glandium.org>
Subject: Re: Crash when using git blame on untracked file
References: <20160827175336.bphgkb6zclvwfntk@ruderich.org>
        <20160827200150.GA18723@hank>
Date:   Mon, 29 Aug 2016 11:27:13 -0700
In-Reply-To: <20160827200150.GA18723@hank> (Thomas Gummerer's message of "Sat,
        27 Aug 2016 21:01:50 +0100")
Message-ID: <xmqqeg57bfcu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 35B25E98-6E16-11E6-ACC3-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Subject: [PATCH] blame: fix segfault on untracked files
>
> Since 3b75ee9 ("blame: allow to blame paths freshly added to the index",
> 2016-07-16) git blame also looks at the index to determine if there is a
> file that was freshly added to the index.
>
> cache_name_pos returns -pos - 1 in case there is no match is found, or
> if the name matches, but the entry has a stage other than 0.  As git
> blame should work for unmerged files, it uses strcmp to determine
> whether the name of the returned position matches, in which case the
> file exists, but is merely unmerged, or if the file actually doesn't
> exist in the index.
>
> If the repository is empty, or if the file would lexicographically be
> sorted as the last file in the repository, -cache_name_pos - 1 is
> outside of the length of the active_cache array, causing git blame to
> segfault.  Guard against that, and die() normally to restore the old
> behaviour.
>
> Reported-by: Simon Ruderich <simon@ruderich.org>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---

This is a recent regression and unfortunately is also in 2.9.3; the
patch looks obviously correct.

>  builtin/blame.c  | 3 ++-
>  t/t8002-blame.sh | 7 +++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 7ec7823..a5bbf91 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -2244,7 +2244,8 @@ static void verify_working_tree_path(struct commit *work_tree, const char *path)
>  	pos = cache_name_pos(path, strlen(path));
>  	if (pos >= 0)
>  		; /* path is in the index */
> -	else if (!strcmp(active_cache[-1 - pos]->name, path))
> +	else if (-1 - pos < active_nr &&
> +		 !strcmp(active_cache[-1 - pos]->name, path))
>  		; /* path is in the index, unmerged */
>  	else
>  		die("no such path '%s' in HEAD", path);
> diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
> index ff09ace..7983bb7 100755
> --- a/t/t8002-blame.sh
> +++ b/t/t8002-blame.sh
> @@ -6,6 +6,13 @@ test_description='git blame'
>  PROG='git blame -c'
>  . "$TEST_DIRECTORY"/annotate-tests.sh
>  
> +test_expect_success 'blame untracked file in empty repo' '
> +	touch untracked &&
> +	test_must_fail git blame untracked 2>actual.err &&
> +	echo "fatal: no such path '\''untracked'\'' in HEAD" >expected.err &&
> +	test_cmp expected.err actual.err
> +'

The point of this fix is not that we show the exact error message,
but we fail in a controlled manner.  I think

        test_expect_success 'blame untracked file in empty repo' '
                >untracked &&
                test_must_fail git blame untracked
        '

is sufficient.

Thanks.

>  PROG='git blame -c -e'
>  test_expect_success 'blame --show-email' '
>  	check_count \
