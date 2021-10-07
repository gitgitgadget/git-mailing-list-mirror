Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05D0C433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 22:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF67161058
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 22:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbhJGW3o (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 18:29:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64226 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233845AbhJGW3o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 18:29:44 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 91CCAF3A95;
        Thu,  7 Oct 2021 18:27:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6RApcPXaWrkX
        d7RwfYDS7fpVDPWX16JFFrIi2cQf0ts=; b=NxXdLYCp9oBwT4iXUfWN7WDos3kG
        HRY4wYlQjzSEvA39hkRNggjgDsaWkB8zXbTIqTBwSE5EXuZEoWm7j661MvC6eOoq
        9iMjTUeFRyj14WPaDCEQU3wZNGyhKuTIkXp/8j6Y6nzhF2d9oPEuWAdOcJH5NoEM
        bQqaAJkvbVWnXtc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 89645F3A94;
        Thu,  7 Oct 2021 18:27:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F0BD7F3A93;
        Thu,  7 Oct 2021 18:27:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/3] unpack-trees: don't leak memory in
 verify_clean_subdirectory()
References: <cover-0.2-00000000000-20211006T093405Z-avarab@gmail.com>
        <cover-v2-0.3-00000000000-20211007T094019Z-avarab@gmail.com>
        <patch-v2-1.3-e5ef1be2aa9-20211007T094019Z-avarab@gmail.com>
Date:   Thu, 07 Oct 2021 15:27:47 -0700
In-Reply-To: <patch-v2-1.3-e5ef1be2aa9-20211007T094019Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 7 Oct
 2021 11:46:09
        +0200")
Message-ID: <xmqqzgrko4gs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CD675B92-27BD-11EC-9E59-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/unpack-trees.c b/unpack-trees.c
> index a7e1712d236..89ca95ce90b 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -2156,9 +2156,10 @@ static int verify_clean_subdirectory(const struc=
t cache_entry *ce,
>  	if (o->dir)
>  		d.exclude_per_dir =3D o->dir->exclude_per_dir;
>  	i =3D read_directory(&d, o->src_index, pathbuf, namelen+1, NULL);
> +	dir_clear(&d);
> +	free(pathbuf);
>  	if (i)
>  		return add_rejected_path(o, ERROR_NOT_UPTODATE_DIR, ce->name);
> -	free(pathbuf);
>  	return cnt;
>  }

Looks trivially correct.

