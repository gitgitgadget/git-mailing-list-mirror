Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFB92510F
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 17:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5151B90
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 10:55:50 -0700 (PDT)
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-49d8dd34f7bso2058799e0c.3
        for <git@vger.kernel.org>; Tue, 24 Oct 2023 10:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698170149; x=1698774949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MHneHS/Y50chBL4OQfPMJPONyAgPPWfqKuJcfoQrZ4g=;
        b=v6QGsTvub2mXy79q34XSMsiIyqHdZQKrdNG5kHAtXvmhBEeH4WVUxvRj2Y5wTugNss
         g5a06UQiGZlCoakl6NVinpkz1rt5MNDxnqcv5sKd/swmLd0eJDBIaQsVADmHNep16VfU
         C5Vq8sednHF5bWcj3c1YFhranIwSGLKmoRRlEZTgO2bRgEYEjlM5p/D2vbQadFOUIxYm
         VjFEWsYlzikYXJs9vgE+Oyk3JhIH7lFucEhzeq/Qud/AAYkQOBF6Y7iyThjJjrW43FzM
         OvOaFTa+1Hu5bPnTxufbIrLW0bhr2hArMMQnXJHMbD9DkmlOg0Nux+EBw6RM5YQVzeMh
         un9Q==
X-Gm-Message-State: AOJu0YyYxuixQFsp4+QPBwCsB4tXZLXVCYFAx6CCNywmOsU+JvmCQS9Y
	NggFBSfAbXSeS0b6awb6o+JzE1luHKNM9UydhPg=
X-Google-Smtp-Source: AGHT+IGLvZpGisHdwDgo2Y0SziAvMNKnEliIX1xKWyvKqW5G5LBglFRZaSyyNJvUKjKPL3X07UwZlEBQIGeZH6cHr8M=
X-Received: by 2002:a05:6122:3c81:b0:49a:9146:ec02 with SMTP id
 fy1-20020a0561223c8100b0049a9146ec02mr14211067vkb.1.1698170149348; Tue, 24
 Oct 2023 10:55:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1698152926.git.ps@pks.im> <7e6ab5dee230dcb66cb8adfe4a8114a06c805802.1698152926.git.ps@pks.im>
In-Reply-To: <7e6ab5dee230dcb66cb8adfe4a8114a06c805802.1698152926.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 24 Oct 2023 13:55:38 -0400
Message-ID: <CAPig+cQ2MgR_1Z+zscC+Acy8PVe4ZNLtMVDpCSK6SDm+4e968g@mail.gmail.com>
Subject: Re: [PATCH 02/12] builtin/show-ref: split up different subcommands
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Han-Wen Nienhuys <hanwen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 9:10=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> While not immediately obvious, git-show-ref(1) actually implements three
> different subcommands:
>
>     - `git show-ref <patterns>` can be used to list references that
>       match a specific pattern.
>
>     - `git show-ref --verify <refs>` can be used to list references.
>       These are _not_ patterns.
>
>     - `git show-ref --exclude-existing` can be used as a filter that
>       reads references from standard input, performing some conversions
>       on each of them.
>
> Let's make this more explicit in the code by splitting up the three
> subcommands into separate functions. This also allows us to address the
> confusingly named `patterns` variable, which may hold either patterns or
> reference names.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> @@ -142,6 +142,53 @@ static int exclude_existing(const char *match)
> +static int cmd_show_ref__verify(const char **refs)
> +{
> +       if (!refs || !*refs)
> +               die("--verify requires a reference");
> +
> +       while (*refs) {
> +               struct object_id oid;
> +
> +               if ((starts_with(*refs, "refs/") || !strcmp(*refs, "HEAD"=
)) &&
> +                   !read_ref(*refs, &oid)) {
> +                       show_one(*refs, &oid);
> +               }
> +               else if (!quiet)
> +                       die("'%s' - not a valid ref", *refs);
> +               else
> +                       return 1;
> +               refs++;
> +       }

A couple style-nits here caught my attention...

- "}" and "else" should be cuddled: `} else if`

- coding guidelines these days want braces on all branches if any
branch needs them

However, since this code is merely being relocated from elsewhere in
this file and since these style-nits were already present, moving the
code verbatim without correcting the style problems is more
reviewer-friendly. Okay.

> +       return 0;
> +}
> +
> +static int cmd_show_ref__patterns(const char **patterns)
> +{
> +       struct show_ref_data show_ref_data =3D {
> +               .patterns =3D (patterns && *patterns) ? patterns : NULL,
> +       };

Are we allowing non-constant initializers in the codebase? If not,
this should probably initialize .patterns to NULL and then
conditionally assign `patterns` separately in code below the
initializer.

> +       if (show_head)
> +               head_ref(show_ref, &show_ref_data);
> +       if (heads_only || tags_only) {
> +               if (heads_only)
> +                       for_each_fullref_in("refs/heads/", show_ref, &sho=
w_ref_data);
> +               if (tags_only)
> +                       for_each_fullref_in("refs/tags/", show_ref, &show=
_ref_data);
> +       } else {
> +               for_each_ref(show_ref, &show_ref_data);
> +       }
> +       if (!found_match) {
> +               if (verify && !quiet)
> +                       die("No match");
> +               return 1;
> +       }
> +
> +       return 0;
> +}
