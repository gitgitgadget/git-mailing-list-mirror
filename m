Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CBEC43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 02:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbiFOCtm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 22:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbiFOCtl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 22:49:41 -0400
X-Greylist: delayed 118 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Jun 2022 19:49:38 PDT
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAF628706
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 19:49:38 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9C793119BFE;
        Tue, 14 Jun 2022 22:47:37 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=p+lihOuuAku6I
        zcEth4GXYB5WskhPGyB6Qghta5f+v0=; b=oGsyPRPcC2TPSzVryyXOFWuDOVs6x
        iks3iV8PE+nbJpQTY2gb8xVQL9CTmsEuC6AThCgGrMsR87jRZ0B5I8HW9jh89Ql/
        ScyOq01QXzJJmqL9k55Pz4ThVCBuIMlBVeAbPldXrdwtwIZGwvQhXb+uOXuYMIem
        YV2ZcxMh0227LE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 93848119BFD;
        Tue, 14 Jun 2022 22:47:37 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [71.254.192.78])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 18254119BFC;
        Tue, 14 Jun 2022 22:47:37 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Tue, 14 Jun 2022 22:47:34 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@grubix.eu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] add -i tests: mark "TODO" depending on
 GIT_TEST_ADD_I_USE_BUILTIN
Message-ID: <YqlIRveupj6tOO4P@pobox.com>
References: <cf6aee9acadfb666de6b24b9ed63e1a65bfc009e.1655220242.git.git@grubix.eu>
 <patch-v2-1.1-13c26e546f6-20220614T153746Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <patch-v2-1.1-13c26e546f6-20220614T153746Z-avarab@gmail.com>
X-Pobox-Relay-ID: 83F05FB0-EC55-11EC-AB58-CB998F0A682E-09356542!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C6var Arnfj=F6r=F0 Bjarmason wrote:
> Fix an issue that existed before 0527ccb1b55 (add -i: default to the
> built-in implementation, 2021-11-30), but which became the default
> with that change, we should not be marking tests that are known to
> pass as "TODO" tests.
[...]
> ---
> Just converting it to "test_expect_success" will break CI and other
> setups that are testing with GIT_TEST_ADD_I_USE_BUILTIN=3Dfalse.
>=20
> The below fixes it, however.

Nice catch.  FWIW, I tested w/GIT_TEST_ADD_I_USE_BUILTIN=3D0
and without.

> diff --git a/t/t2016-checkout-patch.sh b/t/t2016-checkout-patch.sh
> index bc3f69b4b1d..a5822e41af2 100755
> --- a/t/t2016-checkout-patch.sh
> +++ b/t/t2016-checkout-patch.sh
> @@ -4,7 +4,7 @@ test_description=3D'git checkout --patch'
> =20
>  . ./lib-patch-mode.sh
> =20
> -if ! test_bool_env GIT_TEST_ADD_I_USE_BUILTIN true && ! test_have_prer=
eq PERL
> +if ! test_have_prereq ADD_I_USE_BUILTIN && ! test_have_prereq PERL
>  then
>  	skip_all=3D'skipping interactive add tests, PERL not set'

It's not the fault of this patch, but it makes it obvious
that the `skip_all` message is no longer accurate.  Perhaps
somethine like this?

    skip_all=3D'skipping interactive add tests, missing ADD_I_USE_BUILTIN=
 or PERL'

Maybe a separate `ADD_I` prereq would be better?  Though
without looking closer, I don't know if that would end up
being clearer to anyone running the tests without either
PERL or the add -i builtin enabled.

Thanks for the keen eye and attention to detail, =C6var,

--=20
Todd
