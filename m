Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3B481F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 08:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754515AbeGIIgb (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 04:36:31 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:41317 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754495AbeGIIga (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 04:36:30 -0400
Received: by mail-yb0-f195.google.com with SMTP id s8-v6so6877344ybe.8
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 01:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MVAM6uI4blVPZGxv1hD4mjRfGWRqXmMC0XTjXsXsb/w=;
        b=IKoJ2Yplj95EANVxH1bD2Fv8GuembLDWfnpMGc/BNt3uLhoVZzCSJZIgIaJ7W7NyEu
         jrRmoTsBJt3zOl7vqJrvhxZnA32iP3Hm5TWGlRTrPkUFF2hZTiaSUv+YvmfoVXCdYwjX
         FZQn2Q61Yy4/dwhsDiofBSwKcJjDSycNY3xujaZCZXc/VTNIrswn80af/SFx9yCcr32Q
         iiqK5UNPJlCclnFezEdXFOmWvRfb76fJH/TSpzaI33Yw1RmkI3KGZEW8uwKtND4FPgIC
         pXMyEuNFCUbFoaSX5BXOX+3SxBbUL6vOHEKxcXc1o27erEOWY+LGHvE22KF7VQljA37s
         wo/Q==
X-Gm-Message-State: APt69E2gSks7oocZ1ipC2toQh6iQrfZuoEjZA9XrjGpo5ZZik3X+HmfU
        UBGS2iW4BOqbdM6b8lOtBdYbvdi/pfmp1MA5uQs=
X-Google-Smtp-Source: AAOMgpc8QehseJ5Vba6cTt10/X+b1Kw9sOGT+RIPl2z0OfHTemA7DuNUgVgTPTqAotah3KdnBWorwg7N/GwnKDApQ1g=
X-Received: by 2002:a25:ac44:: with SMTP id r4-v6mr10193626ybd.497.1531125390011;
 Mon, 09 Jul 2018 01:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180628074655.5756-1-predatoramigo@gmail.com>
 <20180708180104.17921-1-predatoramigo@gmail.com> <20180708180104.17921-2-predatoramigo@gmail.com>
 <857b04d8-37b4-596f-6f3e-45b6e2a59442@gmail.com>
In-Reply-To: <857b04d8-37b4-596f-6f3e-45b6e2a59442@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 9 Jul 2018 04:36:19 -0400
Message-ID: <CAPig+cQopjftfSoPHPZQAzECTAUUwZ-pXYMeWEV=VJBFm63t9g@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] rebase: start implementing it as a builtin
To:     rybak.a.v@gmail.com
Cc:     Pratik Karki <predatoramigo@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 9, 2018 at 3:59 AM Andrei Rybak <rybak.a.v@gmail.com> wrote:
> On 2018-07-08 20:01, Pratik Karki wrote:
> > +static int use_builtin_rebase(void)
> > +{
> > +     struct child_process cp = CHILD_PROCESS_INIT;
> > +     struct strbuf out = STRBUF_INIT;
> > +     int ret;
> > +
> > +     argv_array_pushl(&cp.args,
> > +                      "config", "--bool", "rebase.usebuiltin", NULL);
> > +     cp.git_cmd = 1;
> > +     if (capture_command(&cp, &out, 6))
> > +             return 0;
>
> Does strbuf out leak on return here?

Good catch. This _is_ a potential leak. Here is an excerpt from the
documentation of pipe_command(), which is called by capture_command():

    Any output collected in the buffers is kept even if the
    command returns a non-zero exit.

So, yes, this needs a strbuf_release() before returning.

> > +     strbuf_trim(&out);
> > +     ret = !strcmp("true", out.buf);
> > +     strbuf_release(&out);
> > +     return ret;
> > +}
