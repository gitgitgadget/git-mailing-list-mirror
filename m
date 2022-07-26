Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C92C00140
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 19:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbiGZTgv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 15:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiGZTgu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 15:36:50 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7931C11D
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 12:36:49 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-31f445bd486so35083327b3.13
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 12:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q1ttIlIgauwy3dsbdiFtgaSP+tm/8NvUbdKUShHQCZk=;
        b=BSHLNvkMLVKOV/j80GAcUkgYEpkyr7JWyBSJrA8AWkAIqXZdSJLt4BXZ6h7C7/mTEI
         ThOVJpxlc5GNzLsgJmGabsM6l44CtAWdJ8M2Uujs5m5VhaTWZdhAakuWMGIeIKJWPPUZ
         7J6/qY77j01Iln9n+KtAMW4I3MZ3zjVnfrcp9jwE15vKqSvsa/SZHoCS0Yf9qqg2Ma36
         vBwgDYA25g2De0wCW8hb8W7b69PH/DV8XQhd/frbsT6LMkIKzPUiigwyG6YmzNJ51sU1
         mIPTso580S8YXqGmL0ZL7/vrgqXdgflUPHgHNqnOPI+GXY2p9kiEqdKIryIOi3I4bJZu
         k9Xw==
X-Gm-Message-State: AJIora8q+A7f1rPROfEIKNZzKlTOc+ZNg/El6Y7Dxpxad+zgzD4LGjH3
        Af3pzmthhI3KACZmr5IJn0v2JqqLKr14UExaGI8=
X-Google-Smtp-Source: AGRyM1vIgKUHRmNLF2TZnOyhCFhqSpHdlEJMvmvCDBj8Glhs1UX3NQuxmZ+jNhjg/NdIUUr9gpl3KEDbiIb6ju8y8ok=
X-Received: by 2002:a81:5753:0:b0:31e:7b28:5de0 with SMTP id
 l80-20020a815753000000b0031e7b285de0mr16584892ywb.427.1658864208422; Tue, 26
 Jul 2022 12:36:48 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1266.v4.git.1658325913.gitgitgadget@gmail.com>
 <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com> <6918f0860adbea1156fb7a9f1a5aedd211872481.1658342304.git.gitgitgadget@gmail.com>
 <Yt8/zl/uOLRBRS4h@nand.local>
In-Reply-To: <Yt8/zl/uOLRBRS4h@nand.local>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 26 Jul 2022 15:36:37 -0400
Message-ID: <CAPig+cTEUsebnsAQxunnonpWodUC_9kPAhy8uHor9HNn9-AZEA@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] pack-bitmap: prepare to read lookup table extension
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 25, 2022 at 9:21 PM Taylor Blau <me@ttaylorr.com> wrote:
> On Wed, Jul 20, 2022 at 06:38:22PM +0000, Abhradeep Chakraborty via GitGitGadget wrote:
> > +     triplet->commit_pos = get_be32(p);
> > +     p += sizeof(uint32_t);
> > +     triplet->offset = get_be64(p);
> > +     p += sizeof(uint64_t);
> > +     triplet->xor_row = get_be32(p);
> > +     return 0;
>
> Just noticing this now, but I wonder if we could avoid incrementing `p`
> here and instead write something like:
>
>     triplet->commit_pos = get_be32(p);
>     triplet->offset = get_be64(p + sizeof(uint32_t));
>     triplet->xor_row = get_be64(p + sizeof(uint64_t) + sizeof(uint32_t));
>
> I don't have a strong feeling about it, though, it just seems to read a
> little more directly to me and avoid modifying a variable that is only
> going to live as long as the function executes (p).

While it may not matter much in this tiny function, the code in the
patch sets a better precedent by conforming to a pattern which is more
maintainable in situations involving more pieces of data which need to
be decoded. It's also easier to reason about than the suggested
replacement since you don't have to spend extra cycles double-checking
if it's adding the correct number of and correctly-sized offsets at
each get_be*() invocation. IMHO, the way the patch already handles
this seems preferable.
