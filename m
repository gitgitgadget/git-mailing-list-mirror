Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8047AC433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 16:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbiKVQTR convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 22 Nov 2022 11:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234351AbiKVQS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 11:18:58 -0500
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2694F85159
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 08:16:31 -0800 (PST)
Received: by mail-pj1-f42.google.com with SMTP id q96-20020a17090a1b6900b00218b8f9035cso5576794pjq.5
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 08:16:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXRygA97t/cKIkIWzX88NF/4yvALhYa0vBsAom+8Sn8=;
        b=fvAiSFq3sPVrWpC40K9ACJcebXb6qhnchcUgV+r03zzCoHIUtbSVgT8JazAJeU0Mu7
         xlbQwJ4D8uBuh+qQiGn6dVCmZPDOwfkPHKSvxedjqkHvqzmUW27gF2uv/Uhk4LJ2T2d+
         x0pDeAzdANEBfFU2JF/cp52mZgH3KwRFKyM3pgj2L+0TtUVRpkHNe5OkNjvEM6yqOFQw
         1kOIek7VhFWEpwMTVLHFZzcuIvoUx9JqIgdctSwnaX+j6Xk3gV9q07GYzXYG/XZb2/iJ
         kW+8DhIhsunVMYCHHBZq0jKKO0lzauvUvqeEJxTW1JxKi4vLtS5/Hlxzsj/GjlZ6OoM+
         INJQ==
X-Gm-Message-State: ANoB5pmGWZZlbVgTaJVksUHBiFqtTzWPkeZ5Yq0OzJnFIWUn8nToff1b
        L3GWMHiLuR+5mRUnuJc5/TKJ03kC24RNvyLpVqE=
X-Google-Smtp-Source: AA0mqf7rOyQ2pl0TxO5lbz1Eqiz+9sGOmtTSlfGt/UF6OrNmyOzZ2F6YfyFx+0Cbfrbn5Az2wzVktLCMaTF66q9i1Rk=
X-Received: by 2002:a17:902:868b:b0:186:8c19:d472 with SMTP id
 g11-20020a170902868b00b001868c19d472mr5278867plo.12.1669133772671; Tue, 22
 Nov 2022 08:16:12 -0800 (PST)
MIME-Version: 1.0
References: <4657a19c-89c3-2237-9e6b-db897a492072@opensuse.org>
 <CAPig+cT92EokWeVA_Ou1P6kkaq90wneRrgPqnKLbkHnc=U56Vg@mail.gmail.com> <221122.86zgcj9hmc.gmgdl@evledraar.gmail.com>
In-Reply-To: <221122.86zgcj9hmc.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 22 Nov 2022 11:16:01 -0500
Message-ID: <CAPig+cTniT+_7MxMm3Kc2C_oEtQGg-WA3870baL8990Av6HmJQ@mail.gmail.com>
Subject: Re: git can not be built for s390x since update to git-2.38.0
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Sarah Julia Kriesch <sarah.kriesch@opensuse.org>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 22, 2022 at 9:41 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Mon, Nov 21 2022, Eric Sunshine wrote:
> > The empty "chainlinttmp/tests" file also sounds suspicious. If you
> > haven't already done so, I would recommend following the advice in [1]
> > and running each command individually which Makefile would have run;
> > this might allow you to isolate the problematic command or shell
> > construct if such exists.
>
> I can also reproduce this on gcc202. It's the same issue with ending up
> with an empty "tests" file.

Were you able to determine why the "tests" file is empty? The creation
loop is simple enough:

    for i in $(CHAINLINTTESTS); do \
        echo "test_expect_success '$$i' '" && \
        sed -e '/^# LINT: /d' chainlint/$$i.test && \
        echo "'"; \
    done >'$(CHAINLINTTMP_SQ)'/tests && \

and the file is never changed after that (or shouldn't be).

>         avar@gcc202:/run/user/1632/git/t$ uname -a
>         Linux gcc202 6.0.0-4-sparc64-smp #1 SMP Debian 6.0.8-1 (2022-11-11) sparc64 GNU/Linux
>         avar@gcc202:/run/user/1632/git/t$ lsb_release -a
>         No LSB modules are available.
>         Distributor ID: Debian
>         Description:    Debian GNU/Linux bookworm/sid
>         Release:        n/a
>         Codename:       bookworm

This is one of the compile-machines to which you have access?

> The change at the tip of
> https://lore.kernel.org/git/221122.86cz9fbyln.gmgdl@evledraar.gmail.com/
> fixes it for me, i.e. getting rid of the perl threads stuff...

I'm confused. How does a change to chainlint.pl -- which only reads
the "tests" file -- fix the empty "tests" file?

> That box is built with "useithreads=define", so it's not that it doesn't
> support threading in general.
