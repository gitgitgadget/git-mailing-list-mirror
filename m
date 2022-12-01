Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0F2C43217
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 19:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiLATUE convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 1 Dec 2022 14:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLATUC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 14:20:02 -0500
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171C9C5E09
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 11:20:02 -0800 (PST)
Received: by mail-pj1-f50.google.com with SMTP id q15so1723179pja.0
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 11:20:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BjLMWwSa9qtagBw1ukrLz549ocKJthyjdK/Vy631+5o=;
        b=jlctPWg8tbDpKS6mIYw0iKtHE7ZWZd8yz1Ug7Js+t9C9fb46xCoQyfQGyfgEF11Jaa
         my3L8AEhQaKTzu3LXqnb+V1/vInV4pdc5lr1FMPJo3FCvY1gT0ICNFspBXMVdd5yLjsg
         16kwXKX21kM4/abTY3KHZDlgsWtM/DxgdtMGP5zeUmH/KrtcxUnt8lr1BR0fI+TVE9zf
         3pDN8GotEujHx+wa+EwM4/FHu2d5JbA77Fl0ZjbSisX3SiLY5q5xaZbGABtEShIZxaaC
         LlLCY7ZJQXtDSadR7yPEh4Zujks5YIGQ+XvpK1QWFYbst6ebNrg8n8NW7kRpIeP3Bk08
         zQHg==
X-Gm-Message-State: ANoB5plrzk7HEFaubSMfhtlJtrcxM28RTQQJHSO7DQvpJr5TIdAlzUAE
        jAIRrx44RV+QjqNJweJdQZq66eZGIu8nvhlxI/I=
X-Google-Smtp-Source: AA0mqf7W0lz34mZBngAujNkC//FRpKSoiczihXZZUpQvhhT0tL/4acH7BcV1E4DBA9GXjPMI/9dmpgP4q9HoSc6mIrI=
X-Received: by 2002:a17:902:aa07:b0:188:eee6:e1a6 with SMTP id
 be7-20020a170902aa0700b00188eee6e1a6mr50291634plb.120.1669922401477; Thu, 01
 Dec 2022 11:20:01 -0800 (PST)
MIME-Version: 1.0
References: <0620b4a6-b80a-d8a0-5a35-857b9fe0c986@web.de> <ea838ae7-b635-d4d2-d9df-e96b3d8980af@web.de>
 <221201.86r0xjgicc.gmgdl@evledraar.gmail.com> <572e29a2-3f19-e946-d152-009999651084@web.de>
In-Reply-To: <572e29a2-3f19-e946-d152-009999651084@web.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 1 Dec 2022 14:19:50 -0500
Message-ID: <CAPig+cTdSNfWwN-c7R3-MF6ipAD6-7aVjxRK9f9XaKzg4yhhyg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] diff: build parseopts array on demand
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 1, 2022 at 2:11 PM René Scharfe <l.s.r@web.de> wrote:
> t4205-log-pretty-formats.sh                      (Wstat: 256 Tests: 21 Failed: 0)
>   Non-zero exit status: 1
>   Parse errors: No plan found in TAP output
>
> The TAP error in t4205-log-pretty-formats.sh is fixed by the following
> patch, but I can't explain it:
>
> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> @@ -156,7 +156,7 @@ test_expect_success 'NUL termination with --reflog --pretty=oneline' '
>         for r in $revs
>         do
>                 git show -s --pretty=oneline "$r" >raw &&
> -               cat raw | lf_to_nul || exit 1
> +               cat raw | lf_to_nul || return 1
>         done >expect &&

Makes sense. The `exit 1` undesirably causes the entire script to
abort, which means test_done() is never invoked, whereas `return 1`
makes only the test fail. `exit 1` would be appropriate inside a
subshell but there is no subshell here.
