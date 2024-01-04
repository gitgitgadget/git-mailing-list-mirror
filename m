Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22321E526
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 20:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-67f7bd86cafso4322496d6.0
        for <git@vger.kernel.org>; Thu, 04 Jan 2024 12:50:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704401455; x=1705006255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYMMIUXQZKBXGYbzGrtdJ0gFYp+LsSYla/y2fl71p7A=;
        b=WX/v6KO8eTjs0UblpCO75nIDNfQcDp01rgmADvsrYCnUHPfl9FpmwJbrAH/Bp36sFZ
         AxpB04hXsN1dF7besiPKqIvSpSecMPzJvg7MsKUTiPnoB64V3xd99EZlWbjxWmYC842d
         cAtoPShS3tfHE6YJFu0H9Qou4/SVz5WAK5Jf9mizr3Ay0ptzVIhwR5MmhPGl0H/xL7QH
         lC+UYMGoUNCzXq0EDHxoq7BBysKKMTuB6mPHlzkpNcu1q8bLof7wOJ35qbfZ7/paXZz7
         N1h95VdhotK2Xt4nC4M4rkhWNGvhE+ZIMwhrFvd4WZxb0MVxXoSeZGBmycLTe++NJyi4
         W8vA==
X-Gm-Message-State: AOJu0YyWCSnChiMPyehhxsXqqftwJY1Yh7bF3kxEjy0u+cNZocJYvRnD
	BaC3yTPvXSCbKr2VR0mIcwtWd4qW7w+siuHUE1jLZBwi
X-Google-Smtp-Source: AGHT+IExhNd3ZOGNBUJzsdy8q87tQCkYsRONHAGDtRUDDvQRB6iICaTPav8srdqRJhIzdPjysEbnYSITxx+cg13TONc=
X-Received: by 2002:ad4:5945:0:b0:67f:6bd0:493b with SMTP id
 eo5-20020ad45945000000b0067f6bd0493bmr1161800qvb.43.1704401454806; Thu, 04
 Jan 2024 12:50:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cc74dc58-4fbe-470d-a212-4c2d2249918c@tb6.eu> <20240104202605.7382-1-dev@tb6.eu>
In-Reply-To: <20240104202605.7382-1-dev@tb6.eu>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 4 Jan 2024 15:50:43 -0500
Message-ID: <CAPig+cSkNVt0P=38X_h3VShirwCDA7UR1SB0Sb7VkBgV5-AGyQ@mail.gmail.com>
Subject: Re: [PATCH] fetch: add new config option fetch.all
To: Tamino Bauknecht <dev@tb6.eu>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 3:26=E2=80=AFPM Tamino Bauknecht <dev@tb6.eu> wrote:
> I'm still not entirely happy with the tests (especially the `cp` in
> there)

Easily enough solved; see below...

> and the heredoc doesn't seem to respect the one additional
> space of its indentation - I am admittedly not the best POSIX shell
> developer, if anyone has an idea on how to improve it, your suggestion
> is welcome.

Not sure what you mean by the heredoc not "respecting one additional
space of indentation".

The <<- operator strips leading TABs from the body of the heredoc but
leaves other leading whitespace alone. In your tests, you have one or
more TABs followed by two spaces, followed by the remaining (actual)
text. So, with the leading TABs stripped off by the <<- operator,
you're left with the two spaces and the remaining text, which is
exactly what you want.

> diff --git a/t/t5514-fetch-multiple.sh b/t/t5514-fetch-multiple.sh
> @@ -209,4 +218,70 @@ test_expect_success 'git fetch --multiple --jobs=3D0=
 picks a default' '
> +for fetch_all in true false
> +do
> +       test_expect_success "git fetch --all (works with fetch.all =3D $f=
etch_all)" '
> +               test_dir=3D"test_fetch_all_$fetch_all" &&
> +               setup_test_clone "$test_dir" && (
> +                cd "$test_dir" &&
> +                git config fetch.all $fetch_all &&
> +                git fetch --all &&
> +                cat >expect <<-\ EOF &&
> +                 one/main
> +                 one/side
> +                 origin/HEAD -> origin/main
> +                 origin/main
> +                 origin/side
> +                 three/another
> +                 three/main
> +                 three/side
> +                 two/another
> +                 two/main
> +                 two/side
> +                EOF
> +                git branch -r >actual &&
> +                test_cmp expect actual)
> +       '
> +done
> +
> +test_expect_success 'git fetch (fetch all remotes with fetch.all =3D tru=
e)' '
> +       setup_test_clone test9 && (
> +        cd test9 &&
> +        git config fetch.all true &&
> +        git fetch --all &&
> +        git branch -r >actual &&
> +        cp ../test_fetch_all_true/expect . &&
> +        test_cmp expect actual)
> +'

Ideally, this test should create the "expect" file itself, even if the
"expect" file happens to exactly match the "expect" file from the
preceding test. Doing so will make the test (more) self-contained,
which makes it possible to run the test in isolation without having to
run all tests preceding it (see the --run option in t/README).
