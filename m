Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F4EEB64D7
	for <git@archiver.kernel.org>; Fri, 16 Jun 2023 22:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbjFPWqY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jun 2023 18:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjFPWqX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2023 18:46:23 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637DC3584
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 15:46:22 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f8c65020dfso11352395e9.2
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 15:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686955581; x=1689547581;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03tPpXGzzSeYoh58/yaO4VCcdpL9B7w/2lLz/dYPfdg=;
        b=A3nuyREkBjoxow1WQ1iAgolrcRyMhQ9fj9gkXf/1Pn5kdUXWSuN7FfK07dTJ0ocQij
         V7tDEEFYx4uD1eoy2J07zgAaBgCDAC0EYqTN4tPWY/RMa6OREVlPqaqPTjAEcPD0Lh2P
         WRHTn5dmOhgTVrJ0uy5y/WRid8x7HyBF3lf4LdUAK4ia1iGizblHb9L/blMsVmszmwa4
         wFtZ3ewbnnOcY18TjuIXiX2C3aPJ5f6xjbQRtnbIxZxO6cKPxrQYhlocdH6vpDK2RB8b
         awX8dOBoXDAszcnhae/+BKwvTvCmHRcQu6J4KtayWhNRuoDQZekDX/05SYttxEVGeZqX
         tQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686955581; x=1689547581;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=03tPpXGzzSeYoh58/yaO4VCcdpL9B7w/2lLz/dYPfdg=;
        b=aLLJvdvW8T1onvy/DwnMULCcn/W/+LMC1W+qVyopJMsJu+SjfOiSpXSy0zyNOAEBEL
         JzpZ1b67QyN/JshsiEMCyOYM1Melr3TFKN/Ycw/qH4khjjMZ/vCyHtf4Gh36i/xYWj+X
         E6ejtaFPJUxYbfmW/HHJrQyBZT5agxYo60g8i5SpMpwQNkDxJHOXgzxNZfv/ALNgHbIR
         Is13MXtxK/5rXPxYnbNm+U70+icIh+jipkTytG+r3k8vDoDcyhIEM6sQdiY0LdGSVma9
         2I0gouWCujFHM9/AuOh3A8xMeHaOXTMlOqMNSTN6jKpFGvgxTVXF0qdGo88jmCVvZVEO
         lqpw==
X-Gm-Message-State: AC+VfDw2XkqDkhpTzYAti1Mxm7G/KNOl+xVHmY7E3/CA91kwMu3W2Lew
        GkFCfIjCONGaGq/yeamrzfXIEvVI/DU=
X-Google-Smtp-Source: ACHHUZ6iZ0gC5WAd9y18+5X/WHx0ZZg74+sFqEydOD3VfS9lYleGTKKZTUvlPPN+mz+cBm/YL7YthA==
X-Received: by 2002:adf:cf05:0:b0:310:fe5e:894a with SMTP id o5-20020adfcf05000000b00310fe5e894amr2500094wrj.6.1686955580696;
        Fri, 16 Jun 2023 15:46:20 -0700 (PDT)
Received: from [192.168.2.52] (151.red-88-14-53.dynamicip.rima-tde.net. [88.14.53.151])
        by smtp.gmail.com with ESMTPSA id s14-20020adfeb0e000000b0030ae53550f5sm24714916wrn.51.2023.06.16.15.46.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 15:46:20 -0700 (PDT)
Subject: Re: [PATCH 05/11] branch: fix a leak in setup_tracking
To:     Jeff King <peff@peff.net>
Cc:     Tao Klerks <tao@klerks.biz>, Git List <git@vger.kernel.org>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
 <49a4339b-d736-2c30-0c57-194ab33f377c@gmail.com>
 <20230612032615.GE306352@coredump.intra.peff.net>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <bb03d449-adb5-5c4d-0a2f-12a26bd48d8c@gmail.com>
Date:   Sat, 17 Jun 2023 00:46:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20230612032615.GE306352@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11-jun-2023 23:26:15, Jeff King wrote:
> On Sun, Jun 11, 2023 at 08:49:51PM +0200, Rubén Justo wrote:
> 
> > The return introduced in bdaf1dfae7 was to avoid setting up the
> > tracking, but even in that case it is still necessary to do the
> > clean-up.  Let's do it.
> 
> That may be a sign that the return introduced by that commit is in the
> wrong spot (i.e., could we be checking it earlier and returning before
> doing the work that led to the allocations?).
> 
> But I didn't look too carefully, and I think for the purposes of your
> series it is OK to simply fix the leak without digging too far.

Thanks.

> 
> I'll cc the author (and quote the patch below) though, as sometimes in
> cases like these they may be interested in looking deeper themselves.

Perfect.  Thank you.
