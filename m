Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC903D965
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4215172E
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 10:08:57 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3ae2f8bf865so4384213b6e.2
        for <git@vger.kernel.org>; Wed, 18 Oct 2023 10:08:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697648937; x=1698253737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zFA4gIf6kmUZ453ojMJEo3sFzyK2C0pYu+KO2k/kLtQ=;
        b=OTh4rww8QaAuosUBWyJss1zoldcfHckTZtnJomf9qfG5RLHjgUyO4nqFhhSTwq2IUF
         QrGXcoZPQIK/zS/hWRIKbgchKXrDzTZh99HPvb3zvZf42LmxRZokuAFv2+7k1PhG2mgS
         ZcoVOEr3bznAEWxXjNrJLByiA2U5VkdzcSwS/Yt2ZOF04MqKKb27Quazcfod5s8alD6V
         e/AXySA4v6wCTwpJT0X2jdjDTVWDJLMwfkD+Z2s+0Ekv0D6JURJ2+hx+JnTmN9cqyxwv
         l8FkMx1x2j4ZesEljyrY6V6pVDfrnfjBFU9pdb2tuCwLYJLZK5BARwSTNmGaR3hJpbWm
         isSA==
X-Gm-Message-State: AOJu0Yxt5yI3a9FjCOOe8L7xKQUbGbYX2ApBtB03aMzLZrrWFb5o4JLC
	Mm4xasNApAB5b0GiJlmL/1E0M00NglMDndKqfDzyguz2OQ0=
X-Google-Smtp-Source: AGHT+IHpeXLY/3LhHoaaSpxEK34gg0J2pnfY56kxQtV64h0sVfakkY92EwAim0+x7yqdfx472lssF5wMWOZ4ny09XL0=
X-Received: by 2002:aca:2816:0:b0:3a9:cfb5:4637 with SMTP id
 22-20020aca2816000000b003a9cfb54637mr5893306oix.38.1697648936810; Wed, 18 Oct
 2023 10:08:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1697607222.git.ps@pks.im> <e947feb1c77f7e9f3c7f983bbe47137fbce42367.1697607222.git.ps@pks.im>
In-Reply-To: <e947feb1c77f7e9f3c7f983bbe47137fbce42367.1697607222.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 18 Oct 2023 13:08:45 -0400
Message-ID: <CAPig+cTueWuiWiw9_vou0Ud71utVMRkk5tR==tfkkMXBj9qWxA@mail.gmail.com>
Subject: Re: [PATCH 01/11] t: add helpers to test for reference existence
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 18, 2023 at 1:35=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> Introduce a new subcommand for our ref-store test helper that explicitly
> checks only for the presence or absence of a reference. This addresses
> these limitations:
> [...]
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
> @@ -221,6 +221,30 @@ static int cmd_verify_ref(struct ref_store *refs, co=
nst char **argv)
> +static int cmd_ref_exists(struct ref_store *refs, const char **argv)
> +{
> +       const char *refname =3D notnull(*argv++, "refname");
> +       struct strbuf unused_referent =3D STRBUF_INIT;
> +       struct object_id unused_oid;
> +       unsigned int unused_type;
> +       int failure_errno;
> +
> +       if (refs_read_raw_ref(refs, refname, &unused_oid, &unused_referen=
t,
> +                             &unused_type, &failure_errno)) {
> +               /*
> +                * We handle ENOENT separately here such that it is possi=
ble to
> +                * distinguish actually-missing references from any kind =
of
> +                * generic error.
> +                */
> +               if (failure_errno =3D=3D ENOENT)
> +                       return 17;
> +               return -1;
> +       }
> +
> +       strbuf_release(&unused_referent);
> +       return 0;
> +}

Unless refs_read_raw_ref() guarantees that `unused_referent` remains
unallocated upon failure[*], then the early returns inside the
conditional leak the strbuf. True, the program is exiting immediately
anyhow, so this (potential) leak isn't significant, but it seems odd
to clean up in one case (return 0) but not in the others (return -1 &
17).

[*] In my (admittedly brief) scan of the code and documentation, I
didn't see any such promise.
