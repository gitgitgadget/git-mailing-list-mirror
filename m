Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02779C433EF
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 21:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbiGVVqu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 17:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiGVVqt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 17:46:49 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA5F7E00B
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 14:46:48 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6C5981B64D4;
        Fri, 22 Jul 2022 17:46:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=gWKYeR4o44LX
        KwST7EFdyfY9/Gjt0wt0Hb7603+qJqI=; b=ieim4MyqKnP1lXCJ7DIlrTP3piSy
        xfksHSnOBo8/oDdptq4EqtarVdq2g2PkJrAUw2kFkvPrZDWbXQNIux0fvkeJsVME
        iqTqBUXRPd8GpGSSS3PnDSN5gqhMKDjEksLBx9bZtr6hbgfdfobTJ7RF9d0k5jFo
        79APlrNKB5bqfvA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6491B1B64D3;
        Fri, 22 Jul 2022 17:46:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 06BBC1B64D2;
        Fri, 22 Jul 2022 17:46:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Joey Hess <id@joeyh.name>, git@vger.kernel.org,
        Tao Klerks <tao@klerks.biz>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH] read-cache: make `do_read_index()` always set up
 `istate->repo`
References: <xmqq35etc4vm.fsf@gitster.g>
        <20220722212232.833188-1-martin.agren@gmail.com>
Date:   Fri, 22 Jul 2022 14:46:42 -0700
In-Reply-To: <20220722212232.833188-1-martin.agren@gmail.com> ("Martin
        =?utf-8?Q?=C3=85gren=22's?= message of "Fri, 22 Jul 2022 23:22:32 +0200")
Message-ID: <xmqqtu78bz25.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C72472C4-0A07-11ED-8AF5-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> If there is no index file, e.g., because the repository has just been
> created, we return zero early (unless `must_exist` makes us die
> instead.)
>
> This early return means we do not set up `istate->repo`. With
> `core.untrackedCache=3Dtrue`, the recent e6a653554b ("untracked-cache:
> support '--untracked-files=3Dall' if configured", 2022-03-31) will
> eventually pass down `istate->repo` as a null pointer to
> `repo_config_get_string()`, causing a segmentation fault.
>
> If we do hit this early return, set up `istate->repo` similar to when w=
e
> actually read the index.
>
> Reported-by: Joey Hess <id@joeyh.name>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  read-cache.c                      | 5 ++++-
>  t/t7063-status-untracked-cache.sh | 6 ++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index 3e0e7d4183..68ed65035b 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2268,8 +2268,11 @@ int do_read_index(struct index_state *istate, co=
nst char *path, int must_exist)
>  	istate->timestamp.nsec =3D 0;
>  	fd =3D open(path, O_RDONLY);
>  	if (fd < 0) {
> -		if (!must_exist && errno =3D=3D ENOENT)
> +		if (!must_exist && errno =3D=3D ENOENT) {
> +			if (!istate->repo)
> +				istate->repo =3D the_repository;
>  			return 0;
> +		}

Makes sense.

>  		die_errno(_("%s: index file open failed"), path);
>  	}
> =20
> diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untrack=
ed-cache.sh
> index 9936cc329e..7dc5631f3d 100755
> --- a/t/t7063-status-untracked-cache.sh
> +++ b/t/t7063-status-untracked-cache.sh
> @@ -985,4 +985,10 @@ test_expect_success '"status" after file replaceme=
nt should be clean with UC=3Dfal
>  	status_is_clean
>  '
> =20
> +test_expect_success 'empty repo (no index) and core.untrackedCache' '
> +	git init emptyrepo &&
> +	cd emptyrepo/ &&
> +	git -c core.untrackedCache=3Dtrue write-tree
> +'

I'll tweak this with "-C emptyrepo" so that future developers do not
have to get bitten when they add more tests to this script.

THanks for a quick fix.  Very much appreciated.

>  test_done
