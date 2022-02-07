Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC561C433EF
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 02:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244009AbiBGCLm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Feb 2022 21:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiBGCLm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Feb 2022 21:11:42 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D0FC061A73
        for <git@vger.kernel.org>; Sun,  6 Feb 2022 18:11:41 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 95DA4108A15;
        Sun,  6 Feb 2022 21:11:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=vMRu2idLHti4
        NnvOaUlclZNdxoNHpPINnQrNcFAEwC0=; b=OVD7yRr8V+g+zC9xR5kHAD78Ep/y
        TfBG4Q6iqNuGJLAJRywb1B4e8CzLQiP5Eo7K2Bf7KTH9zDr8h5xmfHmcN2WPRW2X
        Ah9s0iKtS4XEYXrnnx1NXz+qE1ThxmHVhJuKOU5uF0uutcacd67v2QPTuX1C4QxA
        wavSxjBWGSsSG3Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7E0B5108A13;
        Sun,  6 Feb 2022 21:11:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.213.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DEFB3108A12;
        Sun,  6 Feb 2022 21:11:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] ls-remote & transport API: release "struct
 transport_ls_refs_options"
References: <patch-1.1-e80e8f64eae-20220205T000809Z-avarab@gmail.com>
Date:   Sun, 06 Feb 2022 18:11:39 -0800
In-Reply-To: <patch-1.1-e80e8f64eae-20220205T000809Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat, 5 Feb
 2022 01:08:14 +0100")
Message-ID: <xmqqwni7h1d0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 494179C0-87BB-11EC-9BF7-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Fix a memory leak in codepaths that use the "struct
> transport_ls_refs_options" API. Since the introduction of the struct
> in 39835409d10 (connect, transport: encapsulate arg in struct,
> 2021-02-05) the caller has been responsible for freeing it.
>
> That commit in turn migrated code originally added in
> 402c47d9391 (clone: send ref-prefixes when using protocol v2,
> 2018-07-20) and b4be74105fe (ls-remote: pass ref prefixes when
> requesting a remote's refs, 2018-03-15). Only some of those codepaths
> were releasing the allocated resources of the struct, now all of them
> will.
>
> Mark the "t/t5511-refspec.sh" test as passing when git is compiled
> with SANITIZE=3Dleak. They'll now be listed as running under the
> "GIT_TEST_PASSING_SANITIZE_LEAK=3Dtrue" test mode (the "linux-leaks" CI
> target). Previously 24/47 tests would fail.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  builtin/clone.c     | 13 ++++++-------
>  builtin/fetch.c     |  2 +-
>  builtin/ls-remote.c |  3 ++-
>  connect.c           |  4 ++--
>  t/t5511-refspec.sh  |  1 +
>  transport.c         |  8 +++++++-
>  transport.h         | 10 +++++++---
>  7 files changed, 26 insertions(+), 15 deletions(-)

This ...

> +void transport_ls_refs_options_release(struct transport_ls_refs_option=
s *opts)
> +{
> +	strvec_clear(&opts->ref_prefixes);
> +	free((char *)opts->unborn_head_target);
> +}
> +

... addition is very much welcomed.  And instead of different code
paths doing "we used this member, so clear only that" ad-hoc, making
them all call it makes it very much pleasant read.

> diff --git a/builtin/clone.c b/builtin/clone.c
> index 727e16e0aea..8564e5f603f 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1233,7 +1233,8 @@ int cmd_clone(int argc, const char **argv, const =
char *prefix)
>  	}
>  	else {
>  		const char *branch;
> -		char *ref;
> +		const char *ref;
> +		char *ref_free =3D NULL;
> =20
>  		if (option_branch)
>  			die(_("Remote branch %s not found in upstream %s"),
> @@ -1250,17 +1251,16 @@ int cmd_clone(int argc, const char **argv, cons=
t char *prefix)
>  		    skip_prefix(transport_ls_refs_options.unborn_head_target,
>  				"refs/heads/", &branch)) {
>  			ref =3D transport_ls_refs_options.unborn_head_target;
> -			transport_ls_refs_options.unborn_head_target =3D NULL;
>  			create_symref("HEAD", ref, reflog_msg.buf);
>  		} else {
>  			branch =3D git_default_branch_name(0);
> -			ref =3D xstrfmt("refs/heads/%s", branch);
> +			ref_free =3D xstrfmt("refs/heads/%s", branch);
> +			ref =3D ref_free;
>  		}
> =20
>  		if (!option_bare)
>  			install_branch_config(0, branch, remote_name, ref);
> -
> -		free(ref);
> +		free(ref_free);
>  	}

It is a bit unfortunate that "ref" has to be sometimes a borrowed
pointer and some other times own the storage, only to allow us write
the call that uses the variable only once.  But under the
constraints of the current code, I think this is the best we could
do.

In our code base, we would usually call the auxiliary variable
"to_free", because its "ref"-ness does not matter and its sole
reason to exist is to be the "other owner" of the piece of memory,
to relieve the "ref" variable from the responsibility of releasing
resources.  With it, "ref" consistently borrows from somebody else,
either "to_free", or the .unborn_head_target member, and does not
have to be (and should not be) freed itself.
