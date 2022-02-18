Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E234C433F5
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 23:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240243AbiBRX54 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 18:57:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240256AbiBRX5z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 18:57:55 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4208AE55
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 15:57:37 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4220B184976;
        Fri, 18 Feb 2022 18:57:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=SNEXGw5JHzu7
        z2hHYpByskNf9J4RE0463ocGrPJZtmA=; b=cRBWfz3G5YKXaSga8T8NIWzpDL4z
        3J+jpWob5ffZvpdWWS7FYSxM+Zc7E52EgdYyM3CgVKnCKFnkst/M+F1fLg6b82GG
        YlhJsF7dPl2vTf4rLLxleO+2G0UNqBzh2f+Tl9WhJLVCp3ND96YU07RP/cW9NiKb
        sVxH99xnhI/bPRE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 29050184975;
        Fri, 18 Feb 2022 18:57:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8C178184974;
        Fri, 18 Feb 2022 18:57:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 1/2] merge: don't run post-hook logic on --no-verify
References: <cover-0.2-00000000000-20220218T203834Z-avarab@gmail.com>
        <patch-1.2-9b5144daee6-20220218T203834Z-avarab@gmail.com>
Date:   Fri, 18 Feb 2022 15:57:32 -0800
In-Reply-To: <patch-1.2-9b5144daee6-20220218T203834Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 18 Feb
 2022 21:43:51 +0100")
Message-ID: <xmqqa6enybgz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8A3854F8-9116-11EC-A1FD-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/builtin/merge.c b/builtin/merge.c
> index 133831d42fd..fab553e3bc4 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -845,15 +845,18 @@ static void prepare_to_commit(struct commit_list =
*remoteheads)
>  	struct strbuf msg =3D STRBUF_INIT;
>  	const char *index_file =3D get_index_file();
> =20
> -	if (!no_verify && run_commit_hook(0 < option_edit, index_file, "pre-m=
erge-commit", NULL))
> -		abort_commit(remoteheads, NULL);
> -	/*
> -	 * Re-read the index as pre-merge-commit hook could have updated it,
> -	 * and write it out as a tree.  We must do this before we invoke
> -	 * the editor and after we invoke run_status above.
> -	 */
> -	if (hook_exists("pre-merge-commit"))
> -		discard_cache();
> +	if (!no_verify) {
> +		if (run_commit_hook(0 < option_edit, index_file,
> +				    "pre-merge-commit", NULL))
> +			abort_commit(remoteheads, NULL);
> +		/*
> +		 * Re-read the index as pre-merge-commit hook could have updated it,
> +		 * and write it out as a tree.  We must do this before we invoke
> +		 * the editor and after we invoke run_status above.
> +		 */
> +		if (hook_exists("pre-merge-commit"))
> +			discard_cache();
> +	}

The updated code not just is more correct, but it is much easier to
follow.

I wonder if run_commit_hook() can return "I failed to run the hook",
"I ran the hook and the hook failed", "I successfully run the hook",
and "I didn't find the hook", instead of the current "yes/no".  That
would allow us to express this part in an even cleaner way, I would
think.

Looking good.

Thanks.

>  	read_cache_from(index_file);
>  	strbuf_addbuf(&msg, &merge_msg);
>  	if (squash)
