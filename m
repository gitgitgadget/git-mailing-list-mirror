Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2CCC433B4
	for <git@archiver.kernel.org>; Mon, 10 May 2021 06:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 489F861104
	for <git@archiver.kernel.org>; Mon, 10 May 2021 06:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhEJGfY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 02:35:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59952 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhEJGfY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 02:35:24 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 82FAFB3604;
        Mon, 10 May 2021 02:34:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6oyhLS2yiRyI
        dfBYVGmKDRVH6sjUga7DGZqyQ31RzZ0=; b=W4+G0+2k5nBfWTg363HS7TO/SoKI
        4v9fs+ekafm4zKuATdeVR1yUfdGg0QTuywSiJ+TaH72iEKvWTNnLXTR8pqaF86+i
        nRAfDWEMCt8n+7Ff6VniSHcOG2BQ5Rd6BS2AuLBIS+iJFXsmWy44mFBm1fxkDnvr
        V4xrJ6yh1NDKL+E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 68A70B3603;
        Mon, 10 May 2021 02:34:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CE90EB3601;
        Mon, 10 May 2021 02:34:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] maintenance: fix two memory leaks
References: <20210509221613.474887-1-lenaic@lhuard.fr>
Date:   Mon, 10 May 2021 15:34:18 +0900
In-Reply-To: <20210509221613.474887-1-lenaic@lhuard.fr> (=?utf-8?B?Ikw=?=
 =?utf-8?B?w6luYcOvYw==?= Huard"'s
        message of "Mon, 10 May 2021 00:16:13 +0200")
Message-ID: <xmqqpmxzqeqd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BF89B414-B159-11EB-82C1-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

L=C3=A9na=C3=AFc Huard <lenaic@lhuard.fr> writes:

> Fixes two memory leaks when running `git maintenance start` or `git
> maintenance stop` in `update_background_schedule`:

Thanks, both places look correct, but I have one minor "hmph"
comment.

> diff --git a/builtin/gc.c b/builtin/gc.c
> index ef7226d7bc..2574068ae2 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1947,6 +1947,7 @@ static int crontab_update_schedule(int run_mainte=
nance, int fd, const char *cmd)
>  		fprintf(cron_in, "\n%s\n", END_LINE);
>  	}
> =20
> +	strbuf_release(&line);
>  	fflush(cron_in);
>  	fclose(cron_in);
>  	close(crontab_edit.in);

This is somewhat a curious placement---the loop that iterates over
the cron_list FILE with "while (!strbuf_getline_lf(&line, cron_list)"
is the only place the list strbuf is used, and I wonder if it makes
more sense to do this immediately after the loop.

> @@ -1999,6 +2000,7 @@ static int update_background_schedule(int enable)
>  		die("unknown background scheduler: %s", scheduler);
> =20
>  	rollback_lock_file(&lk);
> +	free(lock_path);
>  	free(testing);
>  	return result;
>  }

This one looks quite natural.
