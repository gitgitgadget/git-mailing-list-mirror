Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73053C433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 22:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49FBE61074
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 22:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbhIPWMe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 18:12:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61887 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbhIPWMe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 18:12:34 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9528DD8D4B;
        Thu, 16 Sep 2021 18:11:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=hsZmj1Rod1vV
        dxrJQpsFMz2AOW3yZOUddJJIZNZdnyY=; b=wC+44BKvLm6QVxaYvbpEaW2vUr4c
        o7CynEshaXScanhtFZwtdwSY9HZ1i57DTclb7M7H4uZa9XRLD0xw6PwLqcAZ3W9A
        1vXK/7bzBPGpKhezZpXTpSOKweAhZ2/uoaqLVf0m/43OXNyU8+BUaokHMjOdjrcz
        gXcTa+dm8pMxq3U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8B7EFD8D4A;
        Thu, 16 Sep 2021 18:11:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 18A0CD8D49;
        Thu, 16 Sep 2021 18:11:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, sam@vilain.net, avarab@gmail.com
Subject: Re: [PATCH 2/3] git-cvsserver: protect against NULL in crypt(3)
References: <20210915080948.11891-1-carenas@gmail.com>
        <20210915080948.11891-3-carenas@gmail.com>
Date:   Thu, 16 Sep 2021 15:11:11 -0700
In-Reply-To: <20210915080948.11891-3-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 15 Sep 2021 01:09:47 -0700")
Message-ID: <xmqqczp8rx1c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0089AB08-173B-11EC-BE00-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> -                if (crypt(descramble($password), $1) eq $1) {
> -                    $auth_ok =3D 1;
> +                my $hash =3D crypt(descramble($password), $1);
> +                if (defined $hash) {
> +                    $auth_ok =3D 1 if $hash eq $1;
>                  }

It is not wrong per-se to separate the two checks into two separate
parts of the conditional, but because we check for definedness only
because comparison of it with $1 makes sense only when it is
defined, writing it either like this,=20

		if (defined $hash and $hash eq $1) {
			$auth_ok =3D 1;
		}

or even like this,

		$auth_ok =3D (defined $hash and $hash eq $1);

may be easier to read, no?
