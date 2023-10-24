Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5772420F
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 20:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F59A2
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 13:13:04 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-66d0c777bf0so30299596d6.3
        for <git@vger.kernel.org>; Tue, 24 Oct 2023 13:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698178383; x=1698783183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9bDs9DPgwwqluyM9K/WFmzjysJDz23cj7okY2nncVA=;
        b=bKyutla0PLE1Z2AlO/UjonX0wJAMFzJIiHY8CiWlEBLB/BG0urlhoJmnTe6D9ohtkQ
         HVFRZhDgyYYDKgHsaH2b++uA6JT+8nlQuiLoZ9aLAIU85K9EFAWReVkfdDeOAJ31cwCB
         3udbV/QupJDHYnDtG0Foahjq7TgmBXeaVnMVCpGuAEglCb9rSGcF2S6ohGea6tUobmhL
         ukYvQcjGVygUFNnyHsSP87XjHE2jiJKfJBocys/iP1Cb/YcUlygi5+qT2odbzGZ6gPm1
         WbEIykKxOBcJVUAFvQI7eWeL8gUgIh7lEH0OplaGpDFFr80jfOZGx4sBwYhniknMZDyZ
         bS0g==
X-Gm-Message-State: AOJu0YyJlZCaMNM3vj0DdTcYDIs0nGNdyp9lKCO5+hIMgDD/u2sRiwSe
	lMkhr+dJECGDIBIEKGIOSCUMDjWrg985byVVsjNZTKtRKhw=
X-Google-Smtp-Source: AGHT+IEZIXTMydrN35qXdTDSSAW2bqJDYSJoaOyQfT3+iJR5DcpI2fCS8O645paJJxFLssOAkQWhWIftqk5skU4mpzM=
X-Received: by 2002:a05:6214:21a5:b0:65d:1270:6846 with SMTP id
 t5-20020a05621421a500b0065d12706846mr14986209qvc.29.1698178383534; Tue, 24
 Oct 2023 13:13:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024195655.2413191-1-sandals@crustytoothpaste.net> <20231024195655.2413191-2-sandals@crustytoothpaste.net>
In-Reply-To: <20231024195655.2413191-2-sandals@crustytoothpaste.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 24 Oct 2023 16:12:52 -0400
Message-ID: <CAPig+cT_yq-ke4RTpTdTTLsnJFxCtyGAP2K0mQ_S23jJYtUp=w@mail.gmail.com>
Subject: Re: [PATCH 1/1] merge-file: add an option to process object IDs
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Elijah Newren <newren@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 3:58=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> git merge-file knows how to merge files on the file system already.  It
> would be helpful, however, to allow it to also merge single blobs.
> Teach it an `--object-id` option which means that its arguments are
> object IDs and not files to allow it to do so.
>
> Since we obviously won't be writing the data to the first argument,
> either write to the object store and print the object ID, or honor the
> -p argument and print it to standard out.
>
> We handle the empty blob specially since read_mmblob doesn't read it
> directly, instead throwing an error, and otherwise users cannot specify
> an empty ancestor.
>
> Signed-off-by: brian m. carlson <bk2204@github.com>
> ---
> diff --git a/builtin/merge-file.c b/builtin/merge-file.c
> @@ -99,20 +116,29 @@ int cmd_merge_file(int argc, const char **argv, cons=
t char *prefix)
>         if (ret >=3D 0) {
> -               const char *filename =3D argv[0];
> -               char *fpath =3D prefix_filename(prefix, argv[0]);
> -               FILE *f =3D to_stdout ? stdout : fopen(fpath, "wb");
> +               if (object_id && !to_stdout) {
> +                       struct object_id oid;
> +                       if (result.size)
> +                               write_object_file(result.ptr, result.size=
, OBJ_BLOB, &oid);

Should this be caring about errors by checking the return value of
write_object_file()?

> +               } else {
> +                       const char *filename =3D argv[0];
> +                       char *fpath =3D prefix_filename(prefix, argv[0]);
> +                       FILE *f =3D to_stdout ? stdout : fopen(fpath, "wb=
");
> +                       if (!f)
> +                               ret =3D error_errno("Could not open %s fo=
r writing",
> +                                                 filename);
> +                       else if (result.size &&
> +                                fwrite(result.ptr, result.size, 1, f) !=
=3D 1)
> +                               ret =3D error_errno("Could not write to %=
s", filename);
> +                       else if (fclose(f))
> +                               ret =3D error_errno("Could not close %s",=
 filename);
> +                       free(fpath);

 The non-"object-id" case cares about errors.
