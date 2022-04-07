Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A480DC433F5
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 00:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiDGAgj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 20:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbiDGAgg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 20:36:36 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115D5C6ECB
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 17:34:38 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id n6-20020a17090a670600b001caa71a9c4aso4592629pjj.1
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 17:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=fQNqYMrBoZp19EfzTgX+RZd8SyzEfcvUVirXZHfuYF8=;
        b=MB1KK3z3NmIbBD5xudqRnyKn2PBPLoDLblhCFl6Tquo+fJNFi+mW5ySvy1e8n9YjXS
         CHI8Hilkhqloyr1btEthIc3Cc9FifJ0TxKFZSNmVjeEP03jbjHtJf8zRkZPXPhF2Qv1U
         HbFdNPu0m6TLxVbWxmWxqb6Nc9aoUtvFvfmXKntexehuqmrXEGP+xmiBi9cuigzytmGB
         K/wJhUlzJF9MVvl8eVxxBhECOzCo5jYt2BXartdcG3gOiIJsgJlCbKO/HwYbn1REWF6e
         ODL/a7pQTS1aNEPrj+d0gnEY+dXxit2xOx91elCfuFmigPG49d2y3rdri/xZgUTKcXdL
         Kn3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=fQNqYMrBoZp19EfzTgX+RZd8SyzEfcvUVirXZHfuYF8=;
        b=HiJ782vPad2jVHLgdG8kQhxf3eIuZlkopAuYzK7xT0vtjXwDDX8AHaqfVrhKMjqJV6
         MB9bDtZLLZgsEw34MXW0k5BjPuZl+ypODeqz/62vsKqsctm198nnpsKJH4/kykOECUh6
         uabls1mMx/bzgV5jLHhEGDwaNVp+ZI+tHCxxTmE8BTGnK28VMiTa7LJ8rPyWFJxiZbw9
         BSKN30MosDS13WBtVC6jWLGZaLhB3x57duHYPjPAeJk+CqJUe8lEvfTWCrGByio9A5dE
         b2CXKJGIfKe7l2oXO2qlysbBMk5yIhRyqJ5muXNC3EttbhYBhxSY2XoNe/ca2A0NAwR0
         B/Bw==
X-Gm-Message-State: AOAM531h2cfSFxcGGin2F2Jw2oRRihyQKJNioYbyW9BKiBfb9I46pqos
        MukFuzl74MwPZgTT9EMbWHLG9IAOmrQ8vArmlt6mmRu6s1S44A==
X-Google-Smtp-Source: ABdhPJyR8FfAec62qctAUkqL7ngHqML7mfEGJ5nK92tD1uaQ9NsVL5d5DCyXdi6BdEBwax8bHoSsDm4+4RBytgtDeyA=
X-Received: by 2002:a17:902:9043:b0:14f:aa08:8497 with SMTP id
 w3-20020a170902904300b0014faa088497mr11249515plz.109.1649291676868; Wed, 06
 Apr 2022 17:34:36 -0700 (PDT)
MIME-Version: 1.0
From:   Bryan Turner <bturner@atlassian.com>
Date:   Wed, 6 Apr 2022 17:34:25 -0700
Message-ID: <CAGyf7-FjqrGYTUwdS=a6nsUnbn0qD9=Pf2Nx=gy6g8KGVRJivw@mail.gmail.com>
Subject: Git 2.36, ls-tree submodule regression?
To:     Git Users <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        dyroneteng@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the test suite for Bitbucket Server, we have a test repository[1]
which has a commit that has a .gitmodules file that lists 3
submodules, each of which has an entry in the tree with "Subproject
commit <SHA>".

The submodules aren't fetched (at least one of them doesn't actually
exist anywhere to fetch), but running git ls-tree in Git 2.35.1 and
prior shows the expected tree data:

$ git ls-tree -r -l ecf42d8adc4d7eb4386e37882d053704067712d4: --
100644 blob c0de405f50ea72f9d2b973dd504671ba63ea7189     346 .gitmodules
100644 blob 493021b1c9e0ecfebcd5ebce646a44138bc60b39      20
add_file/add_file.txt
100644 blob d8c00a7fe6eb6a00378e103a46e3c472c084a949      25
basic_branching/file.txt
100644 blob 927b01c060cf0dc5036e19abeab8e332d9075ea0     167 binary/B.zip
100644 blob 72555d02a139700be930a6734b57c5fab84512b9     167 binary/C.zip
100644 blob 72555d02a139700be930a6734b57c5fab84512b9     167 binary/D.zip
100644 blob 668076c308990933c2df66efb87b946704252486      46
branch_mod_merge/file.txt
100644 blob b1d99e581f0bb8138b8997f9268294e41faee05b      33
modification/mod_file.txt
100644 blob 46fa903c8af8a92c2714a47ae5a341a99c2ee3b2      18 moved_dir/file=
.txt
100644 blob f49abb7d6c366e6f83470e36439bc162234d7963      24
mv_file/moved_file.txt
100644 blob 2e6b03cbbe90d3c9afcfc98967a5a71b4c9cff1a      66
out_of_order/file.txt
160000 commit 0ac826865ce7e8bc76022d49424f52e09b16dc87       -
submodule/atlassian-refapp
160000 commit 92b18c97d9d92d2bd02cfd1d268f22fddddafb67       -
submodule/bamboo-git-plugin
160000 commit 996b4f5a7e242a29fe573582d98f5174142bb97c       - submodule/st=
ash
120000 blob 4cbb553f3f4ac2ee7b01ff6c951d6bf583c39c15      10 symlink/link.t=
xt
100644 blob 57a3592bb2cf8e76e2faef7660945a2fe0e24360      27 symlink/target=
.txt

