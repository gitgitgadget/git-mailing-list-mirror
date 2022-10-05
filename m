Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708FFC433F5
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 11:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiJELXj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 07:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiJELXh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 07:23:37 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B205D11D
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 04:23:32 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id m11-20020a4aab8b000000b00476743c0743so10586488oon.10
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 04:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=xsFQSECkaSVHO6QnVgheSIsSft2MnJvvnGlesMPbOYA=;
        b=qdtxXyGFDH3tRyZkzyMvesPphIYIYtItvh2f4BdORR5OjC/4o5Udgb8vnSWRGfuv0p
         3FtpLL5suWwrmWzqoF8/okoJDhe9cTpRO8/S/G+VcCUwbk7HkECeVJ5Sja/yH0O9VyNW
         pWxmSFYS1akiq41tOb+9zEK3UZdBqTPq715uJ2+jh71hIEmekI1HpMPT874ouqsyizAz
         miHiNjsI2MBLoeKnC0sel7Ew864JLgwcWsfvoveKfjPvLKf0gSu96y3iY/rCo0Vj0UuX
         8sylY1SBjOqkFr+WlBFkBg89uGOcZ3z9n7+2RVi/Oj+IikslbHDxKw/r+W1E4vfW+Tzr
         t8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=xsFQSECkaSVHO6QnVgheSIsSft2MnJvvnGlesMPbOYA=;
        b=oa8hwiZzhN/blUoAzPlZ3asTrfJ5R7+1wx2rmKDfMQ8VdCzXQCPSXkdPy16YZvWPrj
         L1C5LgIVCitXsOyyusXh/WTvYtqeP1iuWxwORKjiQKsp6TSG+/n7GGQR8pCEzQbzVzQs
         9kmFjzR62ZD8AtXTN+EtyJyaG6YoJ9eVEsaWf8KjdfpOHqZ781J5i6/z4siCyEpqROFN
         CmOMwYWICppbthHYmGHTsyVm+VWEhJRzhC463TBLpI90HCnxJuhvlCRtKpcjgZTL5s1j
         nVYF0l+ux2uwmZejRaoRm1QeRf3NXvPjSYBK5ZvnjZhxTQp9gtHbFk001X/a5ER6KCY0
         PVTQ==
X-Gm-Message-State: ACrzQf1xL6rJfYAnOKaRUQL1w9jfKkrb8W5YrHgm7mmP1q3dV4sCyjlJ
        IYOWFJnrpXJdosKNax5AL3vWPV4VlF6mATxxrRka9GCcyDD/Rx8i
X-Google-Smtp-Source: AMsMyM5eeFLW9e2AGu0+bt7b4o9GkxnXSHvfGC957Ia3IxQUSKF6XzkohLqGqfjynvp+ZLdNSpX05KNM4ER2s7jHYEo=
X-Received: by 2002:a4a:9645:0:b0:476:a4e2:8cbc with SMTP id
 r5-20020a4a9645000000b00476a4e28cbcmr11040494ooi.74.1664969011297; Wed, 05
 Oct 2022 04:23:31 -0700 (PDT)
MIME-Version: 1.0
From:   Alireza <rezaxm@gmail.com>
Date:   Wed, 5 Oct 2022 14:53:00 +0330
Message-ID: <CAD9n_qiXZ9xDkJsG0mMmYoVpM8LXrZB+nyjHK_vSsRT3FgjAqw@mail.gmail.com>
Subject: Request for a "connected mode" -- server-side command execution
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are a few mechanisms already to improve perf in big repositories
but they all need a change in usage flow. I had this idea for a while
now and I'd appreciate your feedback on it.

The "connected mode" essentially means to run all git commands on the
server and only download relevant stuff locally. To demonstrate the
usage flow:

git clone --connected <url> # new repo
git config fetch.connected true # existing repo

From there, git is to decide whether or not a command should be sent
to the server. For instance, if all required refs are present locally,
it's run on the machine, otherwise it's sent to the server, collecting
the result and possibly a minimum set of new objects. From the user's
perspective, all commands are run on the latest revision without an
explicit (possibly extensive) fetch.

This would make a --connected clone implicitly shallow, but new data
can be downloaded on demand. User flow is not changed in any other
ways.

Thanks,
