Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B688A15E83
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 11:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B313DDB
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 04:39:37 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-66d998b5f3cso18302406d6.2
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 04:39:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698061176; x=1698665976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/kvgi0wLXimQ7CUfuMi3kR1IATQTEIs53XDtKZN5g0=;
        b=R2jYuPQkZCpHXvwlsiTRB7ZolRvEFSXRQhjlZ1I1QS/QRJhKsH6AubG8wXrCunRaKj
         fLIebAVLMTJVm/NRizvoHckgdjbcqc3vUIAFiWJzXlpiN2g66Bi7Ii+FsM4gUg9QHjEF
         t4vVnYI8SbMFAPMGx6vKZ+BRJEYTLMpkoKFlF6WDSCBpp2tA0zZ0TD+j4JDiRIETwUFm
         AzM5PIMHCX1sUBW/308Cyifl2GCeq7qbBg5KOwWeedrbeY/D8dKtvutbF4o2DKKEDEuD
         +5NKpd82QjS+oqYe+eUS0WBFTloiyI7wnwINMbL6l45Jk86+8W6C+e0zOFRzxlZJBbOZ
         8k9A==
X-Gm-Message-State: AOJu0YyOimLgAimYejr79/RFYX1sKKW+DDINKItI1+WTtQIG3oX0mKgx
	+NifznR2SznPhP6T7CkZi4IruHTmKKhYW/onjAE=
X-Google-Smtp-Source: AGHT+IHt6U7XYlV5XL9e0ODoZoYW9OXERwfus1tFurAHCQujwfyxPEpHaSMQ0LZ/Qf2rvO65cCnY+gMn1NPiv6OpeZc=
X-Received: by 2002:ad4:5763:0:b0:658:65ed:7e8 with SMTP id
 r3-20020ad45763000000b0065865ed07e8mr11974027qvx.57.1698061176619; Mon, 23
 Oct 2023 04:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1697660181.git.code@khaugsbakk.name> <1e2376a4b998b5b182cc5f72afc7282134bcdf2c.1697660181.git.code@khaugsbakk.name>
 <ZTZDsIcrB0zwHlFR@tanuki>
In-Reply-To: <ZTZDsIcrB0zwHlFR@tanuki>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 23 Oct 2023 07:39:25 -0400
Message-ID: <CAPig+cTx_wbs_b6he2O1EyUwZFp+5T8u6400_h87oCHxADb98A@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] maintenance: use XDG config if it exists
To: Patrick Steinhardt <ps@pks.im>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 5:58=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> On Wed, Oct 18, 2023 at 10:28:41PM +0200, Kristoffer Haugsbakk wrote:
> > `git maintenance register` registers the repository in the user's globa=
l
> > config. `$XDG_CONFIG_HOME/git/config` is supposed to be used if
> > `~/.gitconfig` does not exist. However, this command creates a
> > `~/.gitconfig` file and writes to that one even though the XDG variant
> > exists.
> >
> > This used to work correctly until 50a044f1e4 (gc: replace config
> > subprocesses with API calls, 2022-09-27), when the command started call=
ing
> > the config API instead of git-config(1).
> >
> > Also change `unregister` accordingly.
> >
> > Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> > ---
> > +test_expect_success 'register uses XDG_CONFIG_HOME config if it exists=
' '
> > +     XDG_CONFIG_HOME=3D.config &&
> > +     test_when_finished rm -r "$XDG_CONFIG_HOME"/git/config &&
> > +     export "XDG_CONFIG_HOME" &&
>
> Also, I think we need to unset this variable at the end of this test as
> tests don't run in a subshell. [...]

Yup, well spotted. Almost the entire body of this test should be in a
subshell to ensure that the environment variable does not live beyond
the end of this test. But test_when_finished() can't be used in a
subshell, so a little care is needed:

    test_expect_success 'register uses XDG_CONFIG_HOME config if it exists'=
 '
        test_when_finished rm -r .config/git/config &&
        (
            XDG_CONFIG_HOME=3D.config &&
            ...
        )
    '

> > +     mkdir -p "$XDG_CONFIG_HOME"/git &&
> > +     touch "$XDG_CONFIG_HOME"/git/config &&

If the timestamp of the file is not significant, then we use `>` to
create it rather than `touch`:

    >"$XDG_CONFIG_HOME"/git/config &&

> > +     git maintenance register &&
> > +     git config --file=3D"$XDG_CONFIG_HOME"/git/config --get maintenan=
ce.repo >actual &&
> > +     pwd >expect &&
> > +     test_cmp expect actual
> > +'
