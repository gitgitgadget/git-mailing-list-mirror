Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8090C4332D
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 19:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B1AE601FA
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 19:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241570AbhCATYe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 14:24:34 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54231 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbhCATWM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 14:22:12 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 04D4C123689;
        Mon,  1 Mar 2021 14:21:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=B34/d+d2Wrnl
        IJiNHl2pVQErEzg=; b=di+6vNdja1arhFe97rAk67kU4ZQVEFGRW3lrmvI15iMT
        APJGF7e6PD/agWehEaSdoF1lhPMLiI5HMJTssvnN34cDVG2mDWjS4oy89YqBrsAQ
        VibYYyNCZUn6/Y4JvidoFoUFAv44LgNEts2fz4oIgZMV/6dxV1EwQd8vzsHKbQs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=N8JrJy
        f1E9sutSO09pJY2ZFdChNZ+B7h23dIZ/AEICpYqBuNJOOGYaSKpDUVa0LFLi8brB
        kiKThlphPMHifl2CBEotR0QHIyRk62rp2Glu+K/vfDdqAW3NXA94NW+5JNh0+eof
        y1uJ5ZggIZGq5ktxxgYNBVp4ng+UPeuv89qRY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F28F5123688;
        Mon,  1 Mar 2021 14:21:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 40A75123687;
        Mon,  1 Mar 2021 14:21:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        Dan.Moseley@microsoft.com
Subject: Re: [PATCH v2 1/1] git mv foo FOO ; git mv foo bar gave an assert
References: <xmqq7doqwvzx.fsf@gitster.c.googlers.com>
        <20210301170536.12265-1-tboegi@web.de>
Date:   Mon, 01 Mar 2021 11:21:25 -0800
In-Reply-To: <20210301170536.12265-1-tboegi@web.de> (tboegi@web.de's message
        of "Mon, 1 Mar 2021 18:05:36 +0100")
Message-ID: <xmqqzgzmptmy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 51B29C70-7AC3-11EB-83BC-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> The following sequence, on a case-insensitive file system,
> (strictly speeking with core.ignorecase=3Dtrue)
> leads to an assertion, and leaves .git/index.lock behind.

"an assertion failure", I presume?

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
> This avoids the "assert".
>
> Reported-By: Dan Moseley <Dan.Moseley@microsoft.com>
>
> This fixes
> https://github.com/git-for-windows/git/issues/2920
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>

By breaking the list of trailers with an unrelated comment in the
middle, the "Reported-by" won't be recognized as a trailer.  We'd
want to credit non-authorship contribution in the release notes
starting in the upcoming release, and this will start mattering.
Please fix it.

> @@ -221,7 +221,7 @@ int cmd_mv(int argc, const char **argv, const char =
*prefix)
>  				}
>  				argc +=3D last - first;
>  			}
> -		} else if (!(ce =3D cache_file_exists(src, length, ignore_case))) {
> +		} else if (!(ce =3D cache_file_exists(src, length, 0))) {

Good finding.

Before the problematic patch, this used to be

               } else if (cache_name_pos(src, length) < 0)

I wonder if we should revert the change to use cache_file_exists()
in the first place (and rewrite the subsequent use of ce to match),
though.

Thanks.
