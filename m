Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C2FC433DB
	for <git@archiver.kernel.org>; Tue,  2 Mar 2021 15:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 854DF64F2D
	for <git@archiver.kernel.org>; Tue,  2 Mar 2021 15:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378864AbhCBPSV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Mar 2021 10:18:21 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52514 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239445AbhCBAAo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 19:00:44 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3A07B125488;
        Mon,  1 Mar 2021 18:59:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5rWRO47+uaLz
        ydN9BPAnauLuPOw=; b=cwj87Kj/f9dTVHECDm0WdmKuxOqsZvOYI39bpODVn+M0
        TZgzMbdUJxqH+wymtLLzD8uJeaV/EuWd1PrjNIQ2vllSkXrhLKfUrnrnpjhXOjrx
        6OpfXm5CaEuCTBSum1JHD7T/PPEXTUI51qTYvyel4ICZMZwZhnUL7S91xoiHg/A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=i7AKmn
        TsrJkDhgRXNMnE9VqNKaQd0yd4ZYdVDunMSnYfBrKvVouo/CVas1GbmlMrHvEdx4
        yZ9HiMrkshr9SDfpTx9HENlKVlxk+HrELkPb0vJg5XOtjNss7Y/9NWiV158UveIu
        JDTB2kTnHZyQqQmaQ71RrwP4Eqfr5yLbWsDKA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 32A96125487;
        Mon,  1 Mar 2021 18:59:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 753F9125486;
        Mon,  1 Mar 2021 18:59:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        Dan.Moseley@microsoft.com
Subject: Re: [PATCH v3 1/1] git mv foo FOO ; git mv foo bar gave an assert
References: <xmqq7doqwvzx.fsf@gitster.c.googlers.com>
        <20210301214142.5557-1-tboegi@web.de>
Date:   Mon, 01 Mar 2021 15:59:54 -0800
In-Reply-To: <20210301214142.5557-1-tboegi@web.de> (tboegi@web.de's message of
        "Mon, 1 Mar 2021 22:41:42 +0100")
Message-ID: <xmqq8s76mnlx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 392A860A-7AEA-11EB-828B-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> The following sequence, on a case-insensitive file system,
> (strictly speeking with core.ignorecase=3Dtrue)
> leads to an assertion failure and leaves .git/index.lock behind.
>
> git init
> echo foo >foo
> git add foo
> git mv foo FOO
> git mv foo bar
>
> This regression was introduced in Commit 9b906af657,
> "git-mv: improve error message for conflicted file"
>
> The bugfix is to change the "file exist case-insensitive in the index"
> into the correct "file exist (case-sensitive) in the index".
>
> This avoids the "assert" later in the code and keeps setting up the
> "ce" pointer for ce_stage(ce) done in the next else if.
>
> This fixes
> https://github.com/git-for-windows/git/issues/2920
>
> Reported-By: Dan Moseley <Dan.Moseley@microsoft.com>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>

Thanks, that looks better.

> ---
> Changes since V2:
>   avoid the trailer mess-up by putting "this fixes" before the trailers
>   Make clearer why cache_name_pos() (leaving a dangling ce) followed
>   by an additional cache_file_exists() to set up ce can be optimized
>   into a single cache_file_exists()
>
> builtin/mv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/mv.c b/builtin/mv.c
> index 7dac714af9..3fccdcb645 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -221,7 +221,7 @@ int cmd_mv(int argc, const char **argv, const char =
*prefix)
>  				}
>  				argc +=3D last - first;
>  			}
> -		} else if (!(ce =3D cache_file_exists(src, length, ignore_case))) {
> +		} else if (!(ce =3D cache_file_exists(src, length, 0))) {
>  			bad =3D _("not under version control");
>  		} else if (ce_stage(ce)) {
>  			bad =3D _("conflicted");
> --
> 2.30.0.155.g66e871b664
