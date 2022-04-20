Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACD2C433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 20:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382304AbiDTU6y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 16:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382315AbiDTU6v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 16:58:51 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D8141623
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:55:48 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 53EA4185AC7;
        Wed, 20 Apr 2022 16:55:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=SuSoo1KBaKZu
        yEVWHG7DLKlCau6Oi4w4jgPuU9CSGYM=; b=SFnQJ0vdAtDZml6Hk3xz1D69Lr8G
        pnWjCcvujMbQMRQ09NEV9ge2eaUyiT/Uyy0GGyjVXz3DDyd95+fnzamaOQLKaFnn
        Jk6n0hVZ69aGxK0ofEDHzq6jOcOtwAujYnvNMkafwrDnOzDQS/TrOytkvuu01yJX
        wL7CnLl2Fvyva80=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4C972185AC6;
        Wed, 20 Apr 2022 16:55:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B0879185AC5;
        Wed, 20 Apr 2022 16:55:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Kleber =?utf-8?Q?Tarc=C3=ADsio?= <klebertarcisio@yahoo.com.br>
Subject: Re: [PATCH] commit-graph: close file before returning NULL
References: <pull.1213.git.1650302007395.gitgitgadget@gmail.com>
Date:   Wed, 20 Apr 2022 13:55:43 -0700
In-Reply-To: <pull.1213.git.1650302007395.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Mon, 18 Apr 2022 17:13:27
        +0000")
Message-ID: <xmqq8rrzo4og.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3F3C505C-C0EC-11EC-A66A-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: =3D?UTF-8?q?Kleber=3D20Tarc=3DC3=3DADsio?=3D <klebertarcisio@yaho=
o.com.br>
>
> There are two reasons that we could return NULL early within
> load_commit_graph_chain():
>
>  1. The file does not exist, so the file pointer is NULL.
>  2. The file exists, but is too small to contain a single hash.
>
> These were grouped together when the function was first written in
> 5c84b3396 (commit-graph: load commit-graph chains, 2019-06-18) in order
> to simplify how the 'chain_name' string is freed. However, the current
> code leaves a narrow window where the file pointer is not closed when
> the file exists, but is rejected for being too small.
>
> Split out these cases separately to ensure we close the file in this
> case.
>
> Signed-off-by: Kleber Tarc=C3=ADsio <klebertarcisio@yahoo.com.br>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>     commit-graph: close file before returning NULL
>    =20
>     This change was originally submitted to the microsoft/git fork [1].
>     Kleber discovered this issue using some automated tool they are wor=
king
>     on. We recommended that this change be submitted to the core Git gr=
oup,
>     but we have not had any word from the original author in some time.
>     Hence, I am submitting it on their behalf.


Makes me wonder if it were a better world if fclose() behaved more
like free() ;-)

Will queue.  Thanks.

>  commit-graph.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 441b36016ba..06107beedcb 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -523,10 +523,13 @@ static struct commit_graph *load_commit_graph_cha=
in(struct repository *r,
>  	stat_res =3D stat(chain_name, &st);
>  	free(chain_name);
> =20
> -	if (!fp ||
> -	    stat_res ||
> -	    st.st_size <=3D the_hash_algo->hexsz)
> +	if (!fp)
>  		return NULL;
> +	if (stat_res ||
> +	    st.st_size <=3D the_hash_algo->hexsz) {
> +		fclose(fp);
> +		return NULL;
> +	}
> =20
>  	count =3D st.st_size / (the_hash_algo->hexsz + 1);
>  	CALLOC_ARRAY(oids, count);
>
> base-commit: ab1f2765f78e75ee51dface57e1071b3b7f42b09
