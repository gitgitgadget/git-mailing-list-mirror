Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E8914F6E
	for <git@vger.kernel.org>; Sun, 12 Nov 2023 17:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6009B100
	for <git@vger.kernel.org>; Sun, 12 Nov 2023 09:14:11 -0800 (PST)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-66d093265dfso23299876d6.3
        for <git@vger.kernel.org>; Sun, 12 Nov 2023 09:14:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699809250; x=1700414050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Gp94EmT6Z/t0Jax0+GJUgNkTN5qRJ6AjSTEnWNUJfo=;
        b=pRToJ1YFBQT85T9hOCpELf3AztJGaCqbbEw3WJLN2JEgnqzO5sklIRz1M6K02swZbQ
         imKzSRb6g7YCL8cMC2jAwlhndgFwjxiqph62SzbWTHs77BGyCwQh/Is5aHwIRn96xXfW
         E6v0jg4SVbdlWmPtylww85AQ/ub132MTZgH3EY7yYyBTtuU8mchfVAR3SwiYE7Mdtpqh
         2rCRMx/s2v/2+5U2CrPdZG1RoKujH5bBf9ziPZlaJLlH/ZORaIWr4UndmYDB8kb4nik0
         +A2V1XKcQ6nRYzpvWHaR+5tI1YL8I8bHFUoHQ6AtOa4Vlhanf6LaqtjxOoP3x22Ae/xX
         KsRA==
X-Gm-Message-State: AOJu0YzD0xCjqhwphy8RI9fuQ4jWnh/4Wy9YEu4j8sCd8wJbqDtWdEHU
	MK9FOVCkXsdFb2Pe4oJh3463H9WCWMuFFjFTavs=
X-Google-Smtp-Source: AGHT+IEylY0cdV80ttCnSqAikwenGDhvLNR9xQtlKXhwjFV8wmAEX+c9rLRGLiuMNol4f5KHcWw6b4csuvJ3UqIDnyQ=
X-Received: by 2002:ad4:5aec:0:b0:66d:37be:47d2 with SMTP id
 c12-20020ad45aec000000b0066d37be47d2mr6836273qvh.37.1699809250385; Sun, 12
 Nov 2023 09:14:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231104000209.916189-1-eantoranz@gmail.com> <xmqqjzqygg3i.fsf@gitster.g>
 <CAOc6etbowajhHsctFJN4ZQ0gND0jzZUrhEkep_pLYtE9y9RBCQ@mail.gmail.com>
In-Reply-To: <CAOc6etbowajhHsctFJN4ZQ0gND0jzZUrhEkep_pLYtE9y9RBCQ@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 12 Nov 2023 12:13:59 -0500
Message-ID: <CAPig+cQbwcJOQiYyb7bma3pH1hxjE_X_yeAp3JeHWVCeJtySfQ@mail.gmail.com>
Subject: Re: [RFC PATCH] status: avoid reporting worktrees as "Untracked files"
To: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 4:22=E2=80=AFAM Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> On Sat, Nov 4, 2023 at 7:58=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
> > What problem are you trying to solve?  "git add foo" where "foo" is
> > actually a different worktree of the repository would add it as a
> > submodule that causes confusion?  If that is the case, I think the
> > right solution is not to get into such a state, i.e. not create a
> > worktree of the repository inside a different worktree in the first
> > place.
> >
> Hey, guys! Thanks Junio and Eric for sharing your thoughts.
>
> I am not against the idea of creating worktrees outside of the
> repository... however, I like them to be _inside_ the repository. Am I
> the only one? IDK. I might be! It feels completely natural, if you ask
> me.... but that's just my opinion, I acknowledge that.

I doubt you're the only one, but, based upon, list emails over the
years, it seems that both in-main-tree and outside-main-tree (often
sibling) worktrees are common. More recently, we've also heard from
people who don't even have a main-worktree; instead, they hang their
multiple worktrees off of a bare repository (which is an
explicitly-supported use-case); i.e.:

    git clone --bare https://.../foobar.git
    git -C foobar.git worktree add worktree1
    git -C foobar.git worktree add worktree2
    ...
