Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD783171C
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 15:46:46 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5d7692542beso25319447b3.3
        for <git@vger.kernel.org>; Fri, 08 Dec 2023 15:46:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702079206; x=1702684006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLjBdDLFH8k+Pxgi3f2Z90Ii80ADD0I3k/WJRmZByOo=;
        b=QsXAecvAtWH9/gm/KhH1gYaF0mSjtybV4Kllf+RE2RBIq5QcJGjKq5kL/wE/q+c0SJ
         0h4gxw/McnFDK+QSRYR5aNNOs/dZCFyMhryeiChpjWIT2Akt5ziaMzOolckEiBeNOwA7
         ECiTtyoV9QXlG1lBFpN2iZSQP9U+aTWRvs5McQBHf59PCzdNGDETDM7tVqT9sWm9XiAV
         0B9lpBQrnljBSkLZTl1E18IF30WLslhdp4MXtulklf9Y+DPDUqpcC1JBCMGFy+vgR96w
         aJBkROyXyxYLp5FeijEX8hkNGefPxNHiBuMiEwfqA07MmF5fBdefBliEh49ASXQWJM9m
         QQ9A==
X-Gm-Message-State: AOJu0Yzfdvm9enNMn3KaQ8Lr+BeCXHauNCuxa4AT8ImDhg6Te/8pHCZa
	Fsyl795U1aYRvL5SBeFri7adIBQoGxnum3YX5Ow=
X-Google-Smtp-Source: AGHT+IE1jpiBykC9luz3aVoJHorSJOdY8+9iHuoWVaBX/XdTBoLj3POSBo07J3v2LQN/phl/ZFMgOf0C6tZpwLh0DA4=
X-Received: by 2002:a81:4a85:0:b0:5d7:a00d:62e7 with SMTP id
 x127-20020a814a85000000b005d7a00d62e7mr721551ywa.50.1702079205880; Fri, 08
 Dec 2023 15:46:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1700549493.git.ps@pks.im> <cover.1702047081.git.ps@pks.im>
 <8061b9d2fcb3e8c3d1fd641e705b9a8879e452f4.1702047081.git.ps@pks.im> <ZXOML2pcqVnVo0oX@nand.local>
In-Reply-To: <ZXOML2pcqVnVo0oX@nand.local>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 8 Dec 2023 18:46:33 -0500
Message-ID: <CAPig+cRGZvyhSs9=3-tkBKRZDjDUsb-VDs+dzOaZof__qyBjbA@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] reftable/stack: verify that `reftable_stack_add()`
 uses auto-compaction
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>, 
	Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 4:35=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote:
> On Fri, Dec 08, 2023 at 03:53:10PM +0100, Patrick Steinhardt wrote:
> > +static void test_reftable_stack_add_performs_auto_compaction(void)
> > +{
> > +             char name[100];
> > +             snprintf(name, sizeof(name), "branch%04d", i);
> > +             ref.refname =3D name;
>
> Is there a reason that we have to use snprintf() here and not a strbuf?
>
> I would have expected to see something like:
>
>     struct strbuf buf =3D STRBUF_INIT;
>     /* ... */
>     strbuf_addf(&buf, "branch%04d", i);
>     ref.refname =3D strbuf_detach(&buf, NULL);

If I'm reading the code correctly, this use of strbuf would leak each
time through the loop.

> I guess it doesn't matter too much, but I think if we can avoid using
> snprintf(), it's worth doing. If we must use snprintf() here, we should
> probably use Git's xsnprintf() instead.

xstrfmt() from strbuf.h would be even simpler if the intention is to
allocate a new string which will be freed later.

In this case, though, assuming I understand the intent, I think the
more common and safe idiom in this codebase is something like this:

    struct strbuf name =3D STRBUF_INIT;
    strbuf_addstr(&name, "branch");
    size_t len =3D name.len;
    for (...) {
        strbuf_setlen(&name, len);
        strbuf_addf(&name, "%04d", i);
        ref.refname =3D name.buf;
        ...
    }
    strbuf_release(&name);
