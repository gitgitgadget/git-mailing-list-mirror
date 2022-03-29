Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D40C433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 22:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238517AbiC2W4E (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 18:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238481AbiC2W4D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 18:56:03 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F4743ACC
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 15:54:19 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5511C11C6AA;
        Tue, 29 Mar 2022 18:54:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GXB8javXcdGZ
        Qf4IgtJUGk+Yivz4M1/fP+VPm7zO5nI=; b=s6VXwOwTpn/N67ciar0xj1CGXaAn
        /8E4cazQpxQAXlUTaG3fToIDPFKuCGdbZnaj4ccfGPsBPQ3/b5scOv4jREBtQpRz
        t3IIdQzmyiULytHIV3oVatPUa2UumCiX1SKDu9oi/yjzTQzznKf6wgLqQlxYUVPw
        qEuQkwsHIRf8sQI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4CE5011C6A8;
        Tue, 29 Mar 2022 18:54:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AFBDE11C6A6;
        Tue, 29 Mar 2022 18:54:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com
Subject: Re: [PATCH v3 3/3] object-info: add option for retrieving object info
References: <20220208235631.732466-1-calvinwan@google.com>
        <20220328191112.3092139-1-calvinwan@google.com>
        <20220328191112.3092139-4-calvinwan@google.com>
Date:   Tue, 29 Mar 2022 15:54:16 -0700
In-Reply-To: <20220328191112.3092139-4-calvinwan@google.com> (Calvin Wan's
        message of "Mon, 28 Mar 2022 19:11:12 +0000")
Message-ID: <xmqqmth8qsiv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 29D32ABE-AFB3-11EC-8BE5-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> Add =E2=80=98--object-info=E2=80=99 option to fetch. This option allows=
 the client to
> make an object-info command request to a server that supports protocol
> v2. If the server is v2, but does not allow for the object-info
> command request, fetch the objects as if it were a standard fetch
> (however without changing any refs). Therefore, hook `fetch
> object-info` into transport_fetch_refs() to easily fallback if needed.

Sorry, but I do not see anything common between "git fetch" that
fetches history and associated objects and "retrieving only object
info".  Other than "the way I happened to have chosen to implement,
what is used to implement fetch has the most commonality".

If we were to add more "server offloading", say "run blame on the
server side", are we going to piggy back over fetch-pack, too?

It is not necessarily bad way to experiment, to reuse the code to
establish connection, check if the other side is capable to serve
us, throw args at them and then retrieve the result, but exposing
that implemention detail makes a HORRIBLE UX to force users to say
"git fetch --blame=3D'master Makefile' origin".

Shouldn't we be making the part that we truly need to reuse into a
separate API out of fetch-pack and either (1) allow new commands be
easily written reusing the code to create "git remote-object-info"
and "git remote-blame", or (2) come up with a single "do things on
remote" command with various subcommands, i.e. "git over-there
object-info" and "git over-there blame"?

> A previous patch added the `transfer.advertiseObjectInfo` config
> option, of which this patch utilizes to test the fallback.
>
> ---

Missing sign-off.

> diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
> index 550c16ca61..a13d2ba7ad 100644
> --- a/Documentation/git-fetch.txt
> +++ b/Documentation/git-fetch.txt
> @@ -13,6 +13,7 @@ SYNOPSIS
>  'git fetch' [<options>] <group>
>  'git fetch' --multiple [<options>] [(<repository> | <group>)...]
>  'git fetch' --all [<options>]
> +'git fetch' --object-info=3D[<arguments>] <remote> [<object-ids>]

This is a start of slippery slope of making "fetch" a kitchen sink
that does not have much to do with "git fetch".  Let's not go this
route.

> @@ -2087,6 +2094,7 @@ int cmd_fetch(int argc, const char **argv, const =
char *prefix)
>  	struct remote *remote =3D NULL;
>  	int result =3D 0;
>  	int prune_tags_ok =3D 1;
> +	struct oid_array object_info_oids =3D OID_ARRAY_INIT;
> =20
>  	packet_trace_identity("fetch");
> =20
> @@ -2168,7 +2176,19 @@ int cmd_fetch(int argc, const char **argv, const=
 char *prefix)
>  	if (dry_run)
>  		write_fetch_head =3D 0;
> =20
> -	if (all) {
> +	if (object_info_options.nr > 0) {
> +		if (argc =3D=3D 0 || argc =3D=3D 1) {
> +			die(_("must supply remote and object ids when using --object-info")=
);
> +		} else {
> +			struct object_id oid;
> +			remote =3D remote_get(argv[0]);
> +			for (i =3D 1; i < argc; i++) {
> +				if (get_oid(argv[i], &oid))
> +					return error(_("malformed object id '%s'"), argv[i]);
> +				oid_array_append(&object_info_oids, &oid);
> +			}
> +		}
> +	} else if (all) {
>  		if (argc =3D=3D 1)
>  			die(_("fetch --all does not take a repository argument"));
>  		else if (argc > 1)

Yuck.  Let's read this again, realize how little commonality we have
in processing args and barf.  That's all because we tried to
piggy-back on "fetch" because the patch wanted to reuse the parts
that are not shown in the patch text.  The right way to do so would
be to factor that "part that do not appear in the patch, because
they are common" out into callable from new code.  That way, we do
not have to contaminate this if/else conditional, both arms of which
is still about running "fetch" to retrieve history and connected
objects, and has nothing to do with "fetch object info".  The way
this patch changes this part of the code is an unnecessary risk to
break the normal "git fetch", and it does not have to be.

I like the idea to give client side a way to ask server to do random
things.  I do not think I want to see unrelated things piggy-backing
on existing client programs only because that is an expedient way to
implement it.