The same ls-tree command in 2.36.0-rc0 fails:

$ /opt/git/2.36.0-rc0/bin/git ls-tree -r -l
ecf42d8adc4d7eb4386e37882d053704067712d4: --
100644 blob c0de405f50ea72f9d2b973dd504671ba63ea7189     346 .gitmodules
100644 blob 493021b1c9e0ecfebcd5ebce646a44138bc60b39      20
add_file/add_file.txt
100644 blob d8c00a7fe6eb6a00378e103a46e3c472c084a949      25
basic_branching/file.txt
100644 blob 927b01c060cf0dc5036e19abeab8e332d9075ea0     167 binary/B.zip
100644 blob 72555d02a139700be930a6734b57c5fab84512b9     167 binary/C.zip
100644 blob 72555d02a139700be930a6734b57c5fab84512b9     167 binary/D.zip
100644 blob 668076c308990933c2df66efb87b946704252486      46
branch_mod_merge/file.txt
100644 blob b1d99e581f0bb8138b8997f9268294e41faee05b      33
modification/mod_file.txt
100644 blob 46fa903c8af8a92c2714a47ae5a341a99c2ee3b2      18 moved_dir/file=
.txt
100644 blob f49abb7d6c366e6f83470e36439bc162234d7963      24
mv_file/moved_file.txt
100644 blob 2e6b03cbbe90d3c9afcfc98967a5a71b4c9cff1a      66
out_of_order/file.txt
160000 commit 0ac826865ce7e8bc76022d49424f52e09b16dc87       -
submodule/atlassian-refapp
error: Could not read 0ac826865ce7e8bc76022d49424f52e09b16dc87
fatal: Invalid commit 0ac826865ce7e8bc76022d49424f52e09b16dc87 in
submodule path submodule/atlassian-refapp

Bisecting the error selects:

$ git bisect good
9c4d58ff2c385f49585197c8650356955e1fa02e is the first bad commit
commit 9c4d58ff2c385f49585197c8650356955e1fa02e
Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Date:   Wed Mar 23 17:13:15 2022 +0800

    ls-tree: split up "fast path" callbacks

    Make the various if/else in the callbacks for the "fast path" a lot
    easier to read by just using common functions for the parts that are
    common, and have per-format callbacks for those parts that are
    different.

    Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
    Signed-off-by: Teng Long <dyroneteng@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

 builtin/ls-tree.c | 199 ++++++++++++++++++++++++++++++++++----------------=
----
 1 file changed, 125 insertions(+), 74 deletions(-)

(I've CC'd =C3=86var and Teng on this message.)

Looking at the changes in that commit I see differences in the
handling for long listings, so I tried removing the -l. At that point,
the command works again:

$ /opt/git/2.36.0-rc0/bin/git ls-tree -r
ecf42d8adc4d7eb4386e37882d053704067712d4: --
100644 blob c0de405f50ea72f9d2b973dd504671ba63ea7189 .gitmodules
100644 blob 493021b1c9e0ecfebcd5ebce646a44138bc60b39 add_file/add_file.txt
100644 blob d8c00a7fe6eb6a00378e103a46e3c472c084a949 basic_branching/file.t=
xt
100644 blob 927b01c060cf0dc5036e19abeab8e332d9075ea0 binary/B.zip
100644 blob 72555d02a139700be930a6734b57c5fab84512b9 binary/C.zip
100644 blob 72555d02a139700be930a6734b57c5fab84512b9 binary/D.zip
100644 blob 668076c308990933c2df66efb87b946704252486 branch_mod_merge/file.=
txt
100644 blob b1d99e581f0bb8138b8997f9268294e41faee05b modification/mod_file.=
txt
100644 blob 46fa903c8af8a92c2714a47ae5a341a99c2ee3b2 moved_dir/file.txt
100644 blob f49abb7d6c366e6f83470e36439bc162234d7963 mv_file/moved_file.txt
100644 blob 2e6b03cbbe90d3c9afcfc98967a5a71b4c9cff1a out_of_order/file.txt
160000 commit 0ac826865ce7e8bc76022d49424f52e09b16dc87
submodule/atlassian-refapp
160000 commit 92b18c97d9d92d2bd02cfd1d268f22fddddafb67
submodule/bamboo-git-plugin
160000 commit 996b4f5a7e242a29fe573582d98f5174142bb97c submodule/stash
120000 blob 4cbb553f3f4ac2ee7b01ff6c951d6bf583c39c15 symlink/link.txt
100644 blob 57a3592bb2cf8e76e2faef7660945a2fe0e24360 symlink/target.txt

Given the command works without -l, and all -l is supposed to do is
add sizes to blobs, it seems like something has regressed in the logic
that decides whether to continue recursing or move on to the next
sibling?

Can someone else whose C is a little less rusty check this and see if
it's a bug? It almost seems like it _has_ to be, though. Bitbucket
Server manages bare repositories which often include submodules, but
none of those submodules (even assuming they're valid, which is not
always the case for repositories in the wild) are ever _fetched_ into
that bare repository. That implies this would always fail in any
repository that contains submodules referencing other repositories.

Best regards,
Bryan Turner

[1] https://packages.atlassian.com/maven/com/atlassian/stash/git/subreposit=
ories/1.0/subrepositories-1.0.zip
is a zipped bare repository that contains the ecf42d8 commit used
above
