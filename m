Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BA42B756
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 21:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A2D10CE
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 14:02:07 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7788f727dd7so305198385a.1
        for <git@vger.kernel.org>; Tue, 24 Oct 2023 14:02:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698181327; x=1698786127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cQGbPLTW0oqfjMWjHZQKrf+7z/eENd4rXCGZHpbEXjI=;
        b=dg9r5Bzi5GMT7id4ricWXw005Uu+04wVi+lUVGTIvyOyX6vlOxggB624IYb2AyatKq
         dy5EG/0AP/44dMmaKAK/huK60Cyym9H34PrMMn6AxCJOpoxWO0btc3l4s/W9v1EwMf1R
         GkAc3D+eMvrDPWXfN4WWuLrgH9r7xYSy/7sk2muUZKrEECDzVNAIbW9LPg/E0uVPT1E3
         JbpVt9NsSWUihcAIGIMFSF1hlUDA72+sPIgitm7Y1KXtBXayTjaC8T4Rg9J8EEGGDgzt
         uauMnTpHXQq7ODTjfcecz/rNhbL4zlT//j6kaKjQlKHv1Rh+gQL6yttTTbNhHdZ6Hr5K
         Q2jQ==
X-Gm-Message-State: AOJu0Yy7umy/cPWmzOcokqck2ksTVTT1wewIx+Ak5ucYgED2JzqpLQQx
	hfXgLYrg4RgOvse4/ezJ3OwpXEKSVmTxtVWJnSow5wH+sKw=
X-Google-Smtp-Source: AGHT+IFpwL52KZtyRLZZI+Ft0IPhzgfrDYjblhYsbMPKrIXVICIeoCm98e/zowC8Ne2h67uH2vWCJ5cwdrjaDS80LqM=
X-Received: by 2002:a05:6214:d8a:b0:65d:6a5:1a3f with SMTP id
 e10-20020a0562140d8a00b0065d06a51a3fmr18321372qve.43.1698181326767; Tue, 24
 Oct 2023 14:02:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1698152926.git.ps@pks.im> <2f876e61dd36a8887a1286bb8db9fb6577c55c9b.1698152926.git.ps@pks.im>
In-Reply-To: <2f876e61dd36a8887a1286bb8db9fb6577c55c9b.1698152926.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 24 Oct 2023 17:01:55 -0400
Message-ID: <CAPig+cRTOMie0rUf=Mhbo9e2EXf-_2kQyMeqpB9OCRB1MZZ1rw@mail.gmail.com>
Subject: Re: [PATCH 11/12] builtin/show-ref: add new mode to check for
 reference existence
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Han-Wen Nienhuys <hanwen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 9:11=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> While we have multiple ways to show the value of a given reference, we
> do not have any way to check whether a reference exists at all. While
> commands like git-rev-parse(1) or git-show-ref(1) can be used to check
> for reference existence in case the reference resolves to something
> sane, neither of them can be used to check for existence in some other
> scenarios where the reference does not resolve cleanly:
>
>     - References which have an invalid name cannot be resolved.
>
>     - References to nonexistent objects cannot be resolved.
>
>     - Dangling symrefs can be resolved via git-symbolic-ref(1), but this
>       requires the caller to special case existence checks depending on
>       whteher or not a reference is symbolic or direct.

s/whteher/whether/

> Furthermore, git-rev-list(1) and other commands do not let the caller
> distinguish easily between an actually missing reference and a generic
> error.
>
> Taken together, this gseems like sufficient motivation to introduce a

s/gseems/seems/

> separate plumbing command to explicitly check for the existence of a
> reference without trying to resolve its contents.
>
> This new command comes in the form of `git show-ref --exists`. This
> new mode will exit successfully when the reference exists, with a
> specific error code of 2 when it does not exist, or with 1 when there
> has been a generic error.
>
> Note that the only way to properly implement this command is by using
> the internal `refs_read_raw_ref()` function. While the public function
> `refs_resolve_ref_unsafe()` can be made to behave in the same way by
> passing various flags, it does not provide any way to obtain the errno
> with which the reference backend failed when reading the reference. As
> such, it becomes impossible for us to distinguish generic errors from
> the explicit case where the reference wasn't found.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.=
txt
> @@ -65,6 +70,12 @@ OPTIONS
> +--exists::
> +
> +       Check whether the given reference exists. Returns an error code o=
f 0 if

We probably want to call this "exit code" rather than "error code"
since the latter is unnecessarily scary sounding for the success case
(when the ref does exit).

> +       it does, 2 if it is missing, and 128 in case looking up the refer=
ence
> +       failed with an error other than the reference being missing.

The commit message says it returns 1 for a generic error, but this
inconsistently says it returns 128 for that case. The actual
implementation returns 1.

> diff --git a/builtin/show-ref.c b/builtin/show-ref.c
> @@ -214,6 +215,41 @@ static int cmd_show_ref__patterns(const struct patte=
rns_options *opts,
> +static int cmd_show_ref__exists(const char **refs)
> +{
> +       struct strbuf unused_referent =3D STRBUF_INIT;
> +       struct object_id unused_oid;
> +       unsigned int unused_type;
> +       int failure_errno =3D 0;
> +       const char *ref;
> +       int ret =3D 1;
> +
> +       if (!refs || !*refs)
> +               die("--exists requires a reference");
> +       ref =3D *refs++;
> +       if (*refs)
> +               die("--exists requires exactly one reference");
> +
> +       if (refs_read_raw_ref(get_main_ref_store(the_repository), ref,
> +                             &unused_oid, &unused_referent, &unused_type=
,
> +                             &failure_errno)) {
> +               if (failure_errno =3D=3D ENOENT) {
> +                       error(_("reference does not exist"));

The documentation doesn't mention this printing any output, and indeed
one would intuitively expect a boolean-like operation to not produce
any printed output since its exit code indicates the result (except,
of course, in the case of a real error).

> +                       ret =3D 2;
> +               } else {
> +                       error(_("failed to look up reference: %s"), strer=
ror(failure_errno));

Or use error_errno():

    errno =3D failure_errno;
    error_errno(_("failed to look up reference: %s"));

> +               }
> +
> +               goto out;
> +       }
> +
> +       ret =3D 0;
> +
> +out:
> +       strbuf_release(&unused_referent);
> +       return ret;
> +}

It's a bit odd having `ret` be 1 at the outset rather than 0, thus
making the logic a bit more difficult to reason about. I would have
expected it to be organized like this:

    int ret =3D 0;
    if (refs_read_raw_ref(...)) {
         if (failure_errno =3D=3D ENOENT) {
            ret =3D 2;
        } else {
            ret =3D 1;
            errno =3D failure_errno;
            error_errno(_("failed to look up reference: %s"));
       }
    }
    strbuf_release(...);
    return ret;

> @@ -272,13 +309,15 @@ int cmd_show_ref(int argc, const char **argv, const=
 char *prefix)
> +       if ((!!exclude_existing_opts.enabled + !!verify + !!exists) > 1)
> +               die(_("only one of --exclude-existing, --exists or --veri=
fy can be given"));

When reviewing an earlier patch in this series, I forgot to mention
that we can simplify the life of translators by using placeholders:

    die(_("options '%s', '%s' or '%s' cannot be used together"),
        "--exclude-existing", "--exists", "--verify");

which ensures that they don't translate the literal option names, and
makes it possible to reuse the translated message in multiple
locations (since it doesn't mention hard-coded option names).
