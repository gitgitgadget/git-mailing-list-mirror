Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0ABBC636D6
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 21:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjBQVWk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 16:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjBQVWi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 16:22:38 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100715FC72
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 13:22:35 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id l16so1359027pgt.5
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 13:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enfabrica.net; s=google; t=1676668954;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tUQmSdMi38GacMsAizb87PVjKC5h0B9x+QdFzwqpOnA=;
        b=FAsjpDZNs5RkQPh19tXuIn6aOQ0hAkfys+GjNp9Op6/pOWhSc1caqMy9eNxJ6GJe23
         fyVaKIv7DcLcJm5pS76W8flQmpGJ29rl8Oz1Y7dwQ8PKL0K/gqTBf0e5Vfu5FJT7oiKP
         f9tj/AbwJJYUgYw1dWvqYwSrsGa4bcJ85K75v19MmC9+2FZ1HIegYqw4cWIAZZKEedcm
         ++EeepUFLwLmh3E7Kd1ftLYplv+C+XLLgx2d5JHjsrIgDbIzILDtwP4Hu6Thb+t2vU6B
         vq01rMesxKMV/frbEI6sMFuqXgL2SlCEMgKv7O2BB1vapFXXOR8pEyaI1Cok0gKjEmSq
         R8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676668954;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tUQmSdMi38GacMsAizb87PVjKC5h0B9x+QdFzwqpOnA=;
        b=5jVtFDISTYfr1v5lbagH9C/+dZ26q0wOrrQeGQsETWCTU467vKJ1uUfCGdWuR2x4jq
         ckDdNsop/gJstUEX2zE9r00LJ0c+3X9tcT03E6+EIDFndcvWmWP5hKzR13bxM3otL790
         JSMJRKSqJXFCtxxMLPUH9JDvz29vzb8PiBJuqJltV6phu11PRGTP3eiqu5goKvPVNX5S
         SebNXBvAr/rlYmmhmzqv4Su+x7dnBGxl9uXRJMdY2k7iSpueSAOK2TMoyElPjDOQ+KuY
         cOLl9nynyxvT0Vcg62DC6oiif77Cy+k+9nXR6KtMG+CuF/WVE9t3S4xlCrI8UY2PGm9P
         zyVQ==
X-Gm-Message-State: AO0yUKU3X0Gq7nZ6Nfc8E4doUpw84DQJbN/S8q7YJ3qE01hXfNb+GO8T
        FXRbTQlMe4xJWxz6GSJ8HhMR2Heq8jQeMMpLNxlGOrPYhdb+yDK+
X-Google-Smtp-Source: AK7set+P2nZiPfmGot4YhsTS4SI4hZ3J5xoOf3EaJVcgfi1PYZziTjAsdR0eLIyLEjC+WGretieFfyRw8yBJ78PZqkk=
X-Received: by 2002:a62:14d7:0:b0:5a8:be0a:5293 with SMTP id
 206-20020a6214d7000000b005a8be0a5293mr391424pfu.56.1676668954137; Fri, 17 Feb
 2023 13:22:34 -0800 (PST)
MIME-Version: 1.0
From:   Jonathan Mayer <jonathan@enfabrica.net>
Date:   Fri, 17 Feb 2023 13:21:58 -0800
Message-ID: <CAFAmCQDJ0qEn8ZpY-DJ+M6vdBm12hwr=QDeM4GSY5=fZtFxzPg@mail.gmail.com>
Subject: FR: make git clone --depth and --shallow-since produce maximal set of commits
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Problem: "git clone --shallow-since 2022-12-01 --depth 1" recently
failed with "fatal: the remote end hung up unexpectedly" because the
repo happened to not have any sufficiently recent commits.  I was
hoping that by also specifying "--depth 1" that I would get at least
one commit, but it seems combining these options produces an
intersection of the available commits (in my case, zero).

Obviously I can work around this but,

Proposed change: It would be useful if we changed the behavior of
these flags specified together to produce a union of commits instead
of an intersection.

I doubt there's a lot of prior art use cases depending on the old
behavior.  What do you think?

Thanks!  - Jonathan.
