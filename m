Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90130C433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 18:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237410AbiBPSEK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 13:04:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237402AbiBPSEK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 13:04:10 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DABA293B50
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 10:03:57 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3DE9517B92F;
        Wed, 16 Feb 2022 13:03:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JG+bpQ3xgHUk
        feg+tX9h49Cg1gPSoNeAeFKOZ2IbV3M=; b=kOYpHGpxHoR+4X2tCNaVe0iSokmR
        ODUouLtZQitsHDEN4ibcearh6As/iayQU3DyqjD5aMiGRZ2J66//jsMhgJxQy5Wj
        WEQhUnCrZQrDHC7upbwOd6rKRSg/0Km2r7k+utUKUEZyaAVkkuZF2FX/uPw3t6fc
        GagMO6lX8vJcXs4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3828617B92D;
        Wed, 16 Feb 2022 13:03:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 96F7D17B929;
        Wed, 16 Feb 2022 13:03:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] commit: use strbuf_release() instead of UNLEAK()
References: <cover-0.2-00000000000-20220216T081844Z-avarab@gmail.com>
        <patch-2.2-e3e78c9e40b-20220216T081844Z-avarab@gmail.com>
Date:   Wed, 16 Feb 2022 10:03:53 -0800
In-Reply-To: <patch-2.2-e3e78c9e40b-20220216T081844Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 16 Feb
 2022 09:21:06 +0100")
Message-ID: <xmqqa6equ1rq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CDE9780A-8F52-11EC-BE59-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Convert the UNLEAK() added in 0e5bba53af7 (add UNLEAK annotation for
> reducing leak false positives, 2017-09-08) to release the memory using
> strbuf_release() instead.
>
> The tests being marked as passing with
> "TEST_PASSES_SANITIZE_LEAK=3Dtrue" already passed before due to the
> UNLEAK(), but now they really don't leak memory, so let's mark them as
> such.

That smells like a brave move.

Specifically, the cited commit turned an existing strbuf_release()
on &err into UNLEAK().  If that and the other strbuf (sb) were so
easily releasable, why didn't we do so back then already?

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  builtin/commit.c                 | 4 ++--
>  t/t2203-add-intent.sh            | 1 +
>  t/t7011-skip-worktree-reading.sh | 1 +
>  3 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 696b3527adf..c38ae2b7656 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1866,7 +1866,7 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
> =20
>  cleanup:
>  	strbuf_release(&author_ident);
> -	UNLEAK(err);
> -	UNLEAK(sb);
> +	strbuf_release(&err);
> +	strbuf_release(&sb);
>  	return ret;
>  }
