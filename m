Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD29C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 00:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65DEC24655
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 00:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DUt2qomD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfLQAOi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 19:14:38 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64699 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfLQAOi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 19:14:38 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5726A97F3D;
        Mon, 16 Dec 2019 19:14:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Qdb8Zz5ZBucezaq37Et6iUsi8E4=; b=DUt2qo
        mD0dh3zLCG1qq3Mppbcwgjrvw+7nfZm1pnZunEmA70mgGixE7H9F/B0WkXYvXXO2
        MJGxLdWomDU0e7Q2ZhFu5JwE4T/gwRsMFEQCKs1b4zLxF/f8TYTYPLvi4lBjsw4u
        14i2AEg60jocKpy17M7X8d/dftgF0Qz7Y0BLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bo/zz43K36OYSKGaoFa50hhaxzfysHWL
        HykVlxg5lJgNRHvrrOHyk/inN1qXwkFoQyn+v3+FrVkEY88r1FucvCSs+YrIYvOX
        2nPvL1iwNxTq+kXhOCyfk3XZIAT2SOETKPBGN9q8gsWN2Hi/yHXvqIiNsDQ/6mgF
        x4ZneW25J1o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4F5BC97F3C;
        Mon, 16 Dec 2019 19:14:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 799FF97F3A;
        Mon, 16 Dec 2019 19:14:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, blees@dcon.de,
        Kyle Meyer <kyle@kyleam.com>, Samuel Lijin <sxlijin@gmail.com>
Subject: Re: [PATCH v2 6/8] dir: fix checks on common prefix directory
References: <pull.676.git.git.1575924465.gitgitgadget@gmail.com>
        <pull.676.v2.git.git.1576008027.gitgitgadget@gmail.com>
        <9839aca00a10b16d96c47db631ac025281ffc864.1576008027.git.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.1912151126030.46@tvgsbejvaqbjf.bet>
        <CABPp-BE04=A9wx1VfWsghn6scy8aaVFoENxV6YiW2AxgM2jhjQ@mail.gmail.com>
        <CABPp-BGoC_D6LzzMNyf30wFssTU2WA1kTLmFvJ2Do+Tfg4+YQA@mail.gmail.com>
        <nycvar.QRO.7.76.6.1912170101230.46@tvgsbejvaqbjf.bet>
Date:   Mon, 16 Dec 2019 16:14:32 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1912170101230.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 17 Dec 2019 01:04:36 +0100 (CET)")
Message-ID: <xmqqr213iz9z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 34562230-2062-11EA-A60A-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> If you care to look at our very own `compat/win32/dirent.h`, you will see
> this:
>
> struct dirent {
>         unsigned char d_type; /* file type to prevent lstat after readdir */
>         char *d_name;         /* file name */
> };
>
> And looking at
> https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/dirent.h.html, I
> do not see any guarantee of that `[256]` at all:
>
> The <dirent.h> header shall [...] define the structure dirent which shall
> include the following members:
>
> [XSI][Option Start]
> ino_t  d_ino       File serial number.
> [Option End]
> char   d_name[]    Filename string of entry.
>
> You will notice that not even `d_type` is guaranteed.

I am reasonably sure that the code (without Elijah's patches anyway)
takes the possibility of missing d_type into account already.

Doesn't the above mean d_name[] has to be an in-place array of some
size (i.e. even a flex-array is OK)?  It does not look to me that it
allows for it to be a pointer pointing at elsewhere (possibly on
heap), which may be asking for trouble.
