Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB356C43217
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 12:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiLAMZY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 07:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbiLAMZX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 07:25:23 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C052AC1B3
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 04:25:21 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id o13so3841927ejm.1
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 04:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sTkOb9vvCGwJDzbl0y655C3IbxfRq3kByubw0OAzo0s=;
        b=Nvo2EjGl7eGZthh8I5289FnXEbTxl3QzFMQqRFMfFAVXSn4MLV1uZRDeHyvdUKxmn/
         7b87mzUlTpiis7HkCxCEg7SGEr0g6QEoMDqXTJBtwGUWcl1o0ZxgUKqBm1yba7DEBnyN
         IfyaNztXf46qpaXWLdw+OzCO7r7SKHtWbzHrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sTkOb9vvCGwJDzbl0y655C3IbxfRq3kByubw0OAzo0s=;
        b=lM8SPtaSOar9Em3lwRzwc2u548mbgXT/3im/LOEHS7FoUaBvKy9fLV6RppAa4HDFu6
         +XdGdDNmMg22wQRGVDDIWZ8g4Mx+BCmyBq6swHCwWNQSBvJqa8zurF+aM91g3AzWh9g1
         9BEEyMbbvKPFu0zcxgTUH5cxfiVvGKMO162P8xJ5Kv9pD5iRImjprjUK6uO+FzqnM3IM
         Q31G5SNqizmMfBDcCrtr7JPysCPbJBbgjHQaPF2Wmf9AwnWtHdaa1Jy+FcWz40d2oilx
         wYZNpdD0MtocG1+bf3iRXDbZz+n+AWYE/tcekcCJnv98nda708H1isivOds/u2SjcXXP
         Z0og==
X-Gm-Message-State: ANoB5pnzSgxtNSggB21EA97q6YUudRVQQdqHSslwZ1RSZSTGOS6gBqvW
        mQW3k2F5kGq49UQinER4Xj7+K6ZjO93dzNKlsVfHk4N5jw2AMioa
X-Google-Smtp-Source: AA0mqf5BOnl31wq3uhsOqwRBcwKLG3M1iNPPwR76Qi8qlPDwq4ZzdtnogMQDlvZNuOQWdVbFTBiGCroCb2TTzG/nDwA=
X-Received: by 2002:a17:907:77cb:b0:7be:39de:9529 with SMTP id
 kz11-20020a17090777cb00b007be39de9529mr19698556ejc.539.1669897519823; Thu, 01
 Dec 2022 04:25:19 -0800 (PST)
MIME-Version: 1.0
From:   Tao Klerks <tao@klerks.biz>
Date:   Thu, 1 Dec 2022 13:25:08 +0100
Message-ID: <CAPMMpoiN=Rj_z9VEJZ4EFhb8gBeqb6H7JhTUBbn-b-t-jHRVnA@mail.gmail.com>
Subject: Auto packing the repository - foreground or background in Windows?
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

I came across a Windows user today whose "fetch" operations were
taking a long time, because their repository had passed some
persistent maintenance-triggering threshold *and* the resulting
auto-gc was running in the foreground (and not resolving the
maintenance-triggering condition automatically).

The user was seeing, at the end of their fetch, something like:

Auto packing the repository in background for optimum performance.
See "git help gc" for manual housekeeping.
Enumerating objects: 311322, done.
Nothing new to pack.
Checking connectivity: 1490123

Eventually, they noticed a subsequent recommendation to run "git
prune", after the connectivity check completed, and after they did the
git prune, they started getting "bad object" errors on fetch - so
there was clearly something else going wrong somewhere...

But my *question* is: Does anyone know where I could/should look to
understand why the GC was happening in the foreground, even though the
message says it will run in the background?

I don't know how to create the conditions for the auto-GC on demand
(how to create lots of loose objects??), so I don't know how to verify
whether it ever runs in the background on Windows, or what that might
depend on. I saw some discussions in 2016, but I can't tell what the
conclusion was; is it simply the case that git has been "lying" about
running GC in the background, on windows, for all these years? Or is
there something specific going on in this user's environment?

Any info welcome, thank you!

Tao
