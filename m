Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E10C433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 06:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356498AbiFVGBK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 02:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiFVGBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 02:01:09 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD88366B4
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 23:01:08 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C2D4E1A34A8;
        Wed, 22 Jun 2022 02:01:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=AeSKazqdd7yo
        F+5sAcvPVz5X5+T2yIe+LDGsclcLA7Q=; b=N5VENiEpuDfWF0aYBFcKDWJjsLWJ
        CpgYtFP3VhUk6ofhuUaaDmamQjKCL1H+U9qvTCf6N1te10m8KnWCBOBVIeRIyMFr
        ydeza5MUYWUWkZlXotGaiduDTstGic98nbrczXwq3PVCJbLaegV1GjbDJ1Siqtxg
        0zgIRowNVJeu9pM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BAED51A34A7;
        Wed, 22 Jun 2022 02:01:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 60FC21A34A4;
        Wed, 22 Jun 2022 02:01:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        rsbecker@nexbridge.com,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 05/10] fetch tests: pass "mode" parameter first, pave
 way for "$@"
References: <xmqqa6a5g0m3.fsf@gitster.g>
        <cover-00.10-00000000000-20220621T222854Z-avarab@gmail.com>
        <patch-05.10-a3fb3174bde-20220621T222854Z-avarab@gmail.com>
Date:   Tue, 21 Jun 2022 23:01:02 -0700
In-Reply-To: <patch-05.10-a3fb3174bde-20220621T222854Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 22 Jun
 2022 00:34:17
        +0200")
Message-ID: <xmqqy1xp6xup.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B34AD6F0-F1F0-11EC-A3A2-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +	local cmdline=3D"$@" &&

Unless you are using the magic trait of "$@" that lets you pass each
positional parameter without getting split at internal $IFS, it is
less confusing to write "$*", which will make it obvious that a
later use of $cmdline will lose the distinction between
inter-parameter spaces and a whitespace that was embedded inside
an individual parameter.

> @@ -915,8 +930,8 @@ test_configured_prune_type () {
>  }
> =20
>  test_configured_prune () {
> -	test_configured_prune_type "$@" "name" &&
> -	test_configured_prune_type "$@" "link"
> +	test_configured_prune_type --mode name "$@" &&
> +	test_configured_prune_type --mode link "$@"
>  }
> =20
>  # $1 config: fetch.prune
> @@ -1007,11 +1022,19 @@ test_configured_prune unset unset unset true pr=
uned  kept \
>  # +refs/heads/*:refs/remotes/origin/* refspec and supplying it on the
>  # command-line negates --prune-tags, the branches will not be pruned.
>  test_configured_prune_type_branch () {
> -	test_configured_prune_type "$1" "$2" "$3" "$4" pruned "$6" "$7" "name=
"
> -	test_configured_prune_type "$1" "$2" "$3" "$4" kept   "$6" "$7" "link=
"
> +	local cfg_fp=3D"$1" &&
> +	local cfg_rnp=3D"$2" &&
> +	local cfg_fpt=3D"$3" &&
> +	local cfg_rnpt=3D"$4" &&
> +	local arg_branch=3D"$5" &&
> +	local arg_tag=3D"$6" &&
> +	shift 6 &&

Unless we plan to never allow new parameters to be added (or
existing one retired) from this helper, it would probably be easier
to maintain if you wrote

	local cfg_fp=3D"$1" && shift &&
	local cfg_rnp=3D"$1" && shift &&
	...

