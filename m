Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268B4C433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 12:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1F8F611CE
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 12:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239153AbhDSMrB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 08:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbhDSMq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 08:46:57 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05620C06174A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 05:46:26 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id z25so3177447qtn.8
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 05:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition;
        bh=+R26fgryA/BI2zGN48J0ZbKq6yYcj9MxDKdksFD3DxY=;
        b=dwD6Em/HcRXOvJIFzh36Tkq+OnGtysjgHaXSw8gbG6z45fXi/BbQTpUh6ic5ZdbFXJ
         glkgYGN5RyzMG1exUDySqi+ooWeCwDVzwm44UfGL4qvRxJW83ilq3NXPItRx/cAoKF4R
         5LbHkARvG9flRxj2mPKbuwZZRO8kEb6gTZTg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition;
        bh=+R26fgryA/BI2zGN48J0ZbKq6yYcj9MxDKdksFD3DxY=;
        b=fR+qogEwB3ZOQfD1VXRJ72h40yS5WBl93n9/Mqp6lTKlnG5GOkg1HeCgdR9o0nPXax
         quatZoPjYRJ0uWnRVXxauZwPuymAqDJZh/Dkqoj6VWH/PiCsz+Uqy+oQH/ZWpR7OqZGf
         RXKyQw195fXiELDWE+97MQXBoNDjzMoOHMmVUEXB43qvC+YSVTjCIoMpXZh9jgVJqrei
         G9qCnWxuz3lP/mLOaVeu39CvLPfaCxh83QOthMfWwJpXKoGb5Vuwth5G85/9Z85Z6BIu
         ER4ju8oa8MkQWYWyhih0g+ZoN8SDGXeOh4zS/RBbZbDfaMRwrJ/5ADhEdvUeYAsHW+cJ
         s2iw==
X-Gm-Message-State: AOAM531ja2Wm4YHtoKfETFRVHkSersxClJp7KqW0LYIZm/u/vmw72rKt
        iXmzWdztlwkkMpjj4CIfKPVck2P4fiDOdBM4NsI=
X-Google-Smtp-Source: ABdhPJxXJk09lUIVVI562hwZ8qAOpRqfIAR1RVra1dYbfFTWauCVGzb+9eGS+5BFkzcw0Q+HcZvTfg==
X-Received: by 2002:a05:622a:1103:: with SMTP id e3mr11973905qty.346.1618836384908;
        Mon, 19 Apr 2021 05:46:24 -0700 (PDT)
Received: from nitro.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id v11sm8966899qtx.79.2021.04.19.05.46.24
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 05:46:24 -0700 (PDT)
Date:   Mon, 19 Apr 2021 08:46:23 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     git@vger.kernel.org
Subject: Strategy to deal with slow cloners
Message-ID: <20210419124623.wwps2s35x2mrrhi6@nitro.local>
Mail-Followup-To: git@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello:

I try to keep repositories routinely repacked and optimized for clones, in
hopes that most operations needing lots of objects would be sending packs
straight from disk. However, every now and again a client from a slow
connection requests a large clone and then takes half a day downloading it,
resulting in gigabytes of RAM being occupied by a temporary pack.

Are there any strategies to reduce RAM usage in such cases, other than
vm.swappiness (which I'm not sure would work, since it's not a sleeping
process)? Is there a way to write large temporary packs somewhere to disk
before sendfile'ing them?

-K
