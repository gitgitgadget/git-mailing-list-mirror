Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5476A339AE
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 23:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA377BB
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 16:11:24 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7788ebea620so21587585a.3
        for <git@vger.kernel.org>; Wed, 25 Oct 2023 16:11:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698275483; x=1698880283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5NfVJMI8DygF8ykk6Ckh1ZImX2JuLWi7gQ8ET7zZ5D8=;
        b=sfCq/fKuiADF663MX7nM2veAc4Ja+e6IkM1WgCNjIOy2dKjPFEWxOEBbxWBGSlQfrA
         mcfHz1nLLwlcguCvhmIFT+J1kFxFb2s6e2hVcTdSKK1anvwVExrq2YyxLVsLERjTLr3P
         KFNVQ2pNCaqe7fd53N1KiMZFJd0yY8k5d9S9YyiosAPDPhdJzcQkMnLL1OvxHo4PX7Z5
         DicSnQnZrVd4palc149M5WuexHil3I2ngi3VIlckcauBNsLg4F3JtY8s4dxGWHVsP0sI
         +nMtf6ewtj1vgFv00SsfmFux14vJeExf1WPOghNgYryP2yyD6S7zQMPxNXqiAGx1K9Fz
         UNyQ==
X-Gm-Message-State: AOJu0YwSClyaqn7DDGobZ7aTt2oHEh5OJYG35wiGKR8WhtQI28TM8McL
	1MjYWRUb2nKHzJNzPjL+gtOAk2CZwmoffWKGiEwR1lrA
X-Google-Smtp-Source: AGHT+IHDs8TPHkyP9en2UOgkdv7R1FJG90kG4g4RjGmBZEP+LlHqq4X44f/0Ioqqiugq8zPIPh/KNDt6oNauQ6aAnzs=
X-Received: by 2002:a05:6214:c81:b0:66d:4d99:bd3b with SMTP id
 r1-20020a0562140c8100b0066d4d99bd3bmr20603060qvr.23.1698275483567; Wed, 25
 Oct 2023 16:11:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7a92b537-ba88-4667-bb18-2e8c74aa9915@gmail.com> <ZTmcVJaY2TjFCVyw@google.com>
In-Reply-To: <ZTmcVJaY2TjFCVyw@google.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 25 Oct 2023 19:11:12 -0400
Message-ID: <CAPig+cQtoEpTDK1U5R+wUD4qovFtpcx6+zyOQE-SAYp5SE2q2Q@mail.gmail.com>
Subject: Re: git bugreport with invalid CLI argument does not report error
To: Emily Shaffer <nasamuffin@google.com>
Cc: Sheik <sahibzone@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 6:53=E2=80=AFPM Emily Shaffer <nasamuffin@google.co=
m> wrote:
> On Thu, Oct 26, 2023 at 07:59:16AM +1100, Sheik wrote:
> > Running git bugreport with an invalid CLI argument in a valid Git direc=
tory
> > does not report error. Expected behaviour would be that it reports an e=
rror.
>
> It looks like parse-options.[ch] helps us here for misspelled dashed
> options, like `--diaggnose`. But it doesn't complain when there are
> unexpected positional arguments. I think we can just notice if there are
> any argc left over, complain, and print usage.
>
> I put together a quick patch; could be that we don't need to leave this
> error about "positional arguments" and can leave it as an exercise to
> the reader to compare their previous command to the usage text. I guess
> we could also unroll remaining argv but it was just a hair more time
> than I wanted to spend ;)
>
> --- 8< ---
> Subject: [PATCH] bugreport: reject positional arguments
>
> git-bugreport already rejected unrecognized flag arguments, like
> `--diaggnose`, but this doesn't help if the user's mistake was to forget
> the `--` in front of the argument. This can result in a user's intended
> argument not being parsed with no indication to the user that something
> went wrong. Since git-bugreport presently doesn't take any positionals
> at all, let's reject all positionals and give the user a usage hint.
>
> Signed-off-by: Emily Shaffer <nasamuffin@google.com>
> ---
> diff --git a/builtin/bugreport.c b/builtin/bugreport.c
> @@ -126,6 +126,11 @@ int cmd_bugreport(int argc, const char **argv, const=
 char *prefix)
> +       if (argc) {
> +               error(_("git bugreport does not take positional arguments=
"));
> +               usage(bugreport_usage[0]);
> +       }

This error message may be somewhat difficult to interpret. Providing
additional context could help the user understand the actual problem.
For instance:

    % git bugreport diagnose
    error: unrecognized argument "diagnose"
