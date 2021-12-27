Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C2CC433EF
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 18:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhL0SfJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 13:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbhL0SfI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 13:35:08 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A4CC06173E
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 10:35:08 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id q14so57081101edi.3
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 10:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=AEyDmX8+l9NviRIbxWm0/I/WH2qkbfr9HXgGALD0IKE=;
        b=PDcmJLNLB2sR1vjvP5dIiY9egP/ob8jVYRkoHlldmPHufX7H6pyF5Mi5lutgER43K+
         aBi8TZii08lrdQ7al5KSf1YXiDEpA5ABHKUdht8OkZQewU/B/TVk6mD18/5Aj5j4xplJ
         72XH1yw65fv6h4eNdwQXkHSdL2OswDTzbq1TG4u0aYhBuDkEyBOBAHgdWNz+FcNgF6j/
         P8aBEu47C7Nt8mAlXQh7rTtzVv60OD/24Rp/yL/qPwMUVm8NPv5gzrn1BDIXv3PXavNg
         D0Fd0uf/5F4pUf/AZ878ppJvbGqhwyiS4SF+pHFvLhkJsyEt2HI/TiAeMkQOg31Uy6Xl
         f0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=AEyDmX8+l9NviRIbxWm0/I/WH2qkbfr9HXgGALD0IKE=;
        b=ADh4jMktRRrRI9w/H0IlllWwjP9nuYNRsCV0BHZwzuj/xxtlx9eBQ9gcbFT7en8G9P
         khzeAmthfBdSIwa/h/TVVucolXyO2VylqrJ/xuYvv+IDek74ILIXoWSUq9ogMSgnURtN
         SV9wyKBmuQiPUpEedwqrZq+EF1hjE4Hs/DK7Ybzjq2c0jyS3LevOVriiwKecDQZj0oh2
         IEfSpCUvB1ThuKJiE6dTvk/IUi/YZkHaX/ZkkjOLcf0NqCRHCI9WmYjfnnKgbumNF/WO
         qKGxLydzQWQ25qj9+5kWUyupwONVnvCPXBGK7RM+pYb5HAzWeyk+80LXYP7D9vwOiRnh
         UHww==
X-Gm-Message-State: AOAM531+1KMBAs4B5P9hvcnvrzvg9cDtD0iFzsHV7tJmBJm2apvl5m5s
        bXQB7+VjABNdn/nuhN3mUJbjhSM50XvCFHwOJ9/1Cw73ZYg=
X-Google-Smtp-Source: ABdhPJwmuFP2fNsWG8b+y0ZgJoV9KDU95p5PEqG6IKrRdJ/d/RP8MkDTBeRoT6zjskB+yPtunHh14jF5sPS5VFqhv6E=
X-Received: by 2002:a17:907:6e0d:: with SMTP id sd13mr14739794ejc.90.1640630106520;
 Mon, 27 Dec 2021 10:35:06 -0800 (PST)
MIME-Version: 1.0
From:   Ralf Thielow <ralf.thielow@gmail.com>
Date:   Mon, 27 Dec 2021 19:34:30 +0100
Message-ID: <CAN0XMOK8iHZnbtYw7CPAQGJcmuVSDxQoFNFEwiaa41V89F1rzA@mail.gmail.com>
Subject: [BUG?] assertion failure when merging branches
To:     git <git@vger.kernel.org>
Cc:     newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

At $WORK I tried to merge two branches and ran into an assertion
failure. I exported the two branches down to the merge base as
an anonymous repo, so that it can be reproduced.

In the branch I tried to merge into, files have been moved
and/or reformatted.

My Git version is 2.34.1.

wget https://gist.github.com/ralfth/5b624abb0a99e3e705a0984c4b2d253e/raw/7f7ef5b10711550b90342c50b53ce25c19075c97/repo.txt
mkdir tmp
cd tmp
git init
cat ../repo.txt | git fast-import
git checkout ref0/ref1
git config merge.renormalize true
git merge ref2/ref0/ref3

git: merge-ort.c:3846: process_entry: Assertion `!ci->df_conflict &&
!ci->path_conflict' failed.
Aborted (core dumped)

Ciao,
Ralf
