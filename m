Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EF7522C
	for <git@vger.kernel.org>; Fri,  5 Jan 2024 02:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7810c332a2cso81830585a.1
        for <git@vger.kernel.org>; Thu, 04 Jan 2024 18:43:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704422631; x=1705027431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VbP9tRsBixR+kf1vDod/T5U9rOSwcxUczOkfuFHuMOQ=;
        b=rD8vHswOgHt2t7hwvc0QofZ55TjhU5azWFRKULWtEP1Q4b1Ubo44IKZbEb2kClthgb
         AJWBgITBlL4VkSrH71ngn6mEDwVbmhsnDo9hjpi798tJloSA5tYlVOpiHTzcG2e3gmZG
         YuJo1JKRqhPC0liFp+5HzRSuvvyus+ZS/YfJsSh4bziEQna21/w212d/unP+FiRnZokl
         88YC6SSeAmDOJOrod3y4vzaiUhFKJIhdn4Ohdw3F79Fn9GiQNnGRRGiXjaVn5k06Hj6/
         kAlxDMQ+DBQO26bvRkrV+AOEYWoRSy/BFNK0n8F8EZTIQYT+oyelUWIKNXBzv1U4GHIe
         wBHA==
X-Gm-Message-State: AOJu0YxQtlfVEzjdjJyq2uRYpPgFy/qCsBKIrfiYcwqQjyqfNqLbQpXq
	G3b0j6pGbdlnkoh+1nTbkFyP/yTrVsZCbLNQ7duM7riAtho=
X-Google-Smtp-Source: AGHT+IEldzjvcRDT8Y50GkhprihIK+rSYJfUFCdF1zVAXJDlCS9S/+JWbiUsKBUXoaTg/plaPLFYyLD1kWMgyOdk3Yc=
X-Received: by 2002:ad4:4ee6:0:b0:680:82d9:edd6 with SMTP id
 dv6-20020ad44ee6000000b0068082d9edd6mr1861619qvb.98.1704422631036; Thu, 04
 Jan 2024 18:43:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cc74dc58-4fbe-470d-a212-4c2d2249918c@tb6.eu> <20240104222259.15659-1-dev@tb6.eu>
 <20240104222259.15659-2-dev@tb6.eu>
In-Reply-To: <20240104222259.15659-2-dev@tb6.eu>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 4 Jan 2024 21:43:39 -0500
Message-ID: <CAPig+cRo6pFnPN6PDka+jEJ2Y5O1KSgtzwdPcTpamM=-p_hkcQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fetch: add cli option --default-only
To: Tamino Bauknecht <dev@tb6.eu>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 5:23=E2=80=AFPM Tamino Bauknecht <dev@tb6.eu> wrote:
> This option can be used to restore the default behavior of "git fetch"
> if the "fetch.all" config option is enabled.
> The flag cannot be used in combination with "--all" or explicit
> remote(s).
>
> Signed-off-by: Tamino Bauknecht <dev@tb6.eu>
> ---
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> @@ -2344,15 +2347,23 @@ int cmd_fetch(int argc, const char **argv, const =
char *prefix)
> +       if (all && default_only) {
> +               die(_("fetch --all does not work with fetch --default-onl=
y"));

To simplify the life of people who translate Git messages into other
languages, these days we have standard wording for this type of
message, and we extract the literal option from the message itself.
So, this should be:

    die(_("options '%s' and '%s' cannot be used together"),
        "--all", "--default-only");

> diff --git a/t/t5514-fetch-multiple.sh b/t/t5514-fetch-multiple.sh
> @@ -304,4 +304,45 @@ test_expect_success 'git config fetch.all false (fet=
ch only default remote)' '
> +for fetch_all in true false
> +do
> +       test_expect_success "git fetch --default-only (fetch only default=
 remote with fetch.all =3D $fetch_all)" '
> +               test_dir=3D"test_default_only_$fetch_all" &&
> +               setup_test_clone "$test_dir" &&
> +               (
> +                       cd "$test_dir" &&
> +                       git config fetch.all $fetch_all &&
> +                       git fetch --default-only &&
> +                       cat >expect <<-\EOF &&
> +                         origin/HEAD -> origin/main
> +                         origin/main
> +                         origin/side
> +                       EOF
> +                       git branch -r >actual &&
> +                       test_cmp expect actual
> +               )
> +       '
> +done

Do you also want to test the case when "fetch.all" isn't set?

> +test_expect_success 'git fetch --all does not work with --default-only' =
'
> +       (
> +               cd test &&
> +               test_must_fail git fetch --all --default-only
> +       )
> +'

Minor point: This sort of test can be written more succinctly without
the subshell:

    test_expect_success 'git fetch --all does not work with --default-only'=
 '
        test_must_fail git -C test fetch --all --default-only
    '
