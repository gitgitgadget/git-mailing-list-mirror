Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF273C433F5
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 14:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbiAXOOv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 09:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbiAXOOt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 09:14:49 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E4CC06173B
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 06:14:49 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id b16so31217422uaq.4
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 06:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cwlzWlm2NaSkW/g7wmSjA8+wjUmDEB2HJnR/q8iSuc8=;
        b=ZJSaXFsYCDBHeQfLlPROzMYajnHYO9nUSqzbOQ1rGHFjmCdMAxOO5NXsCQv3t+pIX3
         r7v6D/3XefvL4O2G0ZUsWjUSopDSn6r+p366Y8Jp66aCfh40Qfqy8j0h9vNolFecZjgv
         lTlS3urdVRMlTDQeMlfOeDlGCFD+32Q2xzk7/jg2yjdB1USZHPj3vyDuJiAjVq8yqtpH
         +cKU/cdLkO1ronYNkv/yCrkq86wmxTPSFnrncZkI/Utm4dD2tX/Vqef9QJ46yMwiG3Aj
         6j1zIwdI+oWlUidHijNpT54p1PPfE7SR4a4fzM45pnPcrNCV+6XGmS/1pLi1/MsNo2vg
         yKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cwlzWlm2NaSkW/g7wmSjA8+wjUmDEB2HJnR/q8iSuc8=;
        b=3K8a6zDqqrn+wCiava/u9oF5wDR0WQRbU2iMWNi8Y1INC9SppdQJXk2UBda9fWQkA/
         BDfu0Jjb4PFjh73vcu2b/19sDN1WU39Ss1Zu8hUkR9KifwLeZxkf88tCcM2+JgYJi1O7
         Hk3jQbBrmvftMB78FOkVgxXSwQr1v0jR29uuhafZDH3xJJ1UaHlmJC9vmHttkLn7qRva
         YEmeLFUb3YzHi/kJYVJSaEYva6KApG6bKnSxOGHBEbkKv7LzdHHP4T9L+ycxaEcyQXeS
         KtSpl70oTA+dfW+jnqN0adwTkB7zmlz2KrUEwDYfDr+fdeTjcug8tqnTWumamCbJqJtd
         pPkQ==
X-Gm-Message-State: AOAM531IBDF16IobcRoP3beDNlXpe/HRHSZ2CUtiTsM4+qWnlFY8J+UF
        uQnl1zLpMdZi8ADkdbpzAiawjUNWjS4dxrOp9G0zJA==
X-Google-Smtp-Source: ABdhPJzX6y7qyS6kHAcnzMG48STSxmtfoZFnZj2KF6mQUvueeqJWlWulr9/bUkykf4VGgG3z5/X01+gxNxYcHSBffdg=
X-Received: by 2002:a67:d98f:: with SMTP id u15mr2486408vsj.16.1643033688110;
 Mon, 24 Jan 2022 06:14:48 -0800 (PST)
MIME-Version: 1.0
References: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
 <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com> <9218bd59b2570ab08f3a2e5c0b590656d00482c4.1642691534.git.gitgitgadget@gmail.com>
 <220121.86a6fpl3hr.gmgdl@evledraar.gmail.com>
In-Reply-To: <220121.86a6fpl3hr.gmgdl@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 24 Jan 2022 15:14:37 +0100
Message-ID: <CAFQ2z_Pe6PsV4nMRqQRrFTnOQ2+Lb1o-pCn2oBiVAkec2RtkPw@mail.gmail.com>
Subject: Re: [PATCH v6 01/15] reftable: fix OOB stack write in print functions
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 21, 2022 at 12:42 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> > -     char hex[2 * GIT_SHA256_RAWSZ + 1] =3D { 0 }; /* BUG */
> > +     char hex[GIT_MAX_HEXSZ + 1] =3D { 0 }; /* BUG */
>
> Is whatever "BUG" this is still current after this change?

I can't remember what this was about. Dropping.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
