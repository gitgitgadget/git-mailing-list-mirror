Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1CAC433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96B2A61260
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345843AbhIXSEf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 14:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345127AbhIXSEe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 14:04:34 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEB0C061571
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 11:03:00 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id ee50so39170036edb.13
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 11:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=ZHR7oG4TI68PuX+NAs2olRG6k6MROpGEEXf2hxGvMFs=;
        b=vqEv9RvDwsh57UDACHEvh0w48u0pIDS72CC0o/jSCmfpdVeLZnTygosMLoJOsy9See
         OmxC202dMABKzBSIdIBxvcLkoKrrMdqR2Xr1+y5ICeKDrEfSFrqOv9LuSfUgK18umsyk
         gZfOq1lHQ0Xj1oj2xPrSmC/K3ZwtWW0110kS4afssicJkYUQXlnWxVw9YtaetEvWHxjO
         UNrw7d1fIFPvotfDHDbG9x2AwFVsnrLdSwmvw6PgEvm6VkriSXbFbn70Hs6RT/PkmA+q
         zMrlvpOBDqTFI3TxDskY/mLM6UuPXiQMNhkjtU1RwtzmY+JI8Oq2qr0n4OoxVbK/65PG
         5RVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ZHR7oG4TI68PuX+NAs2olRG6k6MROpGEEXf2hxGvMFs=;
        b=ub8I/g2AMZW5AmxS3RXFVt6xdYwxBaeC5Rgj36Mlb6+N1UfApw6e6bZ3oQBPzuMX8e
         hvHxB5MzKIkPDpt3EI13VOeu5HoW6XTeQjF4f8LqhJxvsfV0y8knNB3W+ay2fH/YamPJ
         Fzqw19RbyNlTBUvtfBxxZTEKPe9YFwVeFn4qmoUKLjWn9EUAzP4aNbw6WwLUpleIdHCe
         5smDc5YVhPgrtKyV+8Ki7mvv7on1NgeBJ47obaKdqOltdIZAkL0MOlDKZauiyLNFZZ/3
         prlD/qzmEQOKuYieS0W19MPet5rl0pINA+tXPlQJSvZ/ImT1O+0+3vcEfqdlcTzM1JWO
         YzYQ==
X-Gm-Message-State: AOAM531rGvvwNBpvyq6e/HAq1YrryZASOwXIuQndaYki+Qh/Z0yCzR8u
        5gq5JVRiUla1GqpH7ogb+Udpfk3Dw1wdOX3Akk3zn+xUB5Hy8w==
X-Google-Smtp-Source: ABdhPJy9+7xKVKZiqofN4fb5/b6kH1V5813ruHsmOWeKhfBY2WUszUUvgnEjuawnoK4e84zuRGFYEcLDQu5N3g2qvL8=
X-Received: by 2002:a17:906:584:: with SMTP id 4mr12837024ejn.56.1632506579199;
 Fri, 24 Sep 2021 11:02:59 -0700 (PDT)
MIME-Version: 1.0
From:   Tao Klerks <tao@klerks.biz>
Date:   Fri, 24 Sep 2021 20:02:48 +0200
Message-ID: <CAPMMpoj-oiD1yDHx6WS_1uiPOXMLj7FcfBPZm-q4vO30kpE_ow@mail.gmail.com>
Subject: New built-in fsmonitor: messages accidentally on stdout?
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

I've been testing the new "core.usebuiltinfsmonitor=true" capability
in Git for Windows 2.33.0.windows.2, and came across something today
that threw off my scripting:

In general, git "informational" messages are always output on stderr;
this caught me out initially, but is a godsend for scripting.

However, with this new functionality, the "starting fsmonitor-daemon
in 'C:/whatever" message is being output on stdout!

This interferes with scripting around things like "git status --porcelain".

I understand this fsmonitor stuff is still somewhat in-flux (patched
into the windows port but not yet "regular" git releases?), and this
issue may already have been reported and addressed in the latest set
of patches - my apologies if that is the case!

Best regards,
Tao
