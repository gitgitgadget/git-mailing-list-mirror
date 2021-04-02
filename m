Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08DDC433B4
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 21:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 592026115C
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 21:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbhDBVgw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 17:36:52 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51297 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhDBVgw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 17:36:52 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BC3F112FA66;
        Fri,  2 Apr 2021 17:36:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=s2ZDqa2djAPd
        5c1GUJE4hNjTrKg=; b=nNHOBTbSEWVB4abox6k+BwfBnsrD1uCMeXvBSs8111lH
        3LcW+yMBkX7XCaKX+J3sBQCY304oEyw8/sXwgYQXlNnD8b3I+LvHfET4c+1ssOkY
        VrRgo4mBPl1yoHvod5Pg3rEMfz4wmURxNn6ni0LdSiF2oq9aV0OlvbfrpQSqDik=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=jw0JWa
        h4Zxg2ghARCmaCEVraQRLb1rQs95ZcmGojvB0DfkjV0bKqgmnAh66EAe2LJqfP0C
        RO0k1Fy0I8uvMKBV0qPpdcdJs4fhulW8x7G6vZuF9deaWh7VpHubs4VNekpBNvoL
        hYO2NJafHTJ1JXe//C6uWdIJhO2cBOup1R/pw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B500A12FA65;
        Fri,  2 Apr 2021 17:36:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EB6BB12FA64;
        Fri,  2 Apr 2021 17:36:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 2/2] git-send-email: refactor duplicate $? checks into a
 function
References: <YGTt2cNwq3BlpB7n@google.com>
        <cover-0.3-00000000000-20210402T112946Z-avarab@gmail.com>
        <patch-2.3-f4bace5607c-20210402T112946Z-avarab@gmail.com>
Date:   Fri, 02 Apr 2021 14:36:46 -0700
In-Reply-To: <patch-2.3-f4bace5607c-20210402T112946Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 2 Apr
 2021 13:34:34 +0200")
Message-ID: <xmqqk0pk2wsx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 873B1420-93FB-11EB-BD81-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Refactor the duplicate checking of $? into a function. There's an
> outstanding series[1] wanting to add a third use of system() in this
> file, let's not copy this boilerplate anymore when that happens.
>
> 1. http://lore.kernel.org/git/87y2esg22j.fsf@evledraar.gmail.com
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  git-send-email.perl | 49 +++++++++++++++++++++++++++++----------------
>  1 file changed, 32 insertions(+), 17 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 6893c8e5808..901c935455d 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -212,22 +212,30 @@ sub format_2822_time {
>  my $multiedit;
>  my $editor;
> =20
> +sub system_or_msg {
> +	my ($args, $msg) =3D @_;
> +	system(@$args);
> +	return unless (($? & 127) || ($? >> 8));
> +
> +	die $msg if $msg;
> +	return sprintf(__("failed to run command %s, died with code %d"),
> +		       "@$args", $? >> 8);
> +}

That sounds more like system_and_die_or_msg to me.  More
importantly, the name of the helper makes it clear what difference
this has with ...

> +sub system_or_die {
> +	my $msg =3D system_or_msg(@_);
> +	die $msg if $msg;
> +}

... this one.  The former does nto die but returns message only when
X?  If that X were in its name, readers who look at the caller of
system_or_msg vs system_or_die would immediately know that why the
callsite is using one and not the other variant.
