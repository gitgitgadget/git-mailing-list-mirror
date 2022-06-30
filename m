Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D78C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 22:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiF3WUc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 18:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiF3WUb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 18:20:31 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8BAB16
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 15:20:30 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D46A613039C;
        Thu, 30 Jun 2022 18:20:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=sFKrSlmUmREr
        P5ErhNVCtdSQCxRoKxUJm/hVnLurip0=; b=UwO1XUpBRWqoa5G62wrfzllg99ND
        7zBGqOsoMPoxXWET/r3LgySt7Uk1XJSFYqWIqdin2ONxrKyQd9WX3umShlaZbqIi
        ni5gnTX9iR2fhkt9q6RTUWy1U7Q7S6aNw7lbvrEPWIkOr18ZRY7jFcw9EApYO8zZ
        he6gFt2xzgicBEg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CD19313039A;
        Thu, 30 Jun 2022 18:20:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 01F8E130399;
        Thu, 30 Jun 2022 18:20:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 08/11] checkout: add a missing
 clear_unpack_trees_porcelain()
References: <cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com>
        <patch-08.11-94e28aa7ab3-20220630T175714Z-avarab@gmail.com>
Date:   Thu, 30 Jun 2022 15:20:25 -0700
In-Reply-To: <patch-08.11-94e28aa7ab3-20220630T175714Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 30 Jun
 2022 20:00:18
        +0200")
Message-ID: <xmqq35fldc9i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D7D86D74-F8C2-11EC-9DEC-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> In 1c41d2805e4 (unpack_trees_options: free messages when done,
> 2018-05-21) we started calling clear_unpack_trees_porcelain() on this
> codepath, but missed this error path, let's also clear what we've
> allocated in that case.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  builtin/checkout.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 2eefda81d8c..3d6762106e8 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -750,6 +750,7 @@ static int merge_working_tree(const struct checkout=
_opts *opts,
>  		refresh_cache(REFRESH_QUIET);
> =20
>  		if (unmerged_cache()) {
> +			clear_unpack_trees_porcelain(&topts);
>  			error(_("you need to resolve your current index first"));
>  			return 1;
>  		}

Does refresh_cache(REFRESH_QUIET) depend on the porcelain error
messages already set?  If not another way to fix it may be to delay
the call to setup_unpack_trees_porcelain() until it becomes needed.

But the patch as posted is certainly an improvement.

Thanks.
