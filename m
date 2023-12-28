Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EB7101D9
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 19:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-67f95d69115so48158006d6.1
        for <git@vger.kernel.org>; Thu, 28 Dec 2023 11:27:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703791674; x=1704396474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TtA+oV1XMriiNzkF2OTi36GSNiBejEoODYNjzVb8nMc=;
        b=pthd/0Gq81LkaOhOjrm+44vH/v0Z00iTY4dJ/ObdYoWzmQHPrAj+XkA1euyOwCRPmC
         IRYSviZhui4qBuoksZ8aPkTYA0pYCQCh63gHflzLhLPVwvvSYpLavn8f6CFXF6usPHBK
         vDDZkT0NLb9p9hWWht2Rn9SsM/LWwwfFIecp8FLQmVy2NX8bmQavsbSYMjCr7CAB8yUJ
         OtdzSTkHduseXQqVPub7X9DclcUymr2xeg+S9O4De0XCIA9xetX5g+CgQWkSrh/o6pcP
         xv/MI1ocdJwDRcuTpmqYEg27lBkgcCFP0n+fIZbsvyMFpyK/Gq7+qiXO71QistzzpUvb
         VfPQ==
X-Gm-Message-State: AOJu0Yyd/nkFLqtX5RpHswgd/qDiCpR2tu6LHukDoAYGmbWbsGmP2anh
	//nXuoy0e+KLfJoIRq+bkOoWp2JsQISbp7Z6+ts=
X-Google-Smtp-Source: AGHT+IEpt/st45+l+WwZb8LnmVIFmoDnU/9kmkPuEbwLKuQdqYwL2sxCBv7w3PLiylZVCJQ+J1A86umgKFwL4XNwLg8=
X-Received: by 2002:a05:6214:16c5:b0:680:a4a:db94 with SMTP id
 d5-20020a05621416c500b006800a4adb94mr7516187qvz.77.1703791674397; Thu, 28 Dec
 2023 11:27:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228132844.4240-1-soekkle@freenet.de> <20231228132844.4240-2-soekkle@freenet.de>
In-Reply-To: <20231228132844.4240-2-soekkle@freenet.de>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 28 Dec 2023 14:27:43 -0500
Message-ID: <CAPig+cRK5PVBd6Lvztptk1td1S46rQ8KtA6S6+jTsuuCA6rnnw@mail.gmail.com>
Subject: Re: [PATCH 1/1] Replace SID with domain/username
To: =?UTF-8?Q?S=C3=B6ren_Krecker?= <soekkle@freenet.de>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 8:29=E2=80=AFAM S=C3=B6ren Krecker <soekkle@freenet=
.de> wrote:
> From: soekkle <soekkle@freenet.de>
>
> Replace SID with domain/username in erromessage, if owner of repository
> and user are not equal on windows systems.
>
> Signed-off-by: S=C3=B6ren Krecker <soekkle@freenet.de>
> ---

I don't do Windows (anymore), thus I'm not qualified to comment on the
substance of this patch, so I'll just make some general, hopefully
helpful, observations.

Typo: "erromessage" should be "error message"

Your name in the "From:" header and Signed-off-by: should be the same.

Perhaps Widows folks can understand the purpose of this patch without
further explanation, but for other readers, it's not clear what
problem the patch is trying to solve. The commit message is a good
place to explain _why_ this change is desirable.

> diff --git a/compat/mingw.c b/compat/mingw.c
> @@ -2684,6 +2684,25 @@ static PSID get_current_user_sid(void)
> +BOOL user_sid_to_string(PSID sid, LPSTR* str)

In this codebase, '*' sticks to the variable name, not the type, so:

    BOOL user_sid_to_string(PSID sid, LPSTR *str)

> +{
> +       SID_NAME_USE peUse;
> +       DWORD lenName =3D { 0 }, lenDomain =3D { 0 };

Looking through compat/mingw.c, it appears that (as with the rest of
the project), variable names tend to use underscores rather than
camel-case, so for consistency these might be better expressed as
"pe_use" (whatever that means), "name_len", and "domain_len".

I was curious about the `{ 0 }` initializer. It seems we have a mix of
both `{0}` and `{ 0 }` in the codebase, so what you have here is
likely fine.

> +       LookupAccountSidA(NULL, sid, NULL, &lenName, NULL,
> +                                       &lenDomain, &peUse); // returns o=
nly FALSE, because the string pointers are NULL

As with the rest of the project, compat/mingw.c still shuns "//"
comments. Use /*...*/ comments instead.

> +       ALLOC_ARRAY((*str), (size_t)lenDomain + (size_t)lenName); // Allo=
c neded Space of the strings

Type: "neded" -> "needed"

(and "Space" -> "space")

> +       BOOL retVal =3D LookupAccountSidA(NULL, sid, (*str) + lenDomain, =
&lenName,
> +                                      *str,
> +                                       &lenDomain, &peUse);
> +       *(*str + lenDomain) =3D '/';
> +       if (retVal =3D=3D FALSE)
> +       {
> +               free(*str);
> +               *str =3D NULL;

The FREE_AND_NULL() macro from git-compat-util.h is a good companion
to the ALLOC_ARRAY() macro used above, so freeing and nullifying could
be done in one line:

    FREE_AND_NULL(*str);

> +       }
> +       return retVal;
> +}

Perhaps a variable name such as `ok` would convey more to the reader
than the generic `retVal`?
