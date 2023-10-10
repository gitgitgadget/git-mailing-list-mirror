Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F38CD8CB4
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 19:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbjJJT6b convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 10 Oct 2023 15:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbjJJT6a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 15:58:30 -0400
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02C48E
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 12:58:28 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-65b0383f618so39332026d6.1
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 12:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696967908; x=1697572708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvkNwsu475IkUn2O5QWGO0zyzE7HPO+fhujCpCV4uxk=;
        b=VweAuDy5AXjCK9C/nUJaCu33Qmh/7oHKZmt74TyERr+Jz4G+0txiVJEmWSr1PgkXUq
         3r9Xj80HmoZH1qgleEaTO0dN/MvHHts9/zsaFp7CO0XlGrfY3kmc6SEneVUJfekDa0+z
         ZyV8HntKwTe/JZiOZteB75Xkdy+DJsn4xhJB8jZ5mGQ6Hr/CM2KhKtJjei2xfu7+oFh9
         zghbKS9JixhJf8FFL5N7UVniRyXxZ5ox3zR0pwOdEYpYW9n2X2Ym0aIDko0WGvn5hgOA
         lQJY/lKo4DxxbWuU4Y73c0ffEQ/9n3HVXEnnmrpVUOFAGZ7SVH1Ro1Wo/7rhDBiaqwVl
         uIDA==
X-Gm-Message-State: AOJu0Ywsrc3HPwwE3c+GnlBJLW8DSdT60sPoS2cs4nYuWipAqHznrC2H
        OZxzD8rAsmkONYr7MtWp2cUcOqcL3tzB7Ctk8c8=
X-Google-Smtp-Source: AGHT+IFb++Y/r3Jhvrhrpky4B004QItyN2R+vBN0JeDqQfiak+DLyZMhov2FV3+yxFgTsZaAJBUv8dtGwAFxMAWaPZ4=
X-Received: by 2002:a05:6214:4a0a:b0:655:ea8d:666d with SMTP id
 pg10-20020a0562144a0a00b00655ea8d666dmr18625569qvb.44.1696967907884; Tue, 10
 Oct 2023 12:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1577.v2.git.git.1696443502.gitgitgadget@gmail.com>
 <pull.1577.v3.git.git.1696967380.gitgitgadget@gmail.com> <cef206d47c724f54220b0b915e5405b48f5eb2cb.1696967380.git.gitgitgadget@gmail.com>
In-Reply-To: <cef206d47c724f54220b0b915e5405b48f5eb2cb.1696967380.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 10 Oct 2023 15:58:16 -0400
Message-ID: <CAPig+cQHSiVbsNTDQWJZcyEA3uAHu5EzbCkd4CSJ7+Sno+Az-Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] attr: read attributes from HEAD when bare repo
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 10, 2023 at 3:49 PM John Cai via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> The motivation for 44451a2e5e (attr: teach "--attr-source=<tree>" global
> option to "git" , 2023-05-06), was to make it possible to use
> gitattributes with bare repositories.
>
> To make it easier to read gitattributes in bare repositories however,
> let's just make HEAD:.gitattributes the default. This is in line with
> how mailmap works, 8c473cecfd (mailmap: default mailmap.blob in bare
> repositories, 2012-12-13).
>
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
> diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
> @@ -342,6 +342,20 @@ test_expect_success 'bare repository: check that .gitattribute is ignored' '
> +test_expect_success 'bare repo defaults to reading .gitattributes from HEAD' '
> +       test_when_finished rm -rf test bare_with_gitattribute &&
> +       git init test &&
> +       (
> +               cd test &&
> +               test_commit gitattributes .gitattributes "f/path test=val"
> +       ) &&

Not at all worth a reroll, rather just for future reference... these
days test_commit() supports -C, so the same could be accomplished
without the subshell or `cd`:

    test_commit -C test gitattributes .gitattributes "f/path test=val" &&

> +       git clone --bare test bare_with_gitattribute &&
> +       echo "f/path: test: val" >expect &&
> +       git -C bare_with_gitattribute check-attr test -- f/path >actual &&
> +       test_cmp expect actual
> +'
