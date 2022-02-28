Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E27C433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 08:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbiB1Iof (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 03:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbiB1Iof (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 03:44:35 -0500
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFF91C11E
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 00:43:56 -0800 (PST)
Received: by mail-pf1-f178.google.com with SMTP id a5so9640191pfv.9
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 00:43:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n0fubRbNDzqIX0M08mbWklOXkQgwCcC+iFyT4lDnUco=;
        b=VQgH5wVnLDO7exBmiFXByDBmOfjB5oUgzJpN62N2/C2Sj1vUzK1EOXuwPy/sIhe0fG
         XUKZm2glxFdQotu5ghN/wjuxEPZyyxeiXmTfOOCQFEzbaCUQpKGGFifZSL4RRMNPGF8v
         tlaxOf83RuhOcDyrO2GeGVLwYWwg0zA1Kzq1YxVcaIIlLMUR67M9EgYyvcEB0FFhQAbE
         pWIuhVX1RZJmVu6tXEmA8RkEANoAIb5BwiqNvbawZXTCGETRUNUuO63NQ3idUC01Qnio
         XamMXPHn/eqfQ0nHV/crg59pUuSCYp/2g6TfwpsK1EK+AdMNltgJdRm4tg+0S7FgIeX6
         jHVA==
X-Gm-Message-State: AOAM5329++ea4bkdi3gqsv34bNPGx5oKIZUi41bg2HtkhVBDiB27d60V
        HgMgysy07brTBlhhd23ooLVBNRZm49ISOFL76K4=
X-Google-Smtp-Source: ABdhPJxSkJUC3+qXUn8Ts4aTXCYTm3UB0u9nWJSKEbjWlCA6z2SYczcSORp+6zRNgt08//y7OWcqgMcI0kcBHLYFvpc=
X-Received: by 2002:a63:9245:0:b0:377:7e40:1905 with SMTP id
 s5-20020a639245000000b003777e401905mr12019203pgn.139.1646037836323; Mon, 28
 Feb 2022 00:43:56 -0800 (PST)
MIME-Version: 1.0
References: <CADDzAfNTuuAWn1ynswTayRqgNNcPn3ou=v6c+z_tRsu5uoqJZA@mail.gmail.com>
 <xmqqilt2g9cb.fsf@gitster.g>
In-Reply-To: <xmqqilt2g9cb.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 28 Feb 2022 03:43:45 -0500
Message-ID: <CAPig+cT9H=rcQz8GhAL5RQP+iXYzYc56yn2eWpQPJz9K0P-zLw@mail.gmail.com>
Subject: Re: "Git worktree list" on paths with newlines
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kang-Che Sung <explorer09@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 25, 2022 at 3:47 PM Junio C Hamano <gitster@pobox.com> wrote:
> Kang-Che Sung <explorer09@gmail.com> writes:
> > I wish "git worktree list --porcelain" would show directory names with some
> > quoting or escaping so that tricky names can be handled easily for any program
> > that reads the porcelain output. But I didn't see any command line option that
> > enables quoting or escaping of file names.
> >
> > Does anyone have an idea on what I could do?
>
> I agree that an output mode that claims to be --porcelain should
> produce output that is machine-parseable without ambiguity.
>
> The usual practice is to use quote_c_style() for output without
> "-z", and with "-z", just use the NUL as the termination character,
> as you shouldn't be listing strings with embedded NUL.

A couple additional comments...

Phillip has just submitted a patch to add a `-z` mode to `git worktree
list --porcelain`. You can see it at [1].

Porcelain mode should indeed be quoting the path using
quote_c_style(); the fact that it doesn't is a bug which would be nice
to fix. This has been discussed previously[2], however, there may be
backward compatibility concerns[3].

[1]: https://lore.kernel.org/git/pull.1164.git.1645801727732.gitgitgadget@gmail.com/
[2]: https://lore.kernel.org/git/CAPig+cQq_RnanDQ3jHfNz_L58WyzmsUJBhtdrLxa=H0v_io+WA@mail.gmail.com/
[3]: https://lore.kernel.org/git/936f9b7c-6d54-00bc-f136-4cb4c2836eb6@gmail.com/
