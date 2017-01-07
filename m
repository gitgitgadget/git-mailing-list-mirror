Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DFB820756
	for <e@80x24.org>; Sat,  7 Jan 2017 12:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935330AbdAGMuY (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jan 2017 07:50:24 -0500
Received: from mail-wj0-f175.google.com ([209.85.210.175]:35325 "EHLO
        mail-wj0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932130AbdAGMuW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2017 07:50:22 -0500
Received: by mail-wj0-f175.google.com with SMTP id i20so47643922wjn.2
        for <git@vger.kernel.org>; Sat, 07 Jan 2017 04:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=qTESAE6xWTYfYtlfml+SEg2bZSq3AIv3ell+Ph2q+Fs=;
        b=Z5SsopCOGbWTFkuUS4ti9mQzLjD5emxfuwLhp5dF2srqhJBSR84h3jdpJ1ddSvKs20
         nyuq+qXV5QjBYzPX3qRULnyxLunrn6MXExVRtgMcr7/j8LcYzLQiEP2QGCrtYv496TVT
         H6fQFYs3nq+/h4JRaTIr1brz6NQRiTkqhKgo7H/3/+/N5Fw7Hat18+l5tFlSZMu2tRCG
         8kDPWQ+xEQngReYSVKK2vkx4JTK2bci6YTSIbH3ucW/NaBIzQK/wgVszuoAZRiXmnlqX
         dRGHeMlqrjgmeJiEa+vcRijHHYDYWX9a9vG/i2qr6VAPD49Lol5OEz9QFhwS3GvVxfzA
         cJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=qTESAE6xWTYfYtlfml+SEg2bZSq3AIv3ell+Ph2q+Fs=;
        b=LrZrxM4vwCt+n0DCbpEICO8OHglLHdxCFVW4oEBXj4vXpnbLhkgAi9yj8Rc5wDQWJg
         cTOgTrt6BkrSwBxu1GXklNaqWO1rgUjhkIcJAxvbV3cCxnm9Mx4Nn/Gv5DBeeW7gpW5k
         ml4d9uZ4Yc5ZOdhnmwZbFXtbHI7axSoK72MhNxjaUO8payaDBhdLqYkNL60BvOWMJBVa
         d2u+MlYSsRVYEQCcD9iT8MN7hNDqZWrUXfjaNNBUssczFa4J6mEoNaHOdosi/KQcCrFG
         FHhX4pZ9COlAuZtMGgsMXTPdBjb4LRGSoV3nkM3x6FY7Nx3N8yR0ZaraSwHyFt23hLeW
         2fJQ==
X-Gm-Message-State: AIkVDXJjOlLNuVYIYh9ITihmGnOUUQ85riklIa/+xazyD+rGrYSmIlhT6FWdH2zmMNWHtQaCk1DTzT/Q3y4njA==
X-Received: by 10.194.248.233 with SMTP id yp9mr62370250wjc.228.1483793420283;
 Sat, 07 Jan 2017 04:50:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.94.71 with HTTP; Sat, 7 Jan 2017 04:50:19 -0800 (PST)
From:   John Szakmeister <john@szakmeister.net>
Date:   Sat, 7 Jan 2017 07:50:19 -0500
X-Google-Sender-Auth: PDNQxeirc2aW-YLLTleIjCeYy4w
Message-ID: <CAEBDL5Uc39JagdmXUxfxh1TPSK3H5wxoTfjK-pfLRYjciBnHpA@mail.gmail.com>
Subject: "git fsck" not detecting garbage at the end of blob object files...
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was perusing StackOverflow this morning and ran across this
question: http://stackoverflow.com/questions/41521143/git-fsck-full-only-checking-directories/

It was a simple question about why "checking objects" was not
appearing, but in it was another issue.  The user purposefully
corrupted a blob object file to see if `git fsck` would catch it by
tacking extra data on at the end.  `git fsck` happily said everything
was okay, but when I played with things locally I found out that `git
gc` does not like that extra garbage.  I'm not sure what the trade-off
needs to be here, but my expectation is that if `git fsck` says
everything is okay, then all operations using that object (file)
should work too.

Is that unreasonable?  What would be the impact of fixing this issue?

-John
