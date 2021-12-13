Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE564C433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 16:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240217AbhLMQo7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 11:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbhLMQo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 11:44:58 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED98C06173F
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:44:58 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id r15so30257205uao.3
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XDNFpPRqjaA2JZ+1OlOoYXASSbxJEImIK9NFWPdiwsA=;
        b=ejCYhhR994QNtQWnRynH/n5L5uoapnd5yrDnkYUGCPBpPMkWECcHpznaOHDM8adKzE
         yUy+e9AosAkBvFslQoiQLeIEdGPCZc4Jh0JkIJcVmd8aD3Twp2a/7lu5YolPPSLz6dFF
         l+mURj8OhBe1B01XVWEwrrGpcu8Q1e/Vi54mShMZ6Sb/7RE870Af7hXixSRKwnavB1Q+
         t+4m2p4NE8/h5rztrFll2YkwvmNACixcGzIxY4RHoWknclk/KuKwTq42bXxEU+e5vNB2
         47zYConjRSiRb2nuGgOp4yqa+E7aq/LyRjMnwHstrEv++MLAMn0rSOU+RIBNhe1vsuoK
         HtUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XDNFpPRqjaA2JZ+1OlOoYXASSbxJEImIK9NFWPdiwsA=;
        b=a67DVgE7nAehE45sEMI5zy8Azva/eEGJ6mZvOaZeM2WWYclziQ1IK+if9BqDOAC2hh
         pt6RUzYUbcy+IGfGBFJyxUxOWkED6gKaV0HbittnDKDXvZ5gTdCLVYEvq2Kd2MhTINwR
         p9+uLeGzHy0+lhD6QMG4Lbz2qw+DZXd18V5qzU/lci3L2H7OoDlNZU8xxu2Y0fQlHSpC
         wXAwuvL8Phnl0gCbNcUt0a+WBLaG5pWrYHoLnh7wmhoPdYEV0nk9xqgUgNi/uYZ/DsYk
         CyQcmVa9SJUgxIsZMeCdlBgFdQDcl97g802ILDEI+tVUY4B//sgmdwh0lgq522jT+YYK
         sQ4A==
X-Gm-Message-State: AOAM532B++uL9Tt4X6XHs2aqDTvqQjAnYIrm5cJ0qzhXvee6DWEHJ4FU
        d3XQYkeZxdQndPFTXrhOaLIBPVJku4g+JZalYuxbww==
X-Google-Smtp-Source: ABdhPJyIpHZvNoh7xVd1cwu+JHB6hzxL/KelbDM5TP+wl5N4aMbNes3c/t095oB4Im5xzg4BiCyerCIRvXKdnGuDQ3Q=
X-Received: by 2002:a67:cd19:: with SMTP id u25mr29126559vsl.70.1639413897570;
 Mon, 13 Dec 2021 08:44:57 -0800 (PST)
MIME-Version: 1.0
References: <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
 <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com> <975a570d388fca79546987f4683fcd33419aad98.1639411309.git.gitgitgadget@gmail.com>
 <211213.86pmq08ogt.gmgdl@evledraar.gmail.com>
In-Reply-To: <211213.86pmq08ogt.gmgdl@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 13 Dec 2021 17:44:46 +0100
Message-ID: <CAFQ2z_MrSEExScfBPku1uTZQgBYyk-B08U98zs5P7LNdLphutg@mail.gmail.com>
Subject: Re: [PATCH v3 02/11] reftable: fix resource leak in error path
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 13, 2021 at 5:21 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Other things in the codebase don't check for NULL before feeding things
> to reftable_free(), and our own free() has a coccicheck rule to catch
> this sort of code, we should probably add reftable_free to that list...

Thanks, changed.

> > +     struct reftable_block_source source =3D { NULL };
>
> Nit: It doesn't matter for semantics, but usually we use "{ 0 }", and
> your 1/11 does too. Would be better to do that here for consistency.

I got a past review where someone complained about this. I don't mind
either way, but would rather not flipflop.

>
> > +     for (i =3D 0; i < sizeof(message)-1; i++) {
> > +             message[i] =3D (uint8_t)(rand() % 64 + ' ');
> > +     }
>
> style: braces not needede.

Done.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
