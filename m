Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 702011FF40
	for <e@80x24.org>; Mon,  5 Dec 2016 07:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751400AbcLEHUj (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 02:20:39 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54316 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750951AbcLEHUi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 02:20:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F085648C55;
        Mon,  5 Dec 2016 02:19:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vAQaJbeWeKCjGkuBMlBULvRZb3g=; b=DE7mWp
        xD8ZOYrqtX24fRWXu1eugFJxh3cEJewmnfFSf1PyEPr9TRCVAcmHifm1ckJ+ZPtw
        6iU95Wtdvb+Unbu+LkFgfefMAEGLLg2Y1ti4GOoAKhMzOe18MRRONr8DfcPQMod7
        kknbNrCybv9w7uUjWNvfAwxAldmR3czPvAqZs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oSZC22hXTQlrbo9HFkRlMhHKKQey316L
        0RF/4sPjvPwxsZD02W4sgv8DMQkCKv65/Vg2iU5A4sjvWmJygfYM/YsJvl8C53c9
        94MhuCrdvlvALF8EnfEI9ICkPzSyD6+t7qakx2C7BFS16Cof5qLqa3daLTJMvbCs
        229MKNt0duU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E832048C52;
        Mon,  5 Dec 2016 02:19:48 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 50C1B48C51;
        Mon,  5 Dec 2016 02:19:48 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jack Bates <bk874k@nottheoilrig.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jack Bates <jack@nottheoilrig.com>
Subject: Re: [PATCH] diff: fix up SHA-1 abbreviations outside of repository
References: <20161204194747.7100-1-jack@nottheoilrig.com>
Date:   Sun, 04 Dec 2016 23:19:46 -0800
In-Reply-To: <20161204194747.7100-1-jack@nottheoilrig.com> (Jack Bates's
        message of "Sun, 4 Dec 2016 12:47:47 -0700")
Message-ID: <xmqqr35m6dwt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 347AB628-BABB-11E6-B229-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jack Bates <bk874k@nottheoilrig.com> writes:

> The three cases where "git diff" operates outside of a repository are 1)
> when we run it outside of a repository, 2) when one of the files we're
> comparing is outside of the repository we're in, and 3) the --no-index
> option. Commit 4f03666 ("diff: handle sha1 abbreviations outside of
> repository", 2016-10-20) only worked in the first case.
> ---
>  builtin/diff.c                  |  4 +++-
>  t/t4063-diff-no-index-abbrev.sh | 50 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 53 insertions(+), 1 deletion(-)
>  create mode 100755 t/t4063-diff-no-index-abbrev.sh
>
> diff --git a/builtin/diff.c b/builtin/diff.c
> index 7f91f6d..ec7c432 100644
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -342,9 +342,11 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>  		       "--no-index" : "[--no-index]");
>  
>  	}
> -	if (no_index)
> +	if (no_index) {
>  		/* If this is a no-index diff, just run it and exit there. */
> +		startup_info->have_repository = 0;
>  		diff_no_index(&rev, argc, argv);
> +	}

This kind of change makes me nervous (partly because I am not seeing
the whole code but only this part of the patch).

Some code may react to "have_repository" being zero and do the right
thing (which I think is what you are using from your previous "we
did one of the three cases" change here), but the codepath that led
to "have_repository" being set to non-zero previously must have done
a lot more than just flipping that field to non-zero, and setting
zero to this field alone would not "undo" what it did.

I wonder if we're better off if we made sure that diff_no_index()
works the same way regardless of the value of "have_repository"
field?



