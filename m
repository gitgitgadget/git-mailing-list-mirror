Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB97EB64D7
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 01:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbjFNBlW convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 13 Jun 2023 21:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjFNBlV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2023 21:41:21 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C3C1AD
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 18:41:20 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-62ddb103debso13884846d6.1
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 18:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686706879; x=1689298879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBDkvM1JsvBB/f0PLMe33WVkCUc2c+cPRuzqV1uEW+E=;
        b=GLV9LlRFx1+LbLKEHiEA8wvy6oIbBYeojHG+ckQfneNvKwHtPCZVz/mw7tDu8mQ3m+
         0Tm2zB6SWd2SBBjT1edd/KywSm/1a4llfS1QMR9YeF+7Uyk36fUI4tEGyHg4t9AQfEGu
         ZaFNmlupo4udUhinfq9OtnJ8mtANi2kgQW99MolPIqQH2WpkAHdPvVWsgXSd9yPjh0LJ
         QvZ5hWeD/m57uqX2Emc6ienICvqTEAdHh/tJLG1R+4CaPKypvQOc+PYLcbk6jFwI8sES
         uKBLioP1n4LVQxa9rE2vZ8x7bavP+SFk6LSnvIM+MQgsiq4LHk+N0rQqJ9AEfip4xolt
         aakw==
X-Gm-Message-State: AC+VfDzQUY1Mo84ZgWRaegL/d8jKf/7hvWxuDA1ZRl0iPBMfittpYQVW
        M8LVEn2ljmgt9s548Ek53fwhyrZvcjpRLLZ3EOI=
X-Google-Smtp-Source: ACHHUZ60uJN4TeAUFErBnZ8Mk/aCJ1Pye83qYm/JUf/EcaNOCrDqduUUNEeTxuJGd6iLjyqJ5oc1Nh6W6OyvgPQnSbE=
X-Received: by 2002:a05:6214:e48:b0:629:78ae:80e3 with SMTP id
 o8-20020a0562140e4800b0062978ae80e3mr17027427qvc.24.1686706879222; Tue, 13
 Jun 2023 18:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1682671758.git.dyroneteng@gmail.com> <ed930ef4f795f30792bc14d9c1939484e4976db8.1682671758.git.dyroneteng@gmail.com>
 <xmqqh6ra26vq.fsf@gitster.g>
In-Reply-To: <xmqqh6ra26vq.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 13 Jun 2023 21:41:08 -0400
Message-ID: <CAPig+cRzx2r34tqqi527sBcDXm3h_sLR1Y7_gX9R4uQ4KUKzFA@mail.gmail.com>
Subject: Re: [PATCH v9 4/6] notes.c: introduce '--separator=<paragraph-break>' option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Teng Long <dyroneteng@gmail.com>, avarab@gmail.com,
        git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2023 at 9:02 PM Junio C Hamano <gitster@pobox.com> wrote:
> This step seems to break CI asan/ubsan job
> https://github.com/git/git/actions/runs/5260417146/jobs/9507299904#step:4:1826
> Perhaps something like this is in order?
>
> diff --git c/builtin/notes.c w/builtin/notes.c
> @@ -239,7 +239,7 @@ static void write_note_data(struct note_data *d, struct object_id *oid)
>  static void append_separator(struct strbuf *message)
>  {
> -       if (separator[strlen(separator) - 1] == '\n')
> +       if (*separator && separator[strlen(separator) - 1] == '\n')

Is this the same issue Peff reported[1]? His proposed solution was a
bit different.

[1]: https://lore.kernel.org/git/20230519005447.GA2955320@coredump.intra.peff.net/
