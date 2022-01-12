Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B0CC433F5
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 19:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357211AbiALT4r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 14:56:47 -0500
Received: from mail-pj1-f54.google.com ([209.85.216.54]:36433 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243059AbiALTya (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 14:54:30 -0500
Received: by mail-pj1-f54.google.com with SMTP id i8-20020a17090a138800b001b3936fb375so14475141pja.1
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 11:54:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M9l6KlKDY3ozvnqkEXa5sDHUM0S1Ggf5RYsmLqai2gk=;
        b=paiN5HlG4IMib2VoFmbqIluG03IerM9OWp52jIbLDlpZGXICqRtCNt6ij8oPnDxSMu
         7i0F/zJx9lx0shDxE+GUqstd7frxggkttoej4HhE9K2CtB6Eph1NFYMsEr88YjELqX0x
         6LhGqY7a8hqyL9mR9BUAmBv/NO0Q/wk7XUCr1f7RhHnZUtdwpv8oeAbi9Kl8ZZSrBeB7
         6i0KEER++Fc/81JEf1ntCK7GO/XnfwqQxM9epNsG7pWZzx9xxcjgO11XdCf65z60fQtW
         z906lyitIS6YLIu6NudyAtuwdOWW2EPfl3jNZNI7vd3lhkGNsNQqCcJ/7rLm6BRkuRDr
         rOSg==
X-Gm-Message-State: AOAM530pfBHY5AAz80uiHTscIHgTR8I3NUyBPYdPOfPshx9/ja4auXSf
        Yr8/pAegtRlnQSBfo+jrn//rlM1HDjYguIlSmLs=
X-Google-Smtp-Source: ABdhPJz8iRju5Y5vPN8s6wmg5n92s6R44Jp7fOPt3sD9wM+1854YzoFSQX2r/oeEmBf1t1iJjwDudHiO7uYizWf+oYs=
X-Received: by 2002:a17:902:b688:b0:149:a1d6:c731 with SMTP id
 c8-20020a170902b68800b00149a1d6c731mr1293512pls.145.1642017269023; Wed, 12
 Jan 2022 11:54:29 -0800 (PST)
MIME-Version: 1.0
References: <20220112134635.177877-1-jholdsworth@nvidia.com> <20220112134635.177877-18-jholdsworth@nvidia.com>
In-Reply-To: <20220112134635.177877-18-jholdsworth@nvidia.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 12 Jan 2022 14:54:18 -0500
Message-ID: <CAPig+cSHwN9N1K1Fi2DbZhgRdi=iqBkYB==rMKsrq6vqPQJQ4Q@mail.gmail.com>
Subject: Re: [PATCH 17/20] git-p4: compare to singletons with "is" and "is not"
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     Git List <git@vger.kernel.org>, Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 12, 2022 at 8:47 AM Joel Holdsworth <jholdsworth@nvidia.com> wrote:
> PEP8 recommends that comparisons with singletons such as None should be
> done with "is" and "is not", and never equality operators.
>
> This guideline is described here:
> https://www.python.org/dev/peps/pep-0008/#programming-recommendations
>
> Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
> ---
> diff --git a/git-p4.py b/git-p4.py
> @@ -930,7 +930,7 @@ def p4Where(depotPath):
>              if data[:space] == depotPath:
>                  output = entry
>                  break
> -    if output == None:
> +    if not output:
>          return ""

This changes semantics, doesn't it? It will now return "" for None,
False, and "". Is this change intentional? To match the intent of the
original, I would have expected it to be written:

    if output is None:
        return ""

but, having glanced at the larger context, I suppose the new semantics
may be okay(?).

>  def parseRevision(ref):
> @@ -4497,7 +4497,7 @@ def main():
>      if cmd.needsGit:
> -        if cmd.gitdir == None:
> +        if not cmd.gitdir:
>              cmd.gitdir = os.path.abspath(".git")

Same question/observation as above. In order to save reviewers some
time, perhaps the commit message could say something about why the
semantic change is safe and/or desirable.
