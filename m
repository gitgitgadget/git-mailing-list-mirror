Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB85119B7
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 10:09:15 -0800 (PST)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-77d60604cebso115990785a.2
        for <git@vger.kernel.org>; Fri, 24 Nov 2023 10:09:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700849355; x=1701454155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oe46oY3XD7+T81zJbR9AhsVByWbl0ASNpl269uDDZUs=;
        b=AEsZ5FsDCBZVKAIE0dR2ydO7CyS7PgDnfnTgW3UYr27pIHLdE/DEqOBOzPTwa41yDg
         HvFVB7Dn8Z9qKlOSmvcK6gdEf/eRmViuKRNOx4c/JR5GM3dtGoME+yg5DmW3cwXgk0Fj
         R0RIPELp6+b36Gc2yxc7hyKz4qsoqJsddq2JAC6h31LhDjD6jl4aEIDlo7aQo04F58mN
         kK562PCU1WCpdWQ1IQb7VZcTNdHfIquO/Xv1qOgCiVXEhcpcxeANjwaLX+waP3z3yJG3
         dOeatqBM5KiZPDwvnfBmKkSRvWIxtZFD9NrUEkIZICvmxgFzOnqIUiSvsHWbP8pQ8UB5
         z40Q==
X-Gm-Message-State: AOJu0YyPIE9vCTy5MeDVV2l4UKku/WPmGy4h/I/hvTwwXkiUaRfKjTUP
	ibHDkDuYxcqBa69SjHQCM9Noo4BY42bcjvLlarz+3MxvJSJR8A==
X-Google-Smtp-Source: AGHT+IG+McEyetOUW3iykPQMF937yT+h1TdAJELPgflLGB5YlFud7huT7bSIJVHtrfDdqVjxebGrIQDoCUPUgU5C9Ds=
X-Received: by 2002:a05:6214:488d:b0:67a:2235:7682 with SMTP id
 pc13-20020a056214488d00b0067a22357682mr1448355qvb.12.1700849355067; Fri, 24
 Nov 2023 10:09:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cc902954f30c2faa92d1c5a4469f0dcc23e4acfe.1700825779.git.ps@pks.im>
In-Reply-To: <cc902954f30c2faa92d1c5a4469f0dcc23e4acfe.1700825779.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 24 Nov 2023 13:09:03 -0500
Message-ID: <CAPig+cSa9zxEhKXtXHrVuB3Eb6=vnD1Ppnfj59rA+nPEO-9j-w@mail.gmail.com>
Subject: Re: [PATCH] git-prompt: stop manually parsing HEAD
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 6:37=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> We're manually parsing the HEAD reference in git-prompt to figure out
> whether it is a symbolic or direct reference. This makes it intimately
> tied to the on-disk format we use to store references and will stop
> working once we gain additional reference backends in the Git project.
>
> Refactor the code to always use git-symbolic-ref(1) to read HEAD, which
> is both simpler and compatible with alternate reference backends.

This may get some push-back from Windows folks due to high
process-creation cost on that platform. As I recall, over the years, a
good deal of effort has been put into reducing the number of programs
run each time the prompt is displayed, precisely because invoking Git
(or other programs) multiple times became unbearably slow. In
particular, optimizations efforts have focussed on computing as much
as possible within the shell itself rather than invoking external
programs for the same purpose. Thus, this seems to be taking a step
backwards in that regard for the common or status quo case.

Would it be possible instead to, within shell, detect if the historic
file-based backend is being used in the current repository, thus
continue using the existing shell code for that case, and only employ
git-symbolic-ref if some other backend is in use?

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
