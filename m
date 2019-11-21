Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BEFC432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 13:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F7720872
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 13:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfKUNMM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 08:12:12 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51185 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfKUNMM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 08:12:12 -0500
Received: by mail-wm1-f67.google.com with SMTP id l17so3679322wmh.0
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 05:12:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wbu2DsxdPF/iIjSM/MJ+Tley0ljNL3TLRbnfkFOMvK4=;
        b=LO1rGi+QrFkfM3avgyd7DrxCqcuAOeTX6p9wN3jISu9OedXKQnXiBVqVRR3TS2cHhU
         lEszoIqYD7Pb2v+bIfRMkF0wgbU3Nx3Ar594MZDZlcUfcb37SNiMAvKdGchE5aqxSD1W
         FWmiTkpRR8IvbSBNYItr2Xb1pAYNAFF/FuDyec8Ye7Ibgmaytd93XfiRLEKBpm7FU5Kn
         pCPXGlO52f/eDnnNvpv+TmPs6H5qg+wYw9YpbuOcF1437l7Fyy72L06nkhdUMTdrW03J
         njuJDGyyEnRW1HbAizBHheit8hdWlg6ViTjDNFd3yMISp58HzkcA999r8WEcwEUccGez
         HOhg==
X-Gm-Message-State: APjAAAWUNbZ6nKU4p3ufWUtjTyTN9BrrjfBhy99UrAGgFnDZ4asSucoo
        dXIpaaxPMXZoiKdNUPaEAVv6N1Vm/46sKfaEgKM=
X-Google-Smtp-Source: APXvYqw56bbT8Zk535oUS7sPcOynzolgOGZQi6rRa5+XsM5GUoGl4KC1BbYHOXc23YHPhCi5oXdByQNbRW2XvB69XQs=
X-Received: by 2002:a7b:c94c:: with SMTP id i12mr5691613wml.95.1574341931045;
 Thu, 21 Nov 2019 05:12:11 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573779465.git.liu.denton@gmail.com> <cover.1574296987.git.liu.denton@gmail.com>
 <d5fb60be6bdd5e885c6f830c8c44ba250350538b.1574296987.git.liu.denton@gmail.com>
In-Reply-To: <d5fb60be6bdd5e885c6f830c8c44ba250350538b.1574296987.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 21 Nov 2019 08:12:00 -0500
Message-ID: <CAPig+cTQapDMZwtOPcSiyu-MSBKxSY2MJ+o9rh3=SC4tFu=u=w@mail.gmail.com>
Subject: Re: [PATCH v2 13/21] t5703: simplify one-time-sed generation logic
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 20, 2019 at 7:46 PM Denton Liu <liu.denton@gmail.com> wrote:
> In inconsistency(), we had two `git rev-parse` invocations in the
> upstream of a pipe within a command substitution. In case this
> invocation ever failed, its exit code would be swallowed up and we would
> not know about it.
>
> Pull the command substitutions out into variable assignments so that
> their return codes are not lost.
>
> Drop the pipe into tr because command substitutions should already strip
> leading and trailing whitespace, including newlines.

Saying that command substitution _should_ strip the whitespace leaves
the reader in doubt as to whether there are situations in which it
might or might not do so. More accurately, command substitution _does_
strip the whitespace, so please drop "should" from this sentence
altogether.

> Finally, convert the printf into an echo because it isn't necessary
> anymore.

This is quite misleading. 'printf' was _never_ necessary; 'echo' was
an appropriate alternative even before the other changes made by this
patch. Worse, though, this sentence provides no context about _why_ it
is safe to change 'printf' to 'echo', so the reader is left with even
more questions trying to understand the validity of this change than
if you had merely omitted this sentence. My review email[1] provided
exact reasoning about why this change is safe. Paraphrasing that
explanation for this patch's commit message would go a long way toward
convincing the reader that the change makes sense.

[1]: https://lore.kernel.org/git/CAPig+cTj5qOCFRoD4cZOg7BjVvetQWTgdRHzSvAfgtX2YgUXPg@mail.gmail.com/
