Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1BAC433FE
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 23:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiCBXqm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 18:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiCBXq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 18:46:27 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6135577E
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 15:44:39 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D915B11E87F;
        Wed,  2 Mar 2022 18:06:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=CmuLiCjFi88r
        mCztjdiSaqAv41D7Mipp4nm93bp7ew8=; b=AoTt+1tU6fZWMDFLQFplD0n4/Hv0
        eOW1yKON4Sjv10qezNLzn6PbDrpda/uGn0KnTWhYd2wOq7nn8Ni2szbs6eN1hKzb
        PcGjL4DawkCSatSx3eTI821OTNEJ5iWggvP6yfgtHlX1Hn3Rp0+6kL317eM8QAeu
        4m92+dEaduyToJQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D06F611E87E;
        Wed,  2 Mar 2022 18:06:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0696211E87D;
        Wed,  2 Mar 2022 18:06:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 03/15] read-tree tests: check "diff-files" exit code on
 failure
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
        <patch-03.15-5f02e30d1ab-20220302T171755Z-avarab@gmail.com>
Date:   Wed, 02 Mar 2022 15:06:56 -0800
In-Reply-To: <patch-03.15-5f02e30d1ab-20220302T171755Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 2 Mar
 2022 18:27:12
        +0100")
Message-ID: <xmqqk0dcgdin.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 75D9A000-9A7D-11EC-8D00-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

>  check_cache_at () {
> -	clean_if_empty=3D$(git diff-files -- "$1")
> +	git diff-files -- "$1" >out &&
> +	clean_if_empty=3D$(cat out) &&
>  	case "$clean_if_empty" in
>  	'')  echo "$1: clean" ;;
>  	?*)  echo "$1: dirty" ;;
> -	esac
> +	esac &&

Good to see such an attention to the detail.

>  	case "$2,$clean_if_empty" in
>  	clean,)		:     ;;
>  	clean,?*)	false ;;
> diff --git a/t/t1002-read-tree-m-u-2way.sh b/t/t1002-read-tree-m-u-2way=
.sh
> index ca5c5510c73..46cbd5514a6 100755
> --- a/t/t1002-read-tree-m-u-2way.sh
> +++ b/t/t1002-read-tree-m-u-2way.sh
> @@ -9,7 +9,6 @@ This is identical to t1001, but uses -u to update the w=
ork tree as well.
> =20
>  '
> =20
> -TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/lib-read-tree.sh
> =20
> @@ -23,11 +22,12 @@ compare_change () {
>  }
> =20
>  check_cache_at () {
> -	clean_if_empty=3D$(git diff-files -- "$1")
> +	git diff-files -- "$1" >out &&
> +	clean_if_empty=3D$(cat out) &&
>  	case "$clean_if_empty" in
>  	'')  echo "$1: clean" ;;
>  	?*)  echo "$1: dirty" ;;
> -	esac
> +	esac &&
>  	case "$2,$clean_if_empty" in
>  	clean,)		:     ;;
>  	clean,?*)	false ;;
