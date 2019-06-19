Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 249391F462
	for <e@80x24.org>; Wed, 19 Jun 2019 14:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfFSOke (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 10:40:34 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60352 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfFSOke (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 10:40:34 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6EE9480673;
        Wed, 19 Jun 2019 10:40:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=koTM8DAY4fnZ
        9Y5TlqSlsBCmTk4=; b=ER9vamL+XZ0tDa+bbTwiDTU52ro1H6MrWlTUAIJXNeyH
        hrjK9lB2EBWehqgxTOIKPRDNTLPra8SExzr9YjV0bCS1ShirTFxeUOdq7cnGoPTV
        N1AO28gJxs8fTLtxEYe9fAQVQoLGmFz3/h2lVZwppQx/ucl1Y3zcZ1oFetlhqaw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=AF+nxg
        CIm1mcHwdfMAnUzeVMcgh6uFEPXo0rMh7241uefgSdb3bUU2KX9IVXKYANF0cfDn
        TFB8RnFMq0GXDYpeOPACY/cQ46nw2icPqq3MSndn9QpQdWH4O8C0WUrcX/HIuW3Q
        3Th3iyY2qx+1sOGRTEeEx7PgHE/xLIjbQ03yM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 66DFA80672;
        Wed, 19 Jun 2019 10:40:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 90B818066D;
        Wed, 19 Jun 2019 10:40:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, davvid@gmail.com
Subject: Re: [PATCH] wrapper: avoid UB in macOS
References: <20190616184003.17236-1-carenas@gmail.com>
Date:   Wed, 19 Jun 2019 07:40:28 -0700
In-Reply-To: <20190616184003.17236-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Sun, 16 Jun 2019 11:40:03 -0700")
Message-ID: <xmqqk1dhr63n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2FCFED5E-92A0-11E9-A0D2-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> 0620b39b3b ("compat: add a mkstemps() compatibility function", 2009-05-=
31)
> included a function based on code from libiberty which would result in
> undefined behaviour in platforms where timeval's tv_usec is a 32-bit si=
gned
> type as shown by:
>
> wrapper.c:505:31: runtime error: left shift of 594546 by 16 places cann=
ot be represented in type '__darwin_suseconds_t' (aka 'int')

I had to scratch my head wondering what an UB was (spell it out as
"undefined behaviour" if that is what you wanted to say).

> interestingly the version of this code from gcc never had this bug and =
the
> code had a cast that would had prevented the issue (at least in 64-bit
> platforms) but was misapplied.
>
> change the cast to uint64_t so it also works in 32-bit platforms.

Yup, regardless of the platform, that's the "right" type to use,
certainly more correct than "size_t", as value is declared to be u64
in this function.

>  	gettimeofday(&tv, NULL);
> -	value =3D ((size_t)(tv.tv_usec << 16)) ^ tv.tv_sec ^ getpid();
> +	value =3D ((uint64_t)tv.tv_usec << 16) ^ tv.tv_sec ^ getpid();
>  	filename_template =3D &pattern[len - 6 - suffix_len];
>  	for (count =3D 0; count < TMP_MAX; ++count) {
>  		uint64_t v =3D value;

Thanks.

