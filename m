Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7781F1FA26
	for <e@80x24.org>; Tue, 18 Apr 2017 02:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754472AbdDRCte (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 22:49:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51128 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752773AbdDRCtd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 22:49:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 08BF575481;
        Mon, 17 Apr 2017 22:49:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9M+Bd1IFpk/g
        FRVI2vR5DxDhs3o=; b=fnTJQorNJG9BHpmPSOv6qCXb/tHeVYQZgqQwAdDQAI7O
        J2p5AAweJf1rrBTr8acCjTHaGqrZkCSIIeHOQei9v5RRoDXtfGiFOki0qAhoAiiL
        6Ufkq788IMEnWcTNbNIiC4nFQADB0mGlzp2W4/CnEUHPAGB1z+fh5NsHMMSGEek=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=eeTUtG
        AxHTFcQe9BnMck+JNV/nxQGaWReyQczdbRu0nIl0Z34j9kHCD8icOcxquYUPsCmF
        halia3xu2Pog7Znqrj9K/p5R3JnMLe0YLSZkRtYnsO/UVSemFgRhPaJ/BKaEp5r2
        8lOLTTHM7x8NFz6JF0mvxdVPEFWFFrJes54gk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F406175480;
        Mon, 17 Apr 2017 22:49:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6D7687547F;
        Mon, 17 Apr 2017 22:49:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        bert.wesarg@googlemail.com
Subject: Re: [PATCH v2 2/3] config: handle conditional include when $GIT_DIR is not set up
References: <CACsJy8D-=3qPbEO-dq2+Mr-WZ+5RrivkSw9NX7_FhEJFy+59zA@mail.gmail.com>
        <20170417101002.18272-1-pclouds@gmail.com>
        <20170417101002.18272-2-pclouds@gmail.com>
Date:   Mon, 17 Apr 2017 19:49:30 -0700
In-Reply-To: <20170417101002.18272-2-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Mon, 17 Apr 2017 17:10:01 +0700")
Message-ID: <xmqq7f2ih1l1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A5D0D6E2-23E1-11E7-95AC-C260AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> @@ -1603,10 +1613,12 @@ void read_early_config(config_fn_t cb, void *da=
ta)
>  {
>  	struct config_options opts =3D {0};
>  	struct strbuf buf =3D STRBUF_INIT;
> +	char *to_free =3D NULL;
> =20
>  	opts.respect_includes =3D 1;
> -	git_config_with_options(cb, data, NULL, &opts);
> =20
> +	if (have_git_dir())
> +		opts.git_dir =3D get_git_dir();
>  	/*
>  	 * When setup_git_directory() was not yet asked to discover the
>  	 * GIT_DIR, we ask discover_git_directory() to figure out whether the=
re
> @@ -1615,7 +1627,12 @@ void read_early_config(config_fn_t cb, void *dat=
a)
>  	 * notably, the current working directory is still the same after the
>  	 * call).
>  	 */
> -	if (!have_git_dir() && discover_git_directory(&buf)) {
> +	else if (discover_git_directory(&buf))
> +		opts.git_dir =3D to_free =3D xstrdup(buf.buf);
> +
> +	git_config_with_options(cb, data, NULL, &opts);

This one I can understand.  By having NULL for config_source, this
does the usual do_git_config_sequence() dance, which knows to treat
opts.git_dir is the "repository config" without necessarily being
able to do git_pathdup("config").

> +	if (!have_git_dir() && opts.git_dir) {
>  		struct git_config_source repo_config;
> =20
>  		memset(&repo_config, 0, sizeof(repo_config));

But this one I do not quite understand.  When have_git_dir() was
false and asked discover_git_directory() to set opts.git_dir, we
enter the body of this block and then end up doing

	git_config_with_options(cb, data &repo_config, &opts);

with repo_config set to the discovered git directory plus "/config";
we'd read the repository configuration twice, in other words.

