Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C5FC433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 18:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5091D207FB
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 18:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732988AbgFWSMF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 14:12:05 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50689 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbgFWSMF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 14:12:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id l17so3831601wmj.0
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 11:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RyZfLy/FBCGMA/wgnH3ohjzEgX0dKYdcXjGm9ltAcOc=;
        b=C6o6QY+zCZxRoxpfbb81fqLeZpD82XmjLfBPSV+2N/3ze5tUYrudcOkj+tXXj1xYxO
         mn+fzMWQ1RfjcNX68zbmvbz8LR3fsBml5VGBLbLrkNnYf+FRV9LfWfg6O22JiESqaBXB
         kGaTsNJR3ZQ4SqGqx/fvMobl6K3A9QIolF1MkguonpIyLhjBYyVuJWoxqYNGneFArxgm
         g5t8z1DGzxF//zXKg2vo1ymXmmiY0zA/aiFLaiu3xWNU+BD1UgOhgVZW0DozEZ6+MpIF
         gGmRsxRE1cYe7keCNHwotcKR6IMqpokjpNQxUFKc9+o9zqjUwqFwHmMRhtNk02VYmP7P
         hHiA==
X-Gm-Message-State: AOAM530c0naSXx4+8T7nxjjkJXsLtOSwRZu1YI2SvCFnhqOA29l4aPoP
        cSMIB4HNsG6ql0mZnH3Nv+c+u+Gi2JCXKRxnRYE=
X-Google-Smtp-Source: ABdhPJwAjzKPQwqY5ToKFkm+lj0ZXJkdefzC6oYjkf6k77C2M9FNNd5R5MxiHHPph3i+k0V6FOR8yPXSZ5KHDKbACiU=
X-Received: by 2002:a05:600c:221a:: with SMTP id z26mr18758599wml.177.1592935922916;
 Tue, 23 Jun 2020 11:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200623152436.GA50925@coredump.intra.peff.net> <20200623152505.GI1435482@coredump.intra.peff.net>
In-Reply-To: <20200623152505.GI1435482@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 23 Jun 2020 14:11:51 -0400
Message-ID: <CAPig+cQ1EGR6_8NJ+U3MQEseU1yT9k_AwdL8Mg7qZAB8Ev4y3g@mail.gmail.com>
Subject: Re: [PATCH 09/10] fast-export: allow seeding the anonymized mapping
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 23, 2020 at 11:25 AM Jeff King <peff@peff.net> wrote:
> Let's make it possible to seed the anonymization map. This lets users
> either:
> [...]
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
> @@ -119,6 +119,11 @@ by keeping the marks the same across runs.
> +--seed-anonymized=<from>[:<to>]::
> +       Convert token `<from>` to `<to>` in the anonymized output. If
> +       `<to>` is omitted, map `<from>` to itself (i.e., do not
> +       anonymize it). See the section on `ANONYMIZING` below.

By the way (possible bikeshedding ahead), "seed anonymous" seems
overly technical. I wonder if a name such as
'--anonymize-to=<from>[:<to>]' might be clearer and easier for people
to understand.

In fact, in an earlier email, I asked whether --seed-anonymized should
imply --anonymize. Thinking further on this, I wonder if we even need
the second option name. It should be possible to overload the existing
--anonymize to handle all functions. For instance:

    '--anonymize' would anonymize everything

    '--anonymize=<from>[:<to>]' would anonymize and map <from> to <to>

So, the example you give in the documentation would become:

    git fast-export --all \
        --anonymize=foo.c:secret.c \
        --anonymize=mybranch >stream

Or is that too cryptic?
