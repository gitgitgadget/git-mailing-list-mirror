Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79965C43334
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 16:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240562AbiGTQd1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 12:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiGTQdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 12:33:25 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479824B4AD
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 09:33:24 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D4E921A3E8A;
        Wed, 20 Jul 2022 12:33:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GFciooQwfl8e
        9BR4lf2Nv5GF9G1ravAce+tt2PpeT64=; b=LyCImOwMDDLKo/hEhz2XzR0YRMkL
        A6o3xyozg7/OVKTUlnod5GJuE/sX9+VZBhwjAE3T3WRtJJCloWfIelzM9hXA28yI
        o18ygJBhfWomQFnccKam/5LGLSrvN7RIKKCtYlvnT3OCFVip3YPXlj+mEE6+jmJe
        vyGQSOUSfwp9xLQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CABAC1A3E89;
        Wed, 20 Jul 2022 12:33:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 75B171A3E88;
        Wed, 20 Jul 2022 12:33:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [PATCH v2 04/24] submodule--helper: fix most "struct pathspec"
 memory leaks
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
        <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
        <patch-v2-04.24-9fb60485c3e-20220719T204458Z-avarab@gmail.com>
Date:   Wed, 20 Jul 2022 09:33:19 -0700
In-Reply-To: <patch-v2-04.24-9fb60485c3e-20220719T204458Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 19 Jul
 2022 22:46:55
        +0200")
Message-ID: <xmqq1quf4ucw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AA879124-0849-11ED-A881-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> @@ -269,7 +269,7 @@ static char *get_up_path(const char *path)
>  static int module_list(int argc, const char **argv, const char *prefix=
)
>  {
>  	int i;
> -	struct pathspec pathspec;
> +	struct pathspec pathspec =3D { 0 };
>  	struct module_list list =3D MODULE_LIST_INIT;
> =20
>  	struct option module_list_options[] =3D {
> @@ -278,6 +278,7 @@ static int module_list(int argc, const char **argv,=
 const char *prefix)
>  			   N_("alternative anchor for relative paths")),
>  		OPT_END()
>  	};
> +	int ret;

Adding such a simple variable near the top, perhaps next to "int i",
would probably make it easier to read, especially because you employ
a good pattern below to let the compiler detect unintended use of
the variable uninitialized, i.e. "ret =3D 1; goto cleanup;" is placed
at each error-exit codepath, and "ret =3D 0;" is added immediately
before the "cleanup" label.  If somebody jumps to the cleanup label
without setting "ret", the compiler will catch it.

But you can do better by eliminating the need to check.  Initialize
"ret" to non-zero (i.e. "assume failure"), and have each error-exit
codepath just "goto cleanup".  Keep the "ret =3D 0;" this patch uses
immediately before the "cleanup" label.

> @@ -287,8 +288,10 @@ static int module_list(int argc, const char **argv=
, const char *prefix)
>  	argc =3D parse_options(argc, argv, prefix, module_list_options,
>  			     git_submodule_helper_usage, 0);
> =20
> -	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
> -		return 1;
> +	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0) {
> +		ret =3D 1;
> +		goto cleanup;
> +	}

Which will simplify this hunk.

The same exact pattern repeats throughout this patch, and the above
commits apply to all of the hunks, I think.

Thanks.
