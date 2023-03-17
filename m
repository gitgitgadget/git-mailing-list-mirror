Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017B4C74A5B
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 22:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjCQWPz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 18:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCQWPx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 18:15:53 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0073B20A
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 15:15:51 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id z10so3728967pgr.8
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 15:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679091351;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E0jG0ogOPuf0Q64vWsPDcUDsnEklF2MsHG49wk5zfZI=;
        b=D6h7Q4rrK81XFjiFcysQ01fFLMEkJLk3AiRxfqKsYLYZoKWwWzm6sFp1aVwntPigd5
         QlcR65X29Do98lIyZN6EaNWHfHJ0xfaX4aWk4k/0G5vNJTqlLtJKIRg90P/MvdwtY8MP
         GO5YJuFgz4EnOeqyY3flwnEpdy02Rzp1cDiij3jvz85eq9TUynZF8vN2W8hKEe94cnmL
         pwfiOyjUFMj7drqmBvRlWZHBUTFVQ+J/7eSARz6I476bmUDtFwnP4u4pyr8/3WhG8rTL
         SAYXyaqBhJr18t5EkaLRRwPld3Tb8W/OxUgmtD9kt4BNQEB4qp9F7vXl8jBSaReyYVCT
         bn4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679091351;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E0jG0ogOPuf0Q64vWsPDcUDsnEklF2MsHG49wk5zfZI=;
        b=nl567e3QAPId814M+88sh6GWsm8A0zjGMH7OB8Xoqbq4FeAtF6RKc74GJlvsv3Jf1c
         NcecyfnykyDAIOQsoSkkvVsGaqwpRYssleHiM0bUGMT91e7/01LHL+WYSUWJtwP8hG/i
         4atKd5pCs4wYFESI3A6z0a8o3XJAuMYcHsl/9WfXyrCh9ggXwitMbniMse/AtxXjCWhA
         bzyKo8kL76oz9rPnDp3rhieD+A0IURVz/k7vteVuD8wxCCyB2XXcGbG7EFSQnhvLM/MS
         wnfcmrI5ZD0mFYkc4XITcwJorlXN9fd3TUDF94uMGCo/gA+HU/3OojYZmyiAAxRYn8nY
         0+MQ==
X-Gm-Message-State: AO0yUKWvMLlAorrzvuCUmvv8cxXnyrJ8zWMxsc0Uma11RRCmZgyDsOPT
        Vaf2ys3ExhEw7cGU6kcOOdU=
X-Google-Smtp-Source: AK7set+AfDWAdXiKDGKOq5ZsVc5RXD/lh/JNJfG8Oxx+fmmsghKnZLIdqQvEb+buI10rExkz8PckGg==
X-Received: by 2002:aa7:93d1:0:b0:625:27c4:c1ef with SMTP id y17-20020aa793d1000000b0062527c4c1efmr7054114pff.3.1679091350649;
        Fri, 17 Mar 2023 15:15:50 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id j20-20020aa78d14000000b005ccbe5346ebsm2003587pfe.163.2023.03.17.15.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 15:15:50 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git_connect(): fix corner cases in downgrading v2 to v0
References: <ZBS6wwWXcEBwGBm/@coredump.intra.peff.net>
Date:   Fri, 17 Mar 2023 15:15:49 -0700
In-Reply-To: <ZBS6wwWXcEBwGBm/@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 17 Mar 2023 15:08:51 -0400")
Message-ID: <xmqqr0tnf2i2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> There's code in git_connect() that checks whether we are doing a push
> with protocol_v2, and if so, drops us to protocol_v0 (since we only know
> how to do v0 for fetches).

I had to read this three times to make sense out of it, and then
after reading the NEEDSWORK comment at the beginning of
git_connect(), started to suspect that there is a bit of typo there
that made it confusing to me.  Either "(since we only know how to do
v2 for fetches)", or "(since we only know how to push via v0)",
perhaps.

Other than that, superb reasoning and a very clear solution.  Will
apply.  Thanks.
