Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705A1C433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 22:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236510AbiBPWHa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 17:07:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbiBPWH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 17:07:28 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54FF20190E
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 14:07:14 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id fh9so4702878qvb.1
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 14:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=/2f7ah8wtBy5ReONBJDIHrSlpYQgIyP2LRpiuTHeu40=;
        b=EmZS6Qvxg79O0PYZXvYZmKCjPRP9nkTODPNgfA15evFLt/OGwnSW+S1xaf70fx5OcU
         ari6gKQux3mCyA39zJDXyFAtTCan0zMvFNkOTaHQB5V4z0AZqs0iFNAWZ9OEQlIQ7Qpa
         Oth5V0yH4XsYS9XDm0p4ulGWQ0JZLu9eb1bs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=/2f7ah8wtBy5ReONBJDIHrSlpYQgIyP2LRpiuTHeu40=;
        b=GXcvZ1nQv8iADyJETIbA3zr1Rby7xgD7/kNdthaokabgDCtT/ZxExY7cM359t2eZo5
         gk4uP8KsXN9s4N4qcDdBqB9Hm8StR0dkRvYbv7a/jYnacwBpL8LpEq6Bnm9/fNm80AfC
         xWH9zXonMwRhvo9dUqN7z79xiX11PcsBziv+5yE2JPRhbljNwp2q9BeEL1XhXx6GKoxx
         gFMxqOfqUnft4UkUeCXvUA3zWd6XMYxcdZK/k2RydIX33DktSJ4ZbNZRlY367ATLz+hk
         61ycqx9Iek8KrGrelRfkyQJPfTPTLQc+y56X++zvM3Pc7eyxgJ+VQF+1h7dtbkAGTjjR
         EABQ==
X-Gm-Message-State: AOAM5318UPt/mDuNJLhh9jn9tSHPCtTa068Rshg3sWFbh3tP2vNYTTxA
        IBbqHYw4aORnnh2NMJMUG/bPcx35dnHY+A==
X-Google-Smtp-Source: ABdhPJyDbi2FRxjgzO6LBKVJQu/zPxzH9YgJrYCH9vBLEcZCFpQZr/rfvgG8QCtP90X83LgP5jpiJA==
X-Received: by 2002:a0c:c2cf:0:b0:42c:3b31:86ba with SMTP id c15-20020a0cc2cf000000b0042c3b3186bamr597259qvi.127.1645049233449;
        Wed, 16 Feb 2022 14:07:13 -0800 (PST)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-127.dsl.bell.ca. [216.209.220.127])
        by smtp.gmail.com with ESMTPSA id y15sm19606879qko.95.2022.02.16.14.07.12
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 14:07:12 -0800 (PST)
Date:   Wed, 16 Feb 2022 17:07:10 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     git@vger.kernel.org
Subject: Supporting --depth when cloning from a bundle
Message-ID: <20220216220710.td4vp6mile5m6hjn@meerkat.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, all:

It would be pretty handy if it was possible to do shallow clones from a bundle
file. For example, this would be nice for CI environments that first download
a clone.bundle file from a locally cached location, clone from it, and then
fetch any remaining objects from remote.

E.g., in my mind this outta work:

$ wget https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/clone.bundle
$ git clone --depth 1 clone.bundle linux -b master

Right now, this operation succeeds as-is without any errors, but the resulting
git repository isn't actually shallow.

Oh, it would be even awesomer if the bundle files could be used directly with
--reference, e.g.:

$ git clone --reference clone.bundle --dissociate \
  https://git.kernel.org/.../torvalds/linux.git linux

Any reason that can't work?

-K
