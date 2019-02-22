Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A528E20248
	for <e@80x24.org>; Fri, 22 Feb 2019 19:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfBVTPO (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 14:15:14 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46426 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfBVTPO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 14:15:14 -0500
Received: by mail-qt1-f194.google.com with SMTP id z25so3709087qti.13
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 11:15:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4tNT+V+IJqoywC6/BEvX15yViANDuDb4NVb+4KKgRVE=;
        b=lELZAVE4RvOf38Kk9uNXbDcXv2/zGd7PauGxrP++Gq8LMHEwp0uuhoeIjv0jHruOfu
         GpesZIy2qyPdYDgTkkLGcIJ3OvaFT8ZNzRX4wHS02xPL1HQqYvDHW5NE+ORM371djpvf
         0Obov0O9E6p5DdXORj444gl6WaK3VZIwdGdo4WFeONMwRrjhovnmDZ0QA0bQsWKq1E7R
         VgDsC3OlhjlDPP9DjXbD7Uw21YAcmdWzxYzMhhqkLzDLoBnaW7aF3Irye3Odyrtc5806
         zb+0fWTxPW3uSL7SLDBQ0cXSu6YnDqTiG/MT1nVcUhv3Ex0BQ8qYqWpeqzRUjTccplpO
         uu9A==
X-Gm-Message-State: AHQUAuYQ7TeAUXG/FoFKP8luAjdGTiZ7CFfBj36jpSEVfVL9h7PhSXE1
        glKStzqSnH4qAryoCiovIk23oham9U9DbY5IAgw=
X-Google-Smtp-Source: AHgI3IajlotZA8SI/pCxVc6+ZtugHqs+vmsHV8QrSBvLqRaInpuIxXniLQ7139eAICYnmEPJTVX5xfFJaD1+RKxIZ4c=
X-Received: by 2002:ac8:300a:: with SMTP id f10mr4289576qte.236.1550862913545;
 Fri, 22 Feb 2019 11:15:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550170980.git.jonathantanmy@google.com>
 <cover.1550780213.git.jonathantanmy@google.com> <b0ff17d324d46822da9db898d187dcc5fb0467ca.1550780213.git.jonathantanmy@google.com>
 <CAPig+cQNg26zHm=ns3PsmPHEsNo4M7hTSG8=oO_uKqEa4wf3Vw@mail.gmail.com>
In-Reply-To: <CAPig+cQNg26zHm=ns3PsmPHEsNo4M7hTSG8=oO_uKqEa4wf3Vw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 22 Feb 2019 14:15:02 -0500
Message-ID: <CAPig+cS02Vr9Wwz2+UWcm1f1oNO6hcGe35VpM5RNdc=fTHJhxQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] remote-curl: use post_rpc() for protocol v2 also
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 22, 2019 at 8:18 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, Feb 21, 2019 at 3:25 PM Jonathan Tan <jonathantanmy@google.com> wrote:
> > +       for i in $(test_seq 1 1500)
> > +       do
> > +               # do not use here-doc, because it requires a process
> > +               # per loop iteration
> > +               echo "commit refs/heads/too-many-refs-$i" &&
> > +               echo "committer git <git@example.com> $i +0000" &&
> > +               echo "data 0" &&
> > +               echo "M 644 inline bla.txt" &&
> > +               echo "data 4" &&
> > +               echo "bla"
> > +       done | git -C "$HTTPD_DOCUMENT_ROOT_PATH/big" fast-import &&
>
> Although not outright wrong, maintaining an &&-chain in the loop body
> is a bit misleading here for a couple reasons. First, without "|| exit
> 1" at the end of the body, neither the loop nor the test itself will
> abort early if some command within the body fails. [...]

I meant "|| return 1", not "|| exit 1".

> By the way, I see that this same script already contains a couple
> tests with loops neglecting the trailing "|| exit 1", hence they too
> fail to abort early if something goes wrong inside the body [...]

Ditto.
