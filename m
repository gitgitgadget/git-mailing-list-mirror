Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC4619C
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 02:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E07AB0
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 19:42:31 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-41cd4446cf5so10795231cf.3
        for <git@vger.kernel.org>; Thu, 26 Oct 2023 19:42:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698374550; x=1698979350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QpucwOvvhNkj3g6wqY6kU1uj343BnJydWpcszfiGW3o=;
        b=CiY4dgaeZvphm4DS6k81z2Js2JQOIgeKE1WeU7YLDFdENkUaUlBKjCg+uYEZn0qG1F
         mbZvsdNVKi46RJj6IYxE+OVziDkZKwJxwtR41ApjJCgcobfagECK41ell+Zz6rzmPUo/
         nv/oo90gUEyDtddpsq7F79ao13/e6FU578LTwvAg9tztBbza1MtQNSJvNyitrsmcdKh6
         xer1vY+zFBlQr9aRD1eplpkRjdgTUzuY7ThrILX9zbOM2YJ+oGObYUYLh+Ujo/4beRi9
         OtDlqfqDTz8NN18N8bFZkxIJsPHaxpXfJS/J366YjujNnCUduvDoWtO0qvSDM58DGYAL
         eKcw==
X-Gm-Message-State: AOJu0YxR+Qtn33d/MrC1IoCVdWQNKctRkq/4FiK7pMP4V56tpHgbKZit
	w2Wb6b2iwsxb3EZ4TXkooYs2MRVymGaPt5F3cpc=
X-Google-Smtp-Source: AGHT+IEcue0zyiC9PvZcTq1LCS9aPzR3p0UKMRFxn8hMj5K1NgHk6fOIlCZ6R/77nXreqnL8pBpV/rGa4wONBvDQCUo=
X-Received: by 2002:a05:6214:1316:b0:65b:259f:d6a9 with SMTP id
 pn22-20020a056214131600b0065b259fd6a9mr1811005qvb.7.1698374549979; Thu, 26
 Oct 2023 19:42:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1697607222.git.ps@pks.im> <cover.1698156169.git.ps@pks.im> <089565a358eb28544f0ad6b83b8c47e1edf2db6f.1698156169.git.ps@pks.im>
In-Reply-To: <089565a358eb28544f0ad6b83b8c47e1edf2db6f.1698156169.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 26 Oct 2023 22:42:18 -0400
Message-ID: <CAPig+cTbtT1xu+CcypmPYuvxhtY8VE3SfGppshL7QmvaervaTg@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] t1450: convert tests to remove worktrees via git-worktree(1)
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>, Taylor Blau <me@ttaylorr.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 10:05=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
> Some of our tests in t1450 create worktrees and then corrupt them.
> As it is impossible to delete such worktrees via a normal call to `git
> worktree remove`, we instead opt to remove them manually by calling
> rm(1) instead.
>
> This is ultimately unnecessary though as we can use the `-f` switch to
> remove the worktree. Let's convert the tests to do so such that we don't
> have to reach into internal implementation details of worktrees.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> @@ -141,7 +141,7 @@ test_expect_success 'HEAD link pointing at a funny pl=
ace' '
>  test_expect_success 'HEAD link pointing at a funny object (from differen=
t wt)' '
>         test_when_finished "git update-ref HEAD $orig_head" &&
> -       test_when_finished "rm -rf .git/worktrees wt" &&
> +       test_when_finished "git worktree remove -f wt" &&
>         git worktree add wt &&
>         echo $ZERO_OID >.git/HEAD &&

Technically, this is a change of behavior since the original code
removed the entire .git/worktrees directory, which deleted
administrative metainformation for _all_ worktrees, whereas the new
code only deletes administrative metadata for the mentioned worktree.
However, since there are no other existing worktrees at this point in
any of these tests, the result is functionally the same, so the change
of behavior is immaterial. Moreover, the revised code has a smaller
blast-radius, which may be a desirable property since there has been
some movement toward making tests more self-contained so that they can
be run individually more easily.
