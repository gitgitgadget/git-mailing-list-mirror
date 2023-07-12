Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5460AEB64DC
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 00:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjGLAqL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jul 2023 20:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGLAqK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2023 20:46:10 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DB210C2
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 17:46:09 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-565db4666d7so4368855eaf.0
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 17:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689122768; x=1691714768;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WpNtuBm2diu/6uo1gtcQG41LN1rHdynUjK6pLkF7Ckk=;
        b=VnlioV09jZa/zSD9ggLVlS0AqZr8TluQWNi7jthJ1jeqPlQOCIEiwdCt/v7pYhroRK
         zQyzOB22Oa1mOguox6JnOp60figffcyAqw2cTF2rsnB4cJJNF/7o75JJx75y2io9g9K/
         MnW4cpcV87gGgLM+fiH78wxHjQZZ/8VfSecSSlMH/DWnTZsVlU1nH/7nClW4Wy6tdUxB
         pcRm2/SJ3DAD8Bo6AdA3M8F3aXoru+kS824AEmFMgnIZP+Kko6C4NiCQNWw2qsm9VDmR
         +/pNXcC9xNmodIGAyFePc1s0bs840t37r0nbR/fJ3ahvjrVsA0Ke8xhCVsH7iEvEuani
         WpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689122768; x=1691714768;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WpNtuBm2diu/6uo1gtcQG41LN1rHdynUjK6pLkF7Ckk=;
        b=DLKv8QZkd4xyeHo5Ry68MUr5dOSctrR3bp0Dntd/KA3Pfnnz0kSr36bP2evtsuRUVH
         auanrQi6WB0wxIJkHplYS9qP9D5Ku1KlFWJ0wcel7YI0n0aLgrKByn9OjKVLBLbSjsux
         wjyv22Je8uv8fgzB76fAmNaALVuZHpD3g877l4TtnUoBJvrS19OBnHkqNE7xfx1tj2Vw
         1kGW2loBAeOP2s990Fp0XQCbAucwdO3rQ6h4yzeEGAR+rZGOqb4rTSu4uU9RTJiv6NGY
         9b8iSVZT/Q5R6ZQxVlhlR0A7mLMBtVfj9HBwIZM+SYKZfQr+MVO7XOU16zjFm7kJtcVj
         rV1w==
X-Gm-Message-State: ABy/qLY4nOMwrt/tHGmsFN/IXq244p4f6yn9Jflf6aKHj3TcedVe04qg
        P0y6bxPz3I/eUC/S1N5ERcaXWDxUUIM4kv1OEhEJKJVNbgk=
X-Google-Smtp-Source: APBJJlH12hvQuZGx3pwcjxYXy8V3BQUAcxeP/+UcbKDPEr4LUtvkmnhH5kLHobHxKhLZRok9dxN6FsAI5+kegFKSmzI=
X-Received: by 2002:a4a:4948:0:b0:563:649b:c958 with SMTP id
 z69-20020a4a4948000000b00563649bc958mr11530227ooa.8.1689122767680; Tue, 11
 Jul 2023 17:46:07 -0700 (PDT)
MIME-Version: 1.0
From:   Josh Soref <jsoref@gmail.com>
Date:   Tue, 11 Jul 2023 20:45:54 -0400
Message-ID: <CACZqfqAB7zyn56+NOL=E8Y3bXNiQnJdmVXgzsnj78C-Anw-h2Q@mail.gmail.com>
Subject: [rebase] `fatal: cannot force update the branch ... checkout out at
 ...` is confusing when it isn't active
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Consider this series of unfortunate commands:
```sh
% (cd $(mktemp -d); git init; (touch a; git add a; git commit -m a;
touch b; git add b; git commit -m b; git bisect start; git branch next
HEAD~; git checkout next ) 2>/dev/null >/dev/null; git log --oneline
-1 HEAD; git branch -f main HEAD;)
Initialized empty Git repository in
/private/var/folders/r3/n29fz25x72x191fdv6mhhr3m0000gp/T/tmp.fGD64HAf/.git/
accc238 (HEAD -> next) a
fatal: cannot force update the branch 'main' checked out at
'/private/var/folders/r3/n29fz25x72x191fdv6mhhr3m0000gp/T/tmp.fGD64HAf'
```

It's true git in the repository does have a pin of sorts for the
`main` branch and that `git-rebase` would be very upset if the
branch's location were changed, but as an end user, the `main` branch
is not checked out, the `next` branch is checked out.
