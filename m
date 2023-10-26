Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6D4646
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 03:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A43187
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 20:43:33 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-66d0760cd20so3641836d6.0
        for <git@vger.kernel.org>; Wed, 25 Oct 2023 20:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698291812; x=1698896612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pmv1HrdnvzZikIaNd2E8WxDM+7CzIgLYg77bXyBm5k8=;
        b=jIC8VkY70k8+RWnGJHOetKiAUSBg0obzm83CSZqiETiqE1BG9uXM3PdEMtvQau7UdI
         a39fTD1JHbLb6Lo7fiyRzEJyiav3ejOAlgsDI9lcjVtcqNXDoE9c7iIK/2ok+c/A+4JS
         U1jDXxGx6gvq1JN8VSbg975srKFjTudm5xX13eReP+fxoK+Q32LMBJWasONdXaA4LxJM
         8fS7KiiMS7xewLepn6cRV6DqW5Cc5We7sdQZtMto/HNA3jxl87op58KXsgO8gPGlBlgW
         fhOzFX2adyD8IxyeqlpzSEOrhAMJiiTrwM5CeFDECuspXqegB8dVzw1rFb+sUC7LJ7eW
         kKSA==
X-Gm-Message-State: AOJu0YyxRd0+Ird8mfJE42X1S3A7Fl4UKGXfT1RWgaVF2nBQsT6BYEPM
	BdAc+J/Mrw8ky7Hpa5uytgxzl+vNIrpwla59CDjrxUda
X-Google-Smtp-Source: AGHT+IFs4krr/gusUTBpCIXtIebqJUQDDfbLgL/1R7QkgWtd0vEnTKRNWnC2LW2YF2Qg2z4BKlwE7ufigDSA4tghIo0=
X-Received: by 2002:a0c:aa19:0:b0:66d:9bc8:e1c0 with SMTP id
 d25-20020a0caa19000000b0066d9bc8e1c0mr1630717qvb.29.1698291812544; Wed, 25
 Oct 2023 20:43:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPig+cQtoEpTDK1U5R+wUD4qovFtpcx6+zyOQE-SAYp5SE2q2Q@mail.gmail.com>
 <20231026005542.872301-1-nasamuffin@google.com>
In-Reply-To: <20231026005542.872301-1-nasamuffin@google.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 25 Oct 2023 23:43:20 -0400
Message-ID: <CAPig+cT4G9vdu+se9Fbbs0TRCyPoAYFgVtkSwph_U=sWf-kQ9g@mail.gmail.com>
Subject: Re: [PATCH v2] bugreport: reject positional arguments
To: emilyshaffer@google.com
Cc: git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>, Sheik <sahibzone@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 8:55=E2=80=AFPM <emilyshaffer@google.com> wrote:
> git-bugreport already rejected unrecognized flag arguments, like
> `--diaggnose`, but this doesn't help if the user's mistake was to forget
> the `--` in front of the argument. This can result in a user's intended
> argument not being parsed with no indication to the user that something
> went wrong. Since git-bugreport presently doesn't take any positionals
> at all, let's reject all positionals and give the user a usage hint.
>
> Signed-off-by: Emily Shaffer <nasamuffin@google.com>
> ---
> Per Eric's suggestion, added a citation of the first positional arg
> found. I don't think it's necessary to unroll the entire argv array
> here, though.

Thanks. I had the same thought about the first positional argument
being sufficient since it should provide enough context on its own.

> diff --git a/builtin/bugreport.c b/builtin/bugreport.c
> @@ -126,6 +126,12 @@ int cmd_bugreport(int argc, const char **argv, const=
 char *prefix)
> +       if (argc) {
> +               if (argv[0])
> +                       error(_("unknown argument `%s'"), argv[0]);
> +               usage(bugreport_usage[0]);
> +       }

Can it actually happen that argc is non-zero but argv[0] is NULL? (I
don't have parse-options in front of me to check.) If not, then the
extra `if (argv[0])` conditional may confuse future readers.
