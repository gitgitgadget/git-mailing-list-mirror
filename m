Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED4AC43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 18:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D43D20674
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 18:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sa4UZW2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbfLPS37 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:29:59 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64127 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731085AbfLPSNR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 13:13:17 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9BBCE95445;
        Mon, 16 Dec 2019 13:13:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dZrrdyFPSgCv6lge6eS/85lY5oQ=; b=sa4UZW
        2squDkgBNbxr509oPcNrYHjl76xLUWW1bxS/MkCUDXA+yMtcX1XU1j6J/w4+6tmM
        ZxWQqz2CAK/F2z29LW4+Bw12WZ5kkHlOJ3zErdea1uv5mGa64iKjov2W3TCN6JEm
        CH/729r7TTZDswxkrdNFQMXK66EHXjsPEZPKA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CCx5P+dGRm4kNNiRE8IZlxEfeeHx6REi
        eJdZ4gOd5djcZfg8knF7LDL1cRU1pyI2+tqpJO3WF6wRMT9upWvoSgFX6tZgewKb
        UzsvRAoAf5F5FJorAl67sOziKFFHZuw+zZX62nhVqq3R5zDnIaics7QIS4FvJJ3y
        Sr934j7cPfA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 930BB95444;
        Mon, 16 Dec 2019 13:13:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B4A5A95443;
        Mon, 16 Dec 2019 13:13:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
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
Date:   Mon, 16 Dec 2019 10:13:10 -0800
In-Reply-To: <CABPp-BGoC_D6LzzMNyf30wFssTU2WA1kTLmFvJ2Do+Tfg4+YQA@mail.gmail.com>
        (Elijah Newren's message of "Mon, 16 Dec 2019 08:00:56 -0800")
Message-ID: <xmqqwoawjg09.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B9984424-202F-11EA-986E-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> > > +     memset(&cdir, 0, sizeof(cdir));
>> > > +     memset(&de, 0, sizeof(de));
>> > > +     cdir.de = &de;
>> > > +     de.d_type = DT_DIR;
>> >
>> > So here, `de` is zeroed out, and therefore `de.d_name` is `NULL`.
>>
>> Um, yeah...didn't I have an allocation of de.d_name here?  It will
>> always have a subset of path copied into it, so an allocation of len+1
>> is plenty long enough.
>
> Actually, it looks like I looked up the definition of dirent
> previously and forgot by the time you emailed.  On linux, from
> /usr/include/bits/dirent.h:
>
> struct dirent
>   {
>     ....
>     unsigned char d_type;
>     char d_name[256];           /* We must not include limits.h! */
>   };
>
> ...

Uh, oh.  The size of "struct dirent" is unspecified and it is asking
for trouble to allocate one yourself (iow, treat it pretty much as
something you can only get a pointer to an instance from readdir()).
For example, a dirent that comes back readdir() may have a lot
longer name than the sizeof(.d_name[]) above may imply.

Do you really need to manufacture a dirent yourself, or can you use
a more concrete type you invent yourself?
