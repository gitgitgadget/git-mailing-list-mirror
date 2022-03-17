Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89822C433EF
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 21:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiCQVlj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 17:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiCQVlh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 17:41:37 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F691B2C4C
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 14:40:19 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9368B18420B;
        Thu, 17 Mar 2022 17:40:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Mu3QvqPIr0M5
        LKg9/q/GCPX7Ir5zPQnstyuR5TKxTDs=; b=wdpkzfGC8wbP7vmwT3M7CfI8AI1j
        QShiC1HXSuuCZmMRcNICPq+01erL3RFcZS220u4Hum2zENvMIQ4AKF789mgt2QCm
        7CBPAZ/Ahac+N1ZyP8FzjBTy3NvOgC1Cmr4E8aS9sTPAUeFrEnPV/6rmXnU6cPuv
        NRLoJpbOcO8J2uE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8B4BF18420A;
        Thu, 17 Mar 2022 17:40:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E2F05184207;
        Thu, 17 Mar 2022 17:40:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 00/13] tests: add and use a "test_hook" wrapper +
 hook fixes
References: <cover-v2-00.10-00000000000-20220307T123909Z-avarab@gmail.com>
        <cover-v3-00.13-00000000000-20220317T100820Z-avarab@gmail.com>
        <xmqqpmmkh77b.fsf@gitster.g>
        <220317.86k0cscmqp.gmgdl@evledraar.gmail.com>
Date:   Thu, 17 Mar 2022 14:40:15 -0700
In-Reply-To: <220317.86k0cscmqp.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 17 Mar 2022 22:04:39 +0100")
Message-ID: <xmqqzglocl6o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D5F33028-A63A-11EC-AB9A-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Pending a re-roll this fix-up for 11/13 should fix it.
>
> I do test with /bin/bash before submitting to catch exactly this class
> of issue, but for reasons I haven't looked into this one is odd in not
> failing with --verbose-log, but I see the OSX CI (which I didn't wait
> for) fails on the same issue. Sorry.

Hmph, my integration run failed right away.  I use bash and dash on
alternate days, and you got lucky today ;-)

> diff --git a/t/t5543-atomic-push.sh b/t/t5543-atomic-push.sh
> index 90676365471..70431122a40 100755
> --- a/t/t5543-atomic-push.sh
> +++ b/t/t5543-atomic-push.sh
> @@ -162,13 +162,10 @@ test_expect_success 'atomic push obeys update hoo=
k preventing a branch to be pus
>  		test_commit two &&
>  		git push --mirror up
>  	) &&
> -	(
> -		cd upstream &&
> -		test_hook update <<-\EOF
> -			# only allow update to main from now on
> -			test "$1" =3D "refs/heads/main"
> -		EOF
> -	) &&
> +	test_hook -C upstream update <<-\EOF &&
> +	# only allow update to main from now on
> +	test "$1" =3D "refs/heads/main"
> +	EOF

OK.

>  	(
>  		cd workbench &&
>  		git checkout main &&
