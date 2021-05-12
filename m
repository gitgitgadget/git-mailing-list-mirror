Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBCCC43460
	for <git@archiver.kernel.org>; Wed, 12 May 2021 20:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EBA8611AB
	for <git@archiver.kernel.org>; Wed, 12 May 2021 20:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344281AbhELUiN convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 12 May 2021 16:38:13 -0400
Received: from mail-ej1-f52.google.com ([209.85.218.52]:41860 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383716AbhELTxe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 15:53:34 -0400
Received: by mail-ej1-f52.google.com with SMTP id k10so5518034ejj.8
        for <git@vger.kernel.org>; Wed, 12 May 2021 12:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QEnQRRD2/jpUqgo5TrGHJQjzaHQHRhs+3K5il6JNzf0=;
        b=KMtlGU9+zvWqS8I3XJdlY3x/G+3CMSdYvCHO852YNKbDILYtYMQAZMzLnukHbqf2g+
         eizKWZjS5KVYcgn2IInWrbISzTjhPfAz8kyydk+qH2VfUag5LdXyVxXYBA7enmScT+0r
         8TyQYzzcbndUvpO2o8c3zPFmc+Ldf/AS011bEkJCfqdxqla2juKGu4sfZcksz8qjloSt
         mX8Yjo2HeOYAfaHp5lqR/AnCdv9jLE36xjPVItpBkttBNYJeu8eXtP1y+w3KA1zU68FT
         ADIEajwGFvpK/BAnUs7xQQHX4Yzb1yAtqlFpJv2TVZU7yCl1F/XzJrJrbgZ2VvnbiCWj
         xGDg==
X-Gm-Message-State: AOAM532G4LplYzxUfz1iLlIw5q7GHBs+/BosFg0Rs+42DPKwkzhkTleZ
        FFrCyuuUSGU1EI270yyi8ibFEj/ZCN5a/psclVc=
X-Google-Smtp-Source: ABdhPJwKcrLfNOQJmhmprycTeSAkW4CgJv5lzb7R1+JxYlMATjlToXpXDePbNWPD5ixaf7vcxEvSUEf87enAXA+Mi4o=
X-Received: by 2002:a17:907:3f99:: with SMTP id hr25mr40162892ejc.231.1620849144365;
 Wed, 12 May 2021 12:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com> <patch-9.9-0d87c9a5a3-20210512T132955Z-avarab@gmail.com>
In-Reply-To: <patch-9.9-0d87c9a5a3-20210512T132955Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 12 May 2021 15:52:13 -0400
Message-ID: <CAPig+cSxFzg5F6xfLK0hnWg5tjQ7qbcpaQb=SR0sY2tFQVrbvA@mail.gmail.com>
Subject: Re: [PATCH 9/9] send-email: move trivial config handling to Perl
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 12, 2021 at 9:48 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Optimize the startup time of git-send-email by using an amended
> config_regexp() function to retrieve the list of config keys and
> values we're interested in.
>
> For boolean keys we can handle the [true|false] case ourselves, and
> the "--get" case didn't need any parsing. Let's leave "--path" and
> other "--bool" cases to "git config". As noted in a preceding commit
> we're free to change the config_regexp() function, it's only used by
> "git send-email".
>
> This brings the runtime of "git send-email" from ~60-~70ms to a very
> steady ~40ms on my test box. We no run just one "git config"

s/no/now/

> invocation on startup instead of 8, the exact number will differ based
> on the local sendemail.* config. I happen to have 8 of those set.
>
> This brings the runtime of t9001-send-email.sh from ~13s down to ~12s
> for me. The change there is less impressive as many of those tests set
> various config values, and we're also getting to the point of
> diminishing returns for optimizing "git send-email" itself.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
