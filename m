Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D006FBC
	for <git@vger.kernel.org>; Sat,  4 Nov 2023 06:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8159125
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 23:16:11 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-66cfd35f595so16028826d6.2
        for <git@vger.kernel.org>; Fri, 03 Nov 2023 23:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699078571; x=1699683371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nyPs1ItLQn9I8kOl/VAdUyIzL4Ryg6n/KZZaUtHZ2aw=;
        b=bGEjNvpRQr4Nm/Pbb+d8kqgZafQxYNU4505NJV3rG5F6YqZZPBk+2gbFJzB3ZBxDyG
         hr6guxqK3NxvknllkuqOq4AV44Nqk5zlF/UAWNpRdFxJV7zkGKLbM2lAuKhtgD6iGLT0
         GbU6LUKFmCmALvINbmDNeiz6TjmbC9/sHpbHszLhvsbRM7sGGvBkNYIgorN0q+cz54Vk
         sXXxHxhOGPw1VXAas2J/tNDc950vTDAt2UfKcoFRZuGJwSrWF3CKjXetcDHtUkEe7fKn
         0xIyBfQRguudPlcLwolkGQHLovZZ2wvc5snjJoPz42yp8SJdIgQUY13kgfazH5JHr9VI
         W1lA==
X-Gm-Message-State: AOJu0YwMHWozUI01FSm8p3EULdc42tCsvCCXdbtTcTa06dJgNuLxrMFY
	zBJT3CJnv/wTyMRoY1iURDinVnH2peS6xuli+QhwwSqqfVo=
X-Google-Smtp-Source: AGHT+IH7d8jVs1Q2K/lT7iEjbCOS36MzzxxFZm7qk2iygzAMe7nQ0jZsybzY3qhKrqQQkoGszw5Ayvm4NzyE+yjW1AY=
X-Received: by 2002:a05:6214:cc4:b0:672:4404:c109 with SMTP id
 4-20020a0562140cc400b006724404c109mr22753870qvx.24.1699078570553; Fri, 03 Nov
 2023 23:16:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231104000209.916189-1-eantoranz@gmail.com>
In-Reply-To: <20231104000209.916189-1-eantoranz@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 4 Nov 2023 02:15:59 -0400
Message-ID: <CAPig+cTL6b5ANb-KJt7ZMkfmJ3X3-FMSXu-ThaQaFAdGV73www@mail.gmail.com>
Subject: Re: [RFC PATCH] status: avoid reporting worktrees as "Untracked files"
To: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 8:03=E2=80=AFPM Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> Given that worktrees are tracked in their own special fashion separately,
> it makes sense to _not_ report them as "untracked". Also, when seeing the
> directory of a worktree listed as Untracked, it might be tempting to try
> to do operations (like 'git add') on them from the parent worktree which,
> at the moment, will silently do nothing.
>
> With this patch, we check items against the list of worktrees to add
> them into the untracked items list effectively hiding them.
>
> END OF PATCH
>
> Here are a few questions more inline with the "RFC" part of the patch.
>
> About UI
> - Would it make more sense to separate them from Untracked files instead
>   of hiding them (perhaps add a --worktrees option to display them)?
> - Follow-up if the previous answer is 'yes': List a worktree only if it
>   is not clean?
>
> About code:
> - If keeping the idea/patch, Would it make more sense (performance-wise) =
to
>   fist check an item in the list of worktrees before checking it in the
>   index? In other words, reverse the conditions to add an item to the
>   untracked list?

I have slightly mixed feelings about this idea since I'm sympathetic
to the motivation, however, my knee-jerk reaction is that these really
_are_ untracked considering that Git is a "content tracker" and
worktrees are not project content. Git already has general mechanisms
such as .git/info/exclude and .gitignore for suppressing certain
untracked items, so introducing special-purpose code to suppress
worktrees from being considered untracked may be a case of adding
complexity for little gain.

Moreover, although your personal workflow may be to create worktrees
within your main directory:

    git worktree add new-feature

other people use a workflow in which worktrees are created at other
locations, such as making them siblings:

    git worktree add ../new-feature

For the former case, it's easy enough to mention worktrees in
.git/info/exclude, especially if you use a standard naming convention
for your worktrees, in which case a single wildcard pattern may allow
you to set it once and forget about it. For the latter workflow, the
extra "is untracked" checking is simply wasteful.

Having said all that, I think that someone may have recently floated
the idea on the mailing list about suppressing dirty submodules from
showing up as "dirty" in git-status. Although the underlying concepts
and mechanisms are quite distinct (especially since a submodule _is_
content), perhaps there is some sort of analogy between worktrees and
dirty submodules which invalidates my knee-jerk reaction. Also, I'm
just one person responding without having put all that much thought
into it. Others may feel differently.

Regarding the patch itself...

> diff --git a/wt-status.c b/wt-status.c
> @@ -795,9 +796,12 @@ static void wt_status_collect_untracked(struct wt_st=
atus *s)
> +       worktrees =3D get_worktrees();
> +
>         for (i =3D 0; i < dir.nr; i++) {
>                 struct dir_entry *ent =3D dir.entries[i];
> -               if (index_name_is_other(istate, ent->name, ent->len))
> +               if (index_name_is_other(istate, ent->name, ent->len) &&
> +                   !find_worktree_by_path(worktrees, ent->name))
>                         string_list_insert(&s->untracked, ent->name);
>         }

This first-stab implementation unfortunately has worse than quadratic
complexity, perhaps even cubic complexity since
find_worktree_by_path() performs a linear scan through the worktree
list. So, for each path in `dir`, it's performing a
character-by-character string comparison with each path in
`worktrees`. Worse, find_worktree_by_path() calls strbuf_realpath()
which hits the filesystem for each path in `worktrees` each time it's
called.

So, a real (non-RFC) implementation would probably need to perform a
preparatory step of creating a hash-table/set in which the keys are
the realpath'd elements from `worktrees`, and then simply consult the
hash-table/set for each path in `dir`.

> @@ -809,6 +813,9 @@ static void wt_status_collect_untracked(struct wt_sta=
tus *s)
> +       if (worktrees)
> +               free_worktrees(worktrees);

Nit: At this point, we _know_ that `worktrees` is non-NULL, so
free_worktrees() can be called unconditionally.
