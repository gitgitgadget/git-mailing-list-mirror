Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9C4C38A2D
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 23:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbiJYXwL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 19:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbiJYXwJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 19:52:09 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE47EC1D93
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 16:52:08 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 192so6421492pfx.5
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 16:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2G33NjlF0UZ7a6yuOr3a5ujV+fW8KRP3lNnBkm5RD+8=;
        b=fQ0bpB4qG94ngvBfmQCMzt+hBsLeDjPdLmbuIj4LHOA7gtYbjjVF08UwdAlYqaQsJt
         fBi1abhhd6+cSKQZRSlLVj34r5PM1xUVj78wZ9uIgZQ+96FW5a9SGXrGtc46lCkKwbVC
         5vvdmOvH94+0RTMzo7/UWjPeVONnbGLQrwS4OKqPtnJVy6teJ/qlxa2C8ueK7hmXJU8X
         BMG6HyIsL/MN8yoWyESIoSwHqs07ILaUN/8GHKSakzeNQCmJCxBRnewTWaHVDALP2EEu
         QUfmy4O8mC0B5+CBlSwsU+cwQkqrEWCJ4YFn7DNhtW4i8C+YGfhObuHS7hRiz4Lrgm6d
         uagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2G33NjlF0UZ7a6yuOr3a5ujV+fW8KRP3lNnBkm5RD+8=;
        b=iK5oOPNse2dbs1S6HtudeYAt9qSRSdXSi2yTGpbW4eC9NguwxZ4I5F425o0d3Dnn7S
         TfaybGFBFDi4e2Mj8n8tSOtsu3PMGcVgAxo90T0TG0TGXe8zSTsCJD1CfAhlzyBqe0Xw
         MQVqth6Ssr+Nf0ewgY/ODfi6SOv/2KeZ03bqCUQ0S0Trpki9eerKyZ1gEvz8tqPW4zji
         4tIGl8qXxttaxeJZmic76mNnoyI3x76kFE9INdwqQPSmXoKj1Fai5HVNrE3o6Yw374ml
         eSJ8dMoTAvd8Wiv1/gLX+2s0oCWfu5TyH50s4xzMaJV2FEZis+8KVTTHGaQAtTwkS+KK
         72XA==
X-Gm-Message-State: ACrzQf1p2qE8jS/nJX/u6PXCLV139x01DG43IKU38JryiKEzqTCG0vb1
        x0LMe/qoEnzYaFxpn6uh1hg=
X-Google-Smtp-Source: AMsMyM4xPyJkOgsju+UXs5MJX7xOoEpDUFWfSiCCrUtaLQGTMx29GH1gKSITwZeiwa9maSltgUY6ew==
X-Received: by 2002:a63:125f:0:b0:46e:f23a:e9bd with SMTP id 31-20020a63125f000000b0046ef23ae9bdmr14613579pgs.21.1666741928279;
        Tue, 25 Oct 2022 16:52:08 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id z3-20020a1709027e8300b0017f592a7eccsm1673684pla.298.2022.10.25.16.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 16:52:07 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] negotiator/skipping: avoid stack overflow
References: <20221025232934.1504445-1-jonathantanmy@google.com>
Date:   Tue, 25 Oct 2022 16:52:07 -0700
In-Reply-To: <20221025232934.1504445-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 25 Oct 2022 16:29:34 -0700")
Message-ID: <xmqqilk7mpg8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> mark_common() in negotiator/skipping.c may overflow the stack due to
> recursive function calls. Avoid this by instead recursing using a
> heap-allocated data structure.

Very straight-forward.  I think we've done quite a many of these in
various places by now ;-)

