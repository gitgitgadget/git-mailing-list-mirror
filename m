Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9942FC4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 02:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7418E61042
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 02:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhHBCTJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Aug 2021 22:19:09 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54043 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhHBCTH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Aug 2021 22:19:07 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3CFA213840E;
        Sun,  1 Aug 2021 22:18:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=CUwP+0FRPZZw
        FTUThhhYnkcF9Lhh6bK0U/XoNicU7ew=; b=Uhiv/EBIZdIBzJB26EgcgmXLbj8X
        QHVCL8fVib+Ar0HBDpQu9XUyzc2yBCplM3CRH+UswXme9JHtYBwDbLDzaYfju0Vi
        lpqS/yjYB6ka06Gt2SAfKu4ThkkwrUslxt3dJYCkJCbOUOzjfzr+x9R/2lCwojIc
        wVqP8VfrDsYpeF8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3597513840D;
        Sun,  1 Aug 2021 22:18:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7C9A913840C;
        Sun,  1 Aug 2021 22:18:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] clone: Remove constraint on --bare and --origin
References: <20210801082546.18543-1-oystwa@gmail.com>
Date:   Sun, 01 Aug 2021 19:18:53 -0700
In-Reply-To: <20210801082546.18543-1-oystwa@gmail.com> (=?utf-8?Q?=22?=
 =?utf-8?Q?=C3=98ystein?= Walle"'s
        message of "Sun, 1 Aug 2021 10:25:46 +0200")
Message-ID: <xmqq4kc8zj02.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FCD0C784-F337-11EB-BF45-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=98ystein Walle <oystwa@gmail.com> writes:

> This test has been present since long before clone was ported to C. Now
> there is no need for it, and since df61c88979 (clone: also configure ur=
l
> for bare clones, 2010-03-29) it's especially useful to allow both
> options.
>
> Signed-off-by: =C3=98ystein Walle <oystwa@gmail.com>
> ---
>
> A question on this constraint popped up on #git the other day. I
> investigated a bit and found no particular reason for its existence. Al=
l
> tests still pass (except the one removed here) and the behavior is as
> expected. I realize it might have gone under the radar for 11 years but
> it's still worth the noise to remove it, in my opinion.
>
> I wanted to include a bit on the reasoning for the original check in th=
e
> commit message but I couldn't find it.=20

I suspect that this originally was because "git clone --bare" does
not use any remote-tracking branch (i.e. no refs/remotes/origin/*)
and the only expected way to update a "git clone --bare" repository
was to run "git fetch --mirror [--prune]", so there was no need to
make the nickname "origin" to be configurable.

I do not offhand know what other features in "git clone --bare" that
were added since then affect the resulting repository so that the
name "origin" it leaves there (perhaps in its configuration, if not
names in ref hierarchy) is visible to the end user and deserves to
be customizable.

In short, I think the "don't use --origin in a bare repository" was
not because "doing so will break X and Y", but because "doing so
does not make any practical difference".  So I am OK to lift this
check.  It is a small enough change that is easy to revert if there
were some valid reasons we failed to consider.

Thanks.
