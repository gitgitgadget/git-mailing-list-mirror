Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24CC219ED
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 18:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A85BA2
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 11:48:26 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-66cee0d62fbso33983846d6.3
        for <git@vger.kernel.org>; Tue, 24 Oct 2023 11:48:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698173305; x=1698778105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CbOQIpyQiTBLMHeGVtogdaRBCjTB6vQnE4lAr8KH048=;
        b=uIha+irnT4W7GFuJpUwgaF5lNwAjF9o0eKN9KRJyMAz8645QthgDZRnE65QNTNCNom
         pi7Od19+kEvI6iuR+9m5w63Ims4K/1nKoxAQFBMrzwf30fY/VLymjWAkoHF/EWmhsJFt
         GYiDHXaqQSzthAXiFvL1kMllL6/8lO7+6Sgr9raX9cOwN0NB59TnYTKmhZV1kVkwPeGp
         we+/HxYCEL25NJU1iy+Oss+8Jc72SI4fFSs/Pngr696D4rRkWEAJgpo29W6QR4hFhdhs
         uepPeEuH4jqkCaffcasZ6UkspJvTgwGq7+GmWh4pXlao0n9ukIJjBW/fTnlh3+NQkJRr
         S13A==
X-Gm-Message-State: AOJu0YwbTYZgvwxC7kFSoHYYNrtmmx9qI9tnDcOLfaoRDgLySU4gCI4T
	d06uDQGe2bnJaLrh3eaDeSo3ZjWhkh2l7HBvuuPoXQ8z6rU=
X-Google-Smtp-Source: AGHT+IFfSpYwZCy6cuwR/uN/rmW5QLRBaEELLoWw0Gq2JKO55TvHnRNKR21URoNfO1OA8nKK4Tjo8AgBzjYUClw4hX0=
X-Received: by 2002:a05:6214:c49:b0:66d:69d1:d57a with SMTP id
 r9-20020a0562140c4900b0066d69d1d57amr15919666qvj.38.1698173305374; Tue, 24
 Oct 2023 11:48:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1698152926.git.ps@pks.im> <8d0b0b5700c7ffed6b3a74760d0d9155b404bb4f.1698152926.git.ps@pks.im>
In-Reply-To: <8d0b0b5700c7ffed6b3a74760d0d9155b404bb4f.1698152926.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 24 Oct 2023 14:48:14 -0400
Message-ID: <CAPig+cQrD6uh65UzaKbwryv=wcdymKrjqXsAKgrKHYpQNWqSYQ@mail.gmail.com>
Subject: Re: [PATCH 05/12] builtin/show-ref: refactor `--exclude-existing` options
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Han-Wen Nienhuys <hanwen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 9:11=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> It's not immediately obvious options which options are applicable to
> what subcommand ni git-show-ref(1) because all options exist as global

s/ni/in/

> state. This can easily cause confusion for the reader.
>
> Refactor options for the `--exclude-existing` subcommand to be contained
> in a separate structure. This structure is stored on the stack and
> passed down as required. Consequentially, it clearly delimits the scope

s/Consequentially/Consequently/

> of those options and requires the reader to worry less about global
> state.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> diff --git a/builtin/show-ref.c b/builtin/show-ref.c
> @@ -95,6 +94,11 @@ static int add_existing(const char *refname,
> +struct exclude_existing_options {
> +       int enabled;
> +       const char *pattern;
> +};

Do we need this `enabled` flag? Can't the same be achieved by checking
whether `pattern` is NULL or not (see below)?

> @@ -104,11 +108,11 @@ static int add_existing(const char *refname,
> -static int cmd_show_ref__exclude_existing(const char *match)
> +static int cmd_show_ref__exclude_existing(const struct exclude_existing_=
options *opts)

Since you're renaming `match` to `opts->pattern`...

>  {
> -       int matchlen =3D match ? strlen(match) : 0;
> +       int matchlen =3D opts->pattern ? strlen(opts->pattern) : 0;

... and since you're touching this line anyway, maybe it makes sense
to rename `matchlen` to `patternlen`?

> @@ -124,11 +128,11 @@ static int cmd_show_ref__exclude_existing(const cha=
r *match)
> -                       if (strncmp(ref, match, matchlen))
> +                       if (strncmp(ref, opts->pattern, matchlen))

Especially since, as shown in this context, `matchlen` is really the
length of the _pattern_, not the length of the resulting _match_.

> @@ -200,44 +204,46 @@ static int hash_callback(const struct option *opt, =
const char *arg, int unset)
>  int cmd_show_ref(int argc, const char **argv, const char *prefix)
>  {
>         [...]
> -       if (exclude_arg)
> -               return cmd_show_ref__exclude_existing(exclude_existing_ar=
g);
> +       if (exclude_existing_opts.enabled)
> +               return cmd_show_ref__exclude_existing(&exclude_existing_o=
pts);

(continued from above) Can't this be handled without a separate `enabled` f=
lag?

    if (exclude_existing_opts.pattern)
        ...
