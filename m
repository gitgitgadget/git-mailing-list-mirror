Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA25C433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 19:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiDVTFh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 15:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiDVTFf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 15:05:35 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F67186BD4
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 11:56:21 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B4F4217B309;
        Fri, 22 Apr 2022 14:56:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=FMr6yxTw+BR6
        DxisTKCh2D7RdXm72avjwtWbHUzmaz0=; b=k9CD8MgehI5eokN4CSNcD/Yn85Nv
        RvdoIQNJPuTlq7H+tPwItMfXxwvc3SGBkugEFT880cAmwrEgkQjg+iQpgGUacjTj
        k5hBH+kNBK4kwECDOFPbjFbCv4C7YzHjpvOi/U0JC35ZYT337uXOoo7Vbb+0lK4U
        Qq6wjT0W3JO1iaY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AD61E17B307;
        Fri, 22 Apr 2022 14:56:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2435C17B306;
        Fri, 22 Apr 2022 14:56:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git-packagers@googlegroups.com
Cc:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Carlo Arenas <carenas@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/5] core: update our SHA-1 docs, use
 sha1collisiondetection on OSX too
References: <cover-0.5-00000000000-20220422T094624Z-avarab@gmail.com>
Date:   Fri, 22 Apr 2022 11:56:14 -0700
In-Reply-To: <cover-0.5-00000000000-20220422T094624Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 22 Apr
 2022 11:53:11 +0200")
Message-ID: <xmqqv8v17xrl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E3425CF0-C26D-11EC-A0D8-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> I wasn't able to find any on-list references to it being intentional,
> but it appears that while we made the sha1collisiondetection variant
> of SHA-1 the default in early 2017 we've never updated the OSX builds
> to do likewise.
>
> I don't know what various git packages for OSX to, but our vanilla OSX
> distribution definitely uses Apple Common Crypto, and won't detect the
> https://shattered.io attack.
>
> This series changes that, and while doing so in 2/5 updates our
> documentation and Makefile interface for the SHA-1 selection. Our
> INSTALL file was still claiming we used OpenSSL's SHA-1 by default.
>
> Then since we'd made sha1collisiondetection the default we hadn't
> changed the code's default fallback to be that, it was still
> block-sha1. Now our fallback behavior is "error" instead, which makes
> it less likely that we'll get some foot-gun like the "OSX not using
> sha1collisiondetection" again.
>
> The 4/5 and 5/5 then remove the PPC_SHA1 implementation. I submitted
> this before as [1], and the range-diff is to that submission (it
> wasn't picked up). I think it makes sense as part of this general
> SHA-1 cleanup.

Thanks for this effort.

I'd like to see somebody with "building Git for distributing to
macOS" background to comment (I am assuming that the mailing list
git-packagers@googlegroups.com is the way to reach them).

