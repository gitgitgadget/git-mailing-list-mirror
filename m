Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413CB39FC5
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 19:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-680b1956ca4so24149006d6.3
        for <git@vger.kernel.org>; Tue, 09 Jan 2024 11:24:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704828246; x=1705433046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cCQZUC5L0sHDTvhZm7dorU5kX35VRWL9xSTHPxYnkKk=;
        b=DCwqajC5tThIOGjgto0aSiPlQhVp0z21x/HHGOaciqPWFSm7myhMph1wrtrC97aau7
         WMMORY9TtzRs9EuvIlzTzatxu84G8TnsOPw2d0hVD3hg7J3Xv0gExURLY+R2PhXRWe5w
         2ZCNcwvtsWx4CEszVQkDbIa2AbtW5vGC4Q7a6TEpvMSJZ5DV38r4rNb/L0CW3Q50rQTI
         cuOCuRyoFMI6pyQKLn4+67x01iy2ENnExMcyK+9WFUM/TbXwvWtXJJfJ3F9nFRxeEwRk
         iHDOZ9P4rmACq7n7k3a3voq2tEExF2XUT+beoW9MORY3/Eya8xyB28Yi0wkF3XE05Fk4
         cevw==
X-Gm-Message-State: AOJu0Yx5g5ILO3kdUlUnndofVRf/l8mbKPJsMth5n7+hddxtDziaEZ1B
	4owut68Nu644hCVMiPtIk+aS9YUv+YSdP2iqPSDaHsw+1ME=
X-Google-Smtp-Source: AGHT+IH6F/NxT91DUodJxpFyWPyJO9fDDZs89z6/dAoceoP1AgzwnbW3ZhwhAt/beLKLpolBr5SIqrqjMEzTyRCUx14=
X-Received: by 2002:a05:6214:1d2e:b0:680:c829:7169 with SMTP id
 f14-20020a0562141d2e00b00680c8297169mr7865824qvd.82.1704828246102; Tue, 09
 Jan 2024 11:24:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1704802213.git.ps@pks.im> <51e494a50e4416ed0cbfd3c474ffcaf8b72e6ef4.1704802213.git.ps@pks.im>
In-Reply-To: <51e494a50e4416ed0cbfd3c474ffcaf8b72e6ef4.1704802213.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 9 Jan 2024 14:23:55 -0500
Message-ID: <CAPig+cTB5OH1hCD-EagxNAcaw1=RR7yCeeZ_AzeqHtFTGxT-0g@mail.gmail.com>
Subject: Re: [PATCH 5/6] t5526: break test submodule differently
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 7:17=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
> In 10f5c52656 (submodule: avoid auto-discovery in
> prepare_submodule_repo_env(), 2016-09-01) we fixed a bug when doing a
> recursive fetch with submodule in the case where the submodule is broken
> due to whatever reason. The test to exercise that the fix works breaks
> the submodule by deleting its `HEAD` reference, which will cause us to
> not detect the directory as a Git repository.
>
> While this is perfectly fine in theory, this way of breaking the repo
> becomes problematic with the current efforts to introduce another refdb
> backend into Git. The new reftable backend has a stub HEAD file that
> always contains "ref: refs/heads/.invalid" so that tools continue to be
> able to detect such a repository. But as the reftable backend will never
> delete this file even when asked to delete `HEAD` the current way to
> delete the `HEAD` reference will stop working.

This patch is not the appropriate place to bikeshed (but since this is
the first time I've read or paid attention to it), if I saw "ref:
refs/heads/.invalid", the word ".invalid" would make me think
something was broken in my repository. Would it make sense to use some
less alarming word, such as perhaps ".placeholder", ".stand-in",
".synthesized" or even the name of the non-file-based backend in use?

> Adapt the code to instead delete the objects database. Going back with
> this new way to cuase breakage confirms that it triggers the infinite
> recursion just the same, and there are no equivalent ongoing efforts to
> replace the object database with an alternate backend.

s/cuase/cause/

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
> @@ -771,7 +771,7 @@ test_expect_success 'fetching submodule into a broken=
 repository' '
>         # Break the receiving submodule
> -       test-tool -C dst/sub ref-store main delete-refs REF_NO_DEREF msg =
HEAD &&
> +       rm -r dst/sub/.git/objects &&

If there is no guarantee that .git/objects will exist when any
particular backend is in use, would it be more robust to use -f here,
as well?

    rm -rf dst/sub/.git/objects &&
