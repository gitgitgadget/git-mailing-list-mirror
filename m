Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7770BC433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 05:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48F0263219
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 05:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235691AbhKPFmz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 00:42:55 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57565 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235579AbhKPFmL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 00:42:11 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 64C3B15B659;
        Tue, 16 Nov 2021 00:39:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=axPTnDdadQfdIuEVJpGRrt1Uk
        3ieqeqLKr2lihaFstw=; b=VkFd/XU/ITK3DLMIl2J/OHJZrR+k6YvLvThZ0SE03
        GF59p+cUw6i0dwNGTxBClOc2JqDHKoA2N9gmCme0Vpo3HVae9u5NatGgrnkKgWll
        k/QhRJSA8dO5gTS1Vfbe+mVt+B0HQTQ7rv6zLZWTeSFBz7dFAtkPp51S8M7VqPt/
        h8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5D3CD15B658;
        Tue, 16 Nov 2021 00:39:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BF55415B657;
        Tue, 16 Nov 2021 00:39:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anders Kaseorg <andersk@mit.edu>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Andreas Heiduk <andreas.heiduk@mathema.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v6 4/8] worktree: simplify find_shared_symref() memory
 ownership model
References: <20211113033358.2179376-1-andersk@mit.edu>
        <20211113033358.2179376-5-andersk@mit.edu>
Date:   Mon, 15 Nov 2021 21:39:08 -0800
Message-ID: <xmqq7dd8d5hf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 85ABACBC-469F-11EC-AFAB-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anders Kaseorg <andersk@mit.edu> writes:

> Storing the worktrees list in a static variable meant that
> find_shared_symref() had to rebuild the list on each call (which is
> inefficient when the call site is in a loop), and also that each call
> invalidated the pointer returned by the previous call (which is
> confusing).
>
> Instead, make it the caller=E2=80=99s responsibility to pass in the wor=
ktrees
> list and manage its lifetime.

Very nice.

> +	struct worktree **worktrees =3D get_worktrees();
> +	const struct worktree *worktree =3D
> +		is_bare_repository() ?
> +			NULL :
> +			find_shared_symref(worktrees, "HEAD", name);
> =20
>  	/* only refs/... are allowed */
>  	if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0))=
 {
>  		rp_error("refusing to create funny ref '%s' remotely", name);
> -		return "funny refname";
> +		ret =3D "funny refname";
> +		goto out;
>  	}

Nice touch to make the code clean after itself in a single place.
Good.

> ...
> +out:
> +	free_worktrees(worktrees);
> +	return ret;
>  }
