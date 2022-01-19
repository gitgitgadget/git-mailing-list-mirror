Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BC1C433F5
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 20:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244899AbiASUiF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 15:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbiASUiF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 15:38:05 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FCFC061574
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 12:38:05 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id g81so11117317ybg.10
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 12:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herrmann.io; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=nrETmxp03Emno/NwEnEM2Tjp704kX1ZHsHcNb4Vy6PQ=;
        b=Xs3OZ6/aaoqRAGdKbJ0QJEIZ2n9a5LE5fZjU1/y1wDrT2zmZ/0JP9KLcZ+Za/uQdVX
         J2jcdUj4RQyHQUrE6UyzGfl6C/9GSeB0UMpVeG+cGxxAkOsGL+Y9HuFfu5fFnDQ6NVse
         CnnItRax+lUWw6z/2FSOZYkevGF7p1rifSUls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=nrETmxp03Emno/NwEnEM2Tjp704kX1ZHsHcNb4Vy6PQ=;
        b=iPKMKD4IFbY2duuniM54VDuFDp09VKwXruaEE0HWzacqDlWY5sB+fUC5cjFF4/KxNm
         3flLXRL7bePrMgL9J9wmAfyc9/coWyyaBAlli5Tsbi3E5u5/LNUvlxfPC4cAAZ0R9tnC
         R+yhwouOx1+i7USNGL9kenet33Ty7GWqhuW0m1qYPh2hnobl9SmcjL42yR+q6RFANXKs
         Gx1NSA88yK32sMOs4uUnCtIwEwnoDNYG25MxVvA5sXh+z+bXt+yq16YsuO68CF5S1ECa
         e3sOpPYwo+4Ktv3auycigAz/vE2xh2isZSh6ccJcPOFWkkNcExIgeeHAUcKY1gg9k+ZF
         6SeQ==
X-Gm-Message-State: AOAM5300k+phM6gXeGisWOlfdQWPcAAXrxsqbT/WJtVfbcZNg4Soksst
        bg4n5l1QtzUf5azVInAJ8d68a/ZIOgaTzL/NQm1DvKwzpsgHXFHb
X-Google-Smtp-Source: ABdhPJx1g9hOaMGk/rmYKJ/lSRjd1xm1tEldEPo3dx5WiA1H9Bat8jRC5wVf5rAlxASidE5i/jzQ9S4olMsv8G4rsR8=
X-Received: by 2002:a25:55c2:: with SMTP id j185mr42210476ybb.763.1642624684293;
 Wed, 19 Jan 2022 12:38:04 -0800 (PST)
MIME-Version: 1.0
From:   Michael Herrmann <michael@herrmann.io>
Date:   Wed, 19 Jan 2022 17:37:48 -0300
Message-ID: <CABrKpmDseZkPCpRb8KmBJaxDp24sySJay5ffZrxqgSMGKyj5qQ@mail.gmail.com>
Subject: A puzzle: reset --hard and hard links
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

It seems `git reset --hard` recreates files that have external hard
links. Is this intended?

The example below highlights the behavior. I have an unchanged Git
repository. When I create an (outside) hard link to a file in the
repository, then `git reset --hard` re-creates the file with a new
modification time and inode. This occurs on Debian 11 with Git 2.30.2
but not on Debian 10 with Git 2.20.1

> git init
Initialized empty Git repository in .../git-test/.git/
> echo "test" > file.txt
> git add file.txt
> git commit -m "Import"
[main (root-commit) f73709f] Import
 1 file changed, 1 insertion(+)
 create mode 100644 file.txt
> stat -c '%y' file.txt
2022-01-19 18:43:52.147781748 +0100
> ls -i file.txt
74458979 file.txt
> ln file.txt ../file.txt
> git reset --hard
HEAD is now at f73709f Import
> stat -c '%y' file.txt
2022-01-19 18:44:47.013167127 +0100
> ls -i file.txt
74458995 file.txt

Can this behavior be avoided?

Best,
Michael
