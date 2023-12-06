Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjuRomzS"
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7245ED53
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 13:14:10 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-59063f8455eso121197eaf.3
        for <git@vger.kernel.org>; Wed, 06 Dec 2023 13:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701897250; x=1702502050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OeFJbmVo8ucFn7rUnsp16x/ayWvx5w4AR+uh/ouVhtc=;
        b=hjuRomzSG51Fa/jMehYnIV/GyLIrowL8x1xeLpZad7o9oajK5vTakEJz2dtaN9pck4
         Yrmk0rkuQWfXnm5eHsscjPFTbSJ6XP+wzn3VOAQ4QNyDiZU/39xOc4Fb84A5Vdw3lIRB
         tInoGmj7gwP0OJly7Y9an2mcCwPNXZlTV3OMOm0deA7H6w1LEI2c1b4RRynka4/3gBr3
         P5IiqmQWzi6gu8UmYji4JTQvZJJjcW8fnUSyx2eDijPDLldPplxpIwZ4+kS8SV9ueqr3
         iXl+6bgIxi9sWjmIlWI6h3YSz+ULWef68ioWxS/djayTJ49k6miThf+gxgL1SF9qGetD
         +heA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701897250; x=1702502050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OeFJbmVo8ucFn7rUnsp16x/ayWvx5w4AR+uh/ouVhtc=;
        b=tOw3MyOiOUPa2rGSp12nVfMySsi21vhtliS+q6NygfTBmwhZBYykzQgQbbHBhJWCR/
         h3Jd+um2rnAfcwY1wCuHrUdKvhMwndytcAxGvxUv2CqTzVBZtYWlo0w3Qv8B/1wR+Sfn
         8ZzTLICg3T4OZWoKhJcWU9j2Gn23vDHgplGaetGrwpFmjh3Ssfo4lD6gB5IexHrtjGcc
         8uWWWkCpgNXMyrzMqzN5CX/j28RCyp8AxmPt26Dnvc0xa9kpVzAOt5Xob5hMmURV8xXS
         Qvj+ErCVsaQ5y61GchNNwReZRNwO0lwu51wBGukwOK/K+p/rwfXytikVxJUB2UviBDgM
         JIIA==
X-Gm-Message-State: AOJu0YzsUgnhtZot9glZJIQoslBLSNsD2vyU8CFeOLzt2dPQyF/fd+if
	Au5/eGFN84FhB+YPP1bEaN1/h1jCLoq5JsLprrRBUQEOEZwKMA==
X-Google-Smtp-Source: AGHT+IFczahhKblr5fkXsuzbvFzE61nHfj2D6PWz+9HOXeveKr20tR5I05VClDooL+PVAg7zZMvx+Uolx3eud4wXcbU=
X-Received: by 2002:a05:6871:5a98:b0:1fb:75b:12fd with SMTP id
 oo24-20020a0568715a9800b001fb075b12fdmr1884556oac.79.1701897249690; Wed, 06
 Dec 2023 13:14:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1701863960.git.ps@pks.im> <c7a9d6ef74ff39e660f80e2e104a96b7c875845d.1701863960.git.ps@pks.im>
In-Reply-To: <c7a9d6ef74ff39e660f80e2e104a96b7c875845d.1701863960.git.ps@pks.im>
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 6 Dec 2023 22:13:43 +0100
Message-ID: <CAOLa=ZQc=7Z3w9JAdzS23P=c=KSYZJR6gJSLOHdU-d92Y3kJ5A@mail.gmail.com>
Subject: Re: [PATCH 4/7] builtin/clone: fix bundle URIs with mismatching
 object formats
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 1:40=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrote=
:
> The first Git step where we expect the repository to be fully initalized
> is when we fetch bundles via bundle URIs. Funny enough, the comments
> there also state that "the_repository must match the cloned repo", which
> is indeed not necessarily the case for the hash algorithm right now. So
> in practice it is the right thing to detect the remote's object format
> before downloading bundle URIs anyway, and not doing so causes clones
> with bundle URIS to fail when the local default object format does not
> match the remote repository's format.
>

Nit: s/URIS/URIs
