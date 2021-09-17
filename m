Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2311C433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 16:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D481A60F6E
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 16:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243102AbhIQQ66 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 12:58:58 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55921 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244832AbhIQQ6z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 12:58:55 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 45BFA15FE71;
        Fri, 17 Sep 2021 12:57:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Y1Itafk8hvip
        C7omrcbJyGkaX9quwm3HXCvl+qnjnFo=; b=JMpv4uXGSSdDF2AJJXk5n+phS60Z
        OeOal8msEC6C2H/wol3H+lDZH2Ao0A11THenuQUQgBFK0ujP2Lm8EaYkAKC4Jo8B
        CrQJZUK4llFureRz/y+eMd+h9oHhp88HrRi4UnbEEJ6vK+1dn4on20beNUzt/Jw9
        KwOq0NFs/3N7t4Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3EEB315FE70;
        Fri, 17 Sep 2021 12:57:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A272615FE6F;
        Fri, 17 Sep 2021 12:57:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/5] wrapper.c: add x{un,}setenv(), and use xsetenv()
 in environment.c
References: <cover-v2-0.5-00000000000-20210916T182918Z-avarab@gmail.com>
        <patch-v2-1.5-49706b26642-20210916T182918Z-avarab@gmail.com>
Date:   Fri, 17 Sep 2021 09:57:29 -0700
In-Reply-To: <patch-v2-1.5-49706b26642-20210916T182918Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 16 Sep
 2021 20:30:32
        +0200")
Message-ID: <xmqq35q3i1hi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 58803208-17D8-11EC-8937-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> -	if (setenv(GIT_DIR_ENVIRONMENT, path, 1))
> -		die(_("could not set GIT_DIR to '%s'"), path);
> +	xsetenv(GIT_DIR_ENVIRONMENT, path, 1);
> ...
> +int xsetenv(const char *name, const char *value, int overwrite)
> +{
> +	if (!name)
> +		die("xsetenv() got a NULL name, setenv() would return EINVAL");
> +	if (setenv(name, value, overwrite))
> +		die_errno("setenv(%s, '%s', %d) failed", name, value, overwrite);
> +	return 0;
> +}
> +
> +int xunsetenv(const char *name)
> +{
> +	if (!name)
> +		die("xunsetenv() got a NULL name, xunsetenv() would return EINVAL");
> +	if (!unsetenv(name))
> +		die_errno("unsetenv(%s) failed", name);
> +	return 0;
> +}

None of the existing callers have the "NULL name gets shown a
special error".  If we would get EINVAL and die anyway, there is any
need to add such an extra check that is always performed, no?

As there seems no justification for it in the proposed log message,
I'd have to say this is another "I'd do so while we are at it even
though it has no reason to be there to support this topic" change.

With explanation, perhaps these addtions would make sense.  If you
wanted to protect the printf-like die_errno() from name=3D=3DNULL, the
cost of the check should be borne by the error codepath.

IOW,

    if (!unsetenv(name))
	die_errno(_("unsetenv(%s) failed"), name ? name : "<NULL given>");

or something along that line, perhaps?  That won't need extra
justification, as we are not adding a mysterious feature that gives
a NULL name any special error status.


