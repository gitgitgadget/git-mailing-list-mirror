Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B186C38145
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 15:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbiIHPBi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 11:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbiIHPBd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 11:01:33 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B66127542
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 08:01:31 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id jm11so18104122plb.13
        for <git@vger.kernel.org>; Thu, 08 Sep 2022 08:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=gJsvB4O2cFuhZiJK/v7dTOleMPBxri922Rxy76G4B8o=;
        b=Mu8ndOu8R+del1LKspE6KMhpTS2Teli9ROIDYtJ+iBEBuGZhHG7LGg5936PSmIIEKY
         AmVOogkxNVdynlGya4QPN7G76MUjzYfNbxTJRdG06qkfoNm2eWVFdOUhpxZSGE59ekyf
         iaIgJHdLyMmuO/nuRIYwz+wogRg7e6AC05DfwWqsm91vJa3Y9IJOUF1qENm1TkonbXw0
         6dV1DP7sRe69kuBLwQ3/S1zk7tYRqGWfpuZfdzlMe/HlNJ9I64S+O46APnDgtwd0MMUm
         5kEpvkXXPHBKGheiqGbIEy+h2ZXElS9IHM85rPV3S+CgfVhNIVRwIUpl2QKdABqy3hF+
         08sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=gJsvB4O2cFuhZiJK/v7dTOleMPBxri922Rxy76G4B8o=;
        b=fXdk5vJZm4xXFs/oa76yTIWWoehhVAYpe6daC8Gh4WvwHa1CC4sYr57Q6ZGNpJ7m0P
         DtPWLe8HjJrD4f97FX4/W3RPjKnSeFiAKe70fZdQe8TK6Ih+tHA2zeBbXULyIaOUUxGK
         JsaXG7Y+eBCZ/BHVkscseV4klnt0yq+nJFJEQUVUGgSFY/PqWNhJ2JMt/fwhUJ0r/y8z
         K/tIDrYj7gMVPiCJbVxh9UIxaQ1bTBnZ/9cu3U0zmbmKMSzNxgduEkfupeclfOjYTSCD
         c/nTZVHqgY4+k8IJKj2VDVfdwklLbwRCh8aoOIoux6fhZnTAt6VaFXltExSJUkGWzTh/
         ojjg==
X-Gm-Message-State: ACgBeo0HTSb16jEJRXGJ2jmskIfvT6q4IWKH9AUBvF4lUYnbR/2MRyOj
        qTdCElI8WGDuvmf6mb3WmFC3hCPwQ4SFfRgPXG+u3smXrlnX4g==
X-Google-Smtp-Source: AA6agR63yFtLpfhS2QY3SyoORjTmoh5lh+R4KiDr6Jw9/2yRV1cG2U4PEyZJII+HHAJIT3lqxfDvrnWXX0v2XeMsZoU=
X-Received: by 2002:a17:90b:17ce:b0:1fb:3b43:f6f8 with SMTP id
 me14-20020a17090b17ce00b001fb3b43f6f8mr4818778pjb.76.1662649290329; Thu, 08
 Sep 2022 08:01:30 -0700 (PDT)
MIME-Version: 1.0
From:   Pieter-Jan Busschaert <pieterjan.busschaert@gmail.com>
Date:   Thu, 8 Sep 2022 17:01:19 +0200
Message-ID: <CABxXVRS-9unw-8_N8w2bdj4E5Ch780tMetJyD+++ixdWsBv90A@mail.gmail.com>
Subject: Question related to submodule and different recurse config options
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I'm trying to set my git config like this (fetch.recurseSubmodules =
on-demand) and (submodule.recurse = true). The goal is to do fetch &
submodule update if-and-only-if the pointed-to commit changes.

However, it seems with this config a git pull will act as if
fetch.recurseSubmodules was set to true (instead of on-demand) and do
a fetch on all of the submodules. For me this does not correspond to
the documentation (which says the value of submodule.recurse will only
be used if fetch.recurseSubmodules is NOT set). I would have thought
that this recent commit:
https://github.com/git/git/commit/ed54e1b31ad1a9a35ef6c23024d325a2c4d85221
describes this scenario and fixed it, but I still have that behaviour
(git 2.37.3). Maybe that patch only covered true/false settings for
fetch.recurseSubmodules and doesn't properly handle the on-demand
setting?

Is what I see the intended behaviour?
Is it possible in any way to configure git to only fetch & update
submodules if the pointed-to commit changes?



Kind regards,

Pieter-Jan
