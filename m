Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FF1C433F5
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 01:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348342AbiBGB53 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Feb 2022 20:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbiBGB51 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Feb 2022 20:57:27 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2982EC061A73
        for <git@vger.kernel.org>; Sun,  6 Feb 2022 17:57:27 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CD9AA1088FF;
        Sun,  6 Feb 2022 20:57:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=C5JlnPyplWh1
        DTUYCr3yqDlntFxEEghNyy0XyxLLlEk=; b=I2824KJpCOqY16pfDcG29+RdcOIB
        c57x++41Nu7Zv70MQweWyU6PbP90sSfTfrP8dPyTGLv+S3RVI90oXlTrBPq0mEVe
        NRMQXVLOAteArG81tX2pz5s+u6JqYiIsDRBE2+yv57dB/ph+Fjymp0xPa7FQ3Qvu
        5+GVGEK40JoN/gs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C27F21088FE;
        Sun,  6 Feb 2022 20:57:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.213.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 24CCC1088FD;
        Sun,  6 Feb 2022 20:57:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] hash-object: fix a trivial leak in --path
References: <patch-1.1-53863df1455-20220205T000422Z-avarab@gmail.com>
Date:   Sun, 06 Feb 2022 17:57:23 -0800
In-Reply-To: <patch-1.1-53863df1455-20220205T000422Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat, 5 Feb
 2022 01:04:29 +0100")
Message-ID: <xmqq4k5bigl8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4B2ECC6C-87B9-11EC-8DED-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/builtin/hash-object.c b/builtin/hash-object.c
> index c7b3ad74c60..db9b2535271 100644
> --- a/builtin/hash-object.c
> +++ b/builtin/hash-object.c
> @@ -92,6 +92,7 @@ int cmd_hash_object(int argc, const char **argv, cons=
t char *prefix)
>  	int nongit =3D 0;
>  	unsigned flags =3D HASH_FORMAT_CHECK;
>  	const char *vpath =3D NULL;
> +	char *vpath_free =3D NULL;
>  	const struct option hash_object_options[] =3D {
>  		OPT_STRING('t', NULL, &type, N_("type"), N_("object type")),
>  		OPT_BIT('w', NULL, &flags, N_("write the object into the object data=
base"),
> @@ -114,8 +115,10 @@ int cmd_hash_object(int argc, const char **argv, c=
onst char *prefix)
>  	else
>  		prefix =3D setup_git_directory_gently(&nongit);
> =20
> -	if (vpath && prefix)
> -		vpath =3D prefix_filename(prefix, vpath);
> +	if (vpath && prefix) {
> +		vpath_free =3D prefix_filename(prefix, vpath);
> +		vpath =3D vpath_free;
> +	}
> =20
>  	git_config(git_default_config, NULL);
> =20
> @@ -156,5 +159,7 @@ int cmd_hash_object(int argc, const char **argv, co=
nst char *prefix)
>  	if (stdin_paths)
>  		hash_stdin_paths(type, no_filters, flags, literally);
> =20
> +	free(vpath_free);
> +

Heh.

This is not wrong per-se, but we are about to exit and clean-up, so
having leak-checker complain about this and having us spend brain
cycles to worry about it is a sad thing.

Will queue.  Thanks.


>  	return 0;
>  }
> diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
> index 64b340f2272..ac5ad8c7402 100755
> --- a/t/t1007-hash-object.sh
> +++ b/t/t1007-hash-object.sh
> @@ -2,6 +2,7 @@
> =20
>  test_description=3D"git hash-object"
> =20
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
> =20
>  echo_without_newline() {
