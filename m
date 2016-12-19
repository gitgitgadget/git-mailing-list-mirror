Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72C7E1FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 18:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755542AbcLSSOb (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 13:14:31 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60939 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754930AbcLSSO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 13:14:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D677E597E5;
        Mon, 19 Dec 2016 13:14:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TkrQgg7fv5GF
        T+Lblp7m8uJRqLA=; b=QB6q4FYGrziW09xiZZKKXc7FPo1uZhJzFDeZSZxnIihn
        fQPN48up3CxV4scRH43Vgxn1Ova4vo8KMS5EPT0Z3diZwhFilam9GdSl54qcHlNu
        pL3GPEpLrtp15p4Ker8y6qMz3HhGGK1MCwAaeNodnGCp71RNKU6HjAIvZAf0Yv8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=RGGbd0
        KWv1PDe6TwkOY6jcmETTVlemjVjNmq6xSmGyTPieleLW7mDhxV9i4OvftsIk2ekj
        HdBMQckhhd4269H30/o6R7cE5HQ6AMsQY8YB2nBwtanoDJugVh+N1drmJ6xXlq3M
        MXfqSSZRI7jhsEdnLlr3jdd0oWXwuYpxbhDS0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CEF17597E4;
        Mon, 19 Dec 2016 13:14:28 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4BEFA597E3;
        Mon, 19 Dec 2016 13:14:28 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, josharian@gmail.com
Subject: Re: [PATCH] config.c: handle error case for fstat() calls
References: <CAFAcib_cY8FeLFkW1=MfR+P7xoupGK9DFegNY5boExHSRppAmg@mail.gmail.com>
        <20161219092155.20359-1-pclouds@gmail.com>
Date:   Mon, 19 Dec 2016 10:14:27 -0800
In-Reply-To: <20161219092155.20359-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Mon, 19 Dec 2016 16:21:55 +0700")
Message-ID: <xmqqtw9zpz0c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FAF41ED2-C616-11E6-ACED-E98412518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
> ---
>  Will this fix the problem I'm replying to? I don't know. I found this
>  while checking the code and it should be fixed regardless.

Yeah, from a cursory read, it is a step in the right direction to
check the return value of fstat(). =20

Shouldn't the error-return path in the second hunk rollback the
lockfile to clean after itself?  The existing "Oh, we cannot chmod
to match the original" check that comes immediately after shares the
same issue, so this is not a new problem, but making an existing one
worse.

>  config.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/config.c b/config.c
> index 83fdecb..4973256 100644
> --- a/config.c
> +++ b/config.c
> @@ -2194,7 +2194,12 @@ int git_config_set_multivar_in_file_gently(const=
 char *config_filename,
>  			goto out_free;
>  		}
> =20
> -		fstat(in_fd, &st);
> +		if (fstat(in_fd, &st) =3D=3D -1) {
> +			error_errno(_("fstat on %s failed"), config_filename);
> +			ret =3D CONFIG_INVALID_FILE;
> +			goto out_free;
> +		}
> +
>  		contents_sz =3D xsize_t(st.st_size);
>  		contents =3D xmmap_gently(NULL, contents_sz, PROT_READ,
>  					MAP_PRIVATE, in_fd, 0);
> @@ -2414,7 +2419,10 @@ int git_config_rename_section_in_file(const char=
 *config_filename,
>  		goto unlock_and_out;
>  	}
> =20
> -	fstat(fileno(config_file), &st);
> +	if (fstat(fileno(config_file), &st) =3D=3D -1) {
> +		ret =3D error_errno(_("fstat on %s failed"), config_filename);
> +		goto out;
> +	}
> =20
>  	if (chmod(get_lock_file_path(lock), st.st_mode & 07777) < 0) {
>  		ret =3D error_errno("chmod on %s failed",
