Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B89B51F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 05:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932191AbeGFFSb (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 01:18:31 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:37563 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932115AbeGFFSa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 01:18:30 -0400
Received: by mail-yw0-f194.google.com with SMTP id w76-v6so3769986ywg.4
        for <git@vger.kernel.org>; Thu, 05 Jul 2018 22:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/IYDETTFabgPN73WlkKMkDgMdxR+C8h8d7TKBS60S/8=;
        b=iuL7W5FoJBiJMO3B6dYr4AQXjKGCYh6i3Daejt43m9zhVrtmL976f6HpUt1s/HzY+f
         ivwB6y3iMVmD26kQtjkaHhKRx3neQV9lMQ+7b0OtHP+wT1FOfbHj61EXRlsAdGd2mYtd
         Ts7+mdQGLjpu+2Hm2JsKjRLXc1KhrDf/H3YidmPhTIw228ly2v29g0mVjlFlaqJ0Yivh
         9iLB15e3PsOH0zZsAYFuUjWfdnEkWoNbDi0hlh/kxAu/8KjI0SMsH4N4CDlwbmU2BD2o
         BOtMXLXQusdPn+olG7SvZOYNK6s/24TFnGvZ91oxnwsyYENdvbZgNrrvEJnD5gEH7P8z
         ronA==
X-Gm-Message-State: APt69E1NaVAQ/wma1oFa5dWq7A34K26Qr1sZPASBWd9YyTgI9hIqk7NV
        tZF9HGpmmKLrs6R76vKmjQOcKSzZVa3bB6Ym2BU=
X-Google-Smtp-Source: AAOMgpclvr0gy4LA3UDDU2NWmE+4suE/V8magFgp12DOhlsuV7JQ9J8RUg/UJ7GdqjYbOY+BUJ0N8H7cD1RNd4alzCo=
X-Received: by 2002:a81:4153:: with SMTP id f19-v6mr4340503ywk.418.1530854310360;
 Thu, 05 Jul 2018 22:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180625143434.89044-1-dstolee@microsoft.com> <20180706005321.124643-1-dstolee@microsoft.com>
 <20180706005321.124643-7-dstolee@microsoft.com> <CAPig+cSntb3=YTBm67+4T1FgLCi585CnUuN__DE2mdo4y2n98A@mail.gmail.com>
In-Reply-To: <CAPig+cSntb3=YTBm67+4T1FgLCi585CnUuN__DE2mdo4y2n98A@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 6 Jul 2018 01:18:19 -0400
Message-ID: <CAPig+cTg9QqxWpOPefuy4KcP3TTQuHted4m4kHThgSG-ZQHuog@mail.gmail.com>
Subject: Re: [PATCH v3 06/24] multi-pack-index: load into memory
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 6, 2018 at 12:19 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, Jul 5, 2018 at 8:53 PM Derrick Stolee <stolee@gmail.com> wrote:
> > +midx_read_expect () {
> > +       cat >expect <<-EOF
> > +       header: 4d494458 1 0 0
> > +       object_dir: .
> > +       EOF
> > +       test-tool read-midx . >actual &&
> > +       test_cmp expect actual
> > +}
> > +
> >  test_expect_success 'write midx with no packs' '
> >         git multi-pack-index --object-dir=. write &&
> > -       test_path_is_file pack/multi-pack-index
> > +       test_path_is_file pack/multi-pack-index &&
> > +       midx_read_expect
>
> Kind of a do-nothing change. I wonder if this step would better be
> delayed until a later patch. (Not necessarily a big deal.)

Never mind. I missed that midx_read_expect() is comparing the 'expect'
and 'actual' files, so this is not a do-nothing change. The function
name may have helped to mislead me (or I was just unobservant or too
focused on its creation of the 'expect' file). I wonder if a different
name would have helped. midx_check(), midx_verify()? Meh.
