Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1ADC43334
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 17:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237381AbiFBRIo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 13:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236798AbiFBRIn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 13:08:43 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2AB62BC1
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 10:08:42 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id n10so11196873ejk.5
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 10:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=OFVQSoqRnXmvb2WHkvdr8Jn0wz3YNLYc2XjScEZH8R0=;
        b=gY5+U63CBq8dqzKwkD9nLoO8KB3q4xdRdal1NKHYZ6iO2QDRzMkNp+trc8AUHBcUCz
         QwmxoItmzp3hTfC1GKjr8DJ7dH3Pu5kXRodh+Dq4d8pplZi7gK83gUdHskAgkudPLn3L
         70sNTDl0kRlRK2NYbJ9EQpJnHPTYnifAi4ttE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=OFVQSoqRnXmvb2WHkvdr8Jn0wz3YNLYc2XjScEZH8R0=;
        b=kEYEkMttX0xD303pKfPbC3gfSAnmUrNGmKdbXGxHSS4fVmmXtJc4AbGigmc5o1CCJJ
         K2jmaAht9HUp+J4BYVIjprgn9XPeYbnNjmnBBLM0sgi5ZYx2qcGRIWveDf6SGZXS+/8i
         BEwGhJ8ueCEH08cZmwNSlX7hAwDdzWnHjQHADmzjbdSoiSx27mGAkJYYYTu3BGuSKwxt
         qWr0it1HIHLfBqsQ2qyRmldux1FsNy261rkeOEICi4ubC5aslCRqm+6hY3aC4c7DfeFj
         x3Xxw5utBdjDI7Nezhw0W2DX8ZIisEr9EIj5AEGZ8f3AKX9w3/xc5CFzZ7dEl3J2Mttc
         bydQ==
X-Gm-Message-State: AOAM531KzVuJHvVIVTF4E1qhdreCB+QrxAnLUysACII89VMaWD/IVEBy
        dxxq3jbrQAaUzYwEcFBXWaBMIByKgQQ2BG7rQfQebMTS1gSlalK4
X-Google-Smtp-Source: ABdhPJyOtx0jgRNb8cRY13PBxzeH2o1iLu0YWpjCz7Hm6UsgH4B/LG81VE0Lh1vMxBGhJfAEF5UJQCdU+kyHASpSZlE=
X-Received: by 2002:a17:907:6e20:b0:6ff:1541:8d34 with SMTP id
 sd32-20020a1709076e2000b006ff15418d34mr5032487ejc.447.1654189721343; Thu, 02
 Jun 2022 10:08:41 -0700 (PDT)
MIME-Version: 1.0
From:   Tao Klerks <tao@klerks.biz>
Date:   Thu, 2 Jun 2022 19:08:30 +0200
Message-ID: <CAPMMpoj8CyhB=g0=HD2Y2w6+mkGVRsgoq6zsb5XCTt95uDELog@mail.gmail.com>
Subject: Cherry-Pick without affecting working tree / index?
To:     git <git@vger.kernel.org>
Cc:     Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

I'm wondering whether it's possible to perform a (non-conflicting)
cherry pick without impacting the working tree (or index).

I understand Elijah Newren has been working on git-merge-tree changes
that would allow for simulating (and even saving) merge commits
without affecting the index or working tree, and I could imagine
that's a piece of how such a thing could/should work, but I'm not
terribly clear on the relationship between merges and cherry-picks.

It *seems* as though I could enact something functionally equivalent
to a cherry-pick by first creating a (temporary) "--ours" merge commit
on the target branch, pretending to have merged the parent commit of
the cherry-pickable one, and then merging the cherry-pick commit
itself on top of that. The resulting tree could be used as the basis
for a final commit on top of the original tip of the target branch, if
that merge were clean, and otherwise fail saying "there are conflicts,
go do things properly in a working tree pls".

I'm not sure whether this is the right way to conceive of
cherry-picking, however, or whether it makes more sense to conceive of
it as a single-commit rebase. Is there a relationship between
git-merge-tree and rebases? Is there an aspiration to develop "server
side rebase" also at some stage?

Thanks for any help understanding how cherry-picks conceptually "work".

Thanks,
Tao
