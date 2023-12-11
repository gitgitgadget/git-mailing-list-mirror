Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4CEB3
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 01:36:50 -0800 (PST)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-67a8fb9d112so17219226d6.3
        for <git@vger.kernel.org>; Mon, 11 Dec 2023 01:36:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702287410; x=1702892210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/UhfRvMtTs8q6RILEDfAMHKKxfiKx/3wh8ywQmshV0=;
        b=vMGrangipciWmvYtAO+/BKpkIwu6pHOk06pgWCMh8X7PVA19tV6zD9/h2kypaNPRQg
         Si152vFuD7PJOqXgmfACpbH6/jb+fzfsCagwC6yLfulzqyn/EulM3aPHUv3DiRuB7QUL
         OEf/rME1e/JE11v8gWuZn7Sy1+VW4mWpcWLORbEj0covpTndVdd8sQhvixfFbq0BDmNs
         wM1oWBKcKuTYAnoHxx4NLYNmwb72qoUXRAid8tihoguRshoOeDGbuW+HIxKxLD0b+siy
         DbBDuRWIFMCk2ZRWa//wQoLIQW6yAcphV0Ce3waFY753EkZnqFufgYNHJR/3eDsm1L47
         3Dzw==
X-Gm-Message-State: AOJu0Yzn1Qwm3jfTU16lAjUehbLBNZ957Nno/K+YXBWLJKDgFnD8bGhN
	Q8PmyXugid+Xqi6mC4UrVmPVu9O25z1Uik6FIULZvi4+/D8=
X-Google-Smtp-Source: AGHT+IHC1rKTfl1yMx2UAy/Nd/30VTQjrJIeQXAWY/xDqz+E5LOFgB7BKkGIDSygDk5P0WMXsDFcIyCcXlcT3r+HELA=
X-Received: by 2002:a0c:e907:0:b0:67e:aa3b:5ca6 with SMTP id
 a7-20020a0ce907000000b0067eaa3b5ca6mr2062285qvo.111.1702287409988; Mon, 11
 Dec 2023 01:36:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1700549493.git.ps@pks.im> <cover.1702047081.git.ps@pks.im>
 <8061b9d2fcb3e8c3d1fd641e705b9a8879e452f4.1702047081.git.ps@pks.im>
 <ZXOML2pcqVnVo0oX@nand.local> <CAPig+cRGZvyhSs9=3-tkBKRZDjDUsb-VDs+dzOaZof__qyBjbA@mail.gmail.com>
 <ZXbRkOiD80zT7tC5@tanuki>
In-Reply-To: <ZXbRkOiD80zT7tC5@tanuki>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 11 Dec 2023 04:36:38 -0500
Message-ID: <CAPig+cTmAqDqu4Hiz+JO2GfV3+CqgVTXwFKWSTJXXAJ8Kg-xbw@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] reftable/stack: verify that `reftable_stack_add()`
 uses auto-compaction
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, 
	Han-Wen Nienhuys <hanwenn@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 4:08=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> On Fri, Dec 08, 2023 at 06:46:33PM -0500, Eric Sunshine wrote:
> > In this case, though, assuming I understand the intent, I think the
> > more common and safe idiom in this codebase is something like this:
> >
> >     struct strbuf name =3D STRBUF_INIT;
> >     strbuf_addstr(&name, "branch");
> >     size_t len =3D name.len;
> >     for (...) {
> >         strbuf_setlen(&name, len);
> >         strbuf_addf(&name, "%04d", i);
> >         ref.refname =3D name.buf;
> >         ...
> >     }
> >     strbuf_release(&name);
>
> Yeah, I'll convert this to use a `struct strbuf` instead. But instead of
> tracking the length I'll just use a `strbuf_reset()` followed by
> `strbuf_addf("branch-%04d")`. It's simpler to read and we don't need to
> squeeze every last drop of performance out of this loop anyway.

Sounds perfectly reasonable to me, and I agree with the reasoning,
especially the lower cognitive load with strbuf_reset(). Thanks.
