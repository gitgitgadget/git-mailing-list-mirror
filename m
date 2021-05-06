Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44094C433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 21:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04C2760698
	for <git@archiver.kernel.org>; Thu,  6 May 2021 21:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhEFVVO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 17:21:14 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60446 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhEFVVN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 17:21:13 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3D79412B91B;
        Thu,  6 May 2021 17:20:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZMfvLXoDvppi8/7PuDDeJjsYlKhiH3FhDitpuW
        LqwVI=; b=BZZt68NCfcGp99jRiw7WzgXtNbwLGK1HctsHYMUWK+DCxmpTV016Qy
        CZ3kKdwBFTVVjl0U19bfI53+1U1o9ocV8B97mYlTodxCSpHWTjSKPm4i+DDiK+zW
        /aNa+lSN2L4BK3oJYaNmEFCnLz6U0wArnYgmtvfmr88qo/a9TVYKQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3673212B91A;
        Thu,  6 May 2021 17:20:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 58FE712B915;
        Thu,  6 May 2021 17:20:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] [GSOC] ref-filter: solve bugs caused by enumeration
References: <pull.949.git.1620228664666.gitgitgadget@gmail.com>
        <xmqqfsz01vc2.fsf@gitster.g>
        <CAOLTT8SmvRaohV+v2C9eFXyc8O+di5PfZJeWNinmm8X=Ckdveg@mail.gmail.com>
        <xmqqk0oczao3.fsf@gitster.g>
        <CAOLTT8S9TbRWGPeGKR9=cDnaw2RMukawV48dPEK1KL0X_87udA@mail.gmail.com>
        <xmqqtungxg4y.fsf@gitster.g>
        <CAOLTT8TQXAh9vu21d5rvaHe=+eqtFU8MCVhorfGmqYRohDThUg@mail.gmail.com>
Date:   Fri, 07 May 2021 06:20:09 +0900
In-Reply-To: <CAOLTT8TQXAh9vu21d5rvaHe=+eqtFU8MCVhorfGmqYRohDThUg@mail.gmail.com>
        (ZheNing Hu's message of "Thu, 6 May 2021 19:52:03 +0800")
Message-ID: <xmqq8s4ry2ye.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D7415978-AEB0-11EB-B80D-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> ... now I think something like this will be more secure. In the
> future, other people may be grateful for such a choice. :)
>
> @@ -1730,7 +1759,7 @@ static int populate_value(struct ref_array_item
> *ref, struct strbuf *err)
>                         else
>                                 v->s = xstrdup("");
>                         continue;
> -               } else if (starts_with(name, "push")) {
> +               } else if (starts_with(name, "push") &&
> atom->u.remote_ref.push) {

Hmph, I do no think that would be futureproof at all.  If a new atom
"pushe" gets added, it is not all that unlikely that it would add
its own member to the same union.  name here would be "pushe" and
starts with "push", and upon parsing "pushe", its own member in the
union, atom->u.X, would have been assigned to, but the code we see
here still accesses atom->u.remote_ref.*, so you still have the same
problem you started to solve, no?

The check we use in remote_ref_atom_parser() to see if the atom is
about pushing, i.e.

	if (!strcmp(atom->name, "push") || starts_with(atom->name, "push:"))

is unlikely to be invalidated in future changes, as this is very
much end-user facing and changing the condition will break existing
scripts, so that is what I was expecting you to use instead.



