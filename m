Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D967200B9
	for <e@80x24.org>; Sun,  6 May 2018 15:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751591AbeEFPhf (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 11:37:35 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:46601 "EHLO
        hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbeEFPhe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 11:37:34 -0400
Received: from homiemail-a39.g.dreamhost.com (sub3.mail.dreamhost.com [69.163.253.7])
        by hapkido.dreamhost.com (Postfix) with ESMTP id 689F98D622
        for <git@vger.kernel.org>; Sun,  6 May 2018 08:37:34 -0700 (PDT)
Received: from homiemail-a39.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a39.g.dreamhost.com (Postfix) with ESMTP id AA211150074;
        Sun,  6 May 2018 08:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:cc:date:in-reply-to:references:content-type
        :mime-version:content-transfer-encoding; s=novalis.org; bh=F5kto
        HPwxXaVNHjgzAF9Wu8wOvA=; b=g2pNIfXYzbjrukXa96qqjCbG92XTL7adcYSqt
        5wxvw8X8xwihdMmsfjGyQCnDRvpuns3lZudN4UgGgaMyXErAK0wPvh8YOQffzWhm
        v3tPb5f4jS8dTvBtkSfiAi6YpsqgSghfLF7rzPSI2qHscv44GIIJNsCMZTgkCw0q
        T0C3SY=
Received: from corey (unknown [74.213.195.68])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a39.g.dreamhost.com (Postfix) with ESMTPSA id 566E6150069;
        Sun,  6 May 2018 08:37:33 -0700 (PDT)
Message-ID: <1525621052.16035.4.camel@novalis.org>
Subject: Re: [PATCH] refs: handle null-oid for pseudorefs
From:   David Turner <novalis@novalis.org>
To:     Martin =?ISO-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Rafael =?ISO-8859-1?Q?Ascens=E3o?= <rafa.almas@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Date:   Sun, 06 May 2018 11:37:32 -0400
In-Reply-To: <20180506133549.8536-1-martin.agren@gmail.com>
References: <CACUQV5-9PagVhE5YY=Z3721YRiBwSZykT3ZjtzmD3o-c6O6ddQ@mail.gmail.com>
         <20180506133549.8536-1-martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

LGTM. =20

(This is the current best address to reach me, but do not expect fast
responses over the next few days as I'm out of town)



On Sun, 2018-05-06 at 15:35 +0200, Martin =C3=85gren wrote:
> According to the documentation on `git update-ref`, it is possible to
> "specify 40 '0' or an empty string as <oldvalue> to make sure that
> the
> ref you are creating does not exist." But in the code for pseudorefs,
> we
> do not implement this. If we fail to read the old ref, we immediately
> die. A failure to read would actually be a good thing if we have been
> given the null-oid.
>=20
> With the null-oid, allow -- and even require -- the ref-reading to
> fail.
> This implements the "make sure that the ref ... does not exist" part
> of
> the documentation.
>=20
> Since we have a `strbuf err` for collecting errors, let's use it and
> signal an error to the caller instead of dying hard.
>=20
> Reported-by: Rafael Ascens=C3=A3o <rafa.almas@gmail.com>
> Helped-by: Rafael Ascens=C3=A3o <rafa.almas@gmail.com>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
> (David's twopensource-address bounced, so I'm trying instead the one
> he
> most recently posted from.)
>=20
>  t/t1400-update-ref.sh |  7 +++++++
>  refs.c                | 19 +++++++++++++++----
>  2 files changed, 22 insertions(+), 4 deletions(-)
>=20
> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index 664a3a4e4e..bd41f86f22 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -457,6 +457,13 @@ test_expect_success 'git cat-file blob
> master@{2005-05-26 23:42}:F (expect OTHER
>  	test OTHER =3D $(git cat-file blob "master@{2005-05-26
> 23:42}:F")
>  '
> =20
> +test_expect_success 'create pseudoref with old oid null, but do not
> overwrite' '
> +	git update-ref PSEUDOREF $A $Z &&
> +	test_when_finished "git update-ref -d PSEUDOREF" &&
> +	test $A =3D $(cat .git/PSEUDOREF) &&
> +	test_must_fail git update-ref PSEUDOREF $A $Z
> +'
> +
>  a=3Drefs/heads/a
>  b=3Drefs/heads/b
>  c=3Drefs/heads/c
> diff --git a/refs.c b/refs.c
> index 8b7a77fe5e..3669190499 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -666,10 +666,21 @@ static int write_pseudoref(const char
> *pseudoref, const struct object_id *oid,
>  	if (old_oid) {
>  		struct object_id actual_old_oid;
> =20
> -		if (read_ref(pseudoref, &actual_old_oid))
> -			die("could not read ref '%s'", pseudoref);
> -		if (oidcmp(&actual_old_oid, old_oid)) {
> -			strbuf_addf(err, "unexpected sha1 when
> writing '%s'", pseudoref);
> +		if (read_ref(pseudoref, &actual_old_oid)) {
> +			if (!is_null_oid(old_oid)) {
> +				strbuf_addf(err, "could not read ref
> '%s'",
> +					    pseudoref);
> +				rollback_lock_file(&lock);
> +				goto done;
> +			}
> +		} else if (is_null_oid(old_oid)) {
> +			strbuf_addf(err, "ref '%s' already exists",
> +				    pseudoref);
> +			rollback_lock_file(&lock);
> +			goto done;
> +		} else if (oidcmp(&actual_old_oid, old_oid)) {
> +			strbuf_addf(err, "unexpected sha1 when
> writing '%s'",
> +				    pseudoref);
>  			rollback_lock_file(&lock);
>  			goto done;
>  		}
