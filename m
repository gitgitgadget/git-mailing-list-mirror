Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351D2C11D2F
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 17:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0239F2080D
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 17:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hyXfXaUT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbgBXRKK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:10:10 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64611 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbgBXRKK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 12:10:10 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1ECDD4681E;
        Mon, 24 Feb 2020 12:10:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=T8gr26D8cY58
        P5YJOkmVBk2QI7g=; b=hyXfXaUTB/7XYz4ytdnq8d8ygyWmX8UZ5pBmFBD/J5uF
        4tNjehpzvhUHu5ZEbPPChqraYhtLdOiEFUrs48pwoBzWQEwxBqA708O25XZegBuT
        tNRGD55VkP5ZQerfHrOHgGPl+0hK/OkKVfJNVj1oGj7sMzpM22cdx28yjMh2a3g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=sOLCso
        TybVyXggmPSi28iHZ1E/rxd934DP90TaPEsfaPI0BD/aLaZ4TTj/Txag2gb4H+xd
        A+L1ABztCDONvQ4hY6x5E+kMR58a0Q//9M53IQjk+nhnPZLbHyOlEFbzyZLOCDr0
        /6dk/Pas/3IDCj1fWGsKZiMFR+mHwMgzeBltk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E644A4681D;
        Mon, 24 Feb 2020 12:10:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B75FC4681C;
        Mon, 24 Feb 2020 12:10:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] use strpbrk(3) to search for characters from a given set
References: <4140dade-d999-a74a-1f8e-06eedb84ed20@web.de>
Date:   Mon, 24 Feb 2020 09:10:02 -0800
In-Reply-To: <4140dade-d999-a74a-1f8e-06eedb84ed20@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 22 Feb 2020 19:51:19 +0100")
Message-ID: <xmqqy2srrjx1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 80B1CDA8-5728-11EA-8623-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> We can check if certain characters are present in a string by calling
> strchr(3) on each of them, or we can pass them all to a single
> strpbrk(3) call.  The latter is shorter, less repetitive and slightly
> more efficient, so let's do that instead.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  builtin/show-branch.c              | 2 +-
>  compat/mingw.c                     | 2 +-
>  mailinfo.c                         | 3 +--
>  t/helper/test-windows-named-pipe.c | 2 +-
>  4 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/show-branch.c b/builtin/show-branch.c
> index 35d7f51c23..8c90cbb18f 100644
> --- a/builtin/show-branch.c
> +++ b/builtin/show-branch.c
> @@ -536,7 +536,7 @@ static void append_one_rev(const char *av)
>  		append_ref(av, &revkey, 0);
>  		return;
>  	}
> -	if (strchr(av, '*') || strchr(av, '?') || strchr(av, '[')) {
> +	if (strpbrk(av, "*?[")) {


The changes in the patch obviously look all correct.

I wonder how we can exploit Coccinelle to do this kind of
transformations, though.  Would it be possible to say

 * if we see "strchr(S, C1) || strchr(S, C2)", transform it to
   "strpbrk(S, concat(stringify(C1),stringify(C2)))"; and
 * if we see "strpbrk(S, N) || strchr(S, C)", transform it to
   "strpbrk(S, concat(N, stringify(C))";

and let the tool apply these two rules repeatedly, to catch the
pattern to find any number of needle character in the same haystack?
