Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668F8C64EC4
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 23:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjCHXyU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 18:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjCHXyT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 18:54:19 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879E057089
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 15:54:18 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id bo22so484976pjb.4
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 15:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678319657;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p5//oIvE3OHyRevepOHtBxB6aAK/GpDlVtsd+lxQfvM=;
        b=bxGgCwh97C0ZAezNIdRZOUKGbUKtqZQr5L3znPSa4VkF+UionUJWAYgjiUbpYO3jz6
         b3jMh81IXoSiXoEsMyx/4oolAYPys2J9OksnGl5A5WyWzdhjzXLO+BuxsWVRVKEtA/Aa
         6TVuDekExKoHp5HDzDiWXSnuujvqK5PPGM8xi5la3/F1KtWPLFpeUxthfP2WfFlT4H5C
         4IfeLY2I9C0A9Ql0aMoZWw4HbBPE9cK1i/Po1Ywsa68X/52Dp4f4xmQZXAyk1wk3geeZ
         s30KPeTgkJLiOoQVrErtA7Lqy7uVlGccBtd1CCxLryIHJ9WxzktLUdDcNFM1CK0e6JrA
         rHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678319657;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p5//oIvE3OHyRevepOHtBxB6aAK/GpDlVtsd+lxQfvM=;
        b=eIkJkdUpcuU71YUdCz3AwVeUYXDjnIxkUMv2TMwcWYfW6ZSZfV0aJtMCvEfpwftMxC
         6UfIF4dsNThNDICyFvOVT5+1N5JlkcEhXu333i/Ac+uKMIBHGYMMU5DMZ611XhtHtXi4
         GoecXj6Cyve83BYgBu4y9PVXSA1Z+9tFQvop3LA39UXNkDEuz2f2JesmSxUS65hZrEip
         EnhlB4DsNDsoZZ+Zt3szDAtQWSYV9mOBrm+hN5F+QWkFm0kxjzIGe8RWprytQcTNetri
         Afq0kl8lMHDNl/XnbVLVcwOEACR9sHH4Y/7MXp3cfhfk2A+xgHqCwfW9QmM/DQEYRqBS
         3OHA==
X-Gm-Message-State: AO0yUKUkm4lTYRVq+urX1pxAFnc6hp+BlwiNg7E2APSXNSon302HFDgG
        /DZf4eyIgc7oj/iJpybdysOX5jIZGvhwlBkjzfJkATFKA8c=
X-Google-Smtp-Source: AK7set/Moc1MA2fGnZqisp5x29EHHPhxKPvizWZO8At3va+ipxB7exDa6JgS0zJC89NqvBwfrL0VPU6nEycGkJ19s1U=
X-Received: by 2002:a17:90a:6389:b0:236:6e4c:8a1e with SMTP id
 f9-20020a17090a638900b002366e4c8a1emr7224981pjj.1.1678319657540; Wed, 08 Mar
 2023 15:54:17 -0800 (PST)
MIME-Version: 1.0
From:   Jay Asbury <vbjay.net@gmail.com>
Date:   Wed, 8 Mar 2023 18:53:51 -0500
Message-ID: <CAH74SFS3hFzYzJ6eb2YenJh4-Pf_VBzVTo8axnEtHDyaJUB-jw@mail.gmail.com>
Subject: Writing to err vs std
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I see things like git fetch and other processing writing details to
stderr and not std.  Can someone point to why this is and what the
rule is for determining when to write to err vs std?  See
165f390250874b32ed8158150fe49d574297c9f9 for example.  Is there a
standard in the git project that says write this to err while write
that to std?  Any guidance and why would be appreciated.

Thanks,
Jay Asbury
