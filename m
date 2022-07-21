Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35424C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 21:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbiGUVQr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 17:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbiGUVQp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 17:16:45 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E0A5C963
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 14:16:43 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BC18E1AB57C;
        Thu, 21 Jul 2022 17:16:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JMe4NoU7w7S2
        sbvcrexDepUzLvAiBVt4HL4Y6QtYUV0=; b=qTZskE7tmzMPJHai2snHD69hb5aB
        enJopxb078UiucW+ApkIDU8o2utP2JRKzSsbYw1Arp4ZKw7B68AU3ELEReUZutSL
        fKiGjvsQWvlqYNLowYloGermgIs9EDvSBsMAgndxC+Hhf4sj6H0esnWVJLLba1BB
        5WKTsGUo3vqv5h8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B486A1AB57B;
        Thu, 21 Jul 2022 17:16:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 901741AB573;
        Thu, 21 Jul 2022 17:16:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [PATCH v3 02/26] submodule--helper: stop conflating "sb" in
 clone_submodule()
References: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
        <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
        <patch-v3-02.26-32e4ae7ead5-20220721T191249Z-avarab@gmail.com>
Date:   Thu, 21 Jul 2022 14:16:36 -0700
In-Reply-To: <patch-v3-02.26-32e4ae7ead5-20220721T191249Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 21 Jul
 2022 21:12:58
        +0200")
Message-ID: <xmqqlesmf9or.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6801C9F4-093A-11ED-806F-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> -static int clone_submodule(struct module_clone_data *clone_data)
> +static char *clone_submodule_sm_gitdir(const char *name)
>  {
> -	char *p, *sm_gitdir;
> -	char *sm_alternate =3D NULL, *error_strategy =3D NULL;
>  	struct strbuf sb =3D STRBUF_INIT;
> -	struct child_process cp =3D CHILD_PROCESS_INIT;
> +	char *sm_gitdir;
> =20
> -	submodule_name_to_gitdir(&sb, the_repository, clone_data->name);
> +	submodule_name_to_gitdir(&sb, the_repository, name);
>  	sm_gitdir =3D absolute_pathdup(sb.buf);
> -	strbuf_reset(&sb);
> +	strbuf_release(&sb);
> +
> +	return sm_gitdir;
> +}

OK.

> +static int clone_submodule(struct module_clone_data *clone_data)
> +{
> +	char *p;
> +	char *sm_gitdir =3D clone_submodule_sm_gitdir(clone_data->name);
> +	char *sm_alternate =3D NULL, *error_strategy =3D NULL;
> +	struct child_process cp =3D CHILD_PROCESS_INIT;
> =20
>  	if (!is_absolute_path(clone_data->path)) {
> +		struct strbuf sb =3D STRBUF_INIT;
> +
>  		strbuf_addf(&sb, "%s/%s", get_git_work_tree(), clone_data->path);
>  		clone_data->path =3D strbuf_detach(&sb, NULL);

This looks like a roundabout way to say xstrfmt().

>  	} else {
> @@ -1705,6 +1715,8 @@ static int clone_submodule(struct module_clone_da=
ta *clone_data)
>  			die(_("clone of '%s' into submodule path '%s' failed"),
>  			    clone_data->url, clone_data->path);
>  	} else {
> +		struct strbuf sb =3D STRBUF_INIT;
> +
>  		if (clone_data->require_init && !access(clone_data->path, X_OK) &&
>  		    !is_empty_dir(clone_data->path))
>  			die(_("directory not empty: '%s'"), clone_data->path);
> @@ -1712,7 +1724,7 @@ static int clone_submodule(struct module_clone_da=
ta *clone_data)
>  			die(_("could not create directory '%s'"), clone_data->path);
>  		strbuf_addf(&sb, "%s/index", sm_gitdir);
>  		unlink_or_warn(sb.buf);
> -		strbuf_reset(&sb);
> +		strbuf_release(&sb);

Ditto.

>  	}
> =20
>  	connect_work_tree_and_git_dir(clone_data->path, sm_gitdir, 0);
> @@ -1734,7 +1746,6 @@ static int clone_submodule(struct module_clone_da=
ta *clone_data)
>  	free(sm_alternate);
>  	free(error_strategy);
> =20
> -	strbuf_release(&sb);
>  	free(sm_gitdir);
>  	free(p);
>  	return 0;
