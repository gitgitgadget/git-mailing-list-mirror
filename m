Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167EE1854
	for <git@vger.kernel.org>; Fri,  5 Jan 2024 01:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-67f83812a32so4523286d6.3
        for <git@vger.kernel.org>; Thu, 04 Jan 2024 17:02:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704416559; x=1705021359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JzvHf3QvhHxbYK4JpT9dWDmKQg1iNMEud/hHiTk6BaY=;
        b=iEUZUhtiP9I5pJdrlDbW3Tpx+h73yScWppx5H8yHEzYG9q42j72BNaXdDXNgLVC6qQ
         7OKmRc37usV/Lme0yXrXIUyMoYG3dB/i4nTIm1kkIgP4hBGATS9y6rvXwUbEOeRCq+R0
         eR53VAjyZ8JdGi1Yfx4CqGzrNN22UQflcPREjzfnUi8orUM/w1nzshSOWlLO7X6pP50w
         Kg3xgerGmiWf40AguW1jXCn7sEWnLoQ5U+Uk1PTyfoc+UKmaTUK0P+soiIVYc1O73SJX
         qhuv3ySnNm/ZTAL5QTRnWE2QKwn5rnIrzJmSyLfqJ0N70iA8U1LNGhScd1aEZiJ5U6Ao
         3nlA==
X-Gm-Message-State: AOJu0YyFnQmNRAj2BYzzhTrbzMPV+H8kfdztuC/L1mbQq3wtsun8aBUa
	f8iJNe/KJCqVWIezKjrlb1H+RfksEBwhIVjO9Cw4GLNQdNs=
X-Google-Smtp-Source: AGHT+IHNMOCYvdqqCtKySLQCfpoz86DT32RmdQIt83UkzLv9ZVuEVM9WkSFOHlB2hmub7Sq+0E48u2p3Nxa+AA6Ybc4=
X-Received: by 2002:a05:6214:d84:b0:680:d265:6652 with SMTP id
 e4-20020a0562140d8400b00680d2656652mr1363301qve.83.1704416558743; Thu, 04 Jan
 2024 17:02:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cc74dc58-4fbe-470d-a212-4c2d2249918c@tb6.eu> <20240104222259.15659-1-dev@tb6.eu>
In-Reply-To: <20240104222259.15659-1-dev@tb6.eu>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 4 Jan 2024 20:02:27 -0500
Message-ID: <CAPig+cTYAOXgqSptrRNjxzCTbotrKS08i_EdE_LYaJntcNa24Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fetch: add new config option fetch.all
To: Tamino Bauknecht <dev@tb6.eu>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 5:23=E2=80=AFPM Tamino Bauknecht <dev@tb6.eu> wrote:
> This commit introduces the new boolean configuration option fetch.all
> which allows to fetch all available remotes by default. The config
> option can be overridden by explicitly specifying a remote.
> The behavior for --all is unchanged and calling git-fetch with --all and
> a remote will still result in an error.
>
> The option was also added to the config documentation and new tests
> cover the expected behavior.
>
> Signed-off-by: Tamino Bauknecht <dev@tb6.eu>
> ---
> I fixed the formatting in the test cases and replaced the "cp" with an
> explicit "expect".

Thanks, looks better. More below...

> diff --git a/t/t5514-fetch-multiple.sh b/t/t5514-fetch-multiple.sh
> @@ -24,6 +24,15 @@ setup_repository () {
> +setup_test_clone () {
> +       test_dir=3D"$1"
> +       git clone one "$test_dir"
> +       for r in one two three
> +       do
> +               git -C "$test_dir" remote add "$r" "../$r" || return 1
> +       done
> +}

I wasn't paying attention to this function in the previous round, but
it ought to be made more robust. If the `clone` operation fails, we
want to know about it right away rather than finding out about it "by
accident" when the subsequent `remote add` operation fails. In other
words, you should maintain an unbroken &&-chain, not just in test
bodies, but also in functions which are called from within test
bodies. So, this should really be:

    setup_test_clone () {
        test_dir=3D"$1" &&
        git clone one "$test_dir" &&
        for r in one two three
        do
            git -C "$test_dir" remote add "$r" "../$r" || return 1
        done
    }

> @@ -209,4 +218,90 @@ test_expect_success 'git fetch --multiple --jobs=3D0=
 picks a default' '
> +for fetch_all in true false
> +do
> +       test_expect_success "git fetch --all (works with fetch.all =3D $f=
etch_all)" '
> +               test_dir=3D"test_fetch_all_$fetch_all" &&
> +               setup_test_clone "$test_dir" &&
> +               (
> +                       cd "$test_dir" &&
> +                       git config fetch.all $fetch_all &&
> +                       git fetch --all &&
> +                       cat >expect <<-\EOF &&
> +                         ...
> +                       EOF
> +                       git branch -r >actual &&
> +                       test_cmp expect actual
> +               )
> +       '
> +done
> +
> +test_expect_success 'git fetch (fetch all remotes with fetch.all =3D tru=
e)' '
> +       setup_test_clone test9 &&
> +       (
> +               cd test9 &&
> +               git config fetch.all true &&
> +               git fetch --all &&
> +               git branch -r >actual &&
> +               cat >expect <<-\EOF &&
> +                 ...
> +               EOF
> +               test_cmp expect actual
> +       )
> +'

I'm probably overlooking something, but isn't this testing the exact
same thing as was tested in the "true" case of the loop just above?

Or maybe there is a bug in this test and you meant `git fetch` rather
than `git fetch --all`?
