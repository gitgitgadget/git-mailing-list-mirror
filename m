Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ADE1D6A9
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 19:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43B510C6
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 12:26:03 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5840bb16101so2833691eaf.3
        for <git@vger.kernel.org>; Tue, 24 Oct 2023 12:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698175563; x=1698780363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z7sL7V0HxH0UMW/rL4Jix+I4oRVRd/YvY6IQGRUgZW0=;
        b=Le/1XGmBhvynxJvMyR6tNLa+OW9qzL1cXXq2zeFGfoaKZ0k2n9r6ijZ7QLgWMvjOTr
         LFytqEZYxfBmNM0A+tWg1b0PktLopstbaI9wEzofmTcyHBZASn5Vvdw+6CN2dOm0m6kF
         t9CSylPyP/VxESOSVA62Ib0oN/cdi1FtQAeCABVRJ7ejVbyGfC8c0aYBJDKX41+VGM2R
         AoQUrigs3U7VsTVAqSYE2BOVMKE55ILYyUEawNnPYLJOUoBA6HNlfswR/yBG48YiXX2f
         Aj9AK8tQYVzf1wWRH8jjevlMsIKOHKhokLr+zN6nCyOyRY4ZJE3e+M1UnBfVpnZVQMiI
         48cQ==
X-Gm-Message-State: AOJu0Yyy4s83AzGXtHkGrC7bHsCeTgezTQnXnBt7xe/D6dYfdjRTGEBT
	SDfiwdkb1DoQkKqqXB1mrGNe+fL3zCyW1Femus4=
X-Google-Smtp-Source: AGHT+IE4V4u2Y24N1pi3jnKwr6FV3qorW7UUxn9kuiHbRVCuzsBIB6SxjL7GSAVUP6/CtsrqhPKezPil7IBj1+CLhTY=
X-Received: by 2002:a05:6359:8003:b0:168:dbfd:cec8 with SMTP id
 rc3-20020a056359800300b00168dbfdcec8mr6336170rwb.13.1698175563059; Tue, 24
 Oct 2023 12:26:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1698152926.git.ps@pks.im> <d0a991cf4f892e73e4fd62ef3fdae3fa73277321.1698152926.git.ps@pks.im>
In-Reply-To: <d0a991cf4f892e73e4fd62ef3fdae3fa73277321.1698152926.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 24 Oct 2023 15:25:52 -0400
Message-ID: <CAPig+cSrp7vZuy7D_ENHKZKZzF4OSmCtfYNHPGMtS1Hj6gArDw@mail.gmail.com>
Subject: Re: [PATCH 09/12] builtin/show-ref: ensure mutual exclusiveness of subcommands
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Han-Wen Nienhuys <hanwen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 9:11=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> The git-show-ref(1) command has three different modes, of which one is
> implicit and the other two can be chosen explicitly by passing a flag.
> But while these modes are standalone and cause us to execute completely
> separate code paths, we gladly accept the case where a user asks for
> both `--exclude-existing` and `--verify` at the same time even though it
> is not obvious what will happen. Spoiler: we ignore `--verify` and
> execute the `--exclude-existing` mode.
>
> Let's explicitly detect this invalid usage and die in case both modes
> were requested.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> diff --git a/builtin/show-ref.c b/builtin/show-ref.c
> @@ -269,6 +269,9 @@ int cmd_show_ref(int argc, const char **argv, const c=
har *prefix)
> +       if ((!!exclude_existing_opts.enabled + !!verify) > 1)
> +               die(_("only one of --exclude-existing or --verify can be =
given"));

Somewhat recently, work was done to normalize this sort of message.
The result was to instead use the phrasing "options '%s' and '%s'
cannot be used together". See, for instance, 43ea635c35 (i18n:
refactor "foo and bar are mutually exclusive", 2022-01-05).
