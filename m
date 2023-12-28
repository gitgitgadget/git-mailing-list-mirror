Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2729FF9D7
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 18:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-78106c385a1so582739985a.0
        for <git@vger.kernel.org>; Thu, 28 Dec 2023 10:08:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703786916; x=1704391716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZjjG2fYdP0Y1PWHQN0pCcYOiZjL/pfg9QjxeKJ5iSJw=;
        b=LebsLB3kdTaWJtv3C6i9zrOuWzQ3jRfE5rRoNyHl230+c387etluZQFcvOU1zpbrMR
         cbscx7veVn76Q19wbujKm0noTNTq+lMBJCCCdcKjYpF4MdQjxLWJnSh4kTQjTQhCNLaT
         jrW/GjwosB1eO1esx6xal8eZPuXHcSmwfxrKI0350p/MpalFG5w7DRSgEDU/atIWpldX
         NVrszQSl/+pHc3jLMuywrjm9CSG17YN6+oUD/XiKPyEAoxfwWx/q/sa0ZxiLG4Ol3LO4
         rlbtMtQnULejhWRnmqEJ6dDjXh+AO7yoAFLznaTyDW0uvVp3ARpOL9JLmuLfg6kwrQ1/
         UuuQ==
X-Gm-Message-State: AOJu0Yy7Ad96IUPNv5eT5foH/dt/kyHR4dwA5Nw6Brc+qzNWFxOWnCdB
	q1cSKUwwPUV27EoLfcvQv8whJBqUVbwSD7pv1R7qizYscp8=
X-Google-Smtp-Source: AGHT+IGJUDKlGsAknfJkbqajnaDdkXR+ItirFu0s1eDwrZQW8lDH2vYmLvFHP+WvnzgrSt0MLIqlTq26OR+HKMejAtg=
X-Received: by 2002:a05:6214:2a47:b0:67f:3cc6:4420 with SMTP id
 jf7-20020a0562142a4700b0067f3cc64420mr19030066qvb.2.1703786915921; Thu, 28
 Dec 2023 10:08:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1703067989.git.ps@pks.im> <cover.1703753910.git.ps@pks.im> <ecf4f1ddee36643f0ff7e3d40b9aa7c7e6e6ce43.1703753910.git.ps@pks.im>
In-Reply-To: <ecf4f1ddee36643f0ff7e3d40b9aa7c7e6e6ce43.1703753910.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 28 Dec 2023 13:08:24 -0500
Message-ID: <CAPig+cT6mRyJijL1qo2g56Yny-JxkDYjjmGpAncyS_4Hcpaz6Q@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] worktree: skip reading HEAD when repairing worktrees
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 4:57=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> When calling `git init --separate-git-dir=3D<new-path>` on a preexisting
> repository, we move the Git directory of that repository to the new path
> specified by the user. If there are worktrees present in the repository,
> we need to repair the worktrees so that their gitlinks point to the new
> location of the repository.
>
> This repair logic will load repositories via `get_worktrees()`, which
> will enumerate up and initialize all worktrees. Part of initialization
> is logic that we resolve their respective worktree HEADs, even though
> that information may not actually be needed in the end by all callers.
>
> In the context of git-init(1) this is about to become a problem, because
> we do not have a repository that was set up via `setup_git_directory()`
> or friends. Consequentially, it is not yet fully initialized at the time
> of calling `repair_worktrees()`, and properly setting up all parts of
> the repository in `init_db()` before we repair worktrees is not an easy
> thing to do. While this is okay right now where we only have a single
> reference backend in Git, once we gain a second one we would be trying
> to look up the worktree HEADs before we have figured out the reference
> format, which does not work.

s/Consequentially/Consequently/

I found it difficult to digest this paragraph with its foreshadowing
phrase "about to become a problem" since it wasn't apparent until the
very final sentence in the paragraph what the actual problem would be.
Perhaps if you mention early on that the reftable backend will have
trouble with the current code, it would be easier to grasp. Maybe
something like this:

    Although not a problem presently with the file-based reference
    backend, it will become a problem with the upcoming reftable
    backend.  In the context of git-init(1) a fully-materialized
    repository set up via `setup_git_directory()` or friends is not
    yet present.  Consequently, it is not yet fully initialized at the
    time `repair_worktrees()` is called, and properly setting up all
    parts of the repository in `init_db()` before we repair worktrees
    is not an easy task.  With introduction of the reftable backend,
    it would try to look up the worktree HEADs before we have figured
    out the reference format, thus would not work.

> We do not require the worktree HEADs at all to repair worktrees. So
> let's fix this issue by skipping over the step that reads them.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> diff --git a/worktree.c b/worktree.c
> @@ -51,7 +51,7 @@ static void add_head_info(struct worktree *wt)
> -static struct worktree *get_main_worktree(void)
> +static struct worktree *get_main_worktree(int skip_reading_head)
>  {
> -       add_head_info(worktree);
> +       if (!skip_reading_head)
> +               add_head_info(worktree);

This is so special-case that it feels more than a little dirty.

> @@ -591,7 +599,7 @@ static void repair_noop(int iserr UNUSED,
>  void repair_worktrees(worktree_repair_fn fn, void *cb_data)
>  {
> -       struct worktree **worktrees =3D get_worktrees();
> +       struct worktree **worktrees =3D get_worktrees_internal(1);

In an ideal world, a repair function should not be calling
get_worktrees() at all since get_worktrees() is not tolerant of
corruption of the worktree administrative files. (Plus, as you note,
it does more work than necessary for the current set of repairs
performed by `git worktree repair`.)

Even as I was implementing the worktree repair code, I wavered back
and forth multiple times between calling get_worktrees() and writing a
custom corruption-tolerant function to retrieve worktree
administrative information. In the end, I opted for get_worktrees()
for the pragmatic reason that it allowed me to narrow the scope of the
patches to the types of repairs which were the current focus without
getting mired down in the involved details of writing a
corruption-tolerant function for retrieving worktree metadata.
However, that decision was made with the understanding that the
pragmatic choice of the moment would not rule out the possibility of
returning later and implementing the more correct approach of having a
corruption-tolerant function for retrieving worktree metadata.

The special-case ugliness of this patch suggests strongly in favor of
implementing the earlier-envisioned corruption-tolerant function for
retrieving worktree metadata rather than the band-aid approach taken
by this patch. The generic name get_worktrees_internal() isn't helpful
either; it doesn't do a good job of conveying any particular meaning
to the reader.

Having said all that, I'm not overly opposed to this patch, especially
since your main focus is on getting the reftable backend integrated,
and because the changes (and ugliness) introduced by this patch are
entirely self-contained and private to worktree.c, so are not a
show-stopper by any means. Rather, I wanted to get down to writing
what I think would be a better future approach if someone gets around
to tackling it. (There is no pressing need at the moment, and that
someone doesn't have to be you.)
