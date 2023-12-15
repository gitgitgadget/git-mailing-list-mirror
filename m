Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E6910797
	for <git@vger.kernel.org>; Fri, 15 Dec 2023 06:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-67f06da0b15so2645876d6.2
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 22:24:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702621471; x=1703226271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bladdWEcuvlcLktGVhytip7cAT9NRoV9wHkniRWSg48=;
        b=doTK7Lig4S3DciENzin1Zp/nnejnYZmWl20WXhQepSyCbGrnxMaOFMTFvZGPPwpj1D
         ecq1w9zBrIdlt1kYNW8Gj+UiAjz0W+Ye4fogtUhmqi+d54+vZ+ZtONVnFPlw7Aphmf7C
         pbJ6zxUjIOQX3F4vjCqiZam6uzz1Cvpa+i64ZSOxZBzAltt09mCKJ3/3trazmW5mDvYN
         +2q+3x+/cRmYeum/UYWLELmwevKE2GKj7EVxPg0gY6Q8YKc/TYrpwpvybYH3WYQ0D0rs
         rEygjsMe83rvaOwxcYjtLz/Rj25CCL+SZBAhbG21JEqoFPmNCseXYyGxP2qEJozm0UsD
         rFBA==
X-Gm-Message-State: AOJu0YwL/fK+7JuCnpoe9QFw1MspuHa7iVGVMjQqK7f3Ioz+jMKv2736
	7TTVfwJ0QdxW4u6Jy5JFfVBpLWXDC64mVrh7gNf96kRzaXA=
X-Google-Smtp-Source: AGHT+IFr4Ov7nqQhVHw4UcaIROTRzaMlgHEM2/AA93ZTm33p8dKeSbko1+q0S4AcfJJF9lsBAN+XSkRmiWUz2BrkPYo=
X-Received: by 2002:a05:6214:1c8e:b0:67f:1d52:2b6b with SMTP id
 ib14-20020a0562141c8e00b0067f1d522b6bmr74086qvb.34.1702621471341; Thu, 14 Dec
 2023 22:24:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4112adbe467c14a8f22a87ea41aa4705f8760cf6.1702380646.git.ps@pks.im>
 <8c3e1cb5eae13210070cc14f5f2a3f8c0dfc39c3.1702620230.git.ps@pks.im>
In-Reply-To: <8c3e1cb5eae13210070cc14f5f2a3f8c0dfc39c3.1702620230.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 15 Dec 2023 01:24:20 -0500
Message-ID: <CAPig+cQozi+aiTc5Bve4OHrfuSRGUCSkKmhoYtkGTmn64Ps-rw@mail.gmail.com>
Subject: Re: [PATCH v3] tests: adjust whitespace in chainlint expectations
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 1:04=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> [...]
> Instead of improving the detection logic, fix our ".expect" files so
> that we do not need any post-processing at all anymore. This allows us
> to drop the `-w` flag when diffing so that we can always use diff(1)
> now.
>
> Note that we leave the post-processing of `chainlint.pl` output intact.
> All we do here is to strip leading line numbers that it would otherwise
> generate.

Hmm, okay, but... (see below)

> Having these would cause a rippling effect whenever we add a
> new test that sorts into the middle of existing tests and would require
> us to renumerate all subsequent lines, which seems rather pointless.

Just an aside, not strictly relevant at this time: =C3=86var has proposed
that check-chainlint should not be creating conglomerate "test",
"expect", and "actual" files, but should instead let `make` run
chainlint.pl separately on each chainlint self-test file, thus
benefiting from `make`'s innate parallelism rather than baking
parallelism into chainlint.pl itself. More importantly, `make`'s
dependency tracking would ensure that a chainlint self-test file only
gets rechecked if its timestamp changes. That differs from the current
situation in which _all_ of the chainlint self-test files are checked
on _every_ `make test` which is wasteful if none of them have changed.
Anyhow, with his proposed approach, there wouldn't be cascading line
number changes just because a new self-test file was added.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> diff --git a/t/Makefile b/t/Makefile
> @@ -103,20 +103,12 @@ check-chainlint:
>         $(CHAINLINT) --emit-all '$(CHAINLINTTMP_SQ)'/tests | \
>                 sed -e 's/^[1-9][0-9]* //;/^[   ]*$$/d' >'$(CHAINLINTTMP_=
SQ)'/actual && \

The commit message claims that this is only stripping the line numbers
which prefix each emitted line, but the `/^[   ]*$$/d` bit is also
deleting blank lines from the output of chainlint.pl. Thus, this ought
to be:

    sed -e 's/^[1-9][0-9]* //' >'$(CHAINLINTTMP_SQ)'/actual && \
