Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6876C77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 09:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjDRJSf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 05:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDRJSd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 05:18:33 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CB06E9D
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 02:18:19 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id ey8so4565175qtb.3
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 02:18:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681809498; x=1684401498;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HEBsK/rfWyVLTssDzgKkYNf9M8nw0N/tlLBuN1M32nc=;
        b=bvDOiPZxvGxQLB+UC1Cg+u8lsVYFDzadoGrkL+aeY5OmQvR+jpSHdqhCiu2hiiNQw2
         kRZ5mfUb/5NTs9NB8oOZAJ8cJQOzYhd5MDvo5oRSeJfWO2pFRr6O+LedOQQLmBm3RR85
         huzweuzUdB+e5VeJ+6h2+oNU87+QUjDAAC67BZHo06y6Ff1Wfm+dQbjsdm7gHDVj7kbt
         e9D+b2597AFlCpyahJBRkxhUio6rqQ9HBZwvImiJrHh5yDgHhYC3PmScBtA/ujW7nkhe
         pW+VNbj61/m4z+U00IcCZhO5kE8iHVvcvWyYfZMdxKCt7qTswEQ4PxKXKMsvH8E2X4qy
         k1ww==
X-Gm-Message-State: AAQBX9fmHJTlX09Nzu8H8dw+ei11mVuC/tuB+NtEHydshipzYEcVXynj
        4f/Ya94g3o6+aGCsaLdHm2qeX3c/w9njUMhAtH68LNdU8l8=
X-Google-Smtp-Source: AKy350ZlkQ3T0L+/DAVjsfaJ4lqYPg9q3GPOfapvQOy8k8YZ9OCJjrPgF119Op+NFAxiQ/USB3XTEldPNoriA9K9bQQ=
X-Received: by 2002:ac8:5796:0:b0:3e4:e641:6b1f with SMTP id
 v22-20020ac85796000000b003e4e6416b1fmr25998144qta.55.1681809498125; Tue, 18
 Apr 2023 02:18:18 -0700 (PDT)
MIME-Version: 1.0
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Tue, 18 Apr 2023 11:17:42 +0200
Message-ID: <CA+JQ7M_KuDXBaVTzVwLTx+R4-6-3TOuUOpcchkS26iiosc85Hg@mail.gmail.com>
Subject: Git rebase no longer defaults to upstream after force push
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

  git init --bare foo.git && git clone foo.git/ foo && cd foo
  touch bar && git add bar && git commit -m init
  git push -u
  git switch -c a
  seq 1 3 > bar && git add bar && git commit -m 1
  git push
  seq 11 13 > bar && git add bar && git commit -m 2
  git rebase -ir # Works like git rebase -ir @{upstream}
  git push --force origin main:a
  git rebase -ir # No longer works like git rebase -ir @{upstream}

What did you expect to happen? (Expected behavior)

After force pushing, I still expected the rebase to work like git
rebase -ir @{upstream}.

What happened instead? (Actual behavior)

The rebase defaults to a commit other than that of the tip of the
upstream branch.

What's different between what you expected and what actually happened?

Instead of behaving like git rebase @{upstream}, the rebase seems to
default to rebasing on-top of the old upstream.

git rebase -ir result in a todo like this:

l onto

t onto
p f1cfbff 2023-04-18    2

Compared to git rebase -ir @{upstream} which results in a todo like this:

l onto

t onto
p 01e3c92 2023-04-18    1
p f1cfbff 2023-04-18    2

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.40.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.15.90.1-microsoft-standard-WSL2 #1 SMP Fri Jan 27
02:56:13 UTC 2023 x86_64
compiler info: gnuc: 11.3
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]

-- 
Erik Cervin-Edin
