Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAE8C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 22:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbiF3WDi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 18:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiF3WDh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 18:03:37 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2401C2495C
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 15:03:36 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B6A471A8D82;
        Thu, 30 Jun 2022 18:03:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pCz9b/HNaNRR
        vKDUL0yuE4US4wUDeMqlwj5bvTiz6NA=; b=vUU9MZH8YVp1G+i1HHgZ4PXMqLps
        4QGJEzodJWAbJf/WuDPn3hxa781jnuLfMd9U+neOQ86ESvKMgRdavOQxRV8wiAUu
        EBIAZS3REjCmZGU9vpgoodeuuEeZAjVIdGSDM640XA6t9W0IpYU9GBhlO4D+W0v7
        rcYptr0ZZnsJcQU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A7BF11A8D81;
        Thu, 30 Jun 2022 18:03:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 40DEA1A8D80;
        Thu, 30 Jun 2022 18:03:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 02/11] clone: fix memory leak in copy_ref() call
References: <cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com>
        <patch-02.11-8e424238071-20220630T175714Z-avarab@gmail.com>
Date:   Thu, 30 Jun 2022 15:03:31 -0700
In-Reply-To: <patch-02.11-8e424238071-20220630T175714Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 30 Jun
 2022 20:00:12
        +0200")
Message-ID: <xmqq7d4xdd1o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7B023AC8-F8C0-11EC-B465-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Fix a memory leak added in 0ec4b1650cc (clone: fix ref selection in
> --single-branch --branch=3Dxxx, 2012-06-22), we need to free_refs() the
> result of copy_ref().

remote_head could be the result of guess_remote_head(), instead of
copy_ref(), and in either case, once we are done with it, we need to
and can safely free it.

> diff --git a/builtin/clone.c b/builtin/clone.c
> index 89a91b00177..c43c85dad07 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -494,6 +494,7 @@ static struct ref *wanted_peer_refs(const struct re=
f *refs,
>  			/* if --branch=3Dtag, pull the requested tag explicitly */
>  			get_fetch_map(remote_head, tag_refspec, &tail, 0);
>  		}
> +		free_refs(remote_head);

Looks good.

>  	} else {
>  		int i;
>  		for (i =3D 0; i < refspec->nr; i++)
