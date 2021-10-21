Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A775C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 05:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B1D960FE8
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 05:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhJUFwt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 01:52:49 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61015 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhJUFws (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 01:52:48 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C4A7915D6CA;
        Thu, 21 Oct 2021 01:50:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/jU5AywWr4sc
        acbNH0JCMwxhuoCGXT+KnbACRNPix54=; b=Nha/5PptWIWa3Kx1htw6G9TM7wMn
        ZJibb+PTzCgfeEFNICOdjmycdnX4e3w483mJ8sTm5TeEk43Deeeo/fNP2rblJbR3
        aFpTMd0RKYCc9rbLEeN7W41IirJRzmVuoTGCVDCp7AF2aSvcuhaceBAzxBB5gzd9
        OnklXBdpuyn6iWk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BD29015D6C9;
        Thu, 21 Oct 2021 01:50:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 295FB15D6C8;
        Thu, 21 Oct 2021 01:50:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, dstolee@microsoft.com,
        peff@peff.net
Subject: Re: [PATCH 01/11] midx.c: clean up chunkfile after reading the MIDX
References: <cover.1634787555.git.me@ttaylorr.com>
        <30f6f23daf49814f479865eea5f9ee68de209d5f.1634787555.git.me@ttaylorr.com>
Date:   Wed, 20 Oct 2021 22:50:29 -0700
In-Reply-To: <30f6f23daf49814f479865eea5f9ee68de209d5f.1634787555.git.me@ttaylorr.com>
        (Taylor Blau's message of "Wed, 20 Oct 2021 23:39:47 -0400")
Message-ID: <xmqqfssvncyi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CC78612A-3232-11EC-92A6-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> The patch contents are from =C3=86var, but the message is mine. I hope =
that
> he doesn't mind me forging his sign-off here.
>
>  midx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/midx.c b/midx.c
> index 8433086ac1..36e4754767 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -179,12 +179,13 @@ struct multi_pack_index *load_multi_pack_index(co=
nst char *object_dir, int local
>  	trace2_data_intmax("midx", the_repository, "load/num_packs", m->num_p=
acks);
>  	trace2_data_intmax("midx", the_repository, "load/num_objects", m->num=
_objects);
>
> +	free_chunkfile(cf);
>  	return m;
>
>  cleanup_fail:
>  	free(m);
>  	free(midx_name);
> -	free(cf);
> +	free_chunkfile(cf);
>  	if (midx_map)
>  		munmap(midx_map, midx_size);
>  	if (0 <=3D fd)

The former is not something we can mechanically locate, but the
latter we should be able to.  And indeed this is the only instance
the following experiment finds.

	$ cat >contrib/coccinelle/chunkfile.cocci <<-\EOF
	@@
	identifier f !~ "^free_chunkfile$";
	struct chunkfile *cf;
	@@
	  f(...) {<...
	- free(cf)
	+ free_chunkfile(cf)
	  ...>}
	EOF
	$ make contrib/coccinelle/chunkfile.cocci.patch

Thanks.

