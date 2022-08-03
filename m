Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C58C19F28
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 17:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236686AbiHCRNk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 13:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236054AbiHCRNi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 13:13:38 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6604C613
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 10:13:37 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C0DB71B6B9F;
        Wed,  3 Aug 2022 13:13:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=mqVV/BYxLg0q
        7Y5RVCO5cLThuz4i5/h+0O7RHDb32Dk=; b=rSwc6QCK0irDGGZNz7O0Jge1hvDs
        E8BGrrZj7SUO9X64KFri8BXI9ahDHZPgbH7HGrNI9bRzXinNIPIlY6bKDkvICtKY
        fhJiUomWV0OVbxtJogavPCvOg/Pr8wPwqwQ384sZag/6fOoeQX04SGlYgGuhESGy
        aP9QvJtnIdbWigo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BA6F41B6B9E;
        Wed,  3 Aug 2022 13:13:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 605801B6B9D;
        Wed,  3 Aug 2022 13:13:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 1/6] bisect.c: add missing "goto" for
 release_revisions()
References: <cover-v2-0.6-00000000000-20220729T082919Z-avarab@gmail.com>
        <cover-v3-0.6-00000000000-20220802T152925Z-avarab@gmail.com>
        <patch-v3-1.6-12a4a20c59f-20220802T152925Z-avarab@gmail.com>
Date:   Wed, 03 Aug 2022 10:13:32 -0700
In-Reply-To: <patch-v3-1.6-12a4a20c59f-20220802T152925Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 2 Aug
 2022 17:33:11
        +0200")
Message-ID: <xmqqedxxb683.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9A84D12C-134F-11ED-B279-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Add a missing "goto cleanup", this fixes a bug in
> f196c1e908d (revisions API users: use release_revisions() needing
> REV_INFO_INIT, 2022-04-13).
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  bisect.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/bisect.c b/bisect.c
> index b63669cc9d7..421470bfa59 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -1054,7 +1054,7 @@ enum bisect_error bisect_next_all(struct reposito=
ry *r, const char *prefix)
>  		 */
>  		res =3D error_if_skipped_commits(tried, NULL);
>  		if (res < 0)
> -			return res;
> +			goto cleanup;
>  		printf(_("%s was both %s and %s\n"),
>  		       oid_to_hex(current_bad_oid),
>  		       term_good,

OK, from the cleanup: label we call release_revisions(&rev) which
was used in the "failed" attempt to find bisection.  Looks good.

