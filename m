Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B7CC433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 04:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242179AbiCXEYo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 00:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242088AbiCXEYl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 00:24:41 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1356D1121
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 21:23:09 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2114412D819;
        Thu, 24 Mar 2022 00:23:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=++hEVuZ0kxAu
        dKkkBFVsU6U2XAjTfntLY4twKb2X2VE=; b=ae9fsWsZQPNp0mnWs8aKVRooSdW/
        yYfxZMP+nW1/omATds0jS14kgqjyugP6IUbhk+8+fVS37DYKGMfTVJA1Ry3FyVJP
        /GMD5b1Tcl9F+Utgt+PI8b8NhJyXeIk1HBg2ApXwyts9vl0WJJPYjwgj0+bzB2dn
        e9RRt3e0bqSDYRs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1440712D818;
        Thu, 24 Mar 2022 00:23:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 03A1312D816;
        Thu, 24 Mar 2022 00:23:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 02/27] blame: use "goto cleanup" for
 cleanup_scoreboard()
In-Reply-To: <patch-v2-02.27-77e7c2c321e-20220323T203149Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 23 Mar
 2022 21:31:52
        +0100")
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
        <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
        <patch-v2-02.27-77e7c2c321e-20220323T203149Z-avarab@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date:   Wed, 23 Mar 2022 21:23:05 -0700
Message-ID: <xmqqlex0m11y.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1AF0B1CA-AB2A-11EC-80AA-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Amend a freeing pattern added in 0906ac2b54b (blame: use changed-path
> Bloom filters, 2020-04-16) to use a "goto cleanup", so that we can be
> sure that we call cleanup_scoreboard().

Makes sense.

> This change is needed so that a subsequent addition of a
> release_revisions() doesn't solve this unrelated issue while it's at
> it.

Again, this is irrelevant.  This patch alone with or without
anything else is the right fix to plug the leakage of the
scoreboard.

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  builtin/blame.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 8d15b68afc9..885b381ab83 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -1167,7 +1167,7 @@ int cmd_blame(int argc, const char **argv, const =
char *prefix)
>  	if (!incremental)
>  		setup_pager();
>  	else
> -		return 0;
> +		goto cleanup;
> =20
>  	blame_sort_final(&sb);
> =20
> @@ -1201,6 +1201,7 @@ int cmd_blame(int argc, const char **argv, const =
char *prefix)
>  		printf("num commits: %d\n", sb.num_commits);
>  	}
> =20
> +cleanup:
>  	cleanup_scoreboard(&sb);
>  	return 0;
>  }
