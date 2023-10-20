Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701EB1DDF8
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AF2D7
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 10:30:16 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-65b0e623189so6487166d6.1
        for <git@vger.kernel.org>; Fri, 20 Oct 2023 10:30:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697823016; x=1698427816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ATk2OAR5/nUDN3i9gopes8kr3K692mmEQAluNCjqMKI=;
        b=frt1VOXgodqoBNBfbmR99Mw9EsymR9iE5QxWLmz4NR8F+w7DQuCu3hJFRH305XvP4+
         xCNV2PSCsmqlk0I2QTS9o9Qlh1nhXHLUK/IJLK3mZAB73z8wtblbAdAkNiMfjI/An0ZC
         JFyzod0UyqJYTtuM+SvLoHVOoQ5IECf6eYGT/KZOY3AyXW+iT4TaMWBROHxorI/w0oj/
         mqDQAhQC89dEbGcLdQJdmhuspEnaycifO/5Qe/KJt8HEnnYNmjT+XIvoUJkbEoWd2EtC
         s16kteykkPErf318E0DqAQmfKmJms0GF9VS0Bv+ZfxXEpj8EmOHjm/dbBr7sxE3nVVpX
         1A6A==
X-Gm-Message-State: AOJu0YygJ/JGC18g9xkknWeQl2jEmWIM68w0D3m5U7FTH2QDwrxrNSay
	OyPVgEBBYNFbJE7ghUQ19BivjqiDpDCsMgFdzZs=
X-Google-Smtp-Source: AGHT+IF0WrohFCunoOg4/1QjXZ1huL0LrfHq+PN6/7t1Wx9psHSSqwc0S4gSyIzMhOhNaqv+UMzB/Tm8rMOlPnXy230=
X-Received: by 2002:a05:6214:258b:b0:66d:12e0:2555 with SMTP id
 fq11-20020a056214258b00b0066d12e02555mr2559222qvb.33.1697823015881; Fri, 20
 Oct 2023 10:30:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231020100343.GA2194322@coredump.intra.peff.net> <20231020101524.GA2673857@coredump.intra.peff.net>
In-Reply-To: <20231020101524.GA2673857@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 20 Oct 2023 13:30:05 -0400
Message-ID: <CAPig+cQHOF-aQqqZUQB07HrPAoCg=80P3eLwwSUbbCeHAwX5zg@mail.gmail.com>
Subject: Re: [PATCH 3/3] send-email: handle to/cc/bcc from --compose message
To: Jeff King <peff@peff.net>
Cc: Michael Strawbridge <michael.strawbridge@amd.com>, Junio C Hamano <gitster@pobox.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 6:15=E2=80=AFAM Jeff King <peff@peff.net> wrote:
> If the user writes a message via --compose, send-email will pick up
> varius headers like "From", "Subject", etc and use them for other

s/varius/various/

> patches as if they were specified on the command-line. But we don't
> handle "To", "Cc", or "Bcc" this way; we just tell the user "those
> aren't interpeted yet" and ignore them.
>
> But it seems like an obvious thing to want, especially as the same
> feature exists when the cover letter is generated separately by
> format-patch. There it is gated behind the --to-cover option, but I
> don't think we'd need the same control here; since we generate the
> --compose template ourselves based on the existing input, if the user
> leaves the lines unchanged then the behavior remains the same.
>
> So let's fill in the implementation; like those other headers we already
> handle, we just need to assign to the initial_* variables. The only
> difference in this case is that they are arrays, so we'll feed them
> through parse_address_line() to split them (just like we would when
> reading a single string via prompting).
>
> Signed-off-by: Jeff King <peff@peff.net>
