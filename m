Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14D4C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 21:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245318AbiCBVo5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 16:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241447AbiCBVoz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 16:44:55 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590945643F
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 13:44:11 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0167A1817DB;
        Wed,  2 Mar 2022 16:44:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=AZ8kW6BAVzLj
        vxVMB3ANa74tstcHSN47c7FUXp9wE6A=; b=Io6TVhrkiFYgyp0sZXRn0Mw97sy6
        DMaOIw0xcLYvqdVsx2B8uyV++K2s+dYIRPWgA25CKXG69JegGNrg30LpKQ1D7xa9
        tQAUd2Zz6CDL9bBM7AwIOTTKMfuqxev1GMtVzhXMNkbc8WxZ9L8RcMeW5lJpEYXw
        nR1KEpUNktFTm74=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EE7201817D9;
        Wed,  2 Mar 2022 16:44:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 749171817D8;
        Wed,  2 Mar 2022 16:44:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 07/10] fetch+push tests: have tests clean up their own mess
References: <cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com>
        <patch-07.10-7ce22dbe738-20220302T131859Z-avarab@gmail.com>
Date:   Wed, 02 Mar 2022 13:44:07 -0800
In-Reply-To: <patch-07.10-7ce22dbe738-20220302T131859Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 2 Mar
 2022 14:22:26
        +0100")
Message-ID: <xmqqczj4hvx4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E3C3ECDA-9A71-11EC-A3DF-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the "t5516-fetch-push.sh" test code to make use of
> "test_when_finished" to remove data instead of having tests clean up
> leftover data from earlier tests, which may or may not be
> there (e.g. depending on the --run=3D* option).
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/t5516-fetch-push.sh | 50 +++++++++++++++++++++++++------------------
>  1 file changed, 29 insertions(+), 21 deletions(-)
>
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index e4bb7581568..fbe0a72b0b2 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -23,7 +23,8 @@ D=3D$(pwd)
> =20
>  mk_empty () {
>  	repo_name=3D"$1"
> -	rm -fr "$repo_name" &&
> +	test_when_finished "rm -rf \"$repo_name\"" &&

Any justification to swap between fr and rf?

> +	test_path_is_missing "$repo_name" &&

So, the idea is that the philosophy so far was that each test clears
whatever the mess the previous ones created and empties what it cares
to be empty with "rm -fr", but now in the new world order, each test
relies on test_when_finished to clear any and all effects it leaves
to the environment?

OK.  Since the clearing the "effects" is to remove the whole thing,
there is little room for such a plan to go wrong.

> @@ -191,32 +192,32 @@ grep_wrote () {
>  	grep 'write_pack_file/wrote.*"value":"'$1'"' $2
>  }
> =20
> -test_expect_success 'push with negotiation' '
> -	# Without negotiation

;-)

> +test_expect_success 'push without negotiation' '
>  	mk_empty testrepo &&
>  	git push testrepo $the_first_commit:refs/remotes/origin/first_commit =
&&
>  	test_commit -C testrepo unrelated_commit &&
>  	git -C testrepo config receive.hideRefs refs/remotes/origin/first_com=
mit &&
> -	echo now pushing without negotiation &&
> +	test_when_finished "rm event" &&
>  	GIT_TRACE2_EVENT=3D"$(pwd)/event" git -c protocol.version=3D2 push te=
strepo refs/heads/main:refs/remotes/origin/main &&
> -	grep_wrote 5 event && # 2 commits, 2 trees, 1 blob
> +	grep_wrote 5 event # 2 commits, 2 trees, 1 blob
> +'
> =20
> -	# Same commands, but with negotiation
> -	rm event &&

Good to split them into two.  Presumably the later part wasn't
relying on the leftover side effects created by the early part?

Thanks.  Looking good.
