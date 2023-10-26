Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E89156FA
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 17:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261AB1B6
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 10:18:59 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-66d24ccc6f2so19042746d6.0
        for <git@vger.kernel.org>; Thu, 26 Oct 2023 10:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698340738; x=1698945538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9GUFG/Kymfj5jI21E9lAikkB8aj+p5IJ8qNgXfNI8DE=;
        b=uEJB1gJfSOjMzilMEVGadCBE4IPZcWGSA8FEjCh+OaOASbo1n1w5BU6Vmohk+ITF/6
         vdyQkmuaN6kBRid/iVRzej72CCp1Le5BMpkXwSHSUibF7b3HX5k+49uraAgZmvdYykIh
         IvGJfpkmwy6Z9RTfImKlKT2MjUBRRnM7e4DU4Mki7KabtOMCgbVOeyN2cVqMfCZNLc8d
         IDMC0GrcxRpNp//iUhKrx95wSVJBGIu0rS6VZwcgJ+LIRnqEPiavoBkfN9GKBw93vCUD
         z7sYKI0Pg3YzOWhmDjfoZrrK1asprmf/HV4LH9+oirzOHo5NBlaEYkIcOIKe4W+57X9f
         gybQ==
X-Gm-Message-State: AOJu0YykFUx2nIqG5bJy4YDf8whmZu0IH0X/H2Ehft1lMz2NH4QCNjv+
	QUDUbBehg+5zQqTtZmTpyl90CJxHcKfu4erurD8=
X-Google-Smtp-Source: AGHT+IHjpI0wqAOxYh6jLyXinsIePxejlJfGi/qdMChEee7IzBH0CxlDV1AoA/FcOFfYGX/JHjLXpN7Ck36NPMD5+YA=
X-Received: by 2002:a05:6214:1316:b0:66f:ac58:69d4 with SMTP id
 pn22-20020a056214131600b0066fac5869d4mr634987qvb.1.1698340738102; Thu, 26 Oct
 2023 10:18:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026005542.872301-1-nasamuffin@google.com> <20231026155459.2234929-1-nasamuffin@google.com>
In-Reply-To: <20231026155459.2234929-1-nasamuffin@google.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 26 Oct 2023 13:18:46 -0400
Message-ID: <CAPig+cTmYtWR=QN3LeN9yw3HmsKEmD2fUiRjKf=eJHhAZyT-yA@mail.gmail.com>
Subject: Re: [PATCH v3] bugreport: reject positional arguments
To: emilyshaffer@google.com
Cc: git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>, Sheik <sahibzone@gmail.com>, 
	Dragan Simic <dsimic@manjaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 11:55=E2=80=AFAM <emilyshaffer@google.com> wrote:
> git-bugreport already rejected unrecognized flag arguments, like
> `--diaggnose`, but this doesn't help if the user's mistake was to forget
> the `--` in front of the argument. This can result in a user's intended
> argument not being parsed with no indication to the user that something
> went wrong. Since git-bugreport presently doesn't take any positionals
> at all, let's reject all positionals and give the user a usage hint.
>
> Signed-off-by: Emily Shaffer <nasamuffin@google.com>
> ---
> Per Eric's and Dragan's comments, dropped the null checking for argv[0].
> No point in being too paranoid, I suppose :)
>
> Note that after this morning it's not likely that I'll be able to find
> time to update this again so quickly, so if there are other nits,
> reviewers can feel free to send their own rerolls rather than waiting
> for me to see it and turn the patch around.

Thanks. This version looks good enough to me. Just one minor comment below.=
..

> diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
> @@ -69,6 +69,13 @@ test_expect_success 'incorrect arguments abort with us=
age' '
> +test_expect_success 'incorrect positional arguments abort with usage and=
 hint' '
> +       test_must_fail git bugreport false 2>output &&
> +       test_i18ngrep usage output &&
> +       test_i18ngrep false output &&
> +       test_path_is_missing git-bugreport-*
> +'

I didn't really pay attention to the test in earlier rounds so didn't
notice this, but these days we just use 'grep' rather than
'test_i18ngrep'. (Indeed, the existing tests in this script use
'grep'.)
