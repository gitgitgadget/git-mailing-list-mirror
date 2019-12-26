Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A009FC2D0C0
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 20:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C16206CB
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 20:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfLZUjo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 15:39:44 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33751 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbfLZUjo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 15:39:44 -0500
Received: by mail-wr1-f68.google.com with SMTP id b6so24537348wrq.0
        for <git@vger.kernel.org>; Thu, 26 Dec 2019 12:39:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gTfS7680y2wRSW8/siR4R6ooZmdE6TZNurQbJcCgPgE=;
        b=Upvt+xDlezLHEbgtPZ5ZcRttGF2TfY6uyk3aDEFdsG38Pn1UulGahQJOs4bB8wgtBq
         d5OUfv5Cl84ssQbTg8f+dR21SkLWX52carD6o7ZsbMAgQR2UmuUgE0wGTh17Wl9sGQEH
         J8doBT94oe2byJ/e9cX42MgK5WwoiMYwIGyjLIZ+EI9dT/NRD1b3OnL7RYohysByv5sP
         RU/Cmce9fq5jCJbtGltMBjBYNLlehwkkjyFozhosav5TtIKfUnotp047NI7FhuExlsuf
         Fq3jWDUU746GVGL7tFOYb1jmsdOlW2/PATOb0mj9mGZ7yy/PaCFWFSagsVuWibQmptt3
         pYTA==
X-Gm-Message-State: APjAAAXBum+d/1nzwOeR9CXU7NLMeWsYsKovyZiwGQ19RksXRsz5BGtN
        kfBspfDTPAEYY/SciFJJCLEU/pQrta6R9q7qIDkHTw==
X-Google-Smtp-Source: APXvYqwhD71XoX1R32Y3vl9SgB9A/imMZD6slC9R/KqnCSE9kYXK9fuKqE1oAaTSf14d7I/Nahbkmu8dD93Y8M/AJKA=
X-Received: by 2002:adf:b193:: with SMTP id q19mr46952696wra.78.1577392782204;
 Thu, 26 Dec 2019 12:39:42 -0800 (PST)
MIME-Version: 1.0
References: <20191224005816.GC38316@google.com> <20191224010110.GF38316@google.com>
 <xmqqfth6lwgl.fsf@gitster-ct.c.googlers.com> <20191226195357.GA170890@google.com>
 <20191226195747.GC170890@google.com>
In-Reply-To: <20191226195747.GC170890@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 26 Dec 2019 15:39:31 -0500
Message-ID: <CAPig+cTPQROOvXVPxL2bv0FT1FZs+XcWq6rHkhRE8vsTQJsHCA@mail.gmail.com>
Subject: Re: [PATCH 2/2] t/check-non-portable-shell: detect "FOO= shell_func", too
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 26, 2019 at 2:57 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
> Just like assigning a nonempty value, assigning an empty value to a
> shell variable when calling a function produces non-portable behavior:
> in some shells, the assignment lasts for the duration of the function
> invocation, and in others, it persists after the function returns.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
> @@ -46,7 +46,7 @@ sub err {
> -       /^\s*([A-Z0-9_]+=(\w+|(["']).*?\3)\s+)+(\w+)/ and exists($func{$4}) and
> +       /^\s*([A-Z0-9_]+=(\w*|(["']).*?\3)\s+)+(\w+)/ and exists($func{$4}) and
>                 err '"FOO=bar shell_func" assignment extends beyond "shell_func"';

Thanks, the change makes sense. I suspect that I simply overlooked
this case when implementing this.

Acked-by: me
