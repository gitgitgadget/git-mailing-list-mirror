Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17582646
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 04:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E081BB
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 21:03:44 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-66d190a8f87so3287296d6.0
        for <git@vger.kernel.org>; Wed, 25 Oct 2023 21:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698293023; x=1698897823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sv58dP8PagdpgM5oKZzWDrCzFuYm1QE63egJuO8DJCk=;
        b=DovFUg4kiQLaGnU/DUovHqFEcJfUyb/xlqihAX0xozEAe9Ua6FQI667LmxxG+QV0sF
         c5KAQSjzkj++MhYcx3yHe02LxvD4tARMf0HQa4H8dxKBEOZwM1Y61h37LbWpb5KDXXSQ
         BWhMzgYn1tHY9jQWIzQSM0fwUdUyD2YyILyUTGMvrWYEXpkAtoYO3QpkJGFPGo7LXCfZ
         y7aw4Zui+7l48NBymr4m6vacLonH62EvIxSfo7cC4sqWu/xVAMRb71oYeRbKNFsuyvK0
         Yrl1Jcabss16h6RY3posPOwxpGx0hxMpsrj0cTVMryE8Z4mCc3iTJkGocLvRqP2WuhBG
         k4Kg==
X-Gm-Message-State: AOJu0YzqdfEBcp7FtT2KlUdxotRuwp6RSkTod2dBzAO4BurLblUHt5Ut
	MxB/rRbdjIAQ0ri0xf+Yq/Xj2kH4osy3QHE7nMQ=
X-Google-Smtp-Source: AGHT+IGLbvCpB0F6zRm/PnfeMfvJe1Cte4UQbM/r04tW9q6DWqpDq3psIvMXz0WV7iFVtzMdjQRwdcUMv/nrOc7sQJM=
X-Received: by 2002:a05:6214:21e3:b0:66d:15c3:62ca with SMTP id
 p3-20020a05621421e300b0066d15c362camr23059860qvj.24.1698293023252; Wed, 25
 Oct 2023 21:03:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPig+cQtoEpTDK1U5R+wUD4qovFtpcx6+zyOQE-SAYp5SE2q2Q@mail.gmail.com>
 <20231026005542.872301-1-nasamuffin@google.com> <CAPig+cT4G9vdu+se9Fbbs0TRCyPoAYFgVtkSwph_U=sWf-kQ9g@mail.gmail.com>
 <8c82a138faa28a3c5d15a52b1d9c2c0f@manjaro.org>
In-Reply-To: <8c82a138faa28a3c5d15a52b1d9c2c0f@manjaro.org>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 26 Oct 2023 00:03:30 -0400
Message-ID: <CAPig+cTJFKp6RFdqJTpyL49V+M-zaTDbgpVd2OrgfWf4H-+K+g@mail.gmail.com>
Subject: Re: [PATCH v2] bugreport: reject positional arguments
To: Dragan Simic <dsimic@manjaro.org>
Cc: emilyshaffer@google.com, git@vger.kernel.org, 
	Emily Shaffer <nasamuffin@google.com>, Sheik <sahibzone@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 11:52=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> =
wrote:
> On 2023-10-26 05:43, Eric Sunshine wrote:
> > On Wed, Oct 25, 2023 at 8:55=E2=80=AFPM <emilyshaffer@google.com> wrote=
:
> >> diff --git a/builtin/bugreport.c b/builtin/bugreport.c
> >> @@ -126,6 +126,12 @@ int cmd_bugreport(int argc, const char **argv,
> >> const char *prefix)
> >> +       if (argc) {
> >> +               if (argv[0])
> >> +                       error(_("unknown argument `%s'"), argv[0]);
> >> +               usage(bugreport_usage[0]);
> >> +       }
> >
> > Can it actually happen that argc is non-zero but argv[0] is NULL? (I
> > don't have parse-options in front of me to check.) If not, then the
> > extra `if (argv[0])` conditional may confuse future readers.
>
> According to https://stackoverflow.com/a/2794171/22330192 it can't, but
> argv[0] can be a zero-length string.

This case is different, though, since, by this point, argv[] has been
processed by Git's parse-options API. Here's the relevant comment from
parse-options.h:

   * parse_options() will filter out the processed options and leave the
   * non-option arguments in argv[]. argv0 is assumed program name and
   * skipped.
   *
   * Returns the number of arguments left in argv[].

So, I think the `if (argv[0])` conditional is unnecessary, thus
potentially confusing.

It's possible that Emily meant `if (*argv[0])`, but even that seems
undesirable since even a zero-length argv[0] provides some useful
context.

    % git bugreport ""
    error: unknown argument `'
