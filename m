Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E64621F404
	for <e@80x24.org>; Mon, 22 Jan 2018 23:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751126AbeAVXJ6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 18:09:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52261 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeAVXJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 18:09:57 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7CFECD8609;
        Mon, 22 Jan 2018 18:09:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=LNkAu32PZzaH
        xekTSXpHYPbhwcg=; b=F0dMW3ofW8Q6PsoCJkPyJ64FefW4r0gnE/yzd42zOgWh
        ZlYT3/RpPebWds0Jur0Z9cMylW0x1c/5boOoDXlwcqDnaEGN01rV2l/v3HZbmhn7
        9JUc+qnK4I+SwuiKyMgjxAquLWMkurvE6t/sKffpPvkYF4RgI1Y7xnUR2x5EpQE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Ay7Rwg
        m/W/ZAwKj7JxrCXfxxWBB4y+7r6tiDnT5j7tZWmBtnhF7WI/Z/CS5eUJE/AKwKMh
        sBp1q7XuJqtQ6F8EoX3mE1KrONnbh6BEZoYpU8WQMoy4remX9Ft7Saq/utXKnp4n
        qwyaamxuxp/TDmX9WtQ3D3PC53rCE44IibZgU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6492ED8608;
        Mon, 22 Jan 2018 18:09:56 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C20C7D8607;
        Mon, 22 Jan 2018 18:09:55 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] read-cache: don't write index twice if we can't write shared index
References: <20180122110334.4411-1-pclouds@gmail.com>
        <20180122110334.4411-4-pclouds@gmail.com>
Date:   Mon, 22 Jan 2018 15:09:54 -0800
In-Reply-To: <20180122110334.4411-4-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Mon, 22 Jan 2018 18:03:34 +0700")
Message-ID: <xmqqfu6xjxrx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5C36D454-FFC9-11E7-8FE7-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
> index af9b847761..d2a8e0312a 100755
> --- a/t/t1700-split-index.sh
> +++ b/t/t1700-split-index.sh
> @@ -401,4 +401,23 @@ done <<\EOF
>  0642 -rw-r---w-
>  EOF
> =20
> +test_expect_success SANITY 'graceful handling when splitting index is =
not allowed' '

Is SANITY the only prereq we want, or do we want both it and POSIXPERM?

In "git grep SANITY t/" output, we see that they are almost always
used together.

> +	test_create_repo ro &&
> +	(
> +		cd ro &&
> +		test_commit initial &&
> +		git update-index --split-index &&
> +		test -f .git/sharedindex.*
> +	) &&
> +	cp ro/.git/index new-index &&
> +	test_when_finished "chmod u+w ro/.git" &&
> +	chmod u-w ro/.git &&
> +	GIT_INDEX_FILE=3D"$(pwd)/new-index" git -C ro update-index --split-in=
dex &&
> +	chmod u+w ro/.git &&
> +	rm ro/.git/sharedindex.* &&
> +	GIT_INDEX_FILE=3Dnew-index git ls-files >actual &&
> +	echo initial.t >expected &&
> +	test_cmp expected actual
> +'
> +
>  test_done
