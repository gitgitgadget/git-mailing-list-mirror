Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15F9C433FE
	for <git@archiver.kernel.org>; Thu, 12 May 2022 23:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359554AbiELXjX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 19:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359534AbiELXjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 19:39:16 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B52286FF9
        for <git@vger.kernel.org>; Thu, 12 May 2022 16:39:15 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B2AF11CC07;
        Thu, 12 May 2022 19:39:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=okDg8VhP5R2G
        d8mrFIgbs17g0XipEpVfctn7REPx0w8=; b=HDSCSdIATc1Mu5PUIAZ6Zco9qb6A
        V9oWuugGEwWtCtZzmQLSHKNj6dXt1JjQMu5qq4+V5lnAOdzwfNhxp94RIFw/qepF
        CZWpVE+xTKJbLKYIpxn5Q+qm4WLM1jveOq3151j0gBeTjXcFQNXkanQSpXMpIU0I
        bQ6TT6UYnYBCidw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 628B511CC06;
        Thu, 12 May 2022 19:39:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B8AD411CC04;
        Thu, 12 May 2022 19:39:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 4/4] object-file: fix a unpack_loose_header()
 regression in 3b6a8db3b03
References: <cover-0.4-00000000000-20220421T200733Z-avarab@gmail.com>
        <20220512223218.237544-1-gitster@pobox.com>
        <20220512223218.237544-5-gitster@pobox.com>
Importance: high
Date:   Thu, 12 May 2022 16:39:12 -0700
In-Reply-To: <20220512223218.237544-5-gitster@pobox.com> (Junio C. Hamano's
        message of "Thu, 12 May 2022 15:32:18 -0700")
Message-ID: <xmqqo802codb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BAF73786-D24C-11EC-8920-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> diff --git a/object-file.c b/object-file.c
> index 5ffbf3d4fd..b5d1d12b68 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -2623,8 +2623,12 @@ int read_loose_object(const char *path,
>  		goto out;
>  	}
> =20
> -	if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
> -				NULL) < 0) {
> +	switch (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
> +				    NULL)) {
> +	case ULHR_OK:
> +		break;
> +	case ULHR_BAD:
> +	case ULHR_TOO_LONG:
>  		error(_("unable to unpack header of %s"), path);
>  		goto out;
>  	}

Regarding this hunk, since we only care about a single "did we get
any error, or did we unpack OK" bit, I think this should be more
like

	if (unpack_loose_header(...) !=3D ULHR_OK) {
		error(_("unable to..."), path);
		goto out;
	}

It is true, as =C3=86var mentioned, that there is another place in the
same file that uses switch() in loose_object_info(), and it should
remain to be switch() on the returned enum because it wants to
behave differnetly depending on the kind of error it gets.  But that
is not a reason to make this part that only cares about a single
"did it fail?" into a switch and force future developers to add a
useless case arm.

I left it there as posted in the previous round because I was too
lazy ;-) and also it is something we can clean up with a follow up
patch outside the series.  As my today's focus has been to reduce
the number of topics waiting for a reroll, I'd rather leave things
that are not outright broken but needs clean up as they are for the
sake of expediency.

Thanks.
