Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5CED59
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 14:41:11 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7bb4b7eb808so12547241.3
        for <git@vger.kernel.org>; Wed, 06 Dec 2023 14:41:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701902471; x=1702507271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IbgAiZzCHMQPbq3aJcGYpOFJxuaH41fNwrDODa2e3jM=;
        b=lGHEtZQWDk5+J3nLO6POtMKrO+mw5SuBpMwksMOXRdoQ7Fvz5JAuPj3bFgcuId9X2k
         HntqkUh38YzyPe/LPURtsxoMgdbDVGifcpRkSIRxTS6mb5llAG0Q/iJkL+wklqezKR2E
         Oi7p8X/K6o/GVCDrVYqiGkw9dloVYxvIoHTmKl563T8zdetOb+/zA14n+XDcEgNm4iSo
         e+WlCUOukY5oGsw6sUlYJDM1LhUOSiOzuigo6NpaPsPy9xs9Ey1UZOSm34JpGYICkTO0
         GnjfeNf6z/lqQZJpocMwSjx6x3sT+PM244eFPfGkRUDYjyhAaTcTXrDHGIkXsnf80/pL
         cUKQ==
X-Gm-Message-State: AOJu0YxyeTyYeHuaZLwcpns93IFzgFeKuPMIQ2yKTd27PJxtcTwRMXtI
	plhbs79WzOF8QUSlC/VhRxRg1bUdQOabpIKmGY8=
X-Google-Smtp-Source: AGHT+IGf0NGfQP2Kcc71NkIH9RGTxgBW6BMr7hUAFWKkiwm6aQN9GPg2MF01BZ6ilUzWd5vWZYX+EfThIK2zLTNoixs=
X-Received: by 2002:a05:6102:1613:b0:465:2fec:24fd with SMTP id
 cu19-20020a056102161300b004652fec24fdmr1894402vsb.65.1701902470836; Wed, 06
 Dec 2023 14:41:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206223145.GA638844@coredump.intra.peff.net> <20231206223612.GA650770@coredump.intra.peff.net>
In-Reply-To: <20231206223612.GA650770@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 6 Dec 2023 17:40:59 -0500
Message-ID: <CAPig+cT-vCraf2tfA3t3Rh6mLNTr0rB5mApmz0vu2MCRvssaVw@mail.gmail.com>
Subject: Re: t7900 fails with recent debian systemd?
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 5:36=E2=80=AFPM Jeff King <peff@peff.net> wrote:
> After stracing, it is indeed looking for:
>
>   trash directory.t7900-maintenance/systemd/user/git-maintenance@hourly.s=
ervice
>
> but that file doesn't exist. We installed git-maintenance@hourly.timer,
> and git-maintenance@.service. Is the latter supposed to be a wildcard of
> some kind? Maybe the rules changed. I don't really know anything about
> systemd.

Apparently, that's intentional. From builtin/gc.c:

    /*
     * No matter the schedule, we use the same service and can make
     * use of the templating system. When installing
     * git-maintenance@<schedule>.timer, systemd will notice that
     * git-maintenance@.service exists as a template and will use this
     * file and insert the <schedule> into the template at the
     * position of "%i".
     */
    static int systemd_timer_write_service_template(const char *exec_path)
    {
        char *local_service_name =3D xstrfmt(SYSTEMD_UNIT_FORMAT, "", "serv=
ice");

I'm not sure why the comment is talking about "%i", though.
