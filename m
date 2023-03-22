Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1F8C6FD1C
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 16:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjCVQwx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 12:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjCVQwv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 12:52:51 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A345DC8D
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 09:52:50 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id o2so12436276plg.4
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 09:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679503969;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p/ZfhkgKTeQmf0esD0O2ctXf9CTiop1CcArxdfgwsKE=;
        b=isr1u5dyAj0HPBbuU8Fil1pIYS7oqrfJVWUZ++exgwJTUuux9X7NNP0VdE87zTDkIR
         CvYo1xLSSJB+mIiykWLyvKUlTHbL4HVGH3px6ofRq2wEVbTh3UneRDBbVkTXdzvr5qtL
         L1H1+Mwc3zC4VntCrPKmUJP6rwjIG49xHyOSpHy2BIdBOCtWI4GgIJs6ohsDAByEvlGG
         Uohhn2f1fHtFKuDr1JxpQ9jThIDVR6nfhT03mDvfFa0AM/pvamL54BTMuAX2bnHqmIXp
         rWwo2e4EvMyJCjFZBc8bKXbjoszRtVR0w3lTM9tboXjffTYemUAeWyGiF9Xl7e+gVpK/
         k6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679503969;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p/ZfhkgKTeQmf0esD0O2ctXf9CTiop1CcArxdfgwsKE=;
        b=EOmk8Ih3j7Z4PFYzvzh+UU61ita4lV87Zx9+Fs3DN2FSij6k4orBoPPk+/t9ktrOOR
         zluG5WdSEqCN9F3ixnoE+9gjrpyU1v42e5ECd323ZRhnxBTczUGEaSTAF3A3dQLmSXny
         9kCqDvE7K/tiLWxfSyXQDUUjIRHwfqELVV2MHzCuRbNADoAxdHexTpcwX/rhwdFrmCDG
         113pz/uD4EdUdf4HUh7qF9F/g4V5FK49WlS/alOh8ZiNx2A80ySp508oi6EShpHVuh1u
         tw7CTRDcLGX8JOOEv+w5JnX3FflnZ476D167sSzqI9QJFRF2gXtrJcZmcv4BySyci0O/
         YeXQ==
X-Gm-Message-State: AO0yUKVwtGf1OM3whETalJ2Xyou4t43hZPXSRjBsvls82OWRgnp/lbOu
        xcy8Y5AghCiC+NCqOWUAUYc=
X-Google-Smtp-Source: AK7set82IKSBHJUqodoSyem+uINjC0XZstBl9TTOU+jxmwgzDOXODFifEVIBb1AjnzDIkcVNVOD5Gw==
X-Received: by 2002:a17:902:dccc:b0:1a1:a146:f6d7 with SMTP id t12-20020a170902dccc00b001a1a146f6d7mr2906918pll.4.1679503969439;
        Wed, 22 Mar 2023 09:52:49 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902ee4c00b0019ca68ef7c3sm10863553plo.74.2023.03.22.09.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 09:52:48 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "ctmbl via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ClementMabileau <mabileau.clement@gmail.com>
Subject: Re: [PATCH 2/2] Fix mem leak in branch.c due to not-free newly
 added virtual_name variable
References: <pull.1476.git.git.1679478126.gitgitgadget@gmail.com>
        <27f27f3afd76fc974350c0c94e20307879eead84.1679478126.git.gitgitgadget@gmail.com>
Date:   Wed, 22 Mar 2023 09:52:48 -0700
In-Reply-To: <27f27f3afd76fc974350c0c94e20307879eead84.1679478126.git.gitgitgadget@gmail.com>
        (ctmbl via GitGitGadget's message of "Wed, 22 Mar 2023 09:42:06
        +0000")
Message-ID: <xmqqmt44enj3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ctmbl via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ctmbl <mabileau.clement@gmail.com>
>
> Previous commit introduced virtual_name variable which is the name of
> the branch in case it has been a remote ref (used to check whether the
> user simply forgot `--remote` flag) but didn't free it.
> Call FREE_AND_NULL(virtual_name) to solve it.

Do not introduce a bug in 1/2 and fix it in 2/2, unless it is
absolutely necessary.

Squash this one into the previous commit, before sending your
patches out to the list.  The public do not have to learn your
earlier mistakes, and before sending your patches out is the perfect
chance for you to pretend to be a person that is more perfect than
you are ;-).

Thanks.
