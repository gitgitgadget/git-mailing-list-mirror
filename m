Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F94C352A1
	for <git@archiver.kernel.org>; Sat,  3 Dec 2022 05:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiLCFJl convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 3 Dec 2022 00:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiLCFJi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Dec 2022 00:09:38 -0500
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA1DB90
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 21:09:37 -0800 (PST)
Received: by mail-pg1-f169.google.com with SMTP id h33so6002099pgm.9
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 21:09:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MWqKiafiBNxPn9HJm/hNSJ67kXrQ9bUeAxGPfFFZpms=;
        b=d8BsW/QLfg5Zm1Obm1yZa8Ab4U1JCsxSFCwxbIH7jiHeLrjRkusWKsiQ4sFyiD4KQk
         /Nt2920pMaxpHoL/pRqgzAk4ORg9Bc5Ji6lVgJbvMcokam4TzECfHskXyyj1cdh+5ucv
         kxk4YDW2qtZQIDGE6EQCBcL4CloPK6WiR5yVF9qpg9Kscn4oV7/MMe3dTO26eYKKieUm
         Im9dNgFt+S1BN298F09NAvxvrAXfad7+L3kGzafRgN0oXp6MWKPcOAbeMzQx0Imh+uWh
         46xd0HcCY0H9I1ve1aDsvxNIntYAMywHOvPd7m528TbVvmFFp2hhwpwOXwzFG6R/ytOJ
         Cbkw==
X-Gm-Message-State: ANoB5plITNawGX05wWJZdCTHcguWb8zmYaxASgyZSYjqVsnF38CoI/Mv
        8btmfm5M6YR8kQlDP1X3fNPc4ELSy7Fe6wqJf/k=
X-Google-Smtp-Source: AA0mqf4KjVgxmM2qokFXPVZ6w/4e722w7+Syu3/lZgjyrpU6c2dOjfeG7SOjVKS2L+O8WuCQ41czomebPQ+50T0Qa78=
X-Received: by 2002:a63:d43:0:b0:477:66b9:341b with SMTP id
 3-20020a630d43000000b0047766b9341bmr49013839pgn.130.1670044177060; Fri, 02
 Dec 2022 21:09:37 -0800 (PST)
MIME-Version: 1.0
References: <febcfb0a-c410-fb71-cff9-92acfcb269e2@kdbg.org> <203cb627-2423-8a35-d280-9f9ffc66e072@web.de>
In-Reply-To: <203cb627-2423-8a35-d280-9f9ffc66e072@web.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 3 Dec 2022 00:09:25 -0500
Message-ID: <CAPig+cQack=pJ04fwEiq81x6+2AAG4ni0Gd4GQgr4FS=PERb_Q@mail.gmail.com>
Subject: Re: [PATCH 4/1] t3920: replace two cats with a tee
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 2, 2022 at 11:51 AM René Scharfe <l.s.r@web.de> wrote:
> Use tee(1) to replace two calls of cat(1) for writing files with
> different line endings.  That's shorter and spawns less processes.
> [...]
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
> diff --git a/t/t3920-crlf-messages.sh b/t/t3920-crlf-messages.sh
> @@ -9,8 +9,7 @@ LIB_CRLF_BRANCHES=""
>  create_crlf_ref () {
> -       cat >.crlf-orig-$branch.txt &&
> -       cat .crlf-orig-$branch.txt | append_cr >.crlf-message-$branch.txt &&
> +       tee .crlf-orig-$branch.txt | append_cr >.crlf-message-$branch.txt &&

This feels slightly magical and more difficult to reason about than
using simple redirection to eliminate the second `cat`. Wouldn't this
work just as well?

    cat >.crlf-orig-$branch.txt &&
    append_cr <.crlf-orig-$branch.txt >.crlf-message-$branch.txt &&

(Plus, this avoids introducing `tee` into the test suite, more or
less. The few existing instances are all from the same test author and
don't seem particularly legitimate -- they appear to be aids the
author used while developing the test to be able to watch its output
as it ran.)
